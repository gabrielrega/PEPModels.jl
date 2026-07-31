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
*                         Andre Lemelin, Veronique Robichaud                   *
*                         and Bernard Decaluwe.                                *
*  - Noncommercial:       You may not use this work for commercial purposes.   *
*  - Share Alike:         If you alter, transform, or build upon this work,    *
*                         you may distribute the resulting work only under     *
*                         the same or similar license to this one.             *
*                                                                              *
*==============================================================================*

PARAMETER
 BL_C(i,z,time)          Consumption of commodity i by households in region z
 BL_CABX(z,time)         Current account balance or region z in terms of the international currency
 BL_CG(i,z,time)         Public consumption of commodity i in region z
 BL_CI(j,z,time)         Total intermediate consumption of industry j in region z
 BL_CMIN(i,z,time)       Minimum consumption of commodity i by households in region z
 BL_CTH_REAL(z,time)     Real household consumption in region z
 BL_DD(i,z,time)         Domestic demand for commodity i produced locally in region z
 BL_DI(i,j,z,time)       Intermediate consumption of commodity i by industry j in region z
 BL_DIT(i,z,time)        Total intermediate demand of commodity i in region z
 BL_DS(i,z,time)         Supply of commodity i to the domestic market of region z
 BL_EX(i,z,zj,time)      Quantity of product i exported by country z to country zj
 BL_EXT(i,z,time)        Supply of composite commodity i by region z to the export market
 BL_G_REAL(z,time)       Current real government expenditures on goods and services in region z
 BL_GDP_BP_REAL(z,time)  Real GDP at basic prices
 BL_GDP_BP_W_REAL(time)  Real world GDP at basic prices
 BL_GDP_MP_REAL(z,time)  Real GDP at market prices
 BL_IM(i,zj,z,time)      Quantity of product i imported by country z from country zj
 BL_IMT(i,z,time)        Quantity demanded of composite imports of commodity i by region z
 BL_IND(k,j,z,time)      Volume of new type k capital investment to industry j in region z
 BL_INV(i,z,time)        Final demand of commodity i for investment purposes (GFCF) in region z
 BL_IT_REAL(z,time)      Real gross fixed capital formation
 BL_KD(k,j,z,time)       Demand for type k capital by industry j in region z
 BL_KDC(j,z,time)        Demand for composite capital by industry j in region z
 BL_KS(k,z,time)         Supply of type k capital in region z
 BL_LD(l,j,z,time)       Demand for type l labor by industry j in region z
 BL_LDC(j,z,time)        Demand for composite labor by industry j in region z
 BL_LS(l,z,time)         Supply of type l labor in region z
 BL_MRGN(i,z,time)       Domestic production of commodity i in region z exported as international margin services
 BL_Q(i,z,time)          Quantity demanded of composite commodity i in region z
 BL_VA(j,z,time)         Value added of industry j in region z
 BL_XS(j,z,time)         Total output of industry j in region z
 BL_e(z,time)            Exchange rate (price of international currency in terms of region z local currency)
 BL_IR(z,time)           Interest rate
 BL_P(j,z,time)          Basic price of industry j production in region z
 BL_PC(i,z,time)         Purchaser price of composite commodity i (including all taxes and margins) in region z
 BL_PCI(j,z,time)        Intermediate consumption price index of industry j in region z
 BL_PD(i,z,time)         Price of local product i sold on region z domestic market (including all taxes)
 BL_PE(i,z,zj,time)      Price received for commodity i exported to region zj by region z (excluding export taxes)
 BL_PET(i,z,time)        Border price of composite commodity i exported by region z
 BL_PIXCON(z,time)       Consumer price index in region z
 BL_PIXGDP(z,time)       GDP deflator in region z
 BL_PIXGDP_W(time)       World GDP deflator
 BL_PIXGVT(z,time)       Public expenditures price index in region z
 BL_PIXINV(z,time)       Investment price index in region z
 BL_PK(z,time)           Price of new capital in region z
 BL_PL(i,z,time)         Price of local product i (excluding all taxes on products) in region z
 BL_PM(i,zj,z,time)      Price of commodity i imported by region z from region zj (including all taxes duties and margins)
 BL_PMT(i,z,time)        Price of composite commodity i imported by region z (including all taxes duties and margins)
 BL_PP(j,z,time)         Unit cost of industry j in region z including taxes directly related to the use of capital and labor but excluding other taxes on production
 BL_PVA(j,z,time)        Price of industry j value added in region z (including taxes on production directly related to the use of capital and labor)
 BL_PWM(i,zj,z,time)     World price of commodity i imported from country zj by region z (expressed in international currency)
 BL_PWMG(i,time)         World price of margin i (expressed in international currency)
 BL_PWX(i,z,zj,time)     World price of commodity i exported to country zj by region z (expressed in international currency)
 BL_R(k,j,z,time)        Rental rate of type k capital in industry j of region z
 BL_RC(j,z,time)         Rental rate of industry j composite capital in region z
 BL_RTI(k,j,z,time)      Rental rate paid by industry j for type k capital in region z including capital taxes
 BL_U(z,time)            User cost of capital in region z
 BL_W(l,z,time)          Wage rate of type l labor in region z
 BL_WC(j,z,time)         Wage rate of industry j composite labor in region z
 BL_WTI(l,j,z,time)      Wage rate paid z by industry j for type l labor in region including payroll taxes
 BL_CAB(z,time)          Current account balance of region z
 BL_CTH(z,time)          Consumption budget of households in region z
 BL_DEP(z,time)          Amount of depreciation (capital consumption allowance) in region z
 BL_G(z,time)            Current government expenditures on goods and services in region z
 BL_GDP_BP(z,time)       Region z GDP at basic prices
 BL_GDP_BP_W(time)       World GDP at basic prices
 BL_GDP_FD(z,time)       Region z GDP at purchasers prices from the perspective of final demand
 BL_GDP_IB(z,time)       Region z GDP at market prices (income-based)
 BL_GDP_MP(z,time)       Region z GDP at market prices
 BL_IT(z,time)           Total investment expenditures in region z
 BL_SG(z,time)           Government savings in region z
 BL_SH(z,time)           Household savings in region z
 BL_SROW(z,time)         Rest-of-the-world savings with respect to region z
 BL_TDH(z,time)          Household income taxes in region z
 BL_TIC(i,z,time)        Government revenue from indirect taxes on commodity i in region z
 BL_TICT(z,time)         Total government receipts of indirect taxes on commodities in region z
 BL_TIK(k,j,z,time)      Government revenue from taxes on type k capital used by industry j in region z
 BL_TIKT(z,time)         Total government revenue from from taxes on capital in region z
 BL_TIM(i,zj,z,time)     Government revenue from duties on commodity i imported from region zj by region z
 BL_TIMT(z,time)         Total government revenue from import duties in region z
 BL_TIP(i,z,time)        Government revenue from taxes on industry j production in region z (excluding taxes directly related to the use of capital and labor)
 BL_TIPT(z,time)         Total government revenue from production taxes in region z (excluding taxes directly related to the use of capital and labor)
 BL_TIW(l,j,z,time)      Government revenue from payroll taxes on type l labor in industry j of region z
 BL_TIWT(z,time)         Total government revenue from payroll taxes in region z
 BL_TIX(i,z,zj,time)     Government revenue from export taxes on commodity i exported by region z to region zj
 BL_TIXT(z,time)         Total government revenue from export taxes in region z
 BL_TPRCTS(z,time)       Total government revenue from taxes on products and imports in region z
 BL_TPRODN(z,time)       Total government revenue from other taxes on production in region z
 BL_YDH(z,time)          Household disposable income in region z
 BL_YG(z,time)           Total government income in region z
 BL_YH(z,time)           Household total income in region z
 BL_YHK(z,time)          Household capital income in region z
 BL_YHL(z,time)          Household labor income in region z
 BL_YROW(z,time)         Rest-of-the-world total income from region z
 BL_sh0(z,time)          Intercept (household savings)
 BL_sh1(z,time)          Slope (household savings)
 BL_ttdh0(z,time)        Intercept (household income tax)
 BL_ttdh1(z,time)        Slope (household income tax)
 BL_ttic(i,z,time)       Tax rate on commodity i
 BL_ttik(k,j,z,time)     Tax rate on capital k used in industry j
 BL_ttim(i,zj,z,time)    Rate of taxes and duties on imports of commodity i from country zj
 BL_ttip(j,z,time)       Tax rate on the production of industry j
 BL_ttiw(l,j,z,time)     Tax rate on type l worker compensation in industry j
 BL_ttix(i,z,zj,time)    Export tax rate on exported commodity x
 BL_CrdtMg(z,time)         Region z international credit margin
 BL_Debt(z,time)           Value of region z international financial liabilities
 BL_Debt_Lst(z,time)       Value of region z international financial liabilities at the previous period
 BL_Eqty(z,time)           Value of equity owned by region z
 BL_Eqty_Old(z,time)       Market value of capital inherited from the preceding period
 BL_Fasset(z,time)         Value of region z international financial assets
 BL_Fasset_Lst(z,time)     Value of region z international financial assets at the previous period
 BL_FinW(z,time)           Value of region z net financial wealth
 BL_PtfInv(z,zj,time)      Value of debt securities issued by region zj owned by z
 BL_PTF_W(time)            World portfolio of debt securities
 BL_RDebt(z,time)          Income paid on international financial liabilities
 BL_RFass(z,time)          Income from international financial assets
 BL_RR_Debt(z,time)        Rate of interest paid on financial liabilities
 BL_RR_Eqty(z,time)        Aggregate rate of return on equity assets
 BL_RR_Fasset(z,time)      Aggregate rate of return on international financial assets
 BL_RR_FinW(z,time)        Aggregate rate of return on net financial wealth
 BL_Wealth(z,time)         Region z wealth
 BL_A_VA(z,time)           Multifactor productivity
 BL_LEON(z,time)           Excess supply on the last market in region z
