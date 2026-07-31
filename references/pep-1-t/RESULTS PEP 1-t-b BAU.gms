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

 valC(i,h,time,scen)         Consumption of commodity i by type h households
 valCAB(time,scen)           Current account balance
 valCG(i,time,scen)          Public final consumption of commodity i
 valCI(j,time,scen)          Total intermediate consumption of industry j
 valCMIN(i,h,time,scen)      Minimum consumption of commodity i by type h households
 valCTH(h,time,scen)         Consumption budget of type h households
 valCTH_REAL(h,time,scen)    Real consumption budget of type h households
 valDD(i,time,scen)          Domestic demand for commodity i produced locally
 valDI(i,j,time,scen)        Intermediate consumption of commodity i by industry j
 valDIT(i,time,scen)         Total intermediate demand for commodity i
 valDS(j,i,time,scen)        Supply of commodity i by sector j to the domestic market
 vale(time,scen)             Exchange rate (price of foreign currency in local currency)
 valEX(j,i,time,scen)        Quantity of product i exported by sector j
 valEXD(i,time,scen)         World demand for exports of product i
 valG(time,scen)             Current government expenditures on goods and services
 valG_REAL(time,scen)        Real current government expenditures on goods and services
 valGDP_BP(time,scen)        GDP at basic prices
 valGDP_BP_REAL(time,scen)   Real GDP at basic prices
 valGDP_FD(time,scen)        GDP at purchasers' prices from the perspective of final demand
 valGDP_IB(time,scen)        GDP at market prices (income-based)
 valGDP_MP(time,scen)        GDP at market prices
 valGDP_MP_REAL(time,scen)   Real GDP at market prices
 valGFCF(time,scen)          Gross fixed capital formation
 valGFCF_PRI_REAL(time,scen) Real private gross fixed capital formation
 valGFCF_PUB_REAL(time,scen) Real public gross fixed capital formation
 valIM(i,time,scen)          Quantity of product i imported
 valIND(k,j,time,scen)       Investment in capital k for sector j
 valINV(i,time,scen)         Total final demand of commodity i for investment purposes (GFCF)
 valINV_PRI(i,time,scen)     Final demand of commodity i for private investment purposes
 valINV_PUB(i,time,scen)     Final demand of commodity i for public investment purposes
 valIR(time,scen)            Interest rate
 valIT(time,scen)            Total investment expenditures
 valIT_PRI(time,scen)        Total private investment expenditures
 valIT_PUB(time,scen)        Total public investment expenditures
 valKD(k,j,time,scen)        Demand for type k capital by industry j
 valKDC(j,time,scen)         Industry j demand for composite capital
 valKS(k,time,scen)          Supply of type k capital
 valLD(l,j,time,scen)        Demand for type l labor by industry j
 valLDC(j,time,scen)         Industry j demand for composite labor
 valLS(l,time,scen)          Supply of type l labor
 valMRGN(i,time,scen)        Demand for commodity i as a trade or transport margin
 valP(j,i,time,scen)         Basic price of industry j's production of commodity i
 valPC(i,time,scen)          Purchaser price of composite comodity i (including all taxes and margins)
 valPCI(j,time,scen)         Intermediate consumption price index of industry j
 valPD(i,time,scen)          Price of local product i sold on the domestic market (including all taxes and margins)
 valPE(i,time,scen)          Price received for exported commodity x (excluding export taxes)
 valPE_FOB(i,time,scen)      FOB price of exported commodity x (in local currency)
 valPIXCON(time,scen)        Consumer price index
 valPIXCON_C(time,scen)      Chained consumer price index
 valPIXGDP(time,scen)        GDP deflator
 valPIXGDP_C(time,scen)      Chained GDP deflator
 valPIXGVT(time,scen)        Public expenditures price index
 valPIXGVT_C(time,scen)      Chained public expenditures price index
 valPIXINV_PRI(time,scen)    Private investment price index
 valPIXINV_PRI_C(time,scen)  Chained private investment price index
 valPIXINV_PUB(time,scen)    Public investment price index
 valPIXINV_PUB_C(time,scen)  Chained public investment price index
 valPK_PRI(time,scen)        Price of new private capital
 valPK_PUB(time,scen)        Price of new public capital
 valPL(i,time,scen)          Price of local product i (excluding all taxes on products)
 valPM(i,time,scen)          Price of imported product i (including all taxes and tariffs)
 valPP(j,time,scen)          Industry j unit cost including taxes directly related to the use of capital and labor but excluding other taxes on production
 valPT(j,time,scen)          Basic price of industry j's output
 valPVA(j,time,scen)         Price of industry j value added (including taxes on production directly related to the use of capital and labour)
 valPWM(i,time,scen)         World price of imported product i (expressed in foreign currency)
 valPWX(i,time,scen)         World price of exported product i (expressed in foreign currency)
 valQ(i,time,scen)           Quantity demanded of composite commodity i
 valR(k,j,time,scen)         Rental rate of type k capital in industry j
 valRC(j,time,scen)          Rental rate of industry j composite capital
 valRTI(k,j,time,scen)       Rental rate paid by industry j for type k capital including capital taxes
 valSF(f,time,scen)          Savings of type f businesses
 valSG(time,scen)            Government savings
 valSH(h,time,scen)          Savings of type h households
 valsh0(h,time,scen)         Intercept (type h household savings)
 valsh1(h,time,scen)         Slope (type h household savings)
 valSROW(time,scen)          Rest-of-the-world savings
 valTDF(f,time,scen)         Income taxes of type f businesses
 valTDFT(time,scen)          Total government revenue from business income taxes
 valTDH(h,time,scen)         Income taxes of type h households
 valTDHT(time,scen)          Total government revenue from household income taxes
 valTIC(i,time,scen)         Government revenue from indirect taxes on product i
 valTICT(time,scen)          Total government receipts of indirect taxes on commodities
 valTIK(k,j,time,scen)       Government revenue from taxes on type k capital used by industry j
 valTIKT(time,scen)          Total government revenue from from taxes on capital
 valTIM(i,time,scen)         Government revenue from import duties on product i
 valTIMT(time,scen)          Total government revenue from import duties
 valTIP(j,time,scen)         Government revenue from taxes on industry j production (excluding taxes directly related to the use of capital and labor)
 valTIPT(time,scen)          Total government revenue from production taxes (excluding taxes directly related to the use of capital and labor)
 valTIW(l,j,time,scen)       Government revenue from payroll taxes on type l labor in industry j
 valTIWT(time,scen)          Total government revenue from payroll taxes
 valTIX(i,time,scen)         Government revenue from export taxes on product i
 valTIXT(time,scen)          Total government revenue from export taxes
 valTPRCTS(time,scen)        Total government revenue from taxes on products and imports
 valTPRODN(time,scen)        Total government revenue from other taxes on production
 valTR(ag,agj,time,scen)     Transfers from agent agj to agent ag
 valtr0(h,time,scen)         Intercept (transfers by type h households to government)
 valtr1(h,time,scen)         Marginal rate of transfers by type h households to government
 valttdf0(f,time,scen)       Intercept (income taxes of type f businesses)
 valttdf1(f,time,scen)       Marginal income tax rate of type f businesses
 valttdh0(h,time,scen)       Intercept (income taxes of type h households)
 valttdh1(h,time,scen)       Marginal income tax rate of type h households
 valttic(i,time,scen)        Tax rate on commodity i
 valttik(k,j,time,scen)      Tax rate on type k capital used in industry j
 valttim(i,time,scen)        Rate of taxes and duties on imports of commodity m
 valttip(j,time,scen)        Tax rate on the production of industry j
 valttiw(l,j,time,scen)      Tax rate on type l worker compensation in industry j
 valttix(i,time,scen)        Export tax rate on exported commodity x
 valU(k,j,time,scen)         User cost of type k capital in industry j
 valVA(j,time,scen)          Value added of industry j
 valVSTK(i,time,scen)        Inventory change of commodity i
 valW(l,time,scen)           Wage rate of type l labor
 valWC(j,time,scen)          Wage rate of industry j composite labor
 valWTI(l,j,time,scen)       Wage rate paid by industry j for type l labor including payroll taxes
 valXS(j,i,time,scen)        Industry j production of commodity i
 valXST(j,time,scen)         Total aggregate output of industry j
 valYDF(f,time,scen)         Disposable income of type f businesses
 valYDH(h,time,scen)         Disposable income of type h households
 valYF(f,time,scen)          Total income of type f businesses
 valYFK(f,time,scen)         Capital income of type f businesses
 valYFTR(f,time,scen)        Transfer income of type f businesses
 valYG(time,scen)            Total government income
 valYGK(time,scen)           Government capital income
 valYGTR(time,scen)          Government transfer income
 valYH(h,time,scen)          Total income of type h households
 valYHK(h,time,scen)         Capital income of type h households
 valYHL(h,time,scen)         Labor income of type h households
 valYHTR(h,time,scen)        Transfer income of type h households
 valYROW(time,scen)          Rest-of-the-world income
