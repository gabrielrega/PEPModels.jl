$TITLE     PEP standard model 1-t, version 2.0
$STITLE    Single country dynamic version, July 2013
$STITLE    Version B: Resolution using the loop command (one period at a time)

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

* 1 Set definition

** 1.1 Industries and commodities

SET

J All industries
/
 agr             Agriculture and other primary industries
 ind             Manufacturing and construction
 ser             Services
 adm             Public administration
/

PUB(J) Public industries
/
 adm             Public administration
/

BUS(J) Private industries
/
 agr             Agriculture and other primary industries
 ind             Manufacturing and construction
 ser             Services
/

I All commodities
/
 agr             Agriculture and other primary commodities
 food            Food and beverages
 othind          Other manufacturing and construction
 ser             Services
 adm             Public administration
/

I1(I) All commodities except agriculture
/
* agr             Agriculture and other primary commodities
 food            Food and beverages
 othind          Other manufacturing and construction
 ser             Services
 adm             Public administration
/


** 1.2 Production factors

L Labor categories
/
 usk             Unskilled workers
 sk              Skilled workers
/

K Capital categories
/
 cap             Capital
 land            Land
/


** 1.3 Agents

AG All agents
/
 hrp             Poor rural households
 hup             Poor urban households
 hrr             Rich rural households
 hur             Rich urban households
 firm            Firms
 gvt             Government
 row             Rest of the world
/

AGNG(AG) Non governmental agents
/
 hrp             Poor rural households
 hup             Poor urban households
 hrr             Rich rural households
 hur             Rich urban households
 firm            Firms
* gvt             Government
 row             Rest of the world
/

AGD(AG) All domestic agents
/
 hrp             Poor rural households
 hup             Poor urban households
 hrr             Rich rural households
 hur             Rich urban households
 firm            Firms
 gvt             Government
* row             Rest of the world
/

H(AG) Households
/
 hrp             Poor rural households
 hup             Poor urban households
 hrr             Rich rural households
 hur             Rich urban households
/

F(AG) Firms
/
 firm            Firms
/

** 1.4 Periods

TIME Time periods
/
1*10
/

T(TIME)

T1(time) First period;
T1(time) = yes$[ord(time) eq 1];

ALIAS (j,jj)
ALIAS (i,ij)
ALIAS (ag,agj)
ALIAS (h,hj)
ALIAS (l,lj)
ALIAS (k,kj)
;


* 2 Parameters and benchmark variables definition

** 2.1 Parameters

PARAMETERS
 aij(i,j)        Input output coefficient
 alpha           Tobin q
 A_K_PRI         Scale parameter (private investment funtion)
 A_K_PUB         Scale parameter (public investment funtion)
 B_KD(j)         Scale parameter (CES - composite capital)
 B_LD(j)         Scale parameter (CES - composite labor)
 B_M(i)          Scale parameter (CES - composite commodity)
 B_VA(j)         Scale parameter (CES - value added)
 B_X(j,i)        Scale parameter (CET - exports and local sales)
 B_XT(j)         Scale parameter (CET - total output)
 beta_KD(k,j)    Share parameter (CES - composite capital)
 beta_LD(l,j)    Share parameter (CES - composite labor)
 beta_M(i)       Share parameter (CES - composite commodity)
 beta_VA(j)      Share parameter (CES - value added)
 beta_X(j,i)     Share parameter (CET - exports and local sales)
 beta_XT(j,i)    Share parameter (CET - total output)
 delta(k,j)      Depreciation rate of capital k in industry j
 eta             Price elasticity of indexed transfers and parameters
 frisch(h)       Frisch parameter (LES function)
 gamma_GVT(i)    Share of commodity i in total current public expenditures on goods and services
 gamma_INVPRI(i) Share of commodity i in total private investment expenditures
 gamma_INVPUB(i) Share of commodity i in total public investment expenditures
 gamma_LES(i,h)  Marginal share of commodity i in household h consumption budget
 io(j)           Coefficient (Leontief - intermediate consumption)
 lambda_RK(ag,k) Share of type k capital income received by agent ag
 lambda_TR(ag,agj) Share parameter (transfer functions)
 lambda_WL(h,l)  Share of type l labor income received by type h households
 n(time)         Population growth rate
 n1              Population growth rate for the first period
 phi(k,j)        Scale parameter (allocation of investment to industries)
 pop(time)       Population index
 rho_KD(j)       Elasticity parameter (CES - composite capital)
 rho_LD(j)       Elasticity parameter (CES - composite labor)
 rho_M(i)        Elasticity parameter (CES - composite good)
 rho_VA(j)       Elasticity parameter (CES - value added)
 rho_X(j,i)      Elasticity parameter (CET - exports and local sales)
 rho_XT(j)       Elasticity parameter (CET - total output)
 sigma_INV(k,j)  Elasticity (investment demand)
 sigma_KD(j)     Elasticity (CES - composite capital)
 sigma_LD(j)     Elasticity (CES - composite labor)
 sigma_M(i)      Elasticity (CES - composite good)
 sigma_VA(j)     Elasticity (CES - value added)
 sigma_X(j,i)    Elasticity (CET - exports and local sales)
 sigma_XT(j)     Elasticity (CET - total output)
 sigma_XD(i)     Price elasticity of the world demand for exports of product i
 sigma_Y(i,h)    Income elasticity of consumption
 tmrg(i,ij)      Rate of margin i applied to commodity ij
 tmrg_X(i,ij)    Rate of margin i applied to exported commodity x
 v(j)            Coefficient (Leontief - value added)


** 2.2 Variables - Benchmark
* Benchmark values of variables are parameters.
* Their acronyms are the corresponding variable names,
* followed by the letter "O".

**  2.2.1 Volume variables
 CO(i,h)         Consumption of commodity i by type h households
 CGO(i)          Public consumption of commodity i
 CIO(j)          Total intermediate consumption of industry j
 CMINO(i,h)      Minimum consumption of commodity i by type h households
 CTH_REALO(h)    Real consumption budget of type h households
 DDO(i)          Domestic demand for commodity i produced locally
 DIO(i,j)        Intermediate consumption of commodity i by industry j
 DITO(i)         Total intermediate demand of commodity i
 DSO(j,i)        Supply of commodity i by industry j to the domestic market
 EXO(j,i)        Quantity of product i exported by industry j
 EXDO(i)         World demand for exports of product i
 G_REALO         Real current government expenditures on goods and services
 GDP_BP_REALO    Real GDP at basic prices
 GDP_MP_REALO    Real GDP at market prices
 GFCF_PRI_REALO  Real private gross fixed capital formation
 GFCF_PUB_REALO  Real public gross fixed capital formation
 IMO(i)          Quantity of product i imported
 INDO(k,j)       Volume of new type k capital investment to industry j
 INVO(i)         Final demand of commodity i for investment purposes (GFCF)
 INV_PRIO(i)     Final demand of commodity i for private investment purposes
 INV_PUBO(i)     Final demand of commodity i for public investment purposes
 KDO(k,j)        Demand for type k capital by industry j
 KDCO(j)         Industry j demand for composite capital
 KSO(k)          Supply of type k capital
 LDO(l,j)        Demand for type l labor by industry j
 LDCO(j)         Industry j demand for composite labor
 LSO(l)          Supply of type l labor
 MRGNO(i)        Demand for commodity i as a trade or transport margin
 QO(i)           Quantity demanded of composite commodity i
 VAO(j)          Value added of industry j
 VSTKO(i)        Inventory change of commodity i
 XSO(j,i)        Industry j production of commodity i
 XSTO(j)         Total aggregate output of industry j

**  2.2.2 Price variables
 eO              Exchange rate (price of foreign currency in local currency)
 IRO             Interest rate
 PO(j,i)         Basic price of industry j's production of commodity i
 PCO(i)          Purchaser price of composite comodity i (including all taxes and margins)
 PCIO(j)         Intermediate consumption price index of industry j
 PDO(i)          Price of local product i sold on the domestic market (including all taxes and margins)
 PEO(i)          Price received for exported commodity i (excluding export taxes)
 PE_FOBO(i)      FOB price of exported commodity i (in local currency)
 PIXCONO         Consumer price index
 PIXGDPO         GDP deflator
 PIXGVTO         Public expenditures price index
 PIXINV_PRIO     Private investment price index
 PIXINV_PUBO     Public investment price index
 PK_PRIO         Price of new private capital
 PK_PUBO         Price of new public capital
 PLO(i)          Price of local product i (excluding all taxes on products)
 PMO(i)          Price of imported product i (including all taxes and tariffs)
 PPO(j)          Industry j unit cost including taxes directly related to the use of capital and labor but excluding other taxes on production
 PTO(j)          Basic price of industry j's output
 PVAO(j)         Price of industry j value added (including taxes on production directly related to the use of capital and labor)
 PWMO(i)         World price of imported product i (expressed in foreign currency)
 PWXO(i)         World price of exported product i (expressed in foreign currency)
 RO(k,j)         Rental rate of type k capital in industry j
 RCO(j)          Rental rate of industry j composite capital
 RTIO(k,j)       Rental rate paid by industry j for type k capital including capital taxes
 UO(k,j)         User cost of type k capital in industry j
 WO(l)           Wage rate of type l labor
 WCO(j)          Wage rate of industry j composite labor
 WTIO(l,j)       Wage rate paid by industry j for type l labor including payroll taxes

**  2.2.3 Nominal (value) variables
 CABO            Current account balance
 CTHO(h)         Consumption budget of type h households
 GO              Current government expenditures on goods and services
 GDP_BPO         GDP at basic prices
 GDP_FDO         GDP at purchasers' prices from the perspective of final demand
 GDP_IBO         GDP at market prices (income-based)
 GDP_MPO         GDP at market prices
 GFCFO           Gross fixed capital formation
 ITO             Total investment expenditures
 IT_PRIO         Total private investment expenditures
 IT_PUBO         Total public investment expenditures
 RKDO(k,j)       Type k capital income in industry j
 SFO(f)          Savings of type f businesses
 SGO             Government savings
 SHO(h)          Savings of type h households
 SROWO           Rest-of-the-world savings
 TDFO(f)         Income taxes of type f businesses
 TDFTO           Total government revenue from business income taxes
 TDHO(h)         Income taxes of type h households
 TDHTO           Total government revenue from household income taxes
 TICO(i)         Government revenue from indirect taxes on product i
 TICTO           Total government receipts of indirect taxes on commodities
 TIKO(k,j)       Government revenue from taxes on type k capital used by industry j
 TIKTO           Total government revenue from from taxes on capital
 TIMO(i)         Government revenue from import duties on product i
 TIMTO           Total government revenue from import duties
 TIPO(j)         Government revenue from taxes on industry j production (excluding taxes directly related to the use of capital and labor)
 TIPTO           Total government revenue from production taxes (excluding taxes directly related to the use of capital and labor)
 TIWO(l,j)       Government revenue from payroll taxes on type l labor in industry j
 TIWTO           Total government revenue from payroll taxes
 TIXO(i)         Government revenue from export taxes on product i
 TIXTO           Total government revenue from export taxes
 TPRCTSO         Total government revenue from taxes on products and imports
 TPRODNO         Total government revenue from other taxes on production
 TRO(ag,agj)     Transfers from agent agj to agent ag
 YDFO(f)         Disposable income of type f businesses
 YDHO(h)         Disposable income of type h households
 YFO(f)          Total income of type f businesses
 YFKO(f)         Capital income of type f businesses
 YFTRO(f)        Transfer income of type f businesses
 YGO             Total government income
 YGKO            Government capital income
 YGTRO           Government transfer income
 YHO(h)          Total income of type h households
 YHKO(h)         Capital income of type h households
 YHLO(h)         Labor income of type h households
 YHTRO(h)        Transfer income of type h households
 YROWO           Rest-of-the-world income

