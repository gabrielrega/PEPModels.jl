*==============================================================================*
*                                                                              *
*           Except where otherwise noted, this work is licensed under          *
*               http://creativecommons.org/licenses/by-nc-sa/3.0/              *
*                                                                              *
*                                                                              *
*  You are free to share, to copy, distribute and transmit the work under      *
*  the following conditions:                                                   *
*                                                                              *
*  - Attribution:         You must attribute the work to:                      *
*                         Veronique Robichaud, Andre Lemelin,                  *
*                         Helene Maisonnave and Bernard Decaluwe.              *
*  - Noncommercial:       You may not use this work for commercial purposes.   *
*  - Share Alike:         If you alter, transform, or build upon this work,    *
*                         you may distribute the resulting work only under     *
*                         the same or similar license to this one.             *
*                                                                              *
*==============================================================================*


* This file allows the mapping between the sets defined in the files PEP-w.GMS
* and the sets used in GTAP8.1.
* It also allows the creation of the different sets used in the model.

* Prior to the steps below, GTAP8.1 data need to be converted into GDX files.
* We first used GTAPAgg and a 1 to 1 mapping to generate HAR files.
* We changed the names of two sectors set in order to avoid confusion with
* regions that share the same acronyms. Therefore, "other mining" is refered to
* using OTM instead of OMN (which refers to Oman in the REG set) and "Insurance"
* is refered to using INS instead of ISR (which refers to Israel in the REG set).

* Running GTAPAgg automatically generates a number of files, of which two are
* used below: BaseData2007.har and Default.prm. The latter was renamed
* Parameters2007.har.
* The har2gdx facility allows converting these two files into GDX format.

*==============================================================================
* 1. Define the sets
*==============================================================================
*  1.1 Sets that will be used in the aggregated model
*==============================================================================
SET J All industries
/
 agr             agriculture
 ind             industry
 ser             services
 adm             public administration
/

I1(J) All commodities except agriculture
/
*agr             agriculture
 ind             industry
 ser             services
 adm             public administration
/

BUS(J) Private industries
/
 agr             agriculture
 ind             industry
 ser             services
/

PUB(J) Public industries
/
 adm             public administration
/

F Production factors
/
 slab            Skilled labour
 ulab            Unskilled Labour
 cap             Capital
 land            Land
 natr            Natural resources
/

L(F) Labor categories
/
 slab            Skilled labour
 ulab            Unskilled Labour
/

K(F) Capital categories
/
 cap             Capital
 land            Land
 natr            Natural resources
/

Z Regions
/
 AfriSS          Africa South of the Sahara
 ChinaHK         China (incl. Hong Kong)
 EU15            European Union Fifteen
 EUplus          Rest of the EU (before 2007)
 India           India
 Japan           Japan
 MENA            Middle-East and North Africa
 LAmDev          Latin American developing countries
 AsPaDev         Asia-Pacific developing countries
 RoLAm           Rest of Latin America
 RoAsia          Rest of Asia
 RoW             Rest of the world
 Transit         Transition economies
 USA             United States of America
/

Z1(Z) All regions except reference region
/
 AfriSS          Africa South of the Sahara
 ChinaHK         China (incl. Hong Kong)
 EU15            European Union Fifteen
 EUplus          Rest of the EU (before 2007)
 India           India
 Japan           Japan
 MENA            Middle-East and North Africa
 LAmDev          Latin American developing countries
 AsPaDev         Asia-Pacific developing countries
 RoLAm           Rest of Latin America
 RoAsia          Rest of Asia
 RoW             Rest of the world
 Transit         Transition economies
* USA             United States of America
/

ZR(Z) Reference country
/
 USA             United States of America
/

Zrich(Z) Rich regions

Zother(Z) Non-rich regions

TIME Time periods
/
2002*2054
/

*==============================================================================
*  1.2 Sets used in GTAP8.1
*==============================================================================

 GlobalSet(*)          All of the elements of all sets
 endw_comm(GlobalSet)  All factors of production
 prod_comm(GlobalSet)  All sectors and commodities
 reg(GlobalSet)        All regions
 marg_comm(prod_comm)  Margin commodities
 trad_comm(prod_comm)  All sectors and commodities except for investment

$GDXIN basedata2007.gdx
$LOAD GlobalSet, reg, endw_comm, prod_comm, trad_comm, marg_comm

*==============================================================================
*  1.3 Mapping between sets used in PEP-w and GTAP8.1
*==============================================================================

