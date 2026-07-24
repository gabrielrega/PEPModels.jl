using Test
using JuMP
using PEPModels

const P11 = PEPModels.PEP11
const REF = normpath(joinpath(@__DIR__, "..", "references", "pep-1-1"))

"Lê um CSV de referência (dumps do GAMS): linhas viram (índices, valor)."
function read_ref_rows(path)
    out = Tuple{Vector{Symbol},Float64}[]
    for (n, line) in enumerate(eachline(path))
        n <= 3 && continue
        f = P11.split_csv(line)
        while !isempty(f) && isempty(strip(f[end]))
            pop!(f)
        end
        length(f) < 2 && continue
        raw = strip(f[end])
        val = raw == "EPS" ? 0.0 : tryparse(Float64, raw)
        val === nothing && continue
        idx = [Symbol(lowercase(strip(x))) for x in f[1:end-1]]
        push!(out, (idx, val))
    end
    return out
end

"Busca o valor calibrado `name[idx...]` no NamedTuple da calibração."
function cal_lookup(cal, name::Symbol, idx)
    hasproperty(cal, name) || return nothing
    obj = getproperty(cal, name)
    obj isa Number && return isempty(idx) ? obj : nothing
    key = length(idx) == 1 ? idx[1] : Tuple(idx)
    return get(obj, key, nothing)
end

cal = P11.default_calibration()

@testset "calibração reproduz parameters.xlsx do GAMS" begin
    skip_files = ("parameters__Table_of_Contents.csv", "parameters__Scalar.csv")
    files = filter(f -> startswith(f, "parameters__") && !(f in skip_files),
                   readdir(REF))
    @test !isempty(files)
    for file in files
        name = Symbol(replace(replace(file, "parameters__" => ""), ".csv" => ""))
        for (idx, expected) in read_ref_rows(joinpath(REF, file))
            got = cal_lookup(cal, name, idx)
            if got === nothing
                # célula fora do domínio calibrado: o GAMS só exporta não nulos
                @test expected ≈ 0.0 atol = 1e-12
            else
                @test got ≈ expected rtol = 1e-9 atol = 1e-12
            end
        end
    end
end

"Compara a solução do modelo com a coluna `tag` dos results__val*.csv."
function check_results(m, tag::Symbol; rtol, atol)
    files = filter(f -> startswith(f, "results__val"), readdir(REF))
    @test !isempty(files)
    ncheck = 0
    for file in files
        name = Symbol(replace(replace(file, "results__val" => ""), ".csv" => ""))
        for (idx, expected) in read_ref_rows(joinpath(REF, file))
            (isempty(idx) || idx[end] != tag) && continue
            dims = idx[1:end-1]
            P11.hasindex(m, name, dims...) || continue
            @test P11.value_of(m, name, dims...) ≈ expected rtol = rtol atol = atol
            ncheck += 1
        end
    end
    return ncheck
end

@testset "benchmark é equilíbrio (replicação BASE)" begin
    m = P11.build(cal)
    P11.solve!(m)
    @test abs(value(m[:LEON])) < 1e-6
    n = check_results(m, :base; rtol = 1e-6, atol = 1e-6)
    @test n > 300
end

@testset "simulação ttix*0.75 reproduz SIM1 do GAMS" begin
    m = P11.build(cal)
    for i in m.ext[:sup].iEXD
        fix(m[:ttix][i], cal.ttixO[i] * 0.75; force = true)
    end
    P11.solve!(m)
    @test abs(value(m[:LEON])) < 1e-6
    n = check_results(m, :sim1; rtol = 2e-6, atol = 1e-5)
    @test n > 300
end

# --- SAM brasileira -------------------------------------------------------
# Não há resultado do GAMS para comparar; o que se verifica é que os conjuntos
# generalizados sustentam uma base de dimensões diferentes (4 produtos, 1
# trabalho, 1 capital, 1 família) e que o benchmark é de fato um equilíbrio.

@testset "conjuntos generalizados" begin
    sb = P11.read_sets(joinpath(P11.datadir("pep-1-1-br"), "sets.csv"))
    @test sb.I == [:agr, :ind, :ser, :adm]
    @test sb.L == [:lab] && sb.K == [:cap] && sb.H == [:h] && sb.F == [:firm]
    @test sb.AG == [:h, :firm, :gvt, :row]          # H, F, gvt, row nesta ordem
    @test sb.AGNG == [:h, :firm, :row]
    @test sb.AGD == [:h, :firm, :gvt]
    @test sb.walras == :agr && sb.I1 == [:ind, :ser, :adm]

    # A SAM fictícia tem que continuar dando os conjuntos do GAMS original.
    sf = P11.read_sets(joinpath(P11.datadir("pep-1-1"), "sets.csv"))
    @test sf.I == [:agr, :food, :othind, :ser, :adm]
    @test sf.AG == [:hrp, :hup, :hrr, :hur, :firm, :gvt, :row]

    @test_throws ErrorException P11.Sets(J = [:a], I = [:x], L = [:l], K = [:k],
                                         H = [:h], F = [:f], walras = :zzz)
end

@testset "calibração da SAM brasileira" begin
    br = P11.br_calibration()
    # PIB do IBGE 2015 a preços de mercado, R$ milhões — as três óticas batem.
    @test br.GDP_MPO ≈ 5_995_787 rtol = 1e-9
    @test br.GDP_IBO ≈ br.GDP_MPO rtol = 1e-9
    @test br.GDP_FDO ≈ br.GDP_MPO rtol = 1e-9
    # Elasticidades do val_par.csv chegaram na calibração.
    @test br.sigma_VA[:agr] ≈ 0.24
    @test br.sigma_M[:ind] ≈ 1.5
    @test br.frisch[:h] ≈ -2.0
    # ADM não é importado nem exportado: fora do suporte.
    @test br.IMO[:adm] == 0.0
    @test br.EXDO[:adm] == 0.0
end

@testset "benchmark brasileiro é equilíbrio" begin
    br = P11.br_calibration()
    m = P11.build(br)
    P11.solve!(m)
    @test abs(value(m[:LEON])) / br.GDP_MPO < 1e-10
    @test value(m[:GDP_MP]) ≈ br.GDP_MPO rtol = 1e-9
    for (i, v) in br.QO
        v > 0 && @test value(m[:Q][i]) ≈ v rtol = 1e-8
    end
    for (p, v) in br.LDO
        v > 0 && @test value(m[:LD][p]) ≈ v rtol = 1e-8
    end
end

@testset "choque comercial no modelo brasileiro" begin
    br = P11.br_calibration()
    m = P11.build(br)
    # Corta pela metade a tarifa de importação da indústria.
    fix(m[:ttim][:ind], br.ttimO[:ind] * 0.5; force = true)
    P11.solve!(m)
    @test abs(value(m[:LEON])) / br.GDP_MPO < 1e-10
    # Importação de bens industriais sobe e a receita tarifária cai.
    @test value(m[:IM][:ind]) > br.IMO[:ind]
    @test value(m[:TIM][:ind]) < br.TIMO[:ind]
end