**  2.2.4 Rates and intercepts
 sh0O(h)         Intercept (type h household savings)
 sh1O(h)         Slope (type h household savings)
 tr0O(h)         Intercept (transfers by type h households to government)
 tr1O(h)         Marginal rate of transfers by type h households to government
 ttdf0O(f)       Intercept (income taxes of type f businesses)
 ttdf1O(f)       Marginal income tax rate of type f businesses
 ttdh0O(h)       Intercept (income taxes of type h households)
 ttdh1O(h)       Marginal income tax rate of type h households
 tticO(i)        Tax rate on commodity i
 ttikO(k,j)      Tax rate on type k capital used in industry j
 ttimO(i)        Rate of taxes and duties on imports of commodity i
 ttipO(j)        Tax rate on the production of industry j
 ttiwO(l,j)      Tax rate on type l worker compensation in industry j
 ttixO(i)        Export tax rate on exported commodity i
;


* 3 Data

** 3.1 Data from the SAM
*  SAM data are nominal values. However, several volume variables are
*  provisionally set equal to the corresponding nominal SAM value. Once the
*  benchmark prices have been set or calibrated, volumes will be re-calculated
*  (section 4.4).


PARAMETER
SAM(*,*,*,*);

$CALL GDXXRW.EXE SAM-V2_0.xls par=SAM rng=SAM!A4:AJ39 Rdim=2 Cdim=2
$GDXIN SAM-V2_0.gdx
$LOAD SAM
$GDXIN

 CO(i,h)         = SAM('I',i,'AG',h);
 CGO(i)          = SAM('I',i,'AG','gvt');
 DSO(j,i)        = SAM('J',j,'I',i);
 DDO(i)          = SUM[j,DSO(j,i)];
 DIO(i,j)        = SAM('I',i,'J',j);
 EXO(j,i)        = SAM('J',j,'X',i);
 EXDO(i)         = SAM('X',i,'AG','ROW');
 INVO(i)         = SAM('I',i,'OTH','INV');
 VSTKO(i)        = SAM('I',i,'OTH','VSTK');
 IMO(i)          = SAM('AG','ROW','I',i);
 RKDO(k,j)       = SAM('K',k,'J',j);
 LDO(l,j)        = SAM('L',l,'J',j);
 SFO(f)          = SAM('OTH','INV','AG',f);
 SGO             = SAM('OTH','INV','AG','GVT');
 SHO(h)          = SAM('OTH','INV','AG',h);
 SROWO           = SAM('OTH','INV','AG','ROW');
 TDFO(f)         = SAM('AG','TD','AG',f);
 TDHO(h)         = SAM('AG','TD','AG',h);
 TICO(i)         = SAM('AG','TI','I',i);
 TIKO(k,j)       = SAM('AG',k,'J',j);
 TIMO(i)         = SAM('AG','TM','I',i);
 TIPO(j)         = SAM('AG','GVT','J',j);
 TIXO(i)         = SAM('AG','GVT','X',i);
 TIWO(l,j)       = SAM('AG',l,'J',j);
 TRO(ag,agj)     = SAM('AG',ag,'AG',agj);
 lambda_RK(ag,k) = SAM('AG',ag,'K',k);
 lambda_WL(h,l)  = SAM('AG',h,'L',l);
 tmrg(i,ij)      = SAM('I',i,'I',ij);
 tmrg_X(i,ij)    = SAM('I',i,'X',ij);

** 3.2 Other data
*  Some parameters cannot be calibrated using SAM values
** Exogenous parameters

PARAMETER
PARJ(j,*), PARI(i,*), PARJI(j,i), PARAG(*,ag), PART(time,*), PARKJ1(k,j), PARKJ2(k,j);

$CALL GDXXRW.EXE VAL_PAR.xlsx squeeze = 'no' par=PARJ rng=PAR!A5:E9 par=PARI rng=PAR!A12:C17 par=PARJI rng=PAR!A20:F24 par=PARAG rng=PAR!A27:F37 par=PART rng=PAR!A40:B50 par=PARKJ1 rng=PAR!A53:E55 par=PARKJ2 rng=PAR!A58:E60
$GDXIN VAL_PAR.gdx
$LOAD PARJ, PARI, PARJI, PARAG, PART, PARKJ1, PARKJ2
$GDXIN

* Population growth
 n(time)         = PART(time,'n');
 n1              = SUM[t1,n(t1)];
 pop(t1)         = 1;
 loop{time$[ORD(time) gt 1],
 pop(time)       = pop(time-1)*[1+n(time-1)];
 };

* Interest rate
 IRO             = 0.04;

* Elasticity - Investment demand function
 sigma_INV(k,j)  = PARKJ2(k,j);

* Price elasticity (should be set equal to one when verifying model homogeneity)
 eta             = 1;

** CES and CET elasticities
 sigma_KD(j)     = PARJ(j,'sigma_KD');
 sigma_LD(j)     = PARJ(j,'sigma_LD');
 sigma_M(i)      = PARI(i,'sigma_M');
 sigma_VA(j)     = PARJ(j,'sigma_VA');
 sigma_X(j,i)    = PARJI(j,i);
 sigma_XT(j)     = PARJ(j,'sigma_XT');

** Elasticity of international demand for exported commodity i
 sigma_XD(i)     = PARI(i,'sigma_XD');

** LES parameters
 frisch(h)       = PARAG('frisch',h);
 sigma_y(i,h)    = PARAG(i,h);

** Intercepts of transfers, direct taxes and savings
*  One can either choose to assign a value to the intercept and calibrate
*  the slopes accordingly, or the other way around. This type of modelling
*  can be useful to take into account known marginal savings or taxation rates
*  or to deal with negative average saving rates in cases where savings are
*  negative for some household groups.
*  When no further information is available, one can simply set the intercepts
*  to zero and calibrate an average rate: this is what we do here.
 sh0O(h)         = PARAG('sh0O',h);
 tr0O(h)         = PARAG('tr0O',h);
 ttdf0O(f)       = PARAG('ttdf0O',f);
 ttdh0O(h)       = PARAG('ttdh0O',h);

* Also we need to assign values to some prices
 eO              = 1;
 PEO(i)          = 1;
 PLO(i)          = 1;
 PWMO(i)         = 1;
 WO(l)           = 1;


* 4 Calibration

** 4.1 Calculation of income and savings related variables and parameters

 YHKO(h)         = SUM[k,lambda_RK(h,k)];
 YHLO(h)         = SUM[l,lambda_WL(h,l)];
 YHTRO(h)        = SUM[ag,TRO(h,ag)];
 YHO(h)          = YHLO(h)+YHKO(h)+YHTRO(h);
 YDHO(h)         = YHO(h)-TDHO(h)-TRO('gvt',h);
 CTHO(h)         = YDHO(h)-SHO(h)-SUM[agng,TRO(agng,h)];

 YFKO(f)         = SUM[k,lambda_RK(f,k)];
 YFTRO(f)        = SUM[ag,TRO(f,ag)];
 YFO(f)          = YFKO(f)+YFTRO(f);
 YDFO(f)         = YFO(f)-TDFO(f);

 YGKO            = SUM[k,lambda_RK('gvt',k)];
 TDHTO           = SUM[h,TDHO(h)];
 TDFTO           = SUM[f,TDFO(f)];
 TICTO           = SUM[i,TICO(i)];
 TIMTO           = SUM[i,TIMO(i)];
 TIXTO           = SUM[i,TIXO(i)];
 TIWTO           = SUM[(l,j),TIWO(l,j)];
 TIKTO           = SUM[(k,j),TIKO(k,j)];
 TIPTO           = SUM[j,TIPO(j)];
 TPRODNO         = TIKTO+TIWTO+TIPTO;
 TPRCTSO         = TICTO+TIMTO+TIXTO;
 YGTRO           = SUM[ag,TRO('gvt',ag)];
 YGO             = YGKO+TDHTO+TDFTO+TPRODNO+TPRCTSO+YGTRO;

 YROWO           = SUM[i,IMO(i)]+SUM[k,lambda_RK('row',k)]
                  +SUM[ag,TRO('row',ag)];
 CABO            = -SROWO;

 ITO             = SUM[h,SHO(h)]+SUM[f,SFO(f)]+SGO+SROWO;

 lambda_RK(ag,k) = lambda_RK(ag,k)/SUM[j,RKDO(k,j)];
 lambda_WL(h,l)  = lambda_WL(h,l)/SUM[j,LDO(l,j)];
 lambda_TR(agng,h)
                 = TRO(agng,h)/YDHO(h);
 lambda_TR(ag,f) = TRO(ag,f)/YDFO(f);

 sh1O(h)         = [SHO(h)-sh0O(h)]/YDHO(h);
 tr1O(h)         = [TRO('gvt',h)-tr0O(h)]/YHO(h);

** 4.2 Calibration of investment and government spending shares

 gamma_GVT(i)    = CGO(i)/SUM[ij,CGO(ij)];

*  As in this SAM we do not have private investment separate from public
*  investment, we will assume that the investment shares are the same.

 gamma_INVPRI(i) = INVO(i)/SUM[ij,INVO(ij)];
 gamma_INVPUB(i) = gamma_INVPRI(i);


** 4.3 Calibration of income tax rates
 ttdf1O(f)      = [TDFO(f)-ttdf0O(f)]/YFKO(f);
 ttdh1O(h)      = [TDHO(h)-ttdh0O(h)]/YHO(h);