z1c(reg)  Elements in GTAP that refer to one single country
* All GTAP regions except those beginning with an "x"
/
 bwa, ben, bfa, civ, cmr, eth, gha, gin, ken, mdg, moz, mus, mwi, nam, nga, rwa,
 sen, tgo, tza, uga, zaf, zmb, zwe, chn, hkg, aut, bel, deu, dnk, esp, fin, fra,
 gbr, grc, irl, ita, lux, nld, prt, swe, bgr, cyp, cze, est, hun, ltu, lva, mlt,
 pol, rou, svk, svn, ind, jpn, are, bhr, egy, irn, isr, kwt, mar, omn, qat, sau,
 tun, bol, col, cri, ecu, gtm, hnd, nic, pan, per, pry, slv, ven, bgd, idn, khm,
 lao, lka, mng, npl, pak, phl, tha, vnm, arg, bra, chl, mex, ury, kor, mys, sgp,
 twn, aus, can, che, nor, nzl, tur, alb, arm, aze, blr, geo, hrv, kaz, kgz, rus,
 ukr, usa
/

z2reg(z,reg) Mapping of regions
/
 AfriSS.    (ben, bfa, bwa, civ, cmr, eth, gha, gin, ken, mdg, moz, mus, mwi,
             nam, nga, rwa, sen, tgo, tza, uga, xac, xcf, xec, xsc, xwf, zaf,
             zmb, zwe)
 ChinaHK.   (chn, hkg)
 EU15.      (aut, bel, deu, dnk, esp, fin, fra, gbr, grc, irl, ita, lux, nld,
             prt, swe)
 EUplus.    (bgr, cyp, cze, est, hun, ltu, lva, mlt, pol, rou, svk, svn)
 India.     (ind)
 Japan.     (jpn)
 MENA.      (are, bhr, egy, irn, isr, kwt, mar, omn, qat, sau, tun, xnf, xws)
 LAmDev.    (bol, col, cri, ecu, gtm, hnd, nic, pan, per, pry, slv, ven, xca,
             xcb, xsm)
 AsPaDev.   (bgd, idn, khm, lao, lka, mng, npl, pak, phl, tha, vnm, xea, xoc,
             xsa, xse)
 RoLAm.     (arg, bra, chl, mex, ury)
 RoAsia.    (kor, mys, sgp, twn)
 RoW.       (aus, can, che, nor, nzl, tur, xef, xer, xna, xtw)
 Transit.   (alb, arm, aze, blr, geo, hrv, kaz, kgz, rus, ukr, xee, xsu)
 USA.       (usa)
/

j2trad_comm(j,prod_comm) Mapping of sectors
/
 agr.    (pdr, wht, gro, v_f, osd, c_b, pfb, ocr, ctl, oap, rmk, wol, frs, fsh,
          coa, oil, gas, otm)
 ind.    (cmt, omt, vol, mil, pcr, sgr, ofd, b_t, tex, wap, lea, lum, ppp, p_c,
          crp, nmm, i_s, nfm, fmp, mvh, otn, ele, ome, omf)
 ser.    (ely, gdt, wtr, cns, trd, otp, wtp, atp, cmn, ofi, ins,
          obs, ros, dwe)
 adm.    (osg)
/

f2endw_comm(f,endw_comm) Mapping of production factors
/
 slab.     (SkLab)
 ulab.     (UnSkLab)
 cap.      (Capital)
 land.     (Land)
 natr.     (NatRes)
/

ALIAS(reg,regj)
ALIAS(trad_comm,trad_commj)
ALIAS(j,jj,i,ij)
ALIAS(l,lj)
ALIAS(k,kj)
ALIAS(z,zj,zjj)
ALIAS(time,timej)
;

*==============================================================================
* 2. Calibration of variables
*==============================================================================

