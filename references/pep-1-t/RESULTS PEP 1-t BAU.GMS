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


*   In this file, the set of scenarios is defined (here, we assume that there
*   is only one simulation in addition to the BAU scenario), and values for the
*   BAU scenario are computed and saved for the construction of result tables.

SET

SCEN  Definition of scenarios
/
 BAU             Business as usual values
 SIM1            Complete elimination of import duties
 VAR             Variation from benchmark (in percentage)
/
;

PARAMETER

 valC(i,h,t,scen)         Consumption of commodity i by type h households
 valCAB(t,scen)           Current account balance
 valCG(i,t,scen)          Public final consumption of commodity i
 valCI(j,t,scen)          Total intermediate consumption of industry j
 valCMIN(i,h,t,scen)      Minimum consumption of commodity i by type h households
 valCTH(h,t,scen)         Consumption budget of type h households
 valCTH_REAL(h,t,scen)    Real consumption budget of type h households
 valDD(i,t,scen)          Domestic demand for commodity i produced locally
 valDI(i,j,t,scen)        Intermediate consumption of commodity i by industry j
 valDIT(i,t,scen)         Total intermediate demand for commodity i
 valDS(j,i,t,scen)        Supply of commodity i by sector j to the domestic market
 vale(t,scen)             Exchange rate (price of foreign currency in local currency)
 valEX(j,i,t,scen)        Quantity of product i exported by sector j
 valEXD(i,t,scen)         World demand for exports of product i
 valG(t,scen)             Current government expenditures on goods and services
 valG_REAL(t,scen)        Real current government expenditures on goods and services
 valGDP_BP(t,scen)        GDP at basic prices
 valGDP_BP_REAL(t,scen)   Real GDP at basic prices
 valGDP_FD(t,scen)        GDP at purchasers' prices from the perspective of final demand
 valGDP_IB(t,scen)        GDP at market prices (income-based)
 valGDP_MP(t,scen)        GDP at market prices
 valGDP_MP_REAL(t,scen)   Real GDP at market prices
 valGFCF(t,scen)          Gross fixed capital formation
 valGFCF_PRI_REAL(t,scen) Real private gross fixed capital formation
 valGFCF_PUB_REAL(t,scen) Real public gross fixed capital formation
 valIM(i,t,scen)          Quantity of product i imported
 valIND(k,j,t,scen)       Investment in capital k for sector j
 valINV(i,t,scen)         Total final demand of commodity i for investment purposes (GFCF)
 valINV_PRI(i,t,scen)     Final demand of commodity i for private investment purposes
 valINV_PUB(i,t,scen)     Final demand of commodity i for public investment purposes
 valIR(t,scen)            Interest rate
 valIT(t,scen)            Total investment expenditures
 valIT_PRI(t,scen)        Total private investment expenditures
 valIT_PUB(t,scen)        Total public investment expenditures
 valKD(k,j,t,scen)        Demand for type k capital by industry j
 valKDC(j,t,scen)         Industry j demand for composite capital
 valKS(k,t,scen)          Supply of type k capital
 valLD(l,j,t,scen)        Demand for type l labor by industry j
 valLDC(j,t,scen)         Industry j demand for composite labor
 valLS(l,t,scen)          Supply of type l labor
 valMRGN(i,t,scen)        Demand for commodity i as a trade or transport margin
 valP(j,i,t,scen)         Basic price of industry j's production of commodity i
 valPC(i,t,scen)          Purchaser price of composite comodity i (including all taxes and margins)
 valPCI(j,t,scen)         Intermediate consumption price index of industry j
 valPD(i,t,scen)          Price of local product i sold on the domestic market (including all taxes and margins)
 valPE(i,t,scen)          Price received for exported commodity x (excluding export taxes)
 valPE_FOB(i,t,scen)      FOB price of exported commodity x (in local currency)
 valPIXCON(t,scen)        Consumer price index
 valPIXCON_C(t,scen)      Chained consumer price index
 valPIXGDP(t,scen)        GDP deflator
 valPIXGDP_C(t,scen)      Chained GDP deflator
 valPIXGVT(t,scen)        Public expenditures price index
 valPIXGVT_C(t,scen)      Chained public expenditures price index
 valPIXINV_PRI(t,scen)    Private investment price index
 valPIXINV_PRI_C(t,scen)  Chained private investment price index
 valPIXINV_PUB(t,scen)    Public investment price index
 valPIXINV_PUB_C(t,scen)  Chained public investment price index
 valPK_PRI(t,scen)        Price of new private capital
 valPK_PUB(t,scen)        Price of new public capital
 valPL(i,t,scen)          Price of local product i (excluding all taxes on products)
 valPM(i,t,scen)          Price of imported product i (including all taxes and tariffs)
 valPP(j,t,scen)          Industry j unit cost including taxes directly related to the use of capital and labor but excluding other taxes on production
 valPT(j,t,scen)          Basic price of industry j's output
 valPVA(j,t,scen)         Price of industry j value added (including taxes on production directly related to the use of capital and labour)
 valPWM(i,t,scen)         World price of imported product i (expressed in foreign currency)
 valPWX(i,t,scen)         World price of exported product i (expressed in foreign currency)
 valQ(i,t,scen)           Quantity demanded of composite commodity i
 valR(k,j,t,scen)         Rental rate of type k capital in industry j
 valRC(j,t,scen)          Rental rate of industry j composite capital
 valRTI(k,j,t,scen)       Rental rate paid by industry j for type k capital including capital taxes
 valSF(f,t,scen)          Savings of type f businesses
 valSG(t,scen)            Government savings
 valSH(h,t,scen)          Savings of type h households
 valsh0(h,t,scen)         Intercept (type h household savings)
 valsh1(h,t,scen)         Slope (type h household savings)
 valSROW(t,scen)          Rest-of-the-world savings
 valTDF(f,t,scen)         Income taxes of type f businesses
 valTDFT(t,scen)          Total government revenue from business income taxes
 valTDH(h,t,scen)         Income taxes of type h households
 valTDHT(t,scen)          Total government revenue from household income taxes
 valTIC(i,t,scen)         Government revenue from indirect taxes on product i
 valTICT(t,scen)          Total government receipts of indirect taxes on commodities
 valTIK(k,j,t,scen)       Government revenue from taxes on type k capital used by industry j
 valTIKT(t,scen)          Total government revenue from from taxes on capital
 valTIM(i,t,scen)         Government revenue from import duties on product i
 valTIMT(t,scen)          Total government revenue from import duties
 valTIP(j,t,scen)         Government revenue from taxes on industry j production (excluding taxes directly related to the use of capital and labor)
 valTIPT(t,scen)          Total government revenue from production taxes (excluding taxes directly related to the use of capital and labor)
 valTIW(l,j,t,scen)       Government revenue from payroll taxes on type l labor in industry j
 valTIWT(t,scen)          Total government revenue from payroll taxes
 valTIX(i,t,scen)         Government revenue from export taxes on product i
 valTIXT(t,scen)          Total government revenue from export taxes
 valTPRCTS(t,scen)        Total government revenue from taxes on products and imports
 valTPRODN(t,scen)        Total government revenue from other taxes on production
 valTR(ag,agj,t,scen)     Transfers from agent agj to agent ag
 valtr0(h,t,scen)         Intercept (transfers by type h households to government)
 valtr1(h,t,scen)         Marginal rate of transfers by type h households to government
 valttdf0(f,t,scen)       Intercept (income taxes of type f businesses)
 valttdf1(f,t,scen)       Marginal income tax rate of type f businesses
 valttdh0(h,t,scen)       Intercept (income taxes of type h households)
 valttdh1(h,t,scen)       Marginal income tax rate of type h households
 valttic(i,t,scen)        Tax rate on commodity i
 valttik(k,j,t,scen)      Tax rate on type k capital used in industry j
 valttim(i,t,scen)        Rate of taxes and duties on imports of commodity m
 valttip(j,t,scen)        Tax rate on the production of industry j
 valttiw(l,j,t,scen)      Tax rate on type l worker compensation in industry j
 valttix(i,t,scen)        Export tax rate on exported commodity x
 valU(k,j,t,scen)         User cost of type k capital in industry j
 valVA(j,t,scen)          Value added of industry j
 valVSTK(i,t,scen)        Inventory change of commodity i
 valW(l,t,scen)           Wage rate of type l labor
 valWC(j,t,scen)          Wage rate of industry j composite labor
 valWTI(l,j,t,scen)       Wage rate paid by industry j for type l labor including payroll taxes
 valXS(j,i,t,scen)        Industry j production of commodity i
 valXST(j,t,scen)         Total aggregate output of industry j
 valYDF(f,t,scen)         Disposable income of type f businesses
 valYDH(h,t,scen)         Disposable income of type h households
 valYF(f,t,scen)          Total income of type f businesses
 valYFK(f,t,scen)         Capital income of type f businesses
 valYFTR(f,t,scen)        Transfer income of type f businesses
 valYG(t,scen)            Total government income
 valYGK(t,scen)           Government capital income
 valYGTR(t,scen)          Government transfer income
 valYH(h,t,scen)          Total income of type h households
 valYHK(h,t,scen)         Capital income of type h households
 valYHL(h,t,scen)         Labor income of type h households
 valYHTR(h,t,scen)        Transfer income of type h households
 valYROW(t,scen)          Rest-of-the-world income
