package com.mkpenc.alt.common.model;

import com.mkpenc.common.annotaion.Model;

@SuppressWarnings("serial")
@Model
public class ComTagAltInfo {
	
	 	private int iSeq;            
	 	private String GrpHogi;         
	 	private String Hogi;            
	 	private String XYGubun;         
	 	private String LOOPNAME;              // '- 데이타의 Loopname 저장(액셀 출력용)
	 	private int  BScale;                 //'- 데이타의 Bscale 저장(액셀 출력용)
	 	private String IOTYPE;         
	 	private String ADDRESS;         
	 	private int IOBIT;          
	 	private String Unit;         
	 	private double MinVal;          
	 	private double MaxVal;          
	 	private String Descr;        
	 	private int TBLNO;          
	 	private int FLDNO;           
	 	private int FLDNO_FAST;      
	 	private String  AlarmType;              // '- 데이타의 Alarm Type 저장
	 	private int FASTIOCHK;       
	    
	 	private double DataLimit1;            // '- 데이타의 Limit1값 저장
	 	private double DataLimit2;            // '- 데이타의 Limit2값 저장
	 	private int DtabLimit1;      
	 	private int  DtabLimit2;      
	 	private int SaveCore;        
	    
	 	private double ELOW;            
	 	private double EHIGH;           
	 	private double VLOW ;           
	 	private double VHIGH ;          
	    
	 	private String DataLoop;
	 	
	 	private String spareMinFldNo;
	 	private String spareMaxFldNo;
	 	private String spareAvgFldNo;
	 	private String spareStdevFldNo;
	 	
	 	private String fixedMinFldNo;
	 	private String fixedMaxFldNo;
	 	private String fixedAvgFldNo;
	 	private String fixedStdevFldNo;
	 	
	 	private String gapAB;
	 	private String rateAB;
	 	