;

 valC(i,h,time,'bau')         = C.l(i,h,time);
 valCAB(time,'bau')           = CAB.l(time);
 valCG(i,time,'bau')          = CG.l(i,time);
 valCI(j,time,'bau')          = CI.l(j,time);
 valCMIN(i,h,time,'bau')      = CMIN.l(i,h,time);
 valCTH(h,time,'bau')         = CTH.l(h,time);
 valCTH_REAL(h,time,'bau')    = CTH_REAL.l(h,time);
 valDD(i,time,'bau')          = DD.l(i,time);
 valDI(i,j,time,'bau')        = DI.l(i,j,time);
 valDIT(i,time,'bau')         = DIT.l(i,time);
 valDS(j,i,time,'bau')        = DS.l(j,i,time);
 vale(time,'bau')             = e.l(time);
 valEX(j,i,time,'bau')        = EX.l(j,i,time);
 valEXD(i,time,'bau')         = EXD.l(i,time);
 valG(time,'bau')             = G.l(time);
 valG_REAL(time,'bau')        = G_REAL.l(time);
 valGDP_BP(time,'bau')        = GDP_BP.l(time);
 valGDP_BP_REAL(time,'bau')   = GDP_BP_REAL.l(time);
 valGDP_FD(time,'bau')        = GDP_FD.l(time);
 valGDP_IB(time,'bau')        = GDP_IB.l(time);
 valGDP_MP(time,'bau')        = GDP_MP.l(time);
 valGDP_MP_REAL(time,'bau')   = GDP_MP_REAL.l(time);
 valGFCF(time,'bau')          = GFCF.l(time);
 valGFCF_PRI_REAL(time,'bau') = GFCF_PRI_REAL.l(time);
 valGFCF_PUB_REAL(time,'bau') = GFCF_PUB_REAL.l(time);
 valIM(i,time,'bau')          = IM.l(i,time);
 valIND(k,j,time,'bau')       = IND.l(k,j,time);
 valINV(i,time,'bau')         = INV.l(i,time);
 valINV_PRI(i,time,'bau')     = INV_PRI.l(i,time);
 valINV_PUB(i,time,'bau')     = INV_PUB.l(i,time);
 valIR(time,'bau')            = IR.l(time);
 valIT(time,'bau')            = IT.l(time);
 valIT_PRI(time,'bau')        = IT_PRI.l(time);
 valIT_PUB(time,'bau')        = IT_PUB.l(time);
 valKD(k,j,time,'bau')        = KD.l(k,j,time);
 valKDC(j,time,'bau')         = KDC.l(j,time);
 valKS(k,time,'bau')          = KS.l(k,time);
 valLD(l,j,time,'bau')        = LD.l(l,j,time);
 valLDC(j,time,'bau')         = LDC.l(j,time);
 valLS(l,time,'bau')          = LS.l(l,time);
 valMRGN(i,time,'bau')        = MRGN.l(i,time);
 valP(j,i,time,'bau')         = P.l(j,i,time);
 valPC(i,time,'bau')          = PC.l(i,time);
 valPCI(j,time,'bau')         = PCI.l(j,time);
 valPD(i,time,'bau')          = PD.l(i,time);
 valPE(i,time,'bau')          = PE.l(i,time);
 valPE_FOB(i,time,'bau')      = PE_FOB.l(i,time);
 valPIXCON(time,'bau')        = PIXCON.l(time);
 valPIXGDP(time,'bau')        = PIXGDP.l(time);
 valPIXGVT(time,'bau')        = PIXGVT.l(time);
 valPIXINV_PRI(time,'bau')    = PIXINV_PRI.l(time);
 valPIXINV_PUB(time,'bau')    = PIXINV_PUB.l(time);
 valPK_PRI(time,'bau')        = PK_PRI.l(time);
 valPK_PUB(time,'bau')        = PK_PUB.l(time);
 valPL(i,time,'bau')          = PL.l(i,time);
 valPM(i,time,'bau')          = PM.l(i,time);
 valPP(j,time,'bau')          = PP.l(j,time);
 valPT(j,time,'bau')          = PT.l(j,time);
 valPVA(j,time,'bau')         = PVA.l(j,time);
 valPWM(i,time,'bau')         = PWM.l(i,time);
 valPWX(i,time,'bau')         = PWX.l(i,time);
 valQ(i,time,'bau')           = Q.l(i,time);
 valR(k,j,time,'bau')         = R.l(k,j,time);
 valRC(j,time,'bau')          = RC.l(j,time);
 valRTI(k,j,time,'bau')       = RTI.l(k,j,time);
 valSF(f,time,'bau')          = SF.l(f,time);
 valSG(time,'bau')            = SG.l(time);
 valSH(h,time,'bau')          = SH.l(h,time);
 valsh0(h,time,'bau')         = sh0.l(h,time);
 valsh1(h,time,'bau')         = sh1.l(h,time);
 valSROW(time,'bau')          = SROW.l(time);
 valTDF(f,time,'bau')         = TDF.l(f,time);
 valTDFT(time,'bau')          = TDFT.l(time);
 valTDH(h,time,'bau')         = TDH.l(h,time);
 valTDHT(time,'bau')          = TDHT.l(time);
 valTIC(i,time,'bau')         = TIC.l(i,time);
 valTICT(time,'bau')          = TICT.l(time);
 valTIK(k,j,time,'bau')       = TIK.l(k,j,time);
 valTIKT(time,'bau')          = TIKT.l(time);
 valTIM(i,time,'bau')         = TIM.l(i,time);
 valTIMT(time,'bau')          = TIMT.l(time);
 valTIP(j,time,'bau')         = TIP.l(j,time);
 valTIPT(time,'bau')          = TIPT.l(time);
 valTIW(l,j,time,'bau')       = TIW.l(l,j,time);
 valTIWT(time,'bau')          = TIWT.l(time);
 valTIX(i,time,'bau')         = TIX.l(i,time);
 valTIXT(time,'bau')          = TIXT.l(time);
 valTPRCTS(time,'bau')        = TPRCTS.l(time);
 valTPRODN(time,'bau')        = TPRODN.l(time);
 valTR(ag,agj,time,'bau')     = TR.l(ag,agj,time);
 valtr0(h,time,'bau')         = tr0.l(h,time);
 valtr1(h,time,'bau')         = tr1.l(h,time);
 valttdf0(f,time,'bau')       = ttdf0.l(f,time);
 valttdf1(f,time,'bau')       = ttdf1.l(f,time);
 valttdh0(h,time,'bau')       = ttdh0.l(h,time);
 valttdh1(h,time,'bau')       = ttdh1.l(h,time);
 valttic(i,time,'bau')        = ttic.l(i,time);
 valttik(k,j,time,'bau')      = ttik.l(k,j,time);
 valttim(i,time,'bau')        = ttim.l(i,time);
 valttip(j,time,'bau')        = ttip.l(j,time);
 valttiw(l,j,time,'bau')      = ttiw.l(l,j,time);
 valttix(i,time,'bau')        = ttix.l(i,time);
 valU(k,j,time,'bau')         = U.l(k,j,time);
 valVA(j,time,'bau')          = VA.l(j,time);
 valVSTK(i,time,'bau')        = VSTK.l(i,time);
 valW(l,time,'bau')           = W.l(l,time);
 valWC(j,time,'bau')          = WC.l(j,time);
 valWTI(l,j,time,'bau')       = WTI.l(l,j,time);
 valXS(j,i,time,'bau')        = XS.l(j,i,time);
 valXST(j,time,'bau')         = XST.l(j,time);
 valYDF(f,time,'bau')         = YDF.l(f,time);
 valYDH(h,time,'bau')         = YDH.l(h,time);
 valYF(f,time,'bau')          = YF.l(f,time);
 valYFK(f,time,'bau')         = YFK.l(f,time);
 valYFTR(f,time,'bau')        = YFTR.l(f,time);
 valYG(time,'bau')            = YG.l(time);
 valYGK(time,'bau')           = YGK.l(time);
 valYGTR(time,'bau')          = YGTR.l(time);
 valYH(h,time,'bau')          = YH.l(h,time);
 valYHK(h,time,'bau')         = YHK.l(h,time);
 valYHL(h,time,'bau')         = YHL.l(h,time);
 valYHTR(h,time,'bau')        = YHTR.l(h,time);
 valYROW(time,'bau')          = YROW.l(time);
 valPIXCON_C(t1,'bau')        = PIXCON.l(t1);
 valPIXGDP_C(t1,'bau')        = PIXGDP.l(t1);
 valPIXINV_PRI_C(t1,'bau')    = PIXINV_PRI.l(t1);
 valPIXINV_PUB_C(t1,'bau')    = PIXINV_PUB.l(t1);
