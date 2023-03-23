package com.mkpenc.dcc.tip.model;

import com.mkpenc.common.annotaion.Model;
import com.mkpenc.common.base.BaseSearch;

@SuppressWarnings("serial")
@Model
public class DccSearchTip  extends BaseSearch {
	private String hogiHeader;
	private String xyHeader;
	
	private String searchKey_1;
	private String searchKey_2;
	private String searchKey_3;
	private String searchWord_1;
	private String searchWord_2;
	private String searchWord_3;
	
	private String addressType;
	private String address2;

	/* iolist */
	private String iHogi;
	private String iSeq;
	private String ioType;
	private String address;
	private String ioBit;
	private String xyGubun;
	private String loopName;
	private String tblNo;
	private String fldNo;
	private String filePosition;
	private String fastIoChk;
	private String feedback;
	private String rev;
	private String descr;
	private String purpose;
	private String vLow;
	private String vHigh;
	private String eLow;
	private String eHigh;
	private String unit;
	private String conv;
	private String rtd;
	private String request;
	private String type;
	private String ioGroup;
	private String window;
	private String priority;
	private String tr;
	private String cr;
	private String limit1;
	private String limit2;
	private String j;
	private String n;
	private String message;
	private String equ;
	private String bscal;
	private String wiba;
	private String wb;
	private String aa;
	private String ioIndex;
	private String program;
	private String revision;
	private String device;
	private String ctrlName;
	private String interlock;
	private String alarmCond;
	private String indicate;
	private String com1;
	private String com2;
	private String drawing;
	private String condition;
	private String ioDate;
	private String measureNo;
	private String operationVar;
	private String drawingPos;
	private String rightVal;
	private String normalVal;
	private String reqNo;
	private String reqName;
	private String reqDate;
	private String reqDept;
	private String reqBigo;
	private String zText1;
	private String zText2;
	private String zText3;

	/**
	 * @return the hogiHeader
	 */
	public String getHogiHeader() {
		return hogiHeader;
	}

	/**
	 * @param hogiHeader the hogiHeader to set
	 */
	public void setHogiHeader(String hogiHeader) {
		this.hogiHeader = hogiHeader;
	}

	/**
	 * @return the xyHeader
	 */
	public String getXyHeader() {
		return xyHeader;
	}

	/**
	 * @param xyHeader the xyHeader to set
	 */
	public void setXyHeader(String xyHeader) {
		this.xyHeader = xyHeader;
	}

	/**
	 * @return the iHogi
	 */
	public String getiHogi() {
		return iHogi;
	}

	/**
	 * @param iHogi the iHogi to set
	 */
	public void setiHogi(String iHogi) {
		this.iHogi = iHogi;
	}

	/**
	 * @return the xyGubun
	 */
	public String getXyGubun() {
		return xyGubun;
	}

	/**
	 * @param xyGubun the xyGubun to set
	 */
	public void setXyGubun(String xyGubun) {
		this.xyGubun = xyGubun;
	}

	/**
	 * @return the iSeq
	 */
	public String getiSeq() {
		return iSeq;
	}

	/**
	 * @param iSeq the iSeq to set
	 */
	public void setiSeq(String iSeq) {
		this.iSeq = iSeq;
	}

	/**
	 * @return the ioType
	 */
	public String getIoType() {
		return ioType;
	}

	/**
	 * @param ioType the ioType to set
	 */
	public void setIoType(String ioType) {
		this.ioType = ioType;
	}

	/**
	 * @return the address
	 */
	public String getAddress() {
		return address;
	}

	/**
	 * @param address the address to set
	 */
	public void setAddress(String address) {
		this.address = address;
	}

	/**
	 * @return the ioBit
	 */
	public String getIoBit() {
		return ioBit;
	}

	/**
	 * @param ioBit the ioBit to set
	 */
	public void setIoBit(String ioBit) {
		this.ioBit = ioBit;
	}

	/**
	 * @return the loopName
	 */
	public String getLoopName() {
		return loopName;
	}

