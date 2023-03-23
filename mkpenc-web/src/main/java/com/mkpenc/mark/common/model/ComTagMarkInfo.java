package com.mkpenc.mark.common.model;

import com.mkpenc.common.annotaion.Model;

@SuppressWarnings("serial")
@Model
public class ComTagMarkInfo {
	
	 	private int iSeq;
	    private String Hogi;
	    private String UNIT_DIV;
	    private String Signal_Name;
	    private String Unit;
	    private String GAIN;
	    private String Offset;
	    private String IOTYPE;
	    private String Register;
	    private String IOBIT; 
	    private int TBLNO;
	    private int FLDNO;
	    private int BScale; 
	    private String Signal_Desc;
	    private String D0;
	    private String D1;
	    private int SaveCoreChk;
	    private double MinVal;
	    private double MaxVal;
	    private String Descr;
	    
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
		 * @return the uNIT_DIV
		 */
		public String getUNIT_DIV() {
			return UNIT_DIV;
		}
		/**
		 * @param uNIT_DIV the uNIT_DIV to set
		 */
		public void setUNIT_DIV(String uNIT_DIV) {
			UNIT_DIV = uNIT_DIV;
		}
		/**
		 * @return the signal_Name
		 */
		public String getSignal_Name() {
			return Signal_Name;
		}
		/**
		 * @param signal_Name the signal_Name to set
		 */
		public void setSignal_Name(String signal_Name) {
			Signal_Name = signal_Name;
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
		 * @return the gAIN
		 */
		public String getGAIN() {
			return GAIN;
		}
		/**
		 * @param gAIN the gAIN to set
		 */
		public void setGAIN(String gAIN) {
			GAIN = gAIN;
		}
		/**
		 * @return the offset
		 */
		public String getOffset() {
			return Offset;
		}
		/**
		 * @param offset the offset to set
		 */
		public void setOffset(String offset) {
			Offset = offset;
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
		 * @return the register
		 */
		public String getRegister() {
			return Register;
		}
		/**
		 * @param register the register to set
		 */
		public void setRegister(String register) {
			Register = register;
		}
		/**
		 * @return the iOBIT
		 */
		public String getIOBIT() {
			return IOBIT;
		}
		/**
		 * @param iOBIT the iOBIT to set
		 */
		public void setIOBIT(String iOBIT) {
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
		 * @return the signal_Desc
		 */
		public String getSignal_Desc() {
			return Signal_Desc;
		}
		/**
		 * @param signal_Desc the signal_Desc to set
		 */
		public void setSignal_Desc(String signal_Desc) {
			Signal_Desc = signal_Desc;
		}
		/**
		 * @return the d0
		 */
		public String getD0() {
			return D0;
		}
		/**
		 * @param d0 the d0 to set
		 */
		public void setD0(String d0) {
			D0 = d0;
		}
		/**
		 * @return the d1
		 */
		public String getD1() {
			return D1;
		}
		/**
		 * @param d1 the d1 to set
		 */
		public void setD1(String d1) {
			D1 = d1;
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