** 4.4 Calibration of margins, prices and volumes

 PCO(i)          = [DDO(i)+IMO(i)+SUM(ij, tmrg(ij,i))+TICO(i)+TIMO(i)]
                  /[DDO(i)+IMO(i)];
 tmrg(i,ij)      = tmrg(i,ij)/PCO(i);
 tmrg_X(i,ij)    = tmrg_X(i,ij)/PCO(i);

 DDO(i)          = DDO(i)/PLO(i);
 IMO(i)          = IMO(i)/(PWMO(i)*eO);

 tmrg(i,ij)      = tmrg(i,ij)/{DDO(ij)+IMO(ij)};

 tticO(i)        = TICO(i)/{(PLO(i)+SUM[ij,PCO(ij)*tmrg(ij,i)])*DDO(i)
                           +(eO*PWMO(i)+SUM[ij,PCO(ij)*tmrg(ij,i)])*IMO(i)
                           +TIMO(i)};

 PDO(i)          = {PLO(i)+SUM[ij,PCO(ij)*tmrg(ij,i)]}*(1+tticO(i));

 ttimO(i)$IMO(i) = TIMO(i)/[eO*PWMO(i)*IMO(i)];

 PMO(i)          = {(1+ttimO(i))*eO*PWMO(i)+SUM[ij,PCO(ij)*tmrg(ij,i)]}
                   *(1+tticO(i));

 EXO(j,i)        = EXO(j,i)/PEO(i);
 tmrg_X(ij,i)$EXDO(i)
                 = tmrg_X(ij,i)/SUM[j,EXO(j,i)];
 ttixO(i)$EXDO(i) = TIXO(i)/[EXDO(i)-TIXO(i)];
 PE_FOBO(i)      = (1+ttixO(i))*(PEO(i)+SUM[ij,PCO(ij)*tmrg_X(ij,i)]);
 PWXO(i)         = PE_FOBO(i)/eO;
 EXDO(i)         = EXDO(i)/(PWXO(i)*eO);

 DSO(j,i)        = DSO(j,i)/PLO(i);
 XSO(j,i)        = DSO(j,i)+EXO(j,i);
 PO(j,i)$XSO(j,i)= [PLO(i)*DSO(j,i)+PEO(i)*EXO(j,i)]/XSO(j,i);
 XSTO(j)         = SUM[i,XSO(j,i)];
 PTO(j)          = SUM[i$XSO(j,i),PO(j,i)*XSO(j,i)]/XSTO(j);

 QO(i)           = [PMO(i)*IMO(i)+PDO(i)*DDO(i)]/PCO(i);

 MRGNO(i)        = SUM[ij,tmrg(i,ij)*DDO(ij)]+
                   SUM[ij,tmrg(i,ij)*IMO(ij)]+
                   SUM[(j,ij),tmrg_X(i,ij)*EXO(j,ij)];

 CO(i,h)         = CO(i,h)/PCO(i);
 CGO(i)          = CGO(i)/PCO(i);
 DIO(i,j)        = DIO(i,j)/PCO(i);
 INVO(i)         = INVO(i)/PCO(i);
 VSTKO(i)        = VSTKO(i)/PCO(i);
 GFCFO           = ITO-SUM[i,PCO(i)*VSTKO(i)];

 CIO(j)          = SUM[i,DIO(i,j)];
 DITO(i)         = SUM[j,DIO(i,j)];
 GO              = SUM[i,PCO(i)*CGO(i)];

 PCIO(j)         = SUM[i,PCO(i)*DIO(i,j)]/CIO(j);

 ttiwO(l,j)$LDO(l,j)
                 = TIWO(l,j)/LDO(l,j);
 WTIO(l,j)       = WO(l)*(1+ttiwO(l,j));
 ttikO(k,j)$RKDO(k,j)
                 = TIKO(k,j)/RKDO(k,j);

 LDO(l,j)        = LDO(l,j)/WO(l);
 LDCO(j)         = SUM[l,LDO(l,j)];
 LSO(l)          = SUM[j,LDO(l,j)];
 WCO(j)$LDCO(j)  = SUM[l,WTIO(l,j)*LDO(l,j)]/LDCO(j);

** 4.5 Calibration of dynamic parameters
*-----------------------------------------------------------------------------*
*      HERE IT IS ASSUMED THAT THE ONLY INFORMATION AVAILABLE IS              *
*                      WHAT IS USUALLY FOUND IN A SAM.                        *
*                      IF YOU HAVE OTHER INFORMATION,                         *
*          SUCH AS THE AMOUNT OF PUBLIC INVESTMENT EXPENDITURES,              *
*                OR INVESTMENT BY INDUSTRY OF DESTINATION,                    *
*              THEN YOU ARE URGED TO USE A CALIBRATION PROCEDURE              *
*                  THAT TAKES THAT INFORMATION INTO ACCOUNT.                  *
*                    SEE APPENDIX F IN THE MODEL DOCUMENT                     *
*-----------------------------------------------------------------------------*
*  In case we do not have any information on investment by sector of desti-
*  nation or initial capital stock or the rental rate of capital, the dynamic
*  parameters must be calibrated on the basis of assumptions.
*  Here we develop a calibration procedure based on two key assumptions.
*   1- Tobin's q, RO(k,j)/UO(k,j), is the same for all types of capital and all
*      sectors, including the public sector. This translates as
*      RO(k,j) = alpha*UO(k,j) = alpha*PK_PRIO*(delta(k,j)+IRO)
*      where alpha is an unknown constant.
*   2-  The economy depicted in the SAM is following a balanced growth path,
*       that is, a path where all variables except prices grow at the constant
*       population growth rate. This implies:
*       INDO(k,j) = KDO(k,j)*(n1+delta(k,j))

*  First let's assume that the depreciation rate is known.

 delta(k,j)      = PARKJ1(k,j);

*  The values assigned PKPRIO and PKPUBO are arbitrary. Any proportional change
*  in PKPRIO results in an equal change in UO(k,bus) and RO(k,bus), and in an
*  inversely proportional change in KDO(k,bus) and INDO(k,bus); the same is true
*  of PKPUBO relative to UO(k,pub), RO(k,pub), KDO(k,pub) and INDO(k,pub).
*  Assigning values to PKPRIO and PKPUBO merely defines the units of measurement
*  of the capital stocks. So we set both of them equal to one:

 PK_PRIO         = 1;
 PK_PUBO         = 1;

*  Using model equations 100 and 101 below, we can calibrate the scale
*  parameters of these functions:

 A_K_PRI         = 1/PK_PRIO*{PROD[i$gamma_INVPRI(i),(PCO(i)/gamma_INVPRI(i))
                   **gamma_INVPRI(i)]};
 A_K_PUB         = 1/PK_PUBO*{PROD[i$gamma_INVPUB(i),(PCO(i)/gamma_INVPUB(i))
                   **gamma_INVPUB(i)]};

*  Using these depreciation rates, the price of capital, and the interest rate,
*  we can calibrate the user cost of capital

 UO(k,bus)       = PK_PRIO*(IRO+delta(k,bus));
 UO(k,pub)       = PK_PUBO*(IRO+delta(k,pub));

*  We can also calibrate alpha in our first assumption as being:

 alpha           = SUM[(k,j),RKDO(k,j)*{(n1+delta(k,j))
                       /(delta(k,j)+IRO)}
                       /(ITO-SUM[i,PCO(i)*VSTKO(i)])];

* From our first assumption, we can then calibrate RO:

 RO(k,j)         = alpha*UO(k,j);

* Then from the value in our SAM we calibrate KDO:

 KDO(k,j)        = RKDO(k,j)/RO(k,j);

* And finally our second assumption allows us to calibrate INDO:

 INDO(k,j)       = KDO(k,j)*(n1+delta(k,j));


*  We can calibrate private and public investment.

 IT_PUBO         = SUM[(k,pub),INDO(k,pub)]*PK_PUBO;
 IT_PRIO         = ITO-IT_PUBO-SUM[i,VSTKO(i)*PCO(i)];
 INV_PUBO(i)     = gamma_INVPUB(i)*IT_PUBO/PCO(i);
 INV_PRIO(i)     = gamma_INVPRI(i)*IT_PRIO/PCO(i);

*  Finally, we can calibrate the parameter in the investment demand function

 phi(k,bus)$KDO(k,bus)
                 = INDO(k,bus)/KDO(k,bus)*[UO(k,bus)/RO(k,bus)]**sigma_INV(k,bus);


** 4.6 Calibration of other prices and volumes

 RTIO(k,j)       = RO(k,j)*(1+ttikO(k,j));
 KDCO(j)         = SUM[k,KDO(k,j)];
 KSO(k)          = SUM[j,KDO(k,j)];
 RCO(j)$KDCO(j)  = SUM[k,RTIO(k,j)*KDO(k,j)]/KDCO(j);

 VAO(j)          = LDCO(j)+KDCO(j);
 PVAO(j)         = [WCO(j)*LDCO(j)+RCO(j)*KDCO(j)]/VAO(j);

 ttipO(j)        = TIPO(j)/{PVAO(j)*VAO(j)+SUM[i,PCO(i)*DIO(i,j)]};
 PPO(j)          = PTO(j)/(1+ttipO(j));

* PIXGDPO is tautologically equal to 1, based on its formula
* PIXGDPO         = {SUM[j,{(PVAO(j)*VAO(j)+TIPO(j))/VAO(j)}*VAO(j)]
*                   /SUM[j,{(PVAO(j)*VAO(j)+TIPO(j))/VAO(j)}*VAO(j)]
*                   *SUM[j,{(PVAO(j)*VAO(j)+TIPO(j))/VAO(j)}*VAO(j)]
*                   /SUM[j,{(PVAO(j)*VAO(j)+TIPO(j))/VAO(j)}*VAO(j)]}**0.5;
 PIXGDPO         = 1;

* PIXCONO is tautologically equal to 1, based on its formula
* PIXCONO         = SUM[i,PCO(i)*SUM[h,CO(i,h)]]/SUM[i,PCO(i)*SUM[h,CO(i,h)]];
 PIXCONO         = 1;

* PIXGVTO is tautologically equal to 1, based on its formula
* PIXGVTO         = PROD[i$gamma_GVT(i),(PCO(i)/PCO(i))**gamma_GVT(i)];
 PIXGVTO         = 1;

* PIXINV_PRIO is tautologically equal to 1, based on its formula
* PIXINV_PRIO     = PROD[i$gamma_INVPRI(i),(PCO(i)/PCO(i))**gamma_INVPRI(i)];
 PIXINV_PRIO     = 1;

* PIXINV_PUBO is tautologically equal to 1, based on its formula
* PIXINV_PUBO     = PROD[i$gamma_INVPUB(i),(PCO(i)/PCO(i))**gamma_INVPUB(i)];
 PIXINV_PUBO     = 1;