	/**
	 * @param loopName the loopName to set
	 */
	public void setLoopName(String loopName) {
		this.loopName = loopName;
	}

	/**
	 * @return the tblNo
	 */
	public String getTblNo() {
		return tblNo;
	}

	/**
	 * @param tblNo the tblNo to set
	 */
	public void setTblNo(String tblNo) {
		this.tblNo = tblNo;
	}

	/**
	 * @return the fldNo
	 */
	public String getFldNo() {
		return fldNo;
	}

	/**
	 * @param fldNo the fldNo to set
	 */
	public void setFldNo(String fldNo) {
		this.fldNo = fldNo;
	}

	/**
	 * @return the filePosition
	 */
	public String getFilePosition() {
		return filePosition;
	}

	/**
	 * @param filePosition the filePosition to set
	 */
	public void setFilePosition(String filePosition) {
		this.filePosition = filePosition;
	}

	/**
	 * @return the fastIoChk
	 */
	public String getFastIoChk() {
		return fastIoChk;
	}

	/**
	 * @param fastIoChk the fastIoChk to set
	 */
	public void setFastIoChk(String fastIoChk) {
		this.fastIoChk = fastIoChk;
	}

	/**
	 * @return the feedback
	 */
	public String getFeedback() {
		return feedback;
	}

	/**
	 * @param feedback the feedback to set
	 */
	public void setFeedback(String feedback) {
		this.feedback = feedback;
	}

	/**
	 * @return the rev
	 */
	public String getRev() {
		return rev;
	}

	/**
	 * @param rev the rev to set
	 */
	public void setRev(String rev) {
		this.rev = rev;
	}

	/**
	 * @return the descr
	 */
	public String getDescr() {
		return descr;
	}

	/**
	 * @param descr the descr to set
	 */
	public void setDescr(String descr) {
		this.descr = descr;
	}

	/**
	 * @return the purpose
	 */
	public String getPurpose() {
		return purpose;
	}

	/**
	 * @param purpose the purpose to set
	 */
	public void setPurpose(String purpose) {
		this.purpose = purpose;
	}

	/**
	 * @return the vLow
	 */
	public String getvLow() {
		return vLow;
	}

	/**
	 * @param vLow the vLow to set
	 */
	public void setvLow(String vLow) {
		this.vLow = vLow;
	}

	/**
	 * @return the vHigh
	 */
	public String getvHigh() {
		return vHigh;
	}

	/**
	 * @param vHigh the vHigh to set
	 */
	public void setvHigh(String vHigh) {
		this.vHigh = vHigh;
	}

	/**
	 * @return the eLow
	 */
	public String geteLow() {
		return eLow;
	}

	/**
	 * @param eLow the eLow to set
	 */
	public void seteLow(String eLow) {
		this.eLow = eLow;
	}

	/**
	 * @return the eHigh
	 */
	public String geteHigh() {
		return eHigh;
	}

	/**
	 * @param eHigh the eHigh to set
	 */
	public void seteHigh(String eHigh) {
		this.eHigh = eHigh;
	}

	/**
	 * @return the unit
	 */
	public String getUnit() {
		return unit;
	}

	/**
	 * @param unit the unit to set
	 */
	public void setUnit(String unit) {
		this.unit = unit;
	}

	/**
	 * @return the conv
	 */
	public String getConv() {
		return conv;
	}

	/**
	 * @param conv the conv to set
	 */
	public void setConv(String conv) {
		this.conv = conv;
	}

	/**
	 * @return the rtd
	 */
	public String getRtd() {
		return rtd;
	}

	/**
	 * @param rtd the rtd to set
	 */
	public void setRtd(String rtd) {
		this.rtd = rtd;
	}

	/**
	 * @return the request
	 */
	public String getRequest() {
		return request;
	}

	/**
	 * @param request the request to set
	 */
	public void setRequest(String request) {
		this.request = request;
	}

	/**
	 * @return the type
	 */
	public String getType() {
		return type;
	}