loop[time$(ORD(time) gt 1),
 valPIXCON_C(time,'bau')      = valPIXCON_C(time-1,'bau')*SUM[i,PC.l(i,time)
                              *SUM[h,C.l(i,h,time-1)]]
                              /SUM[i,PC.l(i,time-1)*SUM[h,C.l(i,h,time-1)]];
 valPIXGDP_C(time,'bau')      = valPIXGDP_C(time-1,'bau')*{SUM[j,PVA.l(j,time)
                             *VA.l(j,time-1)]/SUM[j,PVA.l(j,time-1)
                             *VA.l(j,time-1)]*SUM[j,PVA.l(j,time)
                             *VA.l(j,time)]/SUM[j,PVA.l(j,time-1)
                             *VA.l(j,time)]}**0.5;
 valPIXINV_PRI_C(time,'bau')  = valPIXINV_PRI_C(time-1,'bau')*PROD[i$gamma_INVPRI(i),
                          (PC.l(i,time)/PC.l(i,time-1))**gamma_INVPRI(i)];
 valPIXINV_PUB_C(time,'bau')  = valPIXINV_PUB_C(time-1,'bau')*PROD[i$gamma_INVPUB(i),
                           (PC.l(i,time)/PC.l(i,time-1))**gamma_INVPUB(i)];
];