** 4.7 Calibration of indexed transfers and parameters

 TRO(agd,'row')  = TRO(agd,'row')/PIXCONO**eta;
 TRO(agng,'gvt') = TRO(agng,'gvt')/PIXCONO**eta;
 ttdf0O(f)       = ttdf0O(f)/PIXCONO**eta;
 ttdh0O(h)       = ttdh0O(h)/PIXCONO**eta;
 sh0O(h)         = sh0O(h)/PIXCONO**eta;
 tr0O(h)         = tr0O(h)/PIXCONO**eta;


*  4.8 Calibration of function parameters

**  4.8.1 Leontief functions
 io(j)           = CIO(j)/XSTO(j);
 v(j)            = VAO(j)/XSTO(j);
 aij(i,j)        = DIO(i,j)/CIO(j);

**  4.8.2 Calibration of CET parameters
*    4.8.2.1 CET between commodities
 rho_XT(j)       = (1+sigma_XT(j))/sigma_XT(j);
 beta_XT(j,i)${XSO(j,i) and (SUM[ij,XSO(j,ij)] gt 0)}
                 = PO(j,i)*XSO(j,i)**(1-rho_XT(j))/
                   SUM[ij$XSO(j,ij),PO(j,ij)*XSO(j,ij)**(1-rho_XT(j))];
 B_XT(j)         = XSTO(j)
                  /SUM[i$XSO(j,i),beta_XT(j,i)*XSO(j,i)**rho_XT(j)
                  ]**(1/rho_XT(j));

**   4.8.2.2 CET between exports and local production
 rho_X(j,i)$[EXO(j,i) and DSO(j,i)]
                 = (1+sigma_X(j,i))/sigma_X(j,i);
 rho_X(j,i)$[(not EXO(j,i)) or (not DSO(j,i))]
                 = 1;
 beta_X(j,i)$XSO(j,i)
                 = PEO(i)*EXO(j,i)**(1-rho_X(j,i))/
                  [PEO(i)*EXO(j,i)**(1-rho_X(j,i))
                  +PLO(i)*DSO(j,i)**(1-rho_X(j,i))];
 B_X(j,i)$XSO(j,i)
                 = XSO(j,i)/
                 [beta_X(j,i)*EXO(j,i)**rho_X(j,i)+
                 (1-beta_X(j,i))*DSO(j,i)**rho_X(j,i)]
                 **(1/rho_X(j,i));

**  4.8.3 Calibration of CES parameters
**   4.8.3.1 Composite good
 rho_M(i)$[IMO(i) and DDO(i)]
                 = (1-sigma_M(i))/sigma_M(i);
 rho_M(i)$[(not IMO(i)) or (not DDO(i))]
                 = -1;
 beta_M(i)$QO(i) = PMO(i)*IMO(i)**(rho_M(i)+1)/
                  [PMO(i)*IMO(i)**(rho_M(i)+1)+
                   PDO(i)*DDO(i)**(rho_M(i)+1)];
 B_M(i)$QO(i)    = QO(i)
                   /[beta_M(i)*IMO(i)**(-rho_M(i))+
                   (1-beta_M(i))*DDO(i)**(-rho_M(i))
                   ]**(-1/rho_M(i));

**   4.8.3.2 Composite capital
 rho_KD(j)$KDCO(j)
                 = (1-sigma_KD(j))/sigma_KD(j);
 beta_KD(k,j)$KDO(k,j)
                 = RTIO(k,j)*KDO(k,j)**(rho_KD(j)+1)/
                   SUM[kj,RTIO(kj,j)*KDO(kj,j)**(rho_KD(j)+1)];
 B_KD(j)$KDCO(j) = KDCO(j)
                  /SUM[k$KDO(k,j),beta_KD(k,j)*KDO(k,j)**(-rho_KD(j))
                  ]**(-1/rho_KD(j));

**   4.8.3.3 Composite labor
 rho_LD(j)       = (1-sigma_LD(j))/sigma_LD(j);
 beta_LD(l,j)$LDO(l,j)
                 = WTIO(l,j)*LDO(l,j)**(rho_LD(j)+1)/
                   SUM[lj,WTIO(lj,j)*LDO(lj,j)**(rho_LD(j)+1)];
 B_LD(j)$LDCO(j) = LDCO(j)/SUM[l,beta_LD(l,j)$LDO(l,j)*LDO(l,j)**(-rho_LD(j))]
                            **(-1/rho_LD(j));

**   4.8.3.4 Value added
 rho_VA(j)$[KDCO(j) and LDCO(j)]
                 = (1-sigma_VA(j))/sigma_VA(j);
 rho_VA(j)$[(not KDCO(j)) or (not LDCO(j))]
                 = -1;
 beta_VA(j)      = WCO(j)*LDCO(j)**(rho_VA(j)+1)/
                  [WCO(j)*LDCO(j)**(rho_VA(j)+1)+
                   RCO(j)*KDCO(j)**(rho_VA(j)+1)];
 B_VA(j)         = VAO(j)
                   /[beta_VA(j)*LDCO(j)**(-rho_VA(j))+
                   (1-beta_VA(j))*KDCO(j)**(-rho_VA(j))
                   ]**(-1/rho_VA(j));

**  4.8.4 Calibration of LES parameters
*   As the assigned values of income elasticities may not result in
*   consumption shares that add up to 1, this first step
*   adjusts the elasticities proportionally

 sigma_Y(i,h)    = sigma_Y(i,h)*CTHO(h)/SUM[ij,sigma_Y(ij,h)*PCO(ij)*CO(ij,h)];
 gamma_LES(i,h)  = PCO(i)*CO(i,h)*sigma_Y(i,h)/CTHO(h);
 CMINO(i,h)      = CO(i,h)+gamma_LES(i,h)*[CTHO(h)/
                  (PCO(i)*frisch(h))];

** 4.9 Calibration of gross domestic products

 GDP_BPO         = SUM[j,PVAO(j)*VAO(j)]+TIPTO;
 GDP_MPO         = GDP_BPO+TPRCTSO;
 GDP_IBO         = SUM[(l,j),WO(l)*LDO(l,j)]+SUM[(k,j),RO(k,j)*KDO(k,j)]
                   +TPRODNO+TPRCTSO;
 GDP_FDO         = SUM{i,PCO(i)*(SUM[h,CO(i,h)]+CGO(i)+INVO(i)+VSTKO(i))}
                  +SUM[i,PE_FOBO(i)*EXDO(i)]-SUM[i,PWMO(i)*eO*IMO(i)];

** 4.10 Calibration of real (volume) variables computed from price indices
 CTH_REALO(h)    = CTHO(h)/PIXCONO;
 G_REALO         = GO/PIXGVTO;
 GDP_BP_REALO    = GDP_BPO/PIXGDPO;
 GDP_MP_REALO    = GDP_MPO/PIXCONO;
 GFCF_PRI_REALO  = IT_PRIO/PIXINV_PRIO;
 GFCF_PUB_REALO  = IT_PUBO/PIXINV_PUBO;

* 5 Model

** 5.1 Variable definition
VARIABLES

**  5.1.1 Volume variables
 C(i,h,time)         Consumption of commodity i by type h households
 CG(i,time)          Public final consumption of commodity i
 CI(j,time)          Total intermediate consumption of industry j
 CMIN(i,h,time)      Minimum consumption of commodity i by type h households
 CTH_REAL(h,time)    Real consumption budget of type h households
 DD(i,time)          Domestic demand for commodity i produced locally
 DI(i,j,time)        Intermediate consumption of commodity i by industry j
 DIT(i,time)         Total intermediate demand for commodity i
 DS(j,i,time)        Supply of commodity i by industry j to the domestic market
 EX(j,i,time)        Quantity of product i exported by industry j
 EXD(i,time)         World demand for exports of product i
 G_REAL(time)        Real current government expenditures on goods and services
 GDP_BP_REAL(time)   Real GDP at basic prices
 GDP_MP_REAL(time)   Real GDP at market prices
 GFCF_PRI_REAL(time) Real private gross fixed capital formation
 GFCF_PUB_REAL(time) Real public gross fixed capital formation
 IM(i,time)          Quantity of product i imported
 IND(k,j,time)       Investment in capital k for industry j
 INV(i,time)         Total final demand of commodity i for investment purposes (GFCF)
 INV_PRI(i,time)     Final demand of commodity i for private investment purposes
 INV_PUB(i,time)     Final demand of commodity i for public investment purposes
 KD(k,j,time)        Demand for type k capital by industry j
 KDC(j,time)         Industry j demand for composite capital
 KS(k,time)          Supply of type k capital
 LD(l,j,time)        Demand for type l labor by industry j
 LDC(j,time)         Industry j demand for composite labor
 LS(l,time)          Supply of type l labor
 MRGN(i,time)        Demand for commodity i as a trade or transport margin
 Q(i,time)           Quantity demanded of composite commodity i
 VA(j,time)          Value added of industry j
 VSTK(i,time)        Inventory change of commodity i
 XS(j,i,time)        Industry j production of commodity i
 XST(j,time)         Total aggregate output of industry j

**  5.1.2 Price variables
 e(time)             Exchange rate (price of foreign currency in local currency)
 IR(time)            Interest rate
 P(j,i,time)         Basic price of industry j's production of commodity i
 PC(i,time)          Purchaser price of composite comodity i (including all taxes and margins)
 PCI(j,time)         Intermediate consumption price index of industry j
 PD(i,time)          Price of local product i sold on the domestic market (including all taxes and margins)
 PE(i,time)          Price received for exported commodity x (excluding export taxes)
 PE_FOB(i,time)      FOB price of exported commodity x (in local currency)
 PIXCON(time)        Consumer price index
 PIXGDP(time)        GDP deflator
 PIXGVT(time)        Public expenditures price index
 PIXINV_PRI(time)    Private investment price index
 PIXINV_PUB(time)    Public investment price index
 PK_PRI(time)        Price of new private capital
 PK_PUB(time)        Price of new public capital
 PL(i,time)          Price of local product i (excluding all taxes on products)
 PM(i,time)          Price of imported product i (including all taxes and tariffs)
 PP(j,time)          Industry j unit cost including taxes directly related to the use of capital and labor but excluding other taxes on production
 PT(j,time)          Basic price of industry j's output
 PVA(j,time)         Price of industry j value added (including taxes on production directly related to the use of capital and labor)
 PWM(i,time)         World price of imported product i (expressed in foreign currency)
 PWX(i,time)         World price of exported product i (expressed in foreign currency)
 R(k,j,time)         Rental rate of type k capital in industry j
 RC(j,time)          Rental rate of industry j composite capital
 RTI(k,j,time)       Rental rate paid by industry j for type k capital including capital taxes
 U(k,j,time)         User cost of type k capital in industry j
 W(l,time)           Wage rate of type l labor
 WC(j,time)          Wage rate of industry j composite labor
 WTI(l,j,time)       Wage rate paid by industry j for type l labor including payroll taxes