	/**
	 * @param type the type to set
	 */
	public void setType(String type) {
		this.type = type;
	}

	/**
	 * @return the ioGroup
	 */
	public String getIoGroup() {
		return ioGroup;
	}

	/**
	 * @param ioGroup the ioGroup to set
	 */
	public void setIoGroup(String ioGroup) {
		this.ioGroup = ioGroup;
	}

	/**
	 * @return the window
	 */
	public String getWindow() {
		return window;
	}

	/**
	 * @param window the window to set
	 */
	public void setWindow(String window) {
		this.window = window;
	}

	/**
	 * @return the priority
	 */
	public String getPriority() {
		return priority;
	}

	/**
	 * @param priority the priority to set
	 */
	public void setPriority(String priority) {
		this.priority = priority;
	}

	/**
	 * @return the tr
	 */
	public String getTr() {
		return tr;
	}

	/**
	 * @param tr the tr to set
	 */
	public void setTr(String tr) {
		this.tr = tr;
	}

	/**
	 * @return the cr
	 */
	public String getCr() {
		return cr;
	}

	/**
	 * @param cr the cr to set
	 */
	public void setCr(String cr) {
		this.cr = cr;
	}

	/**
	 * @return the limit1
	 */
	public String getLimit1() {
		return limit1;
	}

	/**
	 * @param limit1 the limit1 to set
	 */
	public void setLimit1(String limit1) {
		this.limit1 = limit1;
	}

	/**
	 * @return the limit2
	 */
	public String getLimit2() {
		return limit2;
	}

	/**
	 * @param limit2 the limit2 to set
	 */
	public void setLimit2(String limit2) {
		this.limit2 = limit2;
	}

	/**
	 * @return the j
	 */
	public String getJ() {
		return j;
	}

	/**
	 * @param j the j to set
	 */
	public void setJ(String j) {
		this.j = j;
	}

	/**
	 * @return the n
	 */
	public String getN() {
		return n;
	}

	/**
	 * @param n the n to set
	 */
	public void setN(String n) {
		this.n = n;
	}

	/**
	 * @return the message
	 */
	public String getMessage() {
		return message;
	}

	/**
	 * @param message the message to set
	 */
	public void setMessage(String message) {
		this.message = message;
	}

	/**
	 * @return the equ
	 */
	public String getEqu() {
		return equ;
	}

	/**
	 * @param equ the equ to set
	 */
	public void setEqu(String equ) {
		this.equ = equ;
	}

	/**
	 * @return the bscal
	 */
	public String getBscal() {
		return bscal;
	}

	/**
	 * @param bscal the bscal to set
	 */
	public void setBscal(String bscal) {
		this.bscal = bscal;
	}

	/**
	 * @return the wiba
	 */
	public String getWiba() {
		return wiba;
	}

	/**
	 * @param wiba the wiba to set
	 */
	public void setWiba(String wiba) {
		this.wiba = wiba;
	}

	/**
	 * @return the wb
	 */
	public String getWb() {
		return wb;
	}

	/**
	 * @param wb the wb to set
	 */
	public void setWb(String wb) {
		this.wb = wb;
	}

	/**
	 * @return the aa
	 */
	public String getAa() {
		return aa;
	}

	/**
	 * @param aa the aa to set
	 */
	public void setAa(String aa) {
		this.aa = aa;
	}

	/**
	 * @return the ioIndex
	 */
	public String getIoIndex() {
		return ioIndex;
	}

	/**
	 * @param ioIndex the ioIndex to set
	 */
	public void setIoIndex(String ioIndex) {
		this.ioIndex = ioIndex;
	}

	/**
	 * @return the program
	 */
	public String getProgram() {
		return program;
	}

	/**
	 * @param program the program to set
	 */
	public void setProgram(String program) {
		this.program = program;
	}

	/**
	 * @return the revision
	 */
	public String getRevision() {
		return revision;
	}

	/**
	 * @param revision the revision to set
	 */
	public void setRevision(String revision) {
		this.revision = revision;
	}