	 	private String toolTip;
	 	
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
		 * @return the bScale
		 */
		public int getBScale() {
			return BScale;
		}
		/**
		 * @param bScale the bScale to set
		 */
		public void setBScale(int bScale) {
			BScale = bScale;
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
		 * @return the unit
		 */
		public String getUnit() {
			return Unit;
		}
		/**
		 * @param unit the unit to set
		 */
		public void setUnit(String unit) {
			Unit = unit;
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
		 * @return the fLDNO_FAST
		 */
		public int getFLDNO_FAST() {
			return FLDNO_FAST;
		}
		/**
		 * @param fLDNO_FAST the fLDNO_FAST to set
		 */
		public void setFLDNO_FAST(int fLDNO_FAST) {
			FLDNO_FAST = fLDNO_FAST;
		}
		/**
		 * @return the alarmType
		 */
		public String getAlarmType() {
			return AlarmType;
		}
		/**
		 * @param alarmType the alarmType to set
		 */
		public void setAlarmType(String alarmType) {
			AlarmType = alarmType;
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
		/**
		 * @return the dataLimit1
		 */
		public double getDataLimit1() {
			return DataLimit1;
		}
		/**
		 * @param dataLimit1 the dataLimit1 to set
		 */
		public void setDataLimit1(double dataLimit1) {
			DataLimit1 = dataLimit1;
		}
		/**
		 * @return the dataLimit2
		 */
		public double getDataLimit2() {
			return DataLimit2;
		}
		/**
		 * @param dataLimit2 the dataLimit2 to set
		 */
		public void setDataLimit2(double dataLimit2) {
			DataLimit2 = dataLimit2;
		}
		/**
		 * @return the dtabLimit1
		 */
		public int getDtabLimit1() {
			return DtabLimit1;
		}
		/**
		 * @param dtabLimit1 the dtabLimit1 to set
		 */
		public void setDtabLimit1(int dtabLimit1) {
			DtabLimit1 = dtabLimit1;
		}
		/**
		 * @return the dtabLimit2
		 */
		public int getDtabLimit2() {
			return DtabLimit2;
		}
		/**
		 * @param dtabLimit2 the dtabLimit2 to set
		 */
		public void setDtabLimit2(int dtabLimit2) {
			DtabLimit2 = dtabLimit2;
		}
		/**
		 * @return the saveCore
		 */
		public int getSaveCore() {
			return SaveCore;
		}
		/**
		 * @param saveCore the saveCore to set
		 */
		public void setSaveCore(int saveCore) {
			SaveCore = saveCore;
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
		 * @return the spareMinFldNo
		 */
		public String getSpareMinFldNo() {
			return spareMinFldNo;
		}
		/**
		 * @param spareMinFldNo the spareMinFldNo to set
		 */
		public void setSpareMinFldNo(String spareMinFldNo) {
			this.spareMinFldNo = spareMinFldNo;
		}
		/**
		 * @return the spareMaxFldNo
		 */
		public String getSpareMaxFldNo() {
			return spareMaxFldNo;
		}
		/**
		 * @param spareMaxFldNo the spareMaxFldNo to set
		 */
		public void setSpareMaxFldNo(String spareMaxFldNo) {
			this.spareMaxFldNo = spareMaxFldNo;
		}
		/**
		 * @return the spareAvgFldNo
		 */
		public String getSpareAvgFldNo() {
			return spareAvgFldNo;
		}
		/**
		 * @param spareAvgFldNo the spareAvgFldNo to set
		 */
		public void setSpareAvgFldNo(String spareAvgFldNo) {
			this.spareAvgFldNo = spareAvgFldNo;
		}
		/**
		 * @return the spareStdevFldNo
		 */
		public String getSpareStdevFldNo() {
			return spareStdevFldNo;
		}
		/**
		 * @param spareStdevFldNo the spareStdevFldNo to set
		 */
		public void setSpareStdevFldNo(String spareStdevFldNo) {
			this.spareStdevFldNo = spareStdevFldNo;
		}
		/**
		 * @return the fixedMinFldNo
		 */
		public String getFixedMinFldNo() {
			return fixedMinFldNo;
		}
		/**
		 * @param fixedMinFldNo the fixedMinFldNo to set
		 */
		public void setFixedMinFldNo(String fixedMinFldNo) {
			this.fixedMinFldNo = fixedMinFldNo;
		}
		/**
		 * @return the fixedMaxFldNo
		 */
		public String getFixedMaxFldNo() {
			return fixedMaxFldNo;
		}
		/**
		 * @param fixedMaxFldNo the fixedMaxFldNo to set
		 */
		public void setFixedMaxFldNo(String fixedMaxFldNo) {
			this.fixedMaxFldNo = fixedMaxFldNo;
		}
		/**
		 * @return the fixedAvgFldNo
		 */
		public String getFixedAvgFldNo() {
			return fixedAvgFldNo;
		}
		/**
		 * @param fixedAvgFldNo the fixedAvgFldNo to set
		 */
		public void setFixedAvgFldNo(String fixedAvgFldNo) {
			this.fixedAvgFldNo = fixedAvgFldNo;
		}
		/**
		 * @return the fixedStdevFldNo
		 */
		public String getFixedStdevFldNo() {
			return fixedStdevFldNo;
		}
		/**
		 * @param fixedStdevFldNo the fixedStdevFldNo to set
		 */
		public void setFixedStdevFldNo(String fixedStdevFldNo) {
			this.fixedStdevFldNo = fixedStdevFldNo;
		}
		/**
		 * @return the gapAB
		 */
		public String getGapAB() {
			return gapAB;
		}
		/**
		 * @param gapAB the gapAB to set
		 */
		public void setGapAB(String gapAB) {
			this.gapAB = gapAB;
		}
		/**
		 * @return the rateAB
		 */
		public String getRateAB() {
			return rateAB;
		}
		/**
		 * @param rateAB the rateAB to set
		 */
		public void setRateAB(String rateAB) {
			this.rateAB = rateAB;
		}
		/**
		 * @return the toolTip
		 */
		public String getToolTip() {
			return toolTip;
		}
		/**
		 * @param toolTip the toolTip to set
		 */
		public void setToolTip(String toolTip) {
			this.toolTip = toolTip;
		}
		
	
}