;

$GDXIN B_line_values-25-18.gdx
$LOAD BL_C, BL_CABX, BL_CG, BL_CI, BL_CMIN, BL_CTH_REAL, BL_DD, BL_DI, BL_DIT
$LOAD BL_DS, BL_EX, BL_EXT, BL_G_REAL, BL_GDP_BP_REAL, BL_GDP_BP_W_REAL
$LOAD BL_GDP_MP_REAL, BL_IM, BL_IMT, BL_IND, BL_INV, BL_IT_REAL, BL_KD, BL_KDC
$LOAD BL_KS, BL_LD, BL_LDC, BL_LS, BL_MRGN, BL_Q, BL_VA, BL_XS, BL_e, BL_IR
$LOAD BL_P, BL_PC, BL_PCI, BL_PD, BL_PE, BL_PET, BL_PIXCON, BL_PIXGDP
$LOAD BL_PIXGDP_W, BL_PIXGVT, BL_PIXINV, BL_PK, BL_PL, BL_PM, BL_PMT, BL_PP
$LOAD BL_PVA, BL_PWM, BL_PWMG, BL_PWX, BL_R, BL_RC, BL_RTI, BL_U, BL_W, BL_WC
$LOAD BL_WTI, BL_CAB, BL_CTH, BL_DEP, BL_G, BL_GDP_BP, BL_GDP_BP_W, BL_GDP_FD
$LOAD BL_GDP_IB, BL_GDP_MP, BL_IT, BL_SG, BL_SH, BL_SROW, BL_TDH, BL_TIC
$LOAD BL_TICT, BL_TIK, BL_TIKT, BL_TIM, BL_TIMT, BL_TIP, BL_TIPT, BL_TIW
$LOAD BL_TIWT, BL_TIX, BL_TIXT, BL_TPRCTS, BL_TPRODN, BL_YDH, BL_YG, BL_YH
$LOAD BL_YHK, BL_YHL, BL_YROW, BL_sh0, BL_sh1, BL_ttdh0, BL_ttdh1, BL_ttic
$LOAD BL_ttik, BL_ttim, BL_ttip, BL_ttiw, BL_ttix, BL_CrdtMg, BL_Debt
$LOAD BL_Debt_Lst, BL_Eqty, BL_Eqty_Old, BL_Fasset, BL_Fasset_Lst, BL_FinW
$LOAD BL_PtfInv, BL_PTF_W, BL_RDebt, BL_RFass, BL_RR_Debt, BL_RR_Eqty
$LOAD BL_RR_Fasset, BL_RR_FinW, BL_Wealth, BL_A_VA, BL_LEON


 C.l(i,z,time)            = BL_C(i,z,time);
 CABX.l(z,time)           = BL_CABX(z,time);
 CG.l(i,z,time)           = BL_CG(i,z,time);
 CI.l(j,z,time)           = BL_CI(j,z,time);
 CMIN.l(i,z,time)         = BL_CMIN(i,z,time);
 CTH_REAL.l(z,time)       = BL_CTH_REAL(z,time);
 DD.l(i,z,time)           = BL_DD(i,z,time);
 DI.l(i,j,z,time)         = BL_DI(i,j,z,time);
 DIT.l(i,z,time)          = BL_DIT(i,z,time);
 DS.l(i,z,time)           = BL_DS(i,z,time);
 EX.l(i,z,zj,time)        = BL_EX(i,z,zj,time);
 EXT.l(i,z,time)          = BL_EXT(i,z,time);
 G_REAL.l(z,time)         = BL_G_REAL(z,time);
 GDP_BP_REAL.l(z,time)    = BL_GDP_BP_REAL(z,time);
 GDP_BP_W_REAL.l(time)    = BL_GDP_BP_W_REAL(time);
 GDP_MP_REAL.l(z,time)    = BL_GDP_MP_REAL(z,time);
 IM.l(i,zj,z,time)        = BL_IM(i,zj,z,time);
 IMT.l(i,z,time)          = BL_IMT(i,z,time);
 IND.l(k,j,z,time)        = BL_IND(k,j,z,time);
 INV.l(i,z,time)          = BL_INV(i,z,time);
 IT_REAL.l(z,time)        = BL_IT_REAL(z,time);
 KD.l(k,j,z,time)         = BL_KD(k,j,z,time);
 KDC.l(j,z,time)          = BL_KDC(j,z,time);
 KS.l(k,z,time)           = BL_KS(k,z,time);
 LD.l(l,j,z,time)         = BL_LD(l,j,z,time);
 LDC.l(j,z,time)          = BL_LDC(j,z,time);
 LS.l(l,z,time)           = BL_LS(l,z,time);
 MRGN.l(i,z,time)         = BL_MRGN(i,z,time);
 Q.l(i,z,time)            = BL_Q(i,z,time);
 VA.l(j,z,time)           = BL_VA(j,z,time);
 XS.l(j,z,time)           = BL_XS(j,z,time);
 e.l(z,time)              = BL_e(z,time);
 IR.l(z,time)             = BL_IR(z,time);
 P.l(j,z,time)            = BL_P(j,z,time);
 PC.l(i,z,time)           = BL_PC(i,z,time);
 PCI.l(j,z,time)          = BL_PCI(j,z,time);
 PD.l(i,z,time)           = BL_PD(i,z,time);
 PE.l(i,z,zj,time)        = BL_PE(i,z,zj,time);
 PET.l(i,z,time)          = BL_PET(i,z,time);
 PIXCON.l(z,time)         = BL_PIXCON(z,time);
 PIXGDP.l(z,time)         = BL_PIXGDP(z,time);
 PIXGDP_W.l(time)         = BL_PIXGDP_W(time);
 PIXGVT.l(z,time)         = BL_PIXGVT(z,time);
 PIXINV.l(z,time)         = BL_PIXINV(z,time);
 PK.l(z,time)             = BL_PK(z,time);
 PL.l(i,z,time)           = BL_PL(i,z,time);
 PM.l(i,zj,z,time)        = BL_PM(i,zj,z,time);
 PMT.l(i,z,time)          = BL_PMT(i,z,time);
 PP.l(j,z,time)           = BL_PP(j,z,time);
 PVA.l(j,z,time)          = BL_PVA(j,z,time);
 PWM.l(i,zj,z,time)       = BL_PWM(i,zj,z,time);
 PWMG.l(i,time)           = BL_PWMG(i,time);
 PWX.l(i,z,zj,time)       = BL_PWX(i,z,zj,time);
 R.l(k,j,z,time)          = BL_R(k,j,z,time);
 RC.l(j,z,time)           = BL_RC(j,z,time);
 RTI.l(k,j,z,time)        = BL_RTI(k,j,z,time);
 U.l(z,time)              = BL_U(z,time);
 W.l(l,z,time)            = BL_W(l,z,time);
 WC.l(j,z,time)           = BL_WC(j,z,time);
 WTI.l(l,j,z,time)        = BL_WTI(l,j,z,time);
 CAB.l(z,time)            = BL_CAB(z,time);
 CTH.l(z,time)            = BL_CTH(z,time);
 DEP.l(z,time)            = BL_DEP(z,time);
 G.l(z,time)              = BL_G(z,time);
 GDP_BP.l(z,time)         = BL_GDP_BP(z,time);
 GDP_BP_W.l(time)         = BL_GDP_BP_W(time);
 GDP_FD.l(z,time)         = BL_GDP_FD(z,time);
 GDP_IB.l(z,time)         = BL_GDP_IB(z,time);
 GDP_MP.l(z,time)         = BL_GDP_MP(z,time);
 IT.l(z,time)             = BL_IT(z,time);
 SG.l(z,time)             = BL_SG(z,time);
 SH.l(z,time)             = BL_SH(z,time);
 SROW.l(z,time)           = BL_SROW(z,time);
 TDH.l(z,time)            = BL_TDH(z,time);
 TIC.l(i,z,time)          = BL_TIC(i,z,time);
 TICT.l(z,time)           = BL_TICT(z,time);
 TIK.l(k,j,z,time)        = BL_TIK(k,j,z,time);
 TIKT.l(z,time)           = BL_TIKT(z,time);
 TIM.l(i,zj,z,time)       = BL_TIM(i,zj,z,time);
 TIMT.l(z,time)           = BL_TIMT(z,time);
 TIP.l(i,z,time)          = BL_TIP(i,z,time);
 TIPT.l(z,time)           = BL_TIPT(z,time);
 TIW.l(l,j,z,time)        = BL_TIW(l,j,z,time);
 TIWT.l(z,time)           = BL_TIWT(z,time);
 TIX.l(i,z,zj,time)       = BL_TIX(i,z,zj,time);
 TIXT.l(z,time)           = BL_TIXT(z,time);
 TPRCTS.l(z,time)         = BL_TPRCTS(z,time);
 TPRODN.l(z,time)         = BL_TPRODN(z,time);
 YDH.l(z,time)            = BL_YDH(z,time);
 YG.l(z,time)             = BL_YG(z,time);
 YH.l(z,time)             = BL_YH(z,time);
 YHK.l(z,time)            = BL_YHK(z,time);
 YHL.l(z,time)            = BL_YHL(z,time);
 YROW.l(z,time)           = BL_YROW(z,time);
 sh0.l(z,time)            = BL_sh0(z,time);
 sh1.l(z,time)            = BL_sh1(z,time);
 ttdh0.l(z,time)          = BL_ttdh0(z,time);
 ttdh1.l(z,time)          = BL_ttdh1(z,time);
 ttic.l(i,z,time)         = BL_ttic(i,z,time);
 ttik.l(k,j,z,time)       = BL_ttik(k,j,z,time);
 ttim.l(i,zj,z,time)      = BL_ttim(i,zj,z,time);
 ttip.l(j,z,time)         = BL_ttip(j,z,time);
 ttiw.l(l,j,z,time)       = BL_ttiw(l,j,z,time);
 ttix.l(i,z,zj,time)      = BL_ttix(i,z,zj,time);
 CrdtMg.l(z,time)         = BL_CrdtMg(z,time);
 Debt.l(z,time)           = BL_Debt(z,time);
 Debt_Lst.l(z,time)       = BL_Debt_Lst(z,time);
 Eqty.l(z,time)           = BL_Eqty(z,time);
 Eqty_Old.l(z,time)       = BL_Eqty_Old(z,time);
 Fasset.l(z,time)         = BL_Fasset(z,time);
 Fasset_Lst.l(z,time)     = BL_Fasset_Lst(z,time);
 FinW.l(z,time)           = BL_FinW(z,time);
 PtfInv.l(z,zj,time)      = BL_PtfInv(z,zj,time);
 PTF_W.l(time)            = BL_PTF_W(time);
 RDebt.l(z,time)          = BL_RDebt(z,time);
 RFass.l(z,time)          = BL_RFass(z,time);
 RR_Debt.l(z,time)        = BL_RR_Debt(z,time);
 RR_Eqty.l(z,time)        = BL_RR_Eqty(z,time);
 RR_Fasset.l(z,time)      = BL_RR_Fasset(z,time);
 RR_FinW.l(z,time)        = BL_RR_FinW(z,time);
 Wealth.l(z,time)         = BL_Wealth(z,time);
 A_VA.l(z,time)           = BL_A_VA(z,time);
 LEON.l(z,time)           = BL_LEON(z,time);