Parameter
*==============================================================================
*  2.1 Variables in GTAP8.1
*==============================================================================
* These are the variables from GTAP8.1 used in the calibration process.
* Population data is in million while all other data are expressed in millions
* of USD

 EVOA(endw_comm,reg)              Endowments at agents prices
 FBEP(endw_comm,prod_comm,reg)    Factor-based subsidies
 FTRV(endw_comm,prod_comm,reg)    Taxes - Factor Employment Tax Revenue
 MFRV(trad_comm,reg,reg)          Protection MFA export subsidy equivalent
 OSEP(trad_comm,reg)              Ordinary output subsidies
 POP(reg)                         Population
 TFRV(trad_comm,reg,reg)          Protection Ordinary Import Duty
 VDEP(reg)                        Capital Stock Value of Depreciation
 VDFA(trad_comm,prod_comm,reg)    Intermed Firms Dom Purchases at Agent Prices
 VDFM(trad_comm,prod_comm,reg)    Intermed Firms Dom Purchases at Mkt Prices
 VDGA(trad_comm,reg)              Government Dom Purchases at Agents Prices
 VDGM(trad_comm,reg)              Government Dom Purchases at Market Prices
 VDPA(trad_comm,reg)              Private Hhold Dom Purchases at Agents Prices
 VDPM(trad_comm,reg)              Private Hhold Dom Purchases at Market Prices
 VFM(endw_comm,prod_comm,reg)     Endowments Firms Purchases at Market Prices
 VIFA(trad_comm,prod_comm,reg)    Intermed Firms Imports at Agents Prices
 VIFM(trad_comm,prod_comm,reg)    Intermed Firms Imports at Market Prices
 VIGA(trad_comm,reg)              Government Imports at Agents Prices
 VIGM(trad_comm,reg)              Government Imports at Market Prices
 VIMS(trad_comm,reg,reg)          Trade Bilateral Imports at Market Prices
 VIPA(trad_comm,reg)              Private Households Imports at Agents Prices
 VIPM(trad_comm,reg)              Private Households Imports at Market Prices
 VIWS(trad_comm,reg,reg)          Trade Bilateral Imports at World Prices
 VKB(reg)                         Capital Stock Value at Beginning-of-Period
 VST(marg_comm,reg)               Trade Exports Internatl Trans Mkt Prices
 VTWR(marg_comm,trad_comm,reg,reg) Trade Margins Internatl Trans World Prices
 VXMD(trad_comm,reg,reg)          Trade Bilateral Exports at Market Prices
 VXWD(trad_comm,reg,reg)          Trade Bilateral Exports at World Prices
 XTRV(trad_comm,reg,reg)          Protection Ordinary Export Subsidy

*==============================================================================
*  2.2 Variables in the aggregated model
*==============================================================================
 CO(i,z)         Household consumption of commodity I
 CGO(i,z)        Public final consumption of commodity i
 DDO(i,z)        Demand for domestic production of commodity i
 DEPO(z)         Depreciation
 DIO(i,j,z)      Intermediate consumption of commodity i by industry j
 DSO(i,z)        Supplys of domestic production of commodity i
 EXO(i,z,zj)     Exports supply of commodity i from country z to country zj
 IMO(i,zj,z)     Imports of commodity m by country z from country zj
 INVO(i,z)       Final demand of commodity i for investment purposes
 RKDO(k,j,z)     Type k capital income in industry j
 KSTO(z)         Total capital stock in region z
 LDO(l,j,z)      Industry j demand for labour l
 MRGNO(i,z)      Demand for commodity i as a margin
 POPO(z)         Population
 TDHO(z)         Household income taxes
 TICO(i,z)       Government receipts of indirect taxes on commodity i
 TIKO(k,j,z)     Government receipts of indirect taxes on capital k of industry j
 TIMO(i,zj,z)    Government receipts of indirect taxes on imports of commodity i
 TIPO(i,z)       Government receipts of indirect taxes on production of industry j
 TIWO(l,j,z)     Government receipts of indirect taxes on wages and salaries of industry j
 TIXO(i,z,zj)    Government receipts of indirect taxes on exports of commodity i
 tmrg(i,ij,zj,z) Rate of commodity i margin applied to import m from country zj
 XSO(j,z)        industry j total production
;

*==============================================================================
*  2.3 Loading parameters from GTAP database
*==============================================================================
$LOAD EVOA, FBEP, FTRV, MFRV, OSEP, POP, TFRV, VDEP, VDFA, VDFM, VDGA, VDGM
$LOAD VDPA, VDPM, VFM, VIFA, VIFM, VIGA, VIGM, VIPA, VIPM, VIMS, VIWS, VKB, VST
$LOAD VTWR, VXMD, VXWD, XTRV

*==============================================================================
* 2.4 Mapping between variables in the model and GTAP
*==============================================================================
* NOTE: In GTAP parlance, "agents' prices" are prices paid by buyers, and
*       "market prices" are prices received by sellers.

*==============================================================================
* 2.4.1 Households consumption
*==============================================================================
* Households consumption is given by the sum of domestic purchases at
* agents prices (VDPA) and private household imports at agents prices (VIPA).

 CO(i,z)         = SUM{(trad_comm,reg)$[j2trad_comm(i,trad_comm)$z2reg(z,reg)],
                       VDPA(trad_comm,reg)+VIPA(trad_comm,reg)};

*==============================================================================
* 2.4.2 Public final consumption
*==============================================================================
* Public final consumption is given by the sum of domestic purchases at
* agents prices (VDGA) and public final imports at agents prices (VIGA).

 CGO(i,z)        = SUM{(trad_comm,reg)$[j2trad_comm(i,trad_comm)$z2reg(z,reg)],
                       VDGA(trad_comm,reg)+VIGA(trad_comm,reg)};