*   5.1.3 Nominal (value) variables
 CAB(time)          Current account balance
 CTH(h,time)        Consumption budget of type h households
 G(time)            Current government expenditures on goods and services
 GDP_BP(time)       GDP at basic prices
 GDP_FD(time)       GDP at purchasers' prices from the perspective of final demand
 GDP_IB(time)       GDP at market prices (income-based)
 GDP_MP(time)       GDP at market prices
 GFCF(time)         Gross fixed capital formation
 IT(time)           Total investment expenditures
 IT_PRI(time)       Total private investment expenditures
 IT_PUB(time)       Total public investment expenditures
 SF(f,time)         Savings of type f businesses
 SG(time)           Government savings
 SH(h,time)         Savings of type h households
 SROW(time)         Rest-of-the-world savings
 TDF(f,time)        Income taxes of type f businesses
 TDFT(time)         Total government revenue from business income taxes
 TDH(h,time)        Income taxes of type h households
 TDHT(time)         Total government revenue from household income taxes
 TIC(i,time)        Government revenue from indirect taxes on product i
 TICT(time)         Total government receipts of indirect taxes on commodities
 TIK(k,j,time)      Government revenue from taxes on type k capital used by industry j
 TIKT(time)         Total government revenue from from taxes on capital
 TIM(i,time)        Government revenue from import duties on product i
 TIMT(time)         Total government revenue from import duties
 TIP(j,time)        Government revenue from taxes on industry j production (excluding taxes directly related to the use of capital and labor)
 TIPT(time)         Total government revenue from production taxes (excluding taxes directly related to the use of capital and labor)
 TIW(l,j,time)      Government revenue from payroll taxes on type l labor in industry j
 TIWT(time)         Total government revenue from payroll taxes
 TIX(i,time)        Government revenue from export taxes on product i
 TIXT(time)         Total government revenue from export taxes
 TPRCTS(time)       Total government revenue from taxes on products and imports
 TPRODN(time)       Total government revenue from other taxes on production
 TR(ag,agj,time)    Transfers from agent agj to agent ag
 YDF(f,time)        Disposable income of type f businesses
 YDH(h,time)        Disposable income of type h households
 YF(f,time)         Total income of type f businesses
 YFK(f,time)        Capital income of type f businesses
 YFTR(f,time)       Transfer income of type f businesses
 YG(time)           Total government income
 YGK(time)          Government capital income
 YGTR(time)         Government transfer income
 YH(h,time)         Total income of type h households
 YHK(h,time)        Capital income of type h households
 YHL(h,time)        Labor income of type h households
 YHTR(h,time)       Transfer income of type h households
 YROW(time)         Rest-of-the-world income

**  5.1.4 Rates and intercepts
 sh0(h,time)        Intercept (type h household savings)
 sh1(h,time)        Slope (type h household savings)
 tr0(h,time)        Intercept (transfers by type h households to governmentime)
 tr1(h,time)        Marginal rate of transfers by type h households to government
 ttdf0(f,time)      Intercept (income taxes of type f businesses)
 ttdf1(f,time)      Marginal income tax rate of type f businesses
 ttdh0(h,time)      Intercept (income taxes of type h households)
 ttdh1(h,time)      Marginal income tax rate of type h households
 ttic(i,time)       Tax rate on commodity i
 ttik(k,j,time)     Tax rate on type k capital used in industry j
 ttim(i,time)       Rate of taxes and duties on imports of commodity m
 ttip(j,time)       Tax rate on the production of industry j
 ttiw(l,j,time)     Tax rate on type l worker compensation in industry j
 ttix(i,time)       Export tax rate on exported commodity x

**  5.1.5 Other variables
 LEON(time)         Excess supply on the last market
;


** 5.2 Equation definition

EQUATIONS

 EQ1(j,time)        Value added demand in industry j (Leontief)
 EQ2(j,time)        Total intermediate consumption demand in industry j (Leontief)
 EQ3(j,time)        CES between of composite labor and capital
 EQ4(j,time)        Relative demand for composite labor and capital by industry j(CES)
 EQ5(j,time)        CES between labor categories
 EQ6(l,j,time)      Demand for type l labor by industry j (CES)
 EQ7(j,time)        CES between capital categories
 EQ8(k,j,time)      Demand for type k capital by industry j (CES)
 EQ9(i,j,time)      Intermediate consumption of commodity i by industry j (Leontief)
 EQ10(h,time)       Total income of type h households
 EQ11(h,time)       Labor income of type h households
 EQ12(h,time)       Capital income of type h households
 EQ13(h,time)       Transfer income of type h households
 EQ14(h,time)       Disposable income of type h households
 EQ15(h,time)       Consumption budget of type h households
 EQ16(h,time)       Savings of type h households
 EQ17(f,time)       Total income of type f businesses
 EQ18(f,time)       Capital income of type f businesses
 EQ19(f,time)       Transfer income of type f businesses
 EQ20(f,time)       Disposable income of type f businesses
 EQ21(f,time)       Savings of type f businesses
 EQ22(time)         Total government income
 EQ23(time)         Government capital income
 EQ24(time)         Total government revenue from household income taxes
 EQ25(time)         Total government revenue from business income taxes
 EQ26(time)         Total government revenue from other taxes on production
 EQ27(time)         Total government receipts of indirect taxes on wages
 EQ28(time)         Total government receipts of indirect taxes on capital
 EQ29(time)         Total government revenue from production taxes
 EQ30(time)         Total government revenue from taxes on products and imports
 EQ31(time)         Total government receipts of indirect taxes on commodities
 EQ32(time)         Total government revenue from import duties
 EQ33(time)         Total government revenue from export taxes
 EQ34(time)         Government transfer income
 EQ35(h,time)       Income taxes of type h households
 EQ36(f,time)       Income taxes of type f businesses
 EQ37(l,j,time)     Government revenue from payroll taxes on type l labor in industry j
 EQ38(k,j,time)     Government revenue from taxes on type k capital used by industry j
 EQ39(j,time)       Government revenue from taxes on industry j production
 EQ40(i,time)       Government revenue from indirect taxes on product i
 EQ41(i,time)       Government revenue from import duties on product i
 EQ42(i,time)       Government revenue from export taxes on product i
 EQ43(time)         Government savings
 EQ44(time)         Rest-of-the-world income
 EQ45(time)         Rest-of-the-world savings
 EQ46(time)         Equivalence between current account balance and ROW savings
 EQ47(agng,h,time)  Transfers from household h to agent agng
 EQ48(h,time)       Transfers from household h to government
 EQ49(ag,f,time)    Transfers from type f businesses to agent ag
 EQ50(agng,time)    Public transfers
 EQ51(agd,time)     Transfers from abroad
 EQ52(i,h,time)     Consumption of commodity i by type h households
 EQ53(time)         Gross fixed capital formation
 EQ54(i,time)       Final demand of commodity i for private investment purposes
 EQ55(i,time)       Final demand of commodity i for public investment purposes
 EQ56(i,time)       Total final demand of commodity i for investment purposes
 EQ57(i,time)       Public final consumption of commodity i
 EQ58(i,time)       Total intermediate demand for commodity i
 EQ59(i,time)       Demand for commodity i as a trade or transport margin
 EQ60(j,time)       CET between different commodities produced by industry j
 EQ61(j,i,time)     Industry j production of commodity i (CET)
 EQ62(j,i,time)     CET between exports and local commodity
 EQ63(j,i,time)     Relative supply of exports and local commodity (CET)
 EQ64(i,time)       World demand for exports of product i
 EQ65(i,time)       CES between imports and local production
 EQ66(i,time)       Demand for imports (CES)
 EQ67(j,time)       Industry j unit cost
 EQ68(j,time)       Basic price of industry j's production of commodity i
 EQ69(j,time)       Intermediate consumption price index of industry j
 EQ70(j,time)       Price of industry j value added
* EQ71(j,time)       Wage rate of industry j composite labor
 EQ72(l,j,time)     Wage rate paid by industry j for type l labor including payroll taxes
* EQ73(j,time)       Rental rate of industry j composite capital
 EQ74(k,j,time)     Rental rate paid by industry j for type k capital including capital taxes
* EQ75(j,i,time)     Total producer price
 EQ75a(j,i,time)    Total producer price is equal to P if there is only one product
 EQ76(j,i,time)     Basic price of industry j's production of commodity i
 EQ77(i,time)       Price received for exported commodity x (excluding export taxes)
 EQ78(i,time)       Price of local product i sold on the domestic market (including all taxes and margins)
 EQ79(i,time)       Price of imported product i (including all taxes and tariffs)
 EQ80(i,time)       Purchaser price of composite comodity i
 EQ81(time)         GDP deflator (Fischer index)
 EQ82(time)         Consumer price index (Laspeyres)
 EQ83(time)         Private investment price index
 EQ84(time)         Public investment price index
 EQ85(time)         Public expenditures price index
 EQ86(i1,time)      Domestic absorbtion
 EQ87(l,time)       Labor supply equals labor demand
 EQ88(k,time)       Capital supply equals capital demand
 EQ89(time)         Total investment equals total savings
 EQ90(time)         Private investment equals total investment less public investment
 EQ91(i,time)       Supply of domestic production equals demand
 EQ92(i,time)       International demand for exports equals supply
 EQ93(time)         GDP at basic prices
 EQ94(time)         GDP at market prices
 EQ95(time)         GDP at market prices (income-based)
 EQ96(time)         GDP at purchasers' prices from the perspective of final demand
 EQ97(h,time)       Real consumption budget of type h households
 EQ98(time)         Real current government expenditures on goods and services
 EQ99(time)         Real GDP at basic prices
 EQ100(time)        Real GDP at market prices
 EQ101(time)        Real private gross fixed capital formation
 EQ102(time)        Real public gross fixed capital formation
* EQ103(k,j,time)    Capital growth
 EQ104(time)        Total public investment
 EQ105(time)        Equilibrium on the private investment market
 EQ106(time)        Aggregate private price of capital
 EQ107(time)        Aggregate public price of capital
 EQ108(k,bus,time)  Investment demand by private industry
 EQ109a(k,bus,time) User cost of capital (private sectors)
 EQ109b(k,pub,time) User cost of capital (public sectors)

 WALRAS(time)       Walras law verification
;

*  5.3 Equations