;

 valC(i,h,t,'bau')         = C.l(i,h,t);
 valCAB(t,'bau')           = CAB.l(t);
 valCG(i,t,'bau')          = CG.l(i,t);
 valCI(j,t,'bau')          = CI.l(j,t);
 valCMIN(i,h,t,'bau')      = CMIN.l(i,h,t);
 valCTH(h,t,'bau')         = CTH.l(h,t);
 valCTH_REAL(h,t,'bau')    = CTH_REAL.l(h,t);
 valDD(i,t,'bau')          = DD.l(i,t);
 valDI(i,j,t,'bau')        = DI.l(i,j,t);
 valDIT(i,t,'bau')         = DIT.l(i,t);
 valDS(j,i,t,'bau')        = DS.l(j,i,t);
 vale(t,'bau')             = e.l(t);
 valEX(j,i,t,'bau')        = EX.l(j,i,t);
 valEXD(i,t,'bau')         = EXD.l(i,t);
 valG(t,'bau')             = G.l(t);
 valG_REAL(t,'bau')        = G_REAL.l(t);
 valGDP_BP(t,'bau')        = GDP_BP.l(t);
 valGDP_BP_REAL(t,'bau')   = GDP_BP_REAL.l(t);
 valGDP_FD(t,'bau')        = GDP_FD.l(t);
 valGDP_IB(t,'bau')        = GDP_IB.l(t);
 valGDP_MP(t,'bau')        = GDP_MP.l(t);
 valGDP_MP_REAL(t,'bau')   = GDP_MP_REAL.l(t);
 valGFCF(t,'bau')          = GFCF.l(t);
 valGFCF_PRI_REAL(t,'bau') = GFCF_PRI_REAL.l(t);
 valGFCF_PUB_REAL(t,'bau') = GFCF_PUB_REAL.l(t);
 valIM(i,t,'bau')          = IM.l(i,t);
 valIND(k,j,t,'bau')       = IND.l(k,j,t);
 valINV(i,t,'bau')         = INV.l(i,t);
 valINV_PRI(i,t,'bau')     = INV_PRI.l(i,t);
 valINV_PUB(i,t,'bau')     = INV_PUB.l(i,t);
 valIR(t,'bau')            = IR.l(t);
 valIT(t,'bau')            = IT.l(t);
 valIT_PRI(t,'bau')        = IT_PRI.l(t);
 valIT_PUB(t,'bau')        = IT_PUB.l(t);
 valKD(k,j,t,'bau')        = KD.l(k,j,t);
 valKDC(j,t,'bau')         = KDC.l(j,t);
 valKS(k,t,'bau')          = KS.l(k,t);
 valLD(l,j,t,'bau')        = LD.l(l,j,t);
 valLDC(j,t,'bau')         = LDC.l(j,t);
 valLS(l,t,'bau')          = LS.l(l,t);
 valMRGN(i,t,'bau')        = MRGN.l(i,t);
 valP(j,i,t,'bau')         = P.l(j,i,t);
 valPC(i,t,'bau')          = PC.l(i,t);
 valPCI(j,t,'bau')         = PCI.l(j,t);
 valPD(i,t,'bau')          = PD.l(i,t);
 valPE(i,t,'bau')          = PE.l(i,t);
 valPE_FOB(i,t,'bau')      = PE_FOB.l(i,t);
 valPIXCON(t,'bau')        = PIXCON.l(t);
 valPIXGDP(t,'bau')        = PIXGDP.l(t);
 valPIXGVT(t,'bau')        = PIXGVT.l(t);
 valPIXINV_PRI(t,'bau')    = PIXINV_PRI.l(t);
 valPIXINV_PUB(t,'bau')    = PIXINV_PUB.l(t);
 valPK_PRI(t,'bau')        = PK_PRI.l(t);
 valPK_PUB(t,'bau')        = PK_PUB.l(t);
 valPL(i,t,'bau')          = PL.l(i,t);
 valPM(i,t,'bau')          = PM.l(i,t);
 valPP(j,t,'bau')          = PP.l(j,t);
 valPT(j,t,'bau')          = PT.l(j,t);
 valPVA(j,t,'bau')         = PVA.l(j,t);
 valPWM(i,t,'bau')         = PWM.l(i,t);
 valPWX(i,t,'bau')         = PWX.l(i,t);
 valQ(i,t,'bau')           = Q.l(i,t);
 valR(k,j,t,'bau')         = R.l(k,j,t);
 valRC(j,t,'bau')          = RC.l(j,t);
 valRTI(k,j,t,'bau')       = RTI.l(k,j,t);
 valSF(f,t,'bau')          = SF.l(f,t);
 valSG(t,'bau')            = SG.l(t);
 valSH(h,t,'bau')          = SH.l(h,t);
 valsh0(h,t,'bau')         = sh0.l(h,t);
 valsh1(h,t,'bau')         = sh1.l(h,t);
 valSROW(t,'bau')          = SROW.l(t);
 valTDF(f,t,'bau')         = TDF.l(f,t);
 valTDFT(t,'bau')          = TDFT.l(t);
 valTDH(h,t,'bau')         = TDH.l(h,t);
 valTDHT(t,'bau')          = TDHT.l(t);
 valTIC(i,t,'bau')         = TIC.l(i,t);
 valTICT(t,'bau')          = TICT.l(t);
 valTIK(k,j,t,'bau')       = TIK.l(k,j,t);
 valTIKT(t,'bau')          = TIKT.l(t);
 valTIM(i,t,'bau')         = TIM.l(i,t);
 valTIMT(t,'bau')          = TIMT.l(t);
 valTIP(j,t,'bau')         = TIP.l(j,t);
 valTIPT(t,'bau')          = TIPT.l(t);
 valTIW(l,j,t,'bau')       = TIW.l(l,j,t);
 valTIWT(t,'bau')          = TIWT.l(t);
 valTIX(i,t,'bau')         = TIX.l(i,t);
 valTIXT(t,'bau')          = TIXT.l(t);
 valTPRCTS(t,'bau')        = TPRCTS.l(t);
 valTPRODN(t,'bau')        = TPRODN.l(t);
 valTR(ag,agj,t,'bau')     = TR.l(ag,agj,t);
 valtr0(h,t,'bau')         = tr0.l(h,t);
 valtr1(h,t,'bau')         = tr1.l(h,t);
 valttdf0(f,t,'bau')       = ttdf0.l(f,t);
 valttdf1(f,t,'bau')       = ttdf1.l(f,t);
 valttdh0(h,t,'bau')       = ttdh0.l(h,t);
 valttdh1(h,t,'bau')       = ttdh1.l(h,t);
 valttic(i,t,'bau')        = ttic.l(i,t);
 valttik(k,j,t,'bau')      = ttik.l(k,j,t);
 valttim(i,t,'bau')        = ttim.l(i,t);
 valttip(j,t,'bau')        = ttip.l(j,t);
 valttiw(l,j,t,'bau')      = ttiw.l(l,j,t);
 valttix(i,t,'bau')        = ttix.l(i,t);
 valU(k,j,t,'bau')         = U.l(k,j,t);
 valVA(j,t,'bau')          = VA.l(j,t);
 valVSTK(i,t,'bau')        = VSTK.l(i,t);
 valW(l,t,'bau')           = W.l(l,t);
 valWC(j,t,'bau')          = WC.l(j,t);
 valWTI(l,j,t,'bau')       = WTI.l(l,j,t);
 valXS(j,i,t,'bau')        = XS.l(j,i,t);
 valXST(j,t,'bau')         = XST.l(j,t);
 valYDF(f,t,'bau')         = YDF.l(f,t);
 valYDH(h,t,'bau')         = YDH.l(h,t);
 valYF(f,t,'bau')          = YF.l(f,t);
 valYFK(f,t,'bau')         = YFK.l(f,t);
 valYFTR(f,t,'bau')        = YFTR.l(f,t);
 valYG(t,'bau')            = YG.l(t);
 valYGK(t,'bau')           = YGK.l(t);
 valYGTR(t,'bau')          = YGTR.l(t);
 valYH(h,t,'bau')          = YH.l(h,t);
 valYHK(h,t,'bau')         = YHK.l(h,t);
 valYHL(h,t,'bau')         = YHL.l(h,t);
 valYHTR(h,t,'bau')        = YHTR.l(h,t);
 valYROW(t,'bau')          = YROW.l(t);
 valPIXCON_C(t1,'bau')     = PIXCON.l(t1);
 valPIXGDP_C(t1,'bau')     = PIXGDP.l(t1);
 valPIXINV_PRI_C(t1,'bau') = PIXINV_PRI.l(t1);
 valPIXINV_PUB_C(t1,'bau') = PIXINV_PUB.l(t1);
