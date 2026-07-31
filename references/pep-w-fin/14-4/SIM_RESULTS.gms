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
*                         and Bernard Decaluwe                                 *
*  - Noncommercial:       You may not use this work for commercial purposes.   *
*  - Share Alike:         If you alter, transform, or build upon this work,    *
*                         you may distribute the resulting work only under     *
*                         the same or similar license to this one.             *
*                                                                              *
*==============================================================================*

* This file is included in the program file SIM_SOLVE.gms

*==============================================================================
*   6.3.7 Results
*==============================================================================
*   In this file, values for the SIM scenario are computed and saved
*   for the construction of result tables.

*==============================================================================
*   6.3.7.1 Assignment of solution values to result parameters
*==============================================================================
 valA_VA(z,time,'sim')       = A_VA.l(z,time);
 valC(i,z,time,'sim')        = C.l(i,z,time);
 valCAB(z,time,'sim')        = CAB.l(z,time);
 valCABX(z,time,'sim')       = CABX.l(z,time);
 valCG(i,z,time,'sim')       = CG.l(i,z,time);
 valCI(j,z,time,'sim')       = CI.l(j,z,time);
 valCMIN(i,z,time,'sim')     = CMIN.l(i,z,time);
 valCrdtMg(z,time,'sim')     = CrdtMg.l(z,time);
 valCTH(z,time,'sim')        = CTH.l(z,time);
 valCTH_REAL(z,time,'sim')   = CTH_REAL.l(z,time);
 valDD(i,z,time,'sim')       = DD.l(i,z,time);
 valDebt(z,time,'sim')       = Debt.l(z,time);
 valDebt_Lst(z,time,'sim')   = Debt_Lst.l(z,time);
 valDEP(z,time,'sim')        = DEP.l(z,time);
 valDI(i,j,z,time,'sim')     = DI.l(i,j,z,time);
 valDIT(i,z,time,'sim')      = DIT.l(i,z,time);
 valDS(i,z,time,'sim')       = DS.l(i,z,time);
 vale(z,time,'sim')          = e.l(z,time);
 valEqty(z,time,'sim')       = Eqty.l(z,time);
 valEqty_old(z,time,'sim')   = Eqty_old.l(z,time);
 valEX(i,z,zj,time,'sim')    = EX.l(i,z,zj,time);
 valEXT(i,z,time,'sim')      = EXT.l(i,z,time);
 valFasset(z,time,'sim')     = Fasset.l(z,time);
 valFasset_Lst(z,time,'sim') = Fasset_Lst.l(z,time);
 valFinW(z,time,'sim')       = FinW.l(z,time);
 valG(z,time,'sim')          = G.l(z,time);
 ValG_REAL(z,time,'sim')     = G_REAL.L(z,time);
 valGDP_BP(z,time,'sim')     = GDP_BP.l(z,time);
 valGDP_BP_REAL(z,time,'sim')= GDP_BP_REAL.l(z,time);
 valGDP_BP_W(time,'sim')     = GDP_BP_W.l(time);
 valGDP_BP_W_REAL(time,'sim')= GDP_BP_W_REAL.l(time);
 valGDP_FD(z,time,'sim')     = GDP_FD.l(z,time);
 valGDP_IB(z,time,'sim')     = GDP_IB.l(z,time);
 valGDP_MP(z,time,'sim')     = GDP_MP.l(z,time);
 valGDP_MP_REAL(z,time,'sim')= GDP_MP_REAL.l(z,time);
 valIM(i,zj,z,time,'sim')    = IM.l(i,zj,z,time);
 valIMT(i,z,time,'sim')      = IMT.l(i,z,time);
 valIND(k,j,z,time,'sim')    = IND.l(k,j,z,time);
 valINV(i,z,time,'sim')      = INV.l(i,z,time);
 valIR(z,time,'sim')         = IR.l(z,time);
 valIT(z,time,'sim')         = IT.l(z,time);
 valIT_REAL(z,time,'sim')    = IT_REAL.l(z,time);
 valKD(k,j,z,time,'sim')     = KD.l(k,j,z,time);
 valKDC(j,z,time,'sim')      = KDC.l(j,z,time);
 valKS(k,z,time,'sim')       = KS.l(k,z,time);
 valLD(l,j,z,time,'sim')     = LD.l(l,j,z,time);
 valLDC(j,z,time,'sim')      = LDC.l(j,z,time);
 valLS(l,z,time,'sim')       = LS.l(l,z,time);
 valMRGN(i,z,time,'sim')     = MRGN.l(i,z,time);
 valP(j,z,time,'sim')        = P.l(j,z,time);
 valPC(i,z,time,'sim')       = PC.l(i,z,time);
 valPCI(j,z,time,'sim')      = PCI.l(j,z,time);
 valPD(i,z,time,'sim')       = PD.l(i,z,time);
 valPE(i,z,zj,time,'sim')    = PE.l(i,z,zj,time);
 valPET(i,z,time,'sim')      = PET.l(i,z,time);
 valPIXCON(z,time,'sim')     = PIXCON.l(z,time);
 valPIXGDP(z,time,'sim')     = PIXGDP.l(z,time);
 valPIXGDP_W(time,'sim')     = PIXGDP_W.l(time);
 valPIXGVT(z,time,'sim')     = PIXGVT.l(z,time);
 valPIXINV(z,time,'sim')     = PIXINV.l(z,time);
 valPK(z,time,'sim')         = PK.l(z,time);
 valPL(i,z,time,'sim')       = PL.l(i,z,time);
 valPM(i,zj,z,time,'sim')    = PM.l(i,zj,z,time);
 valPMT(i,z,time,'sim')      = PMT.l(i,z,time);
 valPP(j,z,time,'sim')       = PP.l(j,z,time);
 valPTF_W(time,'sim')        = PTF_W.l(time);
 valPtfInv(z,zj,time,'sim')  = PtfInv.l(z,zj,time);
 valPVA(j,Z,time,'sim')      = PVA.l(j,Z,time);
 valPWM(i,zj,z,time,'sim')   = PWM.l(i,zj,z,time);
 valPWMG(i,time,'sim')       = PWMG.l(i,time);
 valPWX(i,z,zj,time,'sim')   = PWX.l(i,z,zj,time);
 valQ(i,z,time,'sim')        = Q.l(i,z,time);
 valR(k,j,z,time,'sim')      = R.l(k,j,z,time);
 valRC(j,z,time,'sim')       = RC.l(j,z,time);
 valRDebt(z,time,'sim')      = RDebt.l(z,time);
 valRFass(z,time,'sim')      = RFass.l(z,time);
 valRR_Debt(z,time,'sim')    = RR_Debt.l(z,time);
 valRR_Eqty(z,time,'sim')    = RR_Eqty.l(z,time);
 valRR_Fasset(z,time,'sim')  = RR_Fasset.l(z,time);
 valRR_FinW(z,time,'sim')    = RR_FinW.l(z,time);
 valRTI(k,j,z,time,'sim')    = RTI.l(k,j,z,time);
 valSG(z,time,'sim')         = SG.l(z,time);
 valSH(z,time,'sim')         = SH.l(z,time);
 valsh0(z,time,'sim')        = sh0.l(z,time);
 valsh1(z,time,'sim')        = sh1.l(z,time);
 valSROW(z,time,'sim')       = SROW.l(z,time);
 valTDH(z,time,'sim')        = TDH.l(z,time);
 valTIC(i,z,time,'sim')      = TIC.l(i,z,time);
 valTICT(z,time,'sim')       = TICT.l(z,time);
 valTIK(k,j,z,time,'sim')    = TIK.l(k,j,z,time);
 valTIKT(z,time,'sim')       = TIKT.l(z,time);
 valTIM(i,zj,z,time,'sim')   = TIM.l(i,zj,z,time);
 valTIMT(z,time,'sim')       = TIMT.l(z,time);
 valTIP(i,z,time,'sim')      = TIP.l(i,z,time);
 valTIPT(z,time,'sim')       = TIPT.l(z,time);
 valTIW(l,j,z,time,'sim')    = TIW.l(l,j,z,time);
 valTIWT(z,time,'sim')       = TIWT.l(z,time);
 valTIX(i,z,zj,time,'sim')   = TIX.l(i,z,zj,time);
 valTIXT(z,time,'sim')       = TIXT.l(z,time);
 valTPRCTS(z,time,'sim')     = TPRCTS.l(z,time);
 valTPRODN(z,time,'sim')     = TPRODN.l(z,time);
 valttdh0(z,time,'sim')      = ttdh0.l(z,time);
 valttdh1(z,time,'sim')      = ttdh1.l(z,time);
 valttic(i,z,time,'sim')     = ttic.l(i,z,time);
 valttik(k,j,z,time,'sim')   = ttik.l(k,j,z,time);
 valttim(i,zj,z,time,'sim')  = ttim.l(i,zj,z,time);
 valttip(j,z,time,'sim')     = ttip.l(j,z,time);
 valttiw(l,j,z,time,'sim')   = ttiw.l(l,j,z,time);
 valttix(i,z,zj,time,'sim')  = ttix.l(i,z,zj,time);
 valU(z,time,'sim')          = U.l(z,time);
 valVA(j,z,time,'sim')       = VA.l(j,z,time);
 valW(l,z,time,'sim')        = W.l(l,z,time);
 valWC(j,z,time,'sim')       = WC.l(j,z,time);
 valWealth(z,time,'sim')       = Wealth.l(z,time);
 valWTI(l,j,z,time,'sim')    = WTI.l(l,j,z,time);
 valXS(j,z,time,'sim')       = XS.l(j,z,time);
 valYDH(z,time,'sim')        = YDH.l(z,time);
 valYG(z,time,'sim')         = YG.l(z,time);
 valYH(z,time,'sim')         = YH.l(z,time);
 valYHK(z,time,'sim')        = YHK.l(z,time);
 valYHL(z,time,'sim')        = YHL.l(z,time);
 valYROW(z,time,'sim')       = YROW.l(z,time);
 NetIIP(z,time,'sim')        = valFasset(z,time,'sim') - valDebt(z,time,'sim');