*   5.3.1 Production

 EQ1(j,t)..      VA(j,t) =e= v(j)*XST(j,t);

 EQ2(j,t)..      CI(j,t) =e= io(j)*XST(j,t);

 EQ3(j,t)..      VA(j,t) =e= B_VA(j)*{
                         [beta_VA(j)*LDC(j,t)**(-rho_VA(j))]$LDCO(j)
                        +[(1-beta_VA(j))*KDC(j,t)**(-rho_VA(j))]$KDCO(j)
                                     }**(-1/rho_VA(j));

 EQ4(j,t)$[LDCO(j) and KDCO(j)]..
                 LDC(j,t) =e= {[beta_VA(j)/(1-beta_VA(j))]*[RC(j,t)/WC(j,t)]}
                              **sigma_VA(j)*KDC(j,t);

 EQ5(j,t)$LDCO(j)..
                 LDC(j,t) =e= B_LD(j)*SUM[l$LDO(l,j),beta_LD(l,j)*LD(l,j,t)
                              **(-rho_LD(j))]**(-1/rho_LD(j));

 EQ6(l,j,t)$LDO(l,j)..
                 LD(l,j,t) =e= [beta_LD(l,j)*WC(j,t)/WTI(l,j,t)]**sigma_LD(j)
                             *B_LD(j)**(sigma_LD(j)-1)*LDC(j,t);

 EQ7(j,t)$KDCO(j)..
                 KDC(j,t) =e= B_KD(j)*SUM[k$KDO(k,j),beta_KD(k,j)*KD(k,j,t)
                            **(-rho_KD(j))]**(-1/rho_KD(j));

 EQ8(k,j,t)$KDO(k,j)..
                 KD(k,j,t) =e= [beta_KD(k,j)*RC(j,t)/RTI(k,j,t)]**sigma_KD(j)
                             *B_KD(j)**(sigma_KD(j)-1)*KDC(j,t);


 EQ9(i,j,t)..    DI(i,j,t) =e= aij(i,j)*CI(j,t);

**  5.3.2 Income and savings
**   5.3.2.1 Households

 EQ10(h,t)..     YH(h,t) =e= YHL(h,t)+YHK(h,t)+YHTR(h,t);

 EQ11(h,t)..     YHL(h,t) =e= SUM{l,lambda_WL(h,l)*W(l,t)
                             *SUM[j$LDO(l,j),LD(l,j,t)]};

 EQ12(h,t)..     YHK(h,t) =e= SUM{k,lambda_RK(h,k)*SUM[j$KDO(k,j),
                              R(k,j,t)*KD(k,j,t)]};

 EQ13(h,t)..     YHTR(h,t) =e= SUM[ag,TR(h,ag,t)];

 EQ14(h,t)..     YDH(h,t) =e= YH(h,t)-TDH(h,t)-TR('gvt',h,t);

 EQ15(h,t)..     CTH(h,t) =e= YDH(h,t)-SH(h,t)-SUM[agng,TR(agng,h,t)];

 EQ16(h,t)..     SH(h,t) =e= PIXCON(t)**eta*sh0(h,t)+sh1(h,t)*YDH(h,t);


**   5.3.2.2 Firms

 EQ17(f,t)..     YF(f,t) =e= YFK(f,t)+YFTR(f,t);

 EQ18(f,t)..     YFK(f,t) =e= SUM{k,lambda_RK(f,k)*SUM[j$KDO(k,j),
                              R(k,j,t)*KD(k,j,t)]};

 EQ19(f,t)..     YFTR(f,t) =e= SUM[ag,TR(f,ag,t)];

 EQ20(f,t)..     YDF(f,t) =e= YF(f,t)-TDF(f,t);

 EQ21(f,t)..     SF(f,t) =e= YDF(f,t)-SUM[ag,TR(ag,f,t)];

**   5.3.2.3 Government

 EQ22(t)..       YG(t) =e= YGK(t)+TDHT(t)+TDFT(t)+TPRODN(t)+TPRCTS(t)+YGTR(t);

 EQ23(t)..       YGK(t) =e= SUM{k,lambda_RK('gvt',k)*SUM[j$KDO(k,j),
                            R(k,j,t)*KD(k,j,t)]};

 EQ24(t)..       TDHT(t) =e= SUM[h,TDH(h,t)];

 EQ25(t)..       TDFT(t) =e= SUM[f,TDF(f,t)];

 EQ26(t)..       TPRODN(t) =e= TIWT(t)+TIKT(t)+TIPT(t);

 EQ27(t)..       TIWT(t) =e= SUM[(l,j)$LDO(l,j),TIW(l,j,t)];

 EQ28(t)..       TIKT(t) =e= SUM[(k,j)$KDO(k,j),TIK(k,j,t)];

 EQ29(t)..       TIPT(t) =e= SUM[j,TIP(j,t)];

 EQ30(t)..       TPRCTS(t) =e= TICT(t)+TIMT(t)+TIXT(t);

 EQ31(t)..       TICT(t) =e= SUM[i,TIC(i,t)];

 EQ32(t)..       TIMT(t) =e= SUM[i$IMO(i),TIM(i,t)];

 EQ33(t)..       TIXT(t) =e= SUM[i$EXDO(i),TIX(i,t)];

 EQ34(t)..       YGTR(t) =e= SUM[agng,TR('gvt',agng,t)];

 EQ35(h,t)..     TDH(h,t) =e= PIXCON(t)**eta*ttdh0(h,t)+ttdh1(h,t)*YH(h,t);

 EQ36(f,t)..     TDF(f,t) =e= PIXCON(t)**eta*ttdf0(f,t)+ttdf1(f,t)*YFK(f,t);

 EQ37(l,j,t)$LDO(l,j)..
                 TIW(l,j,t) =e= ttiw(l,j,t)*W(l,t)*LD(l,j,t);

 EQ38(k,j,t)$KDO(k,j)..
                 TIK(k,j,t) =e= ttik(k,j,t)*R(k,j,t)*KD(k,j,t);

 EQ39(j,t)..     TIP(j,t) =e= ttip(j,t)*PP(j,t)*XST(j,t);

 EQ40(i,t)..     TIC(i,t) =e= ttic(i,t)*{
                       [(PL(i,t)+SUM[ij,PC(ij,t)*tmrg(ij,i)])*DD(i,t)]$DDO(i)
                      +[((1+ttim(i,t))*PWM(i,t)*e(t)
                          +SUM[ij,PC(ij,t)*tmrg(ij,i)])*IM(i,t)]$IMO(i)};

 EQ41(i,t)$IMO(i)..
                 TIM(i,t) =e= ttim(i,t)*PWM(i,t)*e(t)*IM(i,t);

 EQ42(i,t)$EXDO(i)..
                 TIX(i,t) =e= ttix(i,t)*{PE(i,t)+SUM[ij,PC(ij,t)*tmrg_X(ij,i)]}
                              *EXD(i,t);

 EQ43(t)..       SG(t) =e= YG(t)-SUM[agng,TR(agng,'gvt',t)]-G(t);

**   5.3.2.4 Rest of the world

 EQ44(t)..       YROW(t) =e= e(t)*SUM[i$IMO(i),PWM(i,t)*IM(i,t)]
                       +SUM{k,lambda_RK('row',k)*SUM[j$KDO(k,j),
                        R(k,j,t)*KD(k,j,t)]}+SUM[agd,TR('row',agd,t)];

 EQ45(t)..       SROW(t) =e= YROW(t)-SUM[i$EXDO(i),PE_FOB(i,t)*EXD(i,t)]
                            -SUM[agd,TR(agd,'row',t)];

 EQ46(t)..       SROW(t) =e= -CAB(t);

**   5.3.2.5 Transfers

 EQ47(agng,h,t).. TR(agng,h,t) =e= lambda_TR(agng,h)*YDH(h,t);

 EQ48(h,t)..     TR('gvt',h,t) =e= PIXCON(t)**eta*tr0(h,t)+tr1(h,t)*YH(h,t);

 EQ49(ag,f,t)..  TR(ag,f,t) =e= lambda_TR(ag,f)*YDF(f,t);

 EQ50(agng,t)..  TR(agng,'gvt',t) =e= PIXCON(t)**eta*TRO(agng,'gvt')*pop(t);

 EQ51(agd,t)..   TR(agd,'row',t) =e= PIXCON(t)**eta*TRO(agd,'row')*pop(t);


**  5.3.3 Demand

 EQ52(i,h,t)..   PC(i,t)*C(i,h,t) =e= PC(i,t)*CMIN(i,h,t)+gamma_LES(i,h)
                                 *{CTH(h,t)-SUM[ij,PC(ij,t)*CMIN(ij,h,t)]};

 EQ53(t)..       GFCF(t) =e= IT(t)-SUM[i,PC(i,t)*VSTK(i,t)];

 EQ54(i,t)..     PC(i,t)*INV_PRI(i,t) =e= gamma_INVPRI(i)*IT_PRI(t);

 EQ55(i,t)..     PC(i,t)*INV_PUB(i,t) =e= gamma_INVPUB(i)*IT_PUB(t);

 EQ56(i,t)..     INV(i,t) =e= INV_PRI(i,t)+INV_PUB(i,t);

 EQ57(i,t)..     PC(i,t)*CG(i,t) =e= gamma_GVT(i)*G(t);

 EQ58(i,t)..     DIT(i,t) =e= SUM[j,DI(i,j,t)];

 EQ59(i,t)..     MRGN(i,t) =e= SUM[ij$DDO(ij),tmrg(i,ij)*DD(ij,t)]
                              +SUM[ij$IMO(ij),tmrg(i,ij)*IM(ij,t)]
                              +SUM[ij$EXDO(ij),tmrg_X(i,ij)*EXD(ij,t)];