	/**
	 * @return the device
	 */
	public String getDevice() {
		return device;
	}

	/**
	 * @param device the device to set
	 */
	public void setDevice(String device) {
		this.device = device;
	}

	/**
	 * @return the ctrlName
	 */
	public String getCtrlName() {
		return ctrlName;
	}

	/**
	 * @param ctrlName the ctrlName to set
	 */
	public void setCtrlName(String ctrlName) {
		this.ctrlName = ctrlName;
	}

	/**
	 * @return the interlock
	 */
	public String getInterlock() {
		return interlock;
	}

	/**
	 * @param interlock the interlock to set
	 */
	public void setInterlock(String interlock) {
		this.interlock = interlock;
	}

	/**
	 * @return the alarmCond
	 */
	public String getAlarmCond() {
		return alarmCond;
	}

	/**
	 * @param alarmCond the alarmCond to set
	 */
	public void setAlarmCond(String alarmCond) {
		this.alarmCond = alarmCond;
	}

	/**
	 * @return the indicate
	 */
	public String getIndicate() {
		return indicate;
	}

	/**
	 * @param indicate the indicate to set
	 */
	public void setIndicate(String indicate) {
		this.indicate = indicate;
	}

	/**
	 * @return the com1
	 */
	public String getCom1() {
		return com1;
	}

	/**
	 * @param com1 the com1 to set
	 */
	public void setCom1(String com1) {
		this.com1 = com1;
	}

	/**
	 * @return the com2
	 */
	public String getCom2() {
		return com2;
	}

	/**
	 * @param com2 the com2 to set
	 */
	public void setCom2(String com2) {
		this.com2 = com2;
	}

	/**
	 * @return the drawing
	 */
	public String getDrawing() {
		return drawing;
	}

	/**
	 * @param drawing the drawing to set
	 */
	public void setDrawing(String drawing) {
		this.drawing = drawing;
	}

	/**
	 * @return the condition
	 */
	public String getCondition() {
		return condition;
	}

	/**
	 * @param condition the condition to set
	 */
	public void setCondition(String condition) {
		this.condition = condition;
	}

	/**
	 * @return the ioDate
	 */
	public String getIoDate() {
		return ioDate;
	}

	/**
	 * @param ioDate the ioDate to set
	 */
	public void setIoDate(String ioDate) {
		this.ioDate = ioDate;
	}

	/**
	 * @return the measureNo
	 */
	public String getMeasureNo() {
		return measureNo;
	}

	/**
	 * @param measureNo the measureNo to set
	 */
	public void setMeasureNo(String measureNo) {
		this.measureNo = measureNo;
	}

	/**
	 * @return the operationVar
	 */
	public String getOperationVar() {
		return operationVar;
	}

	/**
	 * @param operationVar the operationVar to set
	 */
	public void setOperationVar(String operationVar) {
		this.operationVar = operationVar;
	}

	/**
	 * @return the drawingPos
	 */
	public String getDrawingPos() {
		return drawingPos;
	}

	/**
	 * @param drawingPos the drawingPos to set
	 */
	public void setDrawingPos(String drawingPos) {
		this.drawingPos = drawingPos;
	}

	/**
	 * @return the rightVal
	 */
	public String getRightVal() {
		return rightVal;
	}

	/**
	 * @param rightVal the rightVal to set
	 */
	public void setRightVal(String rightVal) {
		this.rightVal = rightVal;
	}

	/**
	 * @return the normalVal
	 */
	public String getNormalVal() {
		return normalVal;
	}

	/**
	 * @param normalVal the normalVal to set
	 */
	public void setNormalVal(String normalVal) {
		this.normalVal = normalVal;
	}

	/**
	 * @return the reqNo
	 */
	public String getReqNo() {
		return reqNo;
	}

	/**
	 * @param reqNo the reqNo to set
	 */
	public void setReqNo(String reqNo) {
		this.reqNo = reqNo;
	}

	/**
	 * @return the reqName
	 */
	public String getReqName() {
		return reqName;
	}