loop[t$(ORD(t) gt 1),
 valPIXCON_C(t,'bau')      = valPIXCON_C(t-1,'bau')*SUM[i,PC.l(i,t)
                              *SUM[h,C.l(i,h,t-1)]]
                              /SUM[i,PC.l(i,t-1)*SUM[h,C.l(i,h,t-1)]];
 valPIXGDP_C(t,'bau')      = valPIXGDP_C(t-1,'bau')*
               {SUM[j,{(PVA.l(j,t)*VA.l(j,t)+TIP.l(j,t))/VA.l(j,t)}*VA.l(j,t-1)]
               /SUM[j,{(PVA.l(j,t-1)*VA.l(j,t-1)+TIP.l(j,t-1))/VA.l(j,t-1)}*VA.l(j,t-1)]
               *SUM[j,{(PVA.l(j,t)*VA.l(j,t)+TIP.l(j,t))/VA.l(j,t)}*VA.l(j,t)]
               /SUM[j,{(PVA.l(j,t-1)*VA.l(j,t-1)+TIP.l(j,t-1))/VA.l(j,t-1)}*VA.l(j,t)]
                          }**0.5;
 valPIXINV_PRI_C(t,'bau')  = valPIXINV_PRI_C(t-1,'bau')*PROD[i$gamma_INVPRI(i),
                          (PC.l(i,t)/PC.l(i,t-1))**gamma_INVPRI(i)];
 valPIXINV_PUB_C(t,'bau')  = valPIXINV_PUB_C(t-1,'bau')*PROD[i$gamma_INVPUB(i),
                           (PC.l(i,t)/PC.l(i,t-1))**gamma_INVPUB(i)];
];