*==============================================================================
* 2.4.3 Demand for investment purposes
*=============================================================================
*  In the GTAP data, the accumulation account is presented in the
*  production sector CGDS (Capital goods). Demand for investment purposes
*  is thus given by the sum of domestic purchases at agents prices (VDFA)
*  and public final imports at agents prices (VIFA) for this sector.

 INVO(i,z)       = SUM{(trad_comm,reg)$[j2trad_comm(i,trad_comm)$z2reg(z,reg)],
                      VDFA(trad_comm,'CGDS',reg)+VIFA(trad_comm,'CGDS',reg)};

*==============================================================================
* 2.4.4 Intermediate demand
*==============================================================================
* Intermediate consumption is given by the sum of domestic purchases at
* agents prices (VDFA) and public final imports at agents prices (VIFA).

 DIO(i,j,z)      = SUM[(trad_comm,trad_commj,reg)$[j2trad_comm(i,trad_comm)
                      $j2trad_comm(j,trad_commj)$z2reg(z,reg)],
                      VDFA(trad_comm,trad_commj,reg)
                     +VIFA(trad_comm,trad_commj,reg)];

*==============================================================================
* 2.4.5 Imports
*==============================================================================
* Imports are defined in GTAP at world prices (VIWS) and at market prices
* (VIMS). Data on bilateral flows also include margins on imports (VTWR) and
* import duties (TFRV). On the export side, the database includes exports at
* market prices (VXMD), at world prices (VXWD) and subsidies on exports (MFRV
* and XTRV).
* The relationships between those variables is the following:
*       VIMS = VIWS + TFRV
*       VIWS = VXWD + VTWR
*       VXMD = VXWD - MFRV - XTRV
*
* Imports are evaluated at world prices (VIWS) less transport margins (VTWR).

** Elimination of trade within a country:
** Trade within any entity that is a GTAP single-country region (or equivalent)
** is removed.
 VIWS(trad_comm,z1c,z1c)           = 0;
 VTWR(marg_comm,trad_comm,z1c,z1c) = 0;

 IMO(i,zj,z)     = SUM{(trad_comm,regj,reg)$[j2trad_comm(i,trad_comm)
                       $z2reg(zj,regj)$z2reg(z,reg)],
                       VIWS(trad_comm,regj,reg)-
                       SUM[marg_comm,VTWR(marg_comm,trad_comm,regj,reg)]};

*==============================================================================
* 2.4.6 Exports
*==============================================================================
*  To limit the sources of potential desequilibrium, exports are simply set
*  equal to imports.

 EXO(i,zj,z)     = IMO(i,zj,z);

*==============================================================================
* 2.4.7 Margins
*==============================================================================
*  Transport margins are given by the variable VTWR
 tmrg('ser',ij,zj,z)$IMO(ij,zj,z)
                 = SUM{(trad_comm,regj,reg)$[j2trad_comm(ij,trad_comm)
                       $z2reg(zj,regj)$z2reg(z,reg)],
                       SUM[marg_comm,VTWR(marg_comm,trad_comm,regj,reg)]};

* Supply of transport margin are given by the variable VST
 MRGNO(i,z)      = SUM{(marg_comm,reg)$[j2trad_comm(i,marg_comm)$z2reg(z,reg)],
                       VST(marg_comm,reg)};

*==============================================================================
* 2.4.8 Import duties
*==============================================================================
*  Import duties are given by the variable TFRV

 TIMO(i,zj,z)$IMO(i,zj,z)
                 = SUM{(trad_comm,regj,reg)$[j2trad_comm(i,trad_comm)
                       $z2reg(zj,regj)$z2reg(z,reg)],
                       TFRV(trad_comm,regj,reg)};

*==============================================================================
* 2.4.9 Taxes on exports
*==============================================================================
*  Taxes on exports are given by the sum of MRRV and XTRV

 TIXO(i,z,zj)$IMO(i,z,zj)
                 = SUM{(trad_comm,reg,regj)$[j2trad_comm(i,trad_comm)
                       $z2reg(z,reg)$z2reg(zj,regj)],
                       MFRV(trad_comm,reg,regj)+XTRV(trad_comm,reg,regj)};

*==============================================================================
* 2.4.10 Taxes on factors of production
*==============================================================================
* Net taxes on factor of production are calculated as taxes (FTRV)
* less subsidies (FBEP).

 TIWO(l,j,z)      = SUM{(endw_comm,trad_comm,reg)$[f2endw_comm(l,endw_comm)
                       $j2trad_comm(j,trad_comm)$z2reg(z,reg)],
                       FTRV(endw_comm,trad_comm,reg)-
                       FBEP(endw_comm,trad_comm,reg)};

 TIKO(k,j,z)     = SUM{(endw_comm,trad_comm,reg)$[f2endw_comm(k,endw_comm)
                       $j2trad_comm(j,trad_comm)$z2reg(z,reg)],
                       FTRV(endw_comm,trad_comm,reg)-
                       FBEP(endw_comm,trad_comm,reg)};