	/**
	 * @param reqName the reqName to set
	 */
	public void setReqName(String reqName) {
		this.reqName = reqName;
	}

	/**
	 * @return the reqDate
	 */
	public String getReqDate() {
		return reqDate;
	}

	/**
	 * @param reqDate the reqDate to set
	 */
	public void setReqDate(String reqDate) {
		this.reqDate = reqDate;
	}

	/**
	 * @return the reqDept
	 */
	public String getReqDept() {
		return reqDept;
	}

	/**
	 * @param reqDept the reqDept to set
	 */
	public void setReqDept(String reqDept) {
		this.reqDept = reqDept;
	}

	/**
	 * @return the reqBigo
	 */
	public String getReqBigo() {
		return reqBigo;
	}

	/**
	 * @param reqBigo the reqBigo to set
	 */
	public void setReqBigo(String reqBigo) {
		this.reqBigo = reqBigo;
	}

	/**
	 * @return the zText1
	 */
	public String getzText1() {
		return zText1;
	}

	/**
	 * @param zText1 the zText1 to set
	 */
	public void setzText1(String zText1) {
		this.zText1 = zText1;
	}

	/**
	 * @return the zText2
	 */
	public String getzText2() {
		return zText2;
	}

	/**
	 * @param zText2 the zText2 to set
	 */
	public void setzText2(String zText2) {
		this.zText2 = zText2;
	}

	/**
	 * @return the zText3
	 */
	public String getzText3() {
		return zText3;
	}

	/**
	 * @param zText3 the zText3 to set
	 */
	public void setzText3(String zText3) {
		this.zText3 = zText3;
	}

	/**
	 * @return the searchKey_1
	 */
	public String getSearchKey_1() {
		return searchKey_1;
	}

	/**
	 * @param searchKey_1 the searchKey_1 to set
	 */
	public void setSearchKey_1(String searchKey_1) {
		this.searchKey_1 = searchKey_1;
	}

	/**
	 * @return the searchKey_2
	 */
	public String getSearchKey_2() {
		return searchKey_2;
	}

	/**
	 * @param searchKey_2 the searchKey_2 to set
	 */
	public void setSearchKey_2(String searchKey_2) {
		this.searchKey_2 = searchKey_2;
	}

	/**
	 * @return the searchKey_3
	 */
	public String getSearchKey_3() {
		return searchKey_3;
	}

	/**
	 * @param searchKey_3 the searchKey_3 to set
	 */
	public void setSearchKey_3(String searchKey_3) {
		this.searchKey_3 = searchKey_3;
	}

	/**
	 * @return the searchWord_1
	 */
	public String getSearchWord_1() {
		return searchWord_1;
	}

	/**
	 * @param searchWord_1 the searchWord_1 to set
	 */
	public void setSearchWord_1(String searchWord_1) {
		this.searchWord_1 = searchWord_1;
	}

	/**
	 * @return the searchWord_2
	 */
	public String getSearchWord_2() {
		return searchWord_2;
	}

	/**
	 * @param searchWord_2 the searchWord_2 to set
	 */
	public void setSearchWord_2(String searchWord_2) {
		this.searchWord_2 = searchWord_2;
	}

	/**
	 * @return the searchWord_3
	 */
	public String getSearchWord_3() {
		return searchWord_3;
	}

	/**
	 * @param searchWord_3 the searchWord_3 to set
	 */
	public void setSearchWord_3(String searchWord_3) {
		this.searchWord_3 = searchWord_3;
	}

	/**
	 * @return the addressType
	 */
	public String getAddressType() {
		return addressType;
	}

	/**
	 * @param addressType the addressType to set
	 */
	public void setAddressType(String addressType) {
		this.addressType = addressType;
	}

	/**
	 * @return the address2
	 */
	public String getAddress2() {
		return address2;
	}

	/**
	 * @param address2 the address2 to set
	 */
	public void setAddress2(String address2) {
		this.address2 = address2;
	}
	
}