**  5.3.4 International trade

 EQ60(j,t)..     XST(j,t) =e= B_XT(j)*SUM[i$XSO(j,i),beta_XT(j,i)*XS(j,i,t)
                            **rho_XT(j)]**(1/rho_XT(j));

 EQ61(j,i,t)${XSO(j,i) and [XSO(j,i) ne XSTO(j)]}..
                 XS(j,i,t) =e= XST(j,t)/B_XT(j)**(1+sigma_XT(j))*
                             {P(j,i,t)/[beta_XT(j,i)*PT(j,t)]}**sigma_XT(j);

 EQ62(j,i,t)$XSO(j,i)..
                 XS(j,i,t) =e= B_X(j,i)*{
                            [beta_X(j,i)*EX(j,i,t)**rho_X(j,i)]$EXO(j,i)
                           +[(1-beta_X(j,i))*DS(j,i,t)**rho_X(j,i)]$DSO(j,i)
                                        }**(1/rho_X(j,i));

 EQ63(j,i,t)$[EXO(j,i) and DSO(j,i)]..
                 EX(j,i,t) =e= {[(1-beta_X(j,i))/beta_X(j,i)]*[PE(i,t)/PL(i,t)]}
                         **sigma_X(j,i)*DS(j,i,t);

 EQ64(i,t)$EXDO(i)..
                 EXD(i,t)  =e=  EXDO(i)*pop(t)*[e(t)*PWX(i,t)/PE_fob(i,t)]
                                **sigma_XD(i);

 EQ65(i,t)..     Q(i,t) =e= B_M(i)*{
                              [beta_M(i)*IM(i,t)**(-rho_M(i))]$IMO(i)
                             +[(1-beta_M(i))*DD(i,t)**(-rho_M(i))]$DDO(i)
                                   }**(-1/rho_M(i));

 EQ66(i,t)$[IMO(i) and DDO(i)]..
                 IM(i,t) =e= {[beta_M(i)/(1-beta_M(i))]*[PD(i,t)/PM(i,t)]}
                         **sigma_M(i)*DD(i,t);

**  5.3.5 Prices

 EQ67(j,t)..     PP(j,t)*XST(j,t) =e= PVA(j,t)*VA(j,t)+PCI(j,t)*CI(j,t);

 EQ68(j,t)..     PT(j,t) =e= (1+ttip(j,t))*PP(j,t);

 EQ69(j,t)..     PCI(j,t)*CI(j,t) =e= SUM[i,PC(i,t)*DI(i,j,t)];

 EQ70(j,t)..     PVA(j,t)*VA(j,t) =e= [WC(j,t)*LDC(j,t)]$LDCO(j)
                                     +[RC(j,t)*KDC(j,t)]$KDCO(j);

* Given the way equation 6 is written, equation 71 is redundant
* EQ71(j,t)..     WC(j,t)*LDC(j,t) =e= SUM[l$LDO(l,j),WTI(l,j,t)*LD(l,j,t)];

 EQ72(l,j,t)$LDO(l,j)..
                 WTI(l,j,t) =e= W(l,t)*(1+ttiw(l,j,t));

* Given the way equation 8 is written, equation 73 is redundant
* EQ73(j,t)..   RC(j,t)*KDC(j,t) =e= SUM[k$KDO(k,j),RTI(k,j,t)*KD(k,j,t)];

 EQ74(k,j,t)$KDO(k,j)..
                 RTI(k,j,t) =e= R(k,j,t)*(1+ttik(k,j,t));

* Given the way equation 61 is written, equation 75 is redundant if
* a sector produces more than one commodity
* EQ75(j,t)..     PT(j,t)*XST(j,t) =e= SUM[i,P(j,i,t)*XS(j,i,t)];

 EQ75a(j,i,t)$[XSO(j,i) eq XSTO(j)]..
                 P(j,i,t) =e= PT(j,t);

 EQ76(j,i,t)$XSO(j,i)..
                 P(j,i,t)*XS(j,i,t) =e= [PE(i,t)*EX(j,i,t)]$EXO(j,i)
                                       +[PL(i,t)*DS(j,i,t)]$DSO(j,i);

 EQ77(i,t)$EXDO(i)..
                 PE_FOB(i,t) =e= (1+ttix(i,t))*
                                 {PE(i,t)+SUM[ij,PC(ij,t)*tmrg_X(ij,i)]};

 EQ78(i,t)$DDO(i)..
                 PD(i,t) =e= (1+ttic(i,t))*{PL(i,t)+SUM[ij,PC(ij,t)*tmrg(ij,i)]};

 EQ79(i,t)$IMO(i)..
                 PM(i,t) =e= (1+ttic(i,t))*{(1+ttim(i,t))*e(t)*PWM(i,t)
                             +SUM[ij,PC(ij,t)*tmrg(ij,i)]};

 EQ80(i,t)..     PC(i,t)*Q(i,t) =e= [PM(i,t)*IM(i,t)]$IMO(i)
                                   +[PD(i,t)*DD(i,t)]$DDO(i);

 EQ81(t)..       PIXGDP(t) =e= {SUM[j,{(PVA(j,t)*VA(j,t)+TIP(j,t))/VA(j,t)}*VAO(j)]
                               /SUM[j,{(PVAO(j)*VAO(j)+TIPO(j))/VAO(j)}*VAO(j)]
                               *SUM[j,{(PVA(j,t)*VA(j,t)+TIP(j,t))/VA(j,t)}*VA(j,t)]
                               /SUM[j,{(PVAO(j)*VAO(j)+TIPO(j))/VAO(j)}*VA(j,t)]}**0.5;

 EQ82(t)..       PIXCON(t) =e= SUM[i,PC(i,t)*SUM[h,CO(i,h)]]
                              /SUM[i,PCO(i)*SUM[h,CO(i,h)]];

 EQ83(t)..       PIXINV_PRI(t) =e= PROD[i$gamma_INVPRI(i),(PC(i,t)/PCO(i))
                               **gamma_INVPRI(i)];

 EQ84(t)..       PIXINV_PUB(t) =e= PROD[i$gamma_INVPUB(i),(PC(i,t)/PCO(i))
                               **gamma_INVPUB(i)];

 EQ85(t)..       PIXGVT(t) =e= PROD[i$gamma_GVT(i),(PC(i,t)/PCO(i))**gamma_GVT(i)];

*   5.3.6 Equilibrium

 EQ86(i1,t)..    Q(i1,t) =e= SUM[h,C(i1,h,t)]+CG(i1,t)+INV(i1,t)+VSTK(i1,t)+
                             DIT(i1,t)+MRGN(i1,t);

 EQ87(l,t)..     LS(l,t) =e= SUM[j$LDO(l,j),LD(l,j,t)];

 EQ88(k,t)..     KS(k,t) =e= SUM[j$KDO(k,j),KD(k,j,t)];

 EQ89(t)..       IT(t) =e= SUM[h,SH(h,t)]+SUM[f,SF(f,t)]+SG(t)+SROW(t);

 EQ90(t)..       IT_PRI(t) =e= IT(t)-IT_PUB(t)-SUM[i,PC(i,t)*VSTK(i,t)];

 EQ91(i,t)$DDO(i)..
                 SUM[j$DSO(j,i),DS(j,i,t)] =e= DD(i,t);

 EQ92(i,t)$EXDO(i)..
                 SUM[j$EXO(j,i),EX(j,i,t)] =e= EXD(i,t);


**  5.3.7 Gross domestic product

 EQ93(t)..       GDP_BP(t) =e= SUM[j,PVA(j,t)*VA(j,t)]+TIPT(t);

 EQ94(t)..       GDP_MP(t) =e= GDP_BP(t)+TPRCTS(t);

 EQ95(t)..       GDP_IB(t) =e= SUM[(l,j)$LDO(l,j),W(l,t)*LD(l,j,t)]
                              +SUM[(k,j)$KDO(k,j),R(k,j,t)*KD(k,j,t)]
                              +TPRODN(t)+TPRCTS(t);

 EQ96(t)..       GDP_FD(t) =e= SUM[i,PC(i,t)*(SUM[h,C(i,h,t)]+CG(i,t)+INV(i,t)
                                   +VSTK(i,t))]
                              +SUM[i$EXDO(i),PE_FOB(i,t)*EXD(i,t)]
                              -SUM[i$IMO(i),PWM(i,t)*e(t)*IM(i,t)];

**  5.3.8 Real variables

 EQ97(h,t)..     CTH_REAL(h,t) =e= CTH(h,t)/PIXCON(t);

 EQ98(t)..       G_REAL(t) =e= G(t)/PIXGVT(t);

 EQ99(t)..       GDP_BP_REAL(t) =e= GDP_BP(t)/PIXGDP(t);

 EQ100(t)..      GDP_MP_REAL(t) =e= GDP_MP(t)/PIXCON(t);

 EQ101(t)..      GFCF_PRI_REAL(t) =e= IT_PRI(t)/PIXINV_PRI(t);

 EQ102(t)..      GFCF_PUB_REAL(t) =e= IT_PUB(t)/PIXINV_PUB(t);

**  5.3.9 Dynamic equations

* EQ103(k,j,t+1)$KDO(k,j)..
*                 KD(k,j,t+1) =e= KD(k,j,t)*(1-delta(k,j))+IND(k,j,t);

 EQ104(t)..      IT_PUB(t) =e= PK_PUB(t)*SUM[(k,pub)$KDO(k,pub),IND(k,pub,t)];

 EQ105(t)..      IT_PRI(t) =e= PK_PRI(t)*SUM[(k,bus)$KDO(k,bus),IND(k,bus,t)];

 EQ106(t)..      PK_PRI(t) =e= 1/A_K_PRI*PROD[i$gamma_INVPRI(i),
                              (PC(i,t)/gamma_INVPRI(i))**gamma_INVPRI(i)];

 EQ107(t)..      PK_PUB(t) =e= 1/A_K_PUB*PROD[i$gamma_INVPUB(i),
                              (PC(i,t)/gamma_INVPUB(i))**gamma_INVPUB(i)];

 EQ108(k,bus,t)$KDO(k,bus)..
                 IND(k,bus,t) =e= phi(k,bus)*[R(k,bus,t)/U(k,bus,t)]
                                  **sigma_INV(k,bus)*KD(k,bus,t);

 EQ109a(k,bus,t)$KDO(k,bus)..
                 U(k,bus,t) =e= PK_PRI(t)*(delta(k,bus)+ir(t));

 EQ109b(k,pub,t)$KDO(k,pub)..
                 U(k,pub,t) =e= PK_PUB(t)*(delta(k,pub)+ir(t));

**  5.3.10 Other

 WALRAS(t)..     LEON(t) =e= Q('agr',t)-SUM[h,C('agr',h,t)]-CG('agr',t)
                             -INV('agr',t)-VSTK('agr',t)-DIT('agr',t)
                             -MRGN('agr',t);


* 6 Resolution
OPTION NLP = conopt
MODEL PEP1T Standard PEP dynamic model version 2_1  /ALL/;
PEP1T.HOLDFIXED=1;

** 6.1 BAU
*  First the model must be solved for the BAU. This is specially important
*  if the BAU does not follow a balanced growth path in which all prices remain
*  constant and other variables grow at the same constant rate as the popula-
*  tion. If the BAU is not a balanced growth scenario, then, except for the
*  first period, variables cannot be initialised at their exact BAU values
*  without solving the model. So GAMS computes the values of each variable
*  for each period through this first numerical resolution.