*==============================================================================
* 2.4.11 Taxes on production
*==============================================================================
* Taxes on production are set equal to the negative value of production
* subsidies (OSEP).

 TIPO(j,z)       = -SUM{(trad_comm,reg)$[j2trad_comm(j,trad_comm)$z2reg(z,reg)],
                       OSEP(trad_comm,reg)};

*==============================================================================
* 2.4.12 Domestic taxes on commodities
*==============================================================================
* Domestic taxes on commodities are evaluated as the difference between
* demand at agent prices and demand at market prices.

 TICO(i,z)       = SUM{(trad_comm,reg)$[j2trad_comm(i,trad_comm)$z2reg(z,reg)],
                      VDPA(trad_comm,reg)-VDPM(trad_comm,reg)
                     +VIPA(trad_comm,reg)-VIPM(trad_comm,reg)
                     +VDGA(trad_comm,reg)-VDGM(trad_comm,reg)
                     +VIGA(trad_comm,reg)-VIGM(trad_comm,reg)
                     +SUM[prod_comm,VDFA(trad_comm,prod_comm,reg)
                          +VIFA(trad_comm,prod_comm,reg)]
                     -SUM[prod_comm,VDFM(trad_comm,prod_comm,reg)
                          +VIFM(trad_comm,prod_comm,reg)]};

*==============================================================================
* 2.4.13 Direct taxes
*==============================================================================
* Direct taxes is given by the difference between factor payment at
* market prices (VFM) and endowment at agent prices (EVOA)

 TDHO(z)         = SUM{reg$z2reg(z,reg),
                       SUM[endw_comm,SUM(prod_comm,VFM(endw_comm,prod_comm,reg))
                       -EVOA(endw_comm,reg)]};

*==============================================================================
* 2.4.14 Factors of production
*==============================================================================
* Remuneration of the production factors is evaluated at market prices,
* that is before taxes (VFM).

 LDO(l,j,z)      = SUM{(endw_comm,trad_comm,reg)$[f2endw_comm(l,endw_comm)
                       $j2trad_comm(j,trad_comm)$z2reg(z,reg)],
                       VFM(endw_comm,trad_comm,reg)};

 RKDO(k,j,z)      = SUM{(endw_comm,trad_comm,reg)$[f2endw_comm(k,endw_comm)
                       $j2trad_comm(j,trad_comm)$z2reg(z,reg)],
                       VFM(endw_comm,trad_comm,reg)};

* Total capital stock at the beginning of the period
 KSTO(z)         = SUM{reg$z2reg(z,reg),VKB(reg)};

*==============================================================================
* 2.4.15 Depreciation
*==============================================================================
* Depreciation is given by the variable VDEP

 DEPO(z)         = SUM{reg$z2reg(z,reg),VDEP(reg)};

*==============================================================================
* 2.4.16 Population
*==============================================================================
*  Population by region
 POPO(z)         = SUM{reg$z2reg(z,reg),POP(reg)};


*==============================================================================
* 2.4.17 Domestic demand
*==============================================================================
* Once again, to avoid descrepencies, domestic purchases are calculated
* by substracting imports, transport margins and indirect taxes from total
* domestic absorption.

 DDO(i,z)        = CO(i,z)+CGO(i,z)+INVO(i,z)+SUM[j,DIO(i,j,z)]-TICO(i,z)
                   -SUM[zj,TIMO(i,zj,z)]-SUM[zj,IMO(i,zj,z)]
                   -SUM[(ij,zj),tmrg(ij,i,zj,z)];

*==============================================================================
* 2.5 Equilibrate data
*==============================================================================
*  2.5.1 Equilibrium on the world margin market
*==============================================================================
*  The first step would be to equilibrate international markets. As there is a
*  small difference between supply of margins and demand, we chose to adjust
*  the supply side by increasing or reducing each region's production
*  proportionately.

 MRGNO(i,z)$MRGNO(i,z)
                 = MRGNO(i,z)*SUM[(ij,zj,zjj),tmrg(i,ij,zj,zjj)]
                  /SUM[zjj,MRGNO(i,zjj)];

**==============================================================================
* 2.5.2 Equilibrium in each region
*==============================================================================
*  As exports have already been set equal to imports, the remaining differences
*  would appear in the national data. Total production is first set equal to
*  the sum of production for the domestic market (DSO), adjusted production
*  of margins (MRGNO) and exports.

 DSO(i,z)        = DDO(i,z);
 XSO(j,z)        = DSO(j,z)+MRGNO(j,z)+SUM[zj,EXO(j,z,zj)-TIXO(j,z,zj)];

