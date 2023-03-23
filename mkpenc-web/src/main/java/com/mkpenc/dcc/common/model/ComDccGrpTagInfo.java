package com.mkpenc.dcc.common.model;

import com.mkpenc.common.annotaion.Model;

@SuppressWarnings("serial")
@Model
public class ComDccGrpTagInfo {
	
		private int  iSeq;
		private int  BSCAL;
		private String  LOOPNAME;
		private String  UNIT;
		private double  LIMIT1;
		private double  LIMIT2;
		private String  TYPE;
		private String  IOTYPE;
		private String  ADDRESS;
		private int  IOBIT;
		private int  TBLNO;
		private int  FLDNO;
		private int  SaveCoreChk;
		private String  Descr;
		private String  DataLoop;
		private String  GrpHogi;
		private double  MinVal;
		private double  MaxVal;
		private String  Hogi;
		private String  XYGubun;
		private double  ELOW;
		private double  EHIGH;
		private double  VLOW;
		private double  VHIGH;
		private int  FASTIOCHK;		
		
		
		/**
		 * @return the iSeq
		 */
		public int getiSeq() {
			return iSeq;
		}
		/**
		 * @param iSeq the iSeq to set
		 */
		public void setiSeq(int iSeq) {
			this.iSeq = iSeq;
		}
		/**
		 * @return the bSCAL
		 */
		public int getBSCAL() {
			return BSCAL;
		}
		/**
		 * @param bSCAL the bSCAL to set
		 */
		public void setBSCAL(int bSCAL) {
			BSCAL = bSCAL;
		}
		/**
		 * @return the lOOPNAME
		 */
		public String getLOOPNAME() {
			return LOOPNAME;
		}
		/**
		 * @param lOOPNAME the lOOPNAME to set
		 */
		public void setLOOPNAME(String lOOPNAME) {
			LOOPNAME = lOOPNAME;
		}
		/**
		 * @return the uNIT
		 */
		public String getUNIT() {
			return UNIT;
		}
		/**
		 * @param uNIT the uNIT to set
		 */
		public void setUNIT(String uNIT) {
			UNIT = uNIT;
		}
		/**
		 * @return the lIMIT1
		 */
		public Double getLIMIT1() {
			return LIMIT1;
		}
		/**
		 * @param lIMIT1 the lIMIT1 to set
		 */
		public void setLIMIT1(Double lIMIT1) {
			LIMIT1 = lIMIT1;
		}
		/**
		 * @return the lIMIT2
		 */
		public Double getLIMIT2() {
			return LIMIT2;
		}
		/**
		 * @param lIMIT2 the lIMIT2 to set
		 */
		public void setLIMIT2(Double lIMIT2) {
			LIMIT2 = lIMIT2;
		}
		/**
		 * @return the tYPE
		 */
		public String getTYPE() {
			return TYPE;
		}
		/**
		 * @param tYPE the tYPE to set
		 */
		public void setTYPE(String tYPE) {
			TYPE = tYPE;
		}
		/**
		 * @return the iOTYPE
		 */
		public String getIOTYPE() {
			return IOTYPE;
		}
		/**
		 * @param iOTYPE the iOTYPE to set
		 */
		public void setIOTYPE(String iOTYPE) {
			IOTYPE = iOTYPE;
		}
		/**
		 * @return the aDDRESS
		 */
		public String getADDRESS() {
			return ADDRESS;
		}
		/**
		 * @param aDDRESS the aDDRESS to set
		 */
		public void setADDRESS(String aDDRESS) {
			ADDRESS = aDDRESS;
		}
		/**
		 * @return the iOBIT
		 */
		public int getIOBIT() {
			return IOBIT;
		}
		/**
		 * @param iOBIT the iOBIT to set
		 */
		public void setIOBIT(int iOBIT) {
			IOBIT = iOBIT;
		}
		/**
		 * @return the tBLNO
		 */
		public int getTBLNO() {
			return TBLNO;
		}
		/**
		 * @param tBLNO the tBLNO to set
		 */
		public void setTBLNO(int tBLNO) {
			TBLNO = tBLNO;
		}
		/**
		 * @return the fLDNO
		 */
		public int getFLDNO() {
			return FLDNO;
		}
		/**
		 * @param fLDNO the fLDNO to set
		 */
		public void setFLDNO(int fLDNO) {
			FLDNO = fLDNO;
		}
		/**
		 * @return the saveCoreChk
		 */
		public int getSaveCoreChk() {
			return SaveCoreChk;
		}
		/**
		 * @param saveCoreChk the saveCoreChk to set
		 */
		public void setSaveCoreChk(int saveCoreChk) {
			SaveCoreChk = saveCoreChk;
		}
		/**
		 * @return the descr
		 */
		public String getDescr() {
			return Descr;
		}
		/**
		 * @param descr the descr to set
		 */
		public void setDescr(String descr) {
			Descr = descr;
		}
		/**
		 * @return the dataLoop
		 */
		public String getDataLoop() {
			return DataLoop;
		}
		/**
		 * @param dataLoop the dataLoop to set
		 */
		public void setDataLoop(String dataLoop) {
			DataLoop = dataLoop;
		}
		/**
		 * @return the grpHogi
		 */
		public String getGrpHogi() {
			return GrpHogi;
		}
		/**
		 * @param grpHogi the grpHogi to set
		 */
		public void setGrpHogi(String grpHogi) {
			GrpHogi = grpHogi;
		}
		/**
		 * @return the minVal
		 */
		public double getMinVal() {
			return MinVal;
		}
		/**
		 * @param minVal the minVal to set
		 */
		public void setMinVal(double minVal) {
			MinVal = minVal;
		}
		/**
		 * @return the maxVal
		 */
		public double getMaxVal() {
			return MaxVal;
		}
		/**
		 * @param maxVal the maxVal to set
		 */
		public void setMaxVal(double maxVal) {
			MaxVal = maxVal;
		}
		/**
		 * @return the hogi
		 */
		public String getHogi() {
			return Hogi;
		}
		/**
		 * @param hogi the hogi to set
		 */
		public void setHogi(String hogi) {
			Hogi = hogi;
		}
		/**
		 * @return the xYGubun
		 */
		public String getXYGubun() {
			return XYGubun;
		}
		/**
		 * @param xYGubun the xYGubun to set
		 */
		public void setXYGubun(String xYGubun) {
			XYGubun = xYGubun;
		}
		/**
		 * @return the eLOW
		 */
		public double getELOW() {
			return ELOW;
		}
		/**
		 * @param eLOW the eLOW to set
		 */
		public void setELOW(double eLOW) {
			ELOW = eLOW;
		}
		/**
		 * @return the eHIGH
		 */
		public double getEHIGH() {
			return EHIGH;
		}
		/**
		 * @param eHIGH the eHIGH to set
		 */
		public void setEHIGH(double eHIGH) {
			EHIGH = eHIGH;
		}
		/**
		 * @return the vLOW
		 */
		public double getVLOW() {
			return VLOW;
		}
		/**
		 * @param vLOW the vLOW to set
		 */
		public void setVLOW(double vLOW) {
			VLOW = vLOW;
		}
		/**
		 * @return the vHIGH
		 */
		public double getVHIGH() {
			return VHIGH;
		}
		/**
		 * @param vHIGH the vHIGH to set
		 */
		public void setVHIGH(double vHIGH) {
			VHIGH = vHIGH;
		}
		/**
		 * @return the fASTIOCHK
		 */
		public int getFASTIOCHK() {
			return FASTIOCHK;
		}
		/**
		 * @param fASTIOCHK the fASTIOCHK to set
		 */
		public void setFASTIOCHK(int fASTIOCHK) {
			FASTIOCHK = fASTIOCHK;
		}
	
		
		

}