LOOP[time,
T(time) = YES;
**  6.1.1 Variable initialisation
 C.l(i,h,time)         = CO(i,h)*pop(time);
 CAB.l(time)           = CABO*pop(time);
 CG.l(i,time)          = CGO(i)*pop(time);
 CI.l(j,time)          = CIO(j)*pop(time);
 CMIN.l(i,h,time)      = CMINO(i,h)*pop(time);
 CTH.l(h,time)         = CTHO(h)*pop(time);
 CTH_REAL.l(h,time)    = CTH_REALO(h)*pop(time);
 DD.l(i,time)          = DDO(i)*pop(time);
 DI.l(i,j,time)        = DIO(i,j)*pop(time);
 DIT.l(i,time)         = DITO(i)*pop(time);
 DS.l(j,i,time)        = DSO(j,i)*pop(time);
 e.l(time)             = eO;
 EX.l(j,i,time)        = EXO(j,i)*pop(time);
 EXD.l(i,time)         = EXDO(i)*pop(time);
 G.l(time)             = GO*pop(time);
 G_REAL.l(time)        = G_REALO*pop(time);
 GDP_BP.l(time)        = GDP_BPO*pop(time);
 GDP_BP_REAL.l(time)   = GDP_BP_REALO*pop(time);
 GDP_FD.l(time)        = GDP_FDO*pop(time);
 GDP_IB.l(time)        = GDP_IBO*pop(time);
 GDP_MP.l(time)        = GDP_MPO*pop(time);
 GDP_MP_REAL.l(time)   = GDP_MP_REALO*pop(time);
 GFCF.l(time)          = GFCFO*pop(time);
 GFCF_PRI_REAL.l(time) = GFCF_PRI_REALO*pop(time);
 GFCF_PUB_REAL.l(time) = GFCF_PUB_REALO*pop(time);
 IM.l(i,time)          = IMO(i)*pop(time);
 IND.l(k,j,time)       = INDO(k,j)*pop(time);
 INV.l(i,time)         = INVO(i)*pop(time);
 INV_PRI.l(i,time)     = INV_PRIO(i)*pop(time);
 INV_PUB.l(i,time)     = INV_PUBO(i)*pop(time);
 IR.l(time)            = IRO;
 IT.l(time)            = ITO*pop(time);
 IT_PRI.l(time)        = IT_PRIO*pop(time);
 IT_PUB.l(time)        = IT_PUBO*pop(time);
 KDC.l(j,time)         = KDCO(j)*pop(time);
 KS.l(k,time)          = KSO(k)*pop(time);
 LD.l(l,j,time)        = LDO(l,j)*pop(time);
 LDC.l(j,time)         = LDCO(j)*pop(time);
 LS.l(l,time)          = LSO(l)*pop(time);
 MRGN.l(i,time)        = MRGNO(i)*pop(time);
 P.l(j,i,time)         = PO(j,i);
 PC.l(i,time)          = PCO(i);
 PCI.l(j,time)         = PCIO(j);
 PD.l(i,time)          = PDO(i);
 PE.l(i,time)          = PEO(i);
 PE_FOB.l(i,time)      = PE_FOBO(i);
 PIXCON.l(time)        = PIXCONO;
 PIXGDP.l(time)        = PIXGDPO;
 PIXGVT.l(time)        = PIXGVTO;
 PIXINV_PRI.l(time)    = PIXINV_PRIO;
 PIXINV_PUB.l(time)    = PIXINV_PUBO;
 PK_PRI.l(time)        = PK_PRIO;
 PK_PUB.l(time)        = PK_PUBO;
 PL.l(i,time)          = PLO(i);
 PM.l(i,time)          = PMO(i);
 PP.l(j,time)          = PPO(j);
 PT.l(j,time)          = PTO(j);
 PVA.l(j,time)         = PVAO(j);
 PWM.l(i,time)         = PWMO(i);
 PWX.l(i,time)         = PWXO(i);
 Q.l(i,time)           = QO(i)*pop(time);
 R.l(k,j,time)         = RO(k,j);
 RC.l(j,time)          = RCO(j);
 RTI.l(k,j,time)       = RTIO(k,j);
 SF.l(f,time)          = SFO(f)*pop(time);
 SG.l(time)            = SGO*pop(time);
 SH.l(h,time)          = SHO(h)*pop(time);
 SROW.l(time)          = SROWO*pop(time);
 TDF.l(f,time)         = TDFO(f)*pop(time);
 TDFT.l(time)          = TDFTO*pop(time);
 TDH.l(h,time)         = TDHO(h)*pop(time);
 TDHT.l(time)          = TDHTO*pop(time);
 TIC.l(i,time)         = TICO(i)*pop(time);
 TICT.l(time)          = TICTO*pop(time);
 TIK.l(k,j,time)       = TIKO(k,j)*pop(time);
 TIKT.l(time)          = TIKTO*pop(time);
 TIM.l(i,time)         = TIMO(i)*pop(time);
 TIMT.l(time)          = TIMTO*pop(time);
 TIP.l(j,time)         = TIPO(j)*pop(time);
 TIPT.l(time)          = TIPTO*pop(time);
 TIW.l(l,j,time)       = TIWO(l,j)*pop(time);
 TIWT.l(time)          = TIWTO*pop(time);
 TIX.l(i,time)         = TIXO(i)*pop(time);
 TIXT.l(time)          = TIXTO*pop(time);
 TPRODN.l(time)        = TPRODNO*pop(time);
 TPRCTS.l(time)        = TPRCTSO*pop(time);
 TR.l(ag,agj,time)     = TRO(ag,agj)*pop(time);
 TR.l(agd,'row',time)  = TRO(agd,'row')*PIXCONO**eta*pop(time);
 TR.l(agng,'gvt',time) = TRO(agng,'gvt')*PIXCONO**eta*pop(time);
 VA.l(j,time)          = VAO(j)*pop(time);
 VSTK.l(i,time)        = VSTKO(i)*pop(time);
 WC.l(j,time)          = WCO(j);
 W.l(l,time)           = WO(l);
 WTI.l(l,j,time)       = WTIO(l,j);
 U.l(k,j,time)         = UO(k,j);
 XS.l(j,i,time)        = XSO(j,i)*pop(time);
 XST.l(j,time)         = XSTO(j)*pop(time);
 YDF.l(f,time)         = YDFO(f)*pop(time);
 YDH.l(h,time)         = YDHO(h)*pop(time);
 YF.l(f,time)          = YFO(f)*pop(time);
 YFK.l(f,time)         = YFKO(f)*pop(time);
 YFTR.l(f,time)        = YFTRO(f)*pop(time);
 YG.l(time)            = YGO*pop(time);
 YGK.l(time)           = YGKO*pop(time);
 YGTR.l(time)          = YGTRO*pop(time);
 YH.l(h,time)          = YHO(h)*pop(time);
 YHK.l(h,time)         = YHKO(h)*pop(time);
 YHL.l(h,time)         = YHLO(h)*pop(time);
 YHTR.l(h,time)        = YHTRO(h)*pop(time);
 YROW.l(time)          = YROWO*pop(time);

**  6.1.2 Closures
*   The numeraire is the nominal exchange rate
 e.fx(time)           = 1;
 CAB.fx(time)         = CABO*pop(time);
 CMIN.fx(i,h,time)    = CMINO(i,h)*pop(time);
 G.fx(time)           = GO*pop(time);
 IND.fx(k,pub,time)$KDO(k,pub)
                      = INDO(k,pub)*pop(time);
 KD.fx(k,j,t1)$KDO(k,j)
                      = KDO(k,j);
 KD.fx(k,j,time)${KDO(k,j) and [ord(time) gt 1]}
                      = KD.l(k,j,time-1)*(1-delta(k,j))+IND.l(k,j,time-1);
 LS.fx(l,time)        = LSO(l)*pop(time);
 PWM.fx(i,time)       = PWMO(i);
 PWX.fx(i,time)       = PWXO(i);
 VSTK.fx(i,time)      = VSTKO(i)*pop(time);

**  6.1.3 Rates and intercepts
 sh0.fx(h,time)        = sh0O(h)*pop(time);
 sh1.fx(h,time)        = sh1O(h);
 tr0.fx(h,time)        = tr0O(h)*pop(time);
 tr1.fx(h,time)        = tr1O(h);
 ttdf0.fx(f,time)      = ttdf0O(f)*pop(time);
 ttdf1.fx(f,time)      = ttdf1O(f);
 ttdh0.fx(h,time)      = ttdh0O(h)*pop(time);
 ttdh1.fx(h,time)      = ttdh1O(h);
 ttic.fx(i,time)       = tticO(i);
 ttik.fx(k,j,time)     = ttikO(k,j);
 ttim.fx(i,time)       = ttimO(i);
 ttip.fx(j,time)       = ttipO(j);
 ttiw.fx(l,j,time)     = ttiwO(l,j);
 ttix.fx(i,time)       = ttixO(i);

**  6.1.4 Resolution
SOLVE PEP1T USING CNS;
T(time)          = NO;
];

**  6.1.5 Table of results
*   In the following file, the set of scenarios is defined (here, we assume that
*   there is only one simulation in addition to the BAU scenario), and values
*   for the BAU scenario are computed and saved for the construction of result
*   tables.

$INCLUDE RESULTS PEP 1-t-b BAU.gms

** 6.2 Simulation
*  Here is where simulation scenarios should be defined. There is no need to
*  initialise variables as the solver will use the BAU values as a starting
*  point.

LOOP[time,
T(time) = YES;
 KD.fx(k,j,t1)$KDO(k,j)
                      = KDO(k,j);
 KD.fx(k,j,time)${KDO(k,j) and [ord(time) gt 1]}
                      = KD.l(k,j,time-1)*(1-delta(k,j))+IND.l(k,j,time-1);

**  6.2.1 Shock
*   We simulated a gradual complete elimination of import duties.

 ttim.fx(i,'1')     = 0.9*ttimO(i);
 ttim.fx(i,'2')     = 0.8*ttimO(i);
 ttim.fx(i,'3')     = 0.7*ttimO(i);
 ttim.fx(i,'4')     = 0.6*ttimO(i);
 ttim.fx(i,'5')     = 0.5*ttimO(i);
 ttim.fx(i,'6')     = 0.4*ttimO(i);
 ttim.fx(i,'7')     = 0.3*ttimO(i);
 ttim.fx(i,'8')     = 0.2*ttimO(i);
 ttim.fx(i,'9')     = 0.1*ttimO(i);
 ttim.fx(i,'10')    = 0*ttimO(i);

**  6.2.2 Resolution
SOLVE PEP1T USING CNS;
T(time)          = NO;
];


**  6.2.3 Table of results
*   In the following file, values after shock are computed and tables of
*   results are built and put in a GDX and Excel format.

$INCLUDE RESULTS PEP 1-t-b SIM1.gms