*  The operating surplus is the variable that was used to equilibrate the
*  regional data. As all other variables (income, savings and so on) will
*  be calculated based on the variables described in these steps, there
*  should not be any other descrepency.

 RKDO('cap',j,z)  = XSO(j,z)-SUM[i,DIO(i,j,z)]-SUM[l,LDO(l,j,z)+TIWO(l,j,z)]
                   -TIPO(j,z)-SUM[k,TIKO(k,j,z)]-RKDO('land',j,z)
                   -RKDO('natr',j,z);


*==============================================================================
* 3. CES elasticities
*==============================================================================
* 3.1 Definition of GTAP parameters
*==============================================================================
PARAMETER
 ESUBD(trad_comm)  Elasticity of substitution between domestic product and imports
 ESUBM(trad_comm)  Elasticity of substitution between imports from different regions
 ESUBVA(prod_comm) Elasticity of substitution between primary factors in the production of value added

*==============================================================================
* 3.2 Definition in PEP w
*==============================================================================
 sigma_M1(i,z)   Elasticity (CES - composite commodity)
 sigma_M2(i,z)   Elasticity (CES - composite import)
 sigma_VA(j,z)   Elasticity (CES - value added)

*==============================================================================
* 3.3 Temporary variables
*==============================================================================
 IM_GTAP(trad_comm,z) Total imports using the GTAP commodity sets
 Q_GTAP(trad_comm,z)  Composite commodity using the GTAP commodity sets
 SH_IM(trad_comm,i,z) Share of each import TRAD_COM in aggregation i for region z
 SH_Q(trad_comm,i,z)  Share of each composite commodity TRAD_COM in aggregation i for region z
 SH_VA(trad_comm,j,z) Share of each sector TRAD_COM in aggregation j for region z
 VA_GTAP(trad_comm,z) Value added using the GTAP sectors
;

*==============================================================================
* 3.4 Load the GTAP file which includes the parameters
*==============================================================================
$GDXIN Parameters2007.gdx
$LOAD ESUBD, ESUBM, ESUBVA

*==============================================================================
*  3.5 sigma_M1
*==============================================================================
* Elasticities of substitution between domestic product and imports are
* aggregated acording to the share of each commodity (QO) TRAD_COMM in total I

 Q_GTAP(trad_comm,z)
                 = SUM{reg$z2reg(z,reg),
                   VDPA(trad_comm,reg)+VIPA(trad_comm,reg)+
                   VDGA(trad_comm,reg)+VIGA(trad_comm,reg)+
                   VDFA(trad_comm,'CGDS',reg)+VIFA(trad_comm,'CGDS',reg)+
                   SUM[trad_commj,VDFA(trad_comm,trad_commj,reg)+
                       VIFA(trad_comm,trad_commj,reg)]};

 SH_Q(trad_comm,i,z)$j2trad_comm(i,trad_comm)
                 = Q_GTAP(trad_comm,z)/
                   SUM{trad_commj$j2trad_comm(i,trad_commj),
                       Q_GTAP(trad_commj,z)};

 sigma_M1(i,z)   = SUM{trad_comm$j2trad_comm(i,trad_comm),
                   ESUBD(trad_comm)*SH_Q(trad_comm,i,z)};

*==============================================================================
*  3.6 sigma_M2
*==============================================================================
* Elasticities of substitution between imports from different partners are
* aggregated acording to the share of total import (IMTO) TRAD_COMM in total I

 IM_GTAP(trad_comm,z)
                 = SUM[regj,SUM{reg$z2reg(z,reg),VIWS(trad_comm,regj,reg)}];

 SH_IM(trad_comm,i,z)$j2trad_comm(i,trad_comm)
                 = IM_GTAP(trad_comm,z)/
                   SUM{trad_commj$j2trad_comm(i,trad_commj),
                       IM_GTAP(trad_commj,z)};

 sigma_M2(i,z)   = SUM{trad_comm$j2trad_comm(i,trad_comm),
                   ESUBM(trad_comm)*SH_IM(trad_comm,i,z)};

*==============================================================================
*  3.7 sigma_VA
*==============================================================================
* Elasticities of substitution between factors of production are aggregated
* acording to the share of each sector (VA) TRAD_COMM in total I

 VA_GTAP(trad_comm,z)
                 = SUM{endw_comm,
                       SUM[reg$z2reg(z,reg),VFM(endw_comm,trad_comm,reg)]};

 SH_VA(trad_comm,j,z)$j2trad_comm(j,trad_comm)
                 = VA_GTAP(trad_comm,z)/
                   SUM{trad_commj$j2trad_comm(j,trad_commj),
                       VA_GTAP(trad_commj,z)};

 sigma_VA(j,z)   = SUM{trad_comm$j2trad_comm(j,trad_comm),
                   ESUBVA(trad_comm)*SH_VA(trad_comm,j,z)};

*==============================================================================
* 4. Projections used in PEP w-t model
*==============================================================================
* The following file includes data from:
* Source: "The Great Shift: Macroeconomic projections for the world economy at
* the 2050 horizon" CEPII Working Paper 2012-03
* by Jean Foure, Agnes Benassy-Quere & Lionel Fontagne
* February 2012.

** * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * **
**NOTE THAT THE FOLLOWING GTAP8.1 REGIONS ARE ABSENT FROM THE PROJECTIONS**
**   aze, ben, bfa, cyp, ecu, gin, hrv, nam, rwa, slv, svn, tgo, twn,    **
**   xea, xer, xna, xtw, zwe                                             **
** * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * **

$include Projection.gms
* Data on total and active population are expressed in thousands
* Data on GDP is expressed in millions of USD
PARAMETER
 ACT_POP(z,time)         Active population from 1980 to 2050 based on the PEP w aggregation
 ACT_POP_GTAP8(reg,time) Active population from 1980 to 2050 based on the GTAP8 aggregation
 CAB_Foure(z,time)       Implicit CAB in Foure et al projections
 exogro(z,time)          Exogenous growth factor for exogenously growing variables
 exogro_LS(z,time)       Exogenous growth factor for exogenously growing labor supply
 g_GDP(z,time)           GDP growth
 g_KS(z,time)            Capital stock growth rate
 g_LS(z,time)            Active population growth rate
 g_POP(z,time)           Population growth rate
 g_SDR(z,time)           Domestic savings rate growth rate
 GDP(z,time)             GDP projection based on the PEP w aggregation
 GDP_GTAP8(reg,time)     GDP from 1980 to 2050 based on the GTAP8 aggregation
 gdp_per_cap(z)          GDP per capita
 I_rate(z,time)          Investment rate - domestic savings over GDP
 Invest(z,time)          Investments from 1980 to 2050 based on PEP w aggregation
 Invest_GTAP8(reg,time)  Investments from 1980 to 2050 based on GTAP8 aggregation
 K_Stock_GTAP8(reg,time) Capital stock from 1980 to 2050 based on the GTAP8 aggregation
 K_Stock(z,time)         Capital stock from 1980 to 2050 based on the PEP w aggregation
 TFP(z,time)             Total factor productivity index 1980-2050 for PEP w aggregation
 TFP_GTAP8(reg,time)     Total factor productivity 1980-2050 for GTAP8 aggregation
 S_rate(z,time)          Savings rate - domestic savings over GDP
 Savings(z,time)         Domestic savings from 1980 to 2050 based on PEP w aggregation
 Savings_GTAP8(reg,time) Domestic savings from 1980 to 2050 based on GTAP8 aggregation
 sdr_fac(z,time)         Exogenous change factor for domestic savings rate
 TOT_POP(z,time)         Total population from 1980 to 2050 based on the PEP w aggregation
 TOT_POP_GTAP8(reg,time) Total population from 1980 to 2050 based on the GTAP8 aggregation
;

*==============================================================================
* 4.1 Real GDP projections
*==============================================================================
 GDP_GTAP8(reg,time)     = Projection('GDP_K',reg,time);
 GDP(z,time)             = SUM{reg$z2reg(z,reg),GDP_GTAP8(reg,time)};

loop{time$[time.val lt 2050],
 g_GDP(z,time)           = [GDP(z,time+1)/GDP(z,time)]-1;
};
 g_GDP(z,time)$[time.val ge 2050]
                         = g_GDP(z,time-1);

*==============================================================================
* 4.2 Active population projections
*==============================================================================
 ACT_POP_GTAP8(reg,time) = Projection('PopAc',reg,time);
 ACT_POP(z,time)         = SUM{reg$z2reg(z,reg),ACT_POP_GTAP8(reg,time)};
loop{time$[time.val lt 2050],
 g_LS(z,time)            = [ACT_POP(z,time+1)/ACT_POP(z,time)]-1;
};
 g_LS(z,time)$[time.val ge 2050]
                         = g_LS(z,time-1);
 exogro_LS(z,'2007')     = 1;
loop{time$([time.val gt 2007] and [time.val le 2050]),
 exogro_LS(z,time)       = exogro_LS(z,time-1)*[1+g_LS(z,time-1)];
};

*==============================================================================
* 4.3 Total population projections
*==============================================================================
 TOT_POP_GTAP8(reg,time) = Projection ('Pop',reg,time);
 TOT_POP(z,time)         = SUM{reg$z2reg(z,reg),TOT_POP_GTAP8(reg,time)};
loop{time$[time.val lt 2050],
 g_POP(z,time)           = [TOT_POP(z,time+1)/TOT_POP(z,time)]-1;
};
 g_POP(z,time)$[time.val ge 2050]
                         = g_POP(z,time-1);

*==============================================================================
* 4.4 Growth factor
*==============================================================================
* In the projections of Fouré et al. (2012), the growth rate of labor,
* based on demographic variables, is generally much more stable than the
* growth rate of either GDP, or output per worker. In order to obtain a smooth
* reference scenario, we suggest using a 10 year moving average.

 exogro(z,'2007')        = 1;
loop{time$([time.val gt 2007] and [time.val le 2050]),
 exogro(z,time)          = exogro(z,time-1)*[1+g_LS(z,time-1)]*
            SUM[timej${(timej.val ge time.val-5) and (timej.val le time.val+4)},
                [1+g_GDP(z,timej)]/[1+g_LS(z,timej)]]/10;
};

*==============================================================================
* 4.5 Total factor productivity projections
*==============================================================================
 TFP_GTAP8(reg,time)            = Projection ('TFPxGDP',reg,time);
 TFP(z,time)                    = SUM{reg$z2reg(z,reg),TFP_GTAP8(reg,time)};
 TFP(z,time)$[time.val le 2050] = TFP(z,time)/GDP(z,time);
 TFP(z,time)                    = TFP(z,time)/TFP(z,'2007');

*==============================================================================
* 4.6 Capital stock projections
*==============================================================================
 K_Stock_GTAP8(reg,time) = Projection ('K_Stock',reg,time);
 K_Stock(z,time)         = SUM{reg$z2reg(z,reg),K_Stock_GTAP8(reg,time)};

loop{time$[time.val lt 2050],
 g_KS(z,time)           = [K_Stock(z,time+1)/K_Stock(z,time)]-1;
};
 g_KS(z,time)$[time.val ge 2050]
                         = g_KS(z,time-1);

*==============================================================================
* 4.7 Savings and savings rate projections
*==============================================================================
 Savings_GTAP8(reg,time) = Projection ('Savings',reg,time);
 Savings(z,time)         = SUM{reg$z2reg(z,reg),Savings_GTAP8(reg,time)};
 S_rate(z,time)$Savings(z,time) = Savings(z,time)/GDP(z,time);

loop{time$[time.val lt 2050],
 g_SDR(z,time)           = [S_rate(z,time+1)/S_rate(z,time)]-1;
};
 g_SDR(z,time)$[time.val ge 2050]
                         = g_SDR(z,time-1);
 sdr_fac(z,'2007')        = 1;
loop{time$([time.val gt 2007] and [time.val le 2050]),
 sdr_fac(z,time)          = sdr_fac(z,time-1)*[1+g_SDR(z,time-1)];
};

*==============================================================================
* 4.8 Investments, investment rate projections and implicit CAB
*==============================================================================
 Invest_GTAP8(reg,time) = Projection ('Invest',reg,time);
 Invest(z,time)         = SUM{reg$z2reg(z,reg),Invest_GTAP8(reg,time)};
 I_rate(z,time)$Invest(z,time) = Invest(z,time)/GDP(z,time);
 CAB_Foure(z,time)      = Savings(z,time) - Invest(z,time);

*==============================================================================
* 5. Endogenous definition of set for rich regions/countries
*==============================================================================
* In the World Bank's 2007 World Development Indicators, "High-income" countries
* are defined as those with a per capita Gross National Income of 10726USD
* or above. Since there is no income from abroad in PEP-w-t, GDP is equal to
* GNI, and we define high-income economies according to GDP per capita.

 gdp_per_cap(z)  = [GDP(z,'2007')*1000000]/[TOT_POP(z,'2007')*1000];
 Zrich(Z)        = yes$[gdp_per_cap(z) ge 10726];
 Zother(Z)       = yes$[not Zrich(Z)];

execute_unload 'DATA_AGG-2007',
*Sets used in PEP w-1 and PEP w-t
 J, I1, BUS, PUB, F, L, K, Z, ZR, Z1, Zrich, Zother

*Benchmark variables and parameters used in PEP w-1 and PEP w-t
 CO, CGO, DDO, DEPO, DIO, DSO, EXO, IMO, INVO, KSTO, LDO, MRGNO, POPO, RKDO,
 TDHO, TICO, TIKO, TIMO, TIPO, TIWO, TIXO, tmrg, XSO, sigma_M1, sigma_M2,
 sigma_VA

*Parameters used in PEP w-t only
 exogro, exogro_LS, sdr_fac, g_POP, g_SDR, g_GDP, g_LS

*Other parameters that are not used in the PEP w models
* TFP, g_KS, GDP, ACT_POP, TOT_POP, K_Stock, Savings, S_rate, Invest, I_rate,
* CAB_Foure
;
