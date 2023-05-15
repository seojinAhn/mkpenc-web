package com.mkpenc.common.module;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.mkpenc.common.model.Upload;
import com.mkpenc.dcc.admin.model.EquipInfo;
import com.mkpenc.dcc.admin.model.IOListInfo;
import com.mkpenc.dcc.admin.model.SwSmInfo;
import com.mkpenc.dcc.alarm.model.DccAlarmInfo;
import com.mkpenc.dcc.common.model.ComTagDccInfo;
import com.mkpenc.dcc.status.model.DccTagInfo;
import com.mkpenc.dcc.tip.model.DccIolistInfo;

@Service
public class ExcelHelperUtil {
	
	private static Logger logger = LoggerFactory.getLogger(ExcelHelperUtil.class);
	
	public void swsmExcelDownload(HttpServletRequest request, HttpServletResponse response, List<SwSmInfo> swSmInfoList) throws Exception{
		
		Workbook wb = new XSSFWorkbook();
        Sheet sheet = wb.createSheet("S/W 형상관리");
        Row row = null;
        Cell cell = null;
        int rowNum = 0;
        
        // Header
        row = sheet.createRow(rowNum++);
        cell = row.createCell(0);
        cell.setCellValue("SEQ번호");
        cell = row.createCell(1);
        cell.setCellValue("Log번호");
        cell = row.createCell(2);
        cell.setCellValue("변경서 고유번호");
        cell = row.createCell(3);
        cell.setCellValue("프로그램명");
        cell = row.createCell(4);
        cell.setCellValue("분류");
        cell = row.createCell(5);
        cell.setCellValue("내용");
        cell = row.createCell(6);
        cell.setCellValue("일자");
        cell = row.createCell(7);
        cell.setCellValue("호기");
        cell = row.createCell(8);
        cell.setCellValue("비고");

        
        cell = row.createCell(9);
        cell.setCellValue("첨부파일 1");
        cell = row.createCell(10);
        cell.setCellValue("첨부파일 2");
        cell = row.createCell(11);
        cell.setCellValue("첨부파일 3");
        cell = row.createCell(12);
        cell.setCellValue("첨부파일 4");
        cell = row.createCell(13);
        cell.setCellValue("첨부파일 5");
        cell = row.createCell(14);
        cell.setCellValue("첨부파일 6");
        cell = row.createCell(15);
        cell.setCellValue("첨부파일 7");
        cell = row.createCell(16);
        cell.setCellValue("첨부파일 8");
        cell = row.createCell(17);
        cell.setCellValue("첨부파일 9");
        cell = row.createCell(18);
        cell.setCellValue("첨부파일 18");
            
        // Body
        for (SwSmInfo swSmInfo:swSmInfoList) {
        	
            row = sheet.createRow(rowNum++);
            cell = row.createCell(0);
            cell.setCellValue(swSmInfo.getSeqNo());
            cell = row.createCell(1);
            cell.setCellValue(swSmInfo.getLogNo());
            cell = row.createCell(2);
            cell.setCellValue(swSmInfo.getProNo());
            cell = row.createCell(3);
            cell.setCellValue(swSmInfo.getProgName());
            cell = row.createCell(4);
            cell.setCellValue(swSmInfo.getDivide());
            cell = row.createCell(5);
            cell.setCellValue(swSmInfo.getDescr());
            cell = row.createCell(6);
            cell.setCellValue(swSmInfo.getCreateDate());
            cell = row.createCell(7);
            cell.setCellValue(swSmInfo.getHogi());
            cell = row.createCell(8);
            cell.setCellValue(swSmInfo.getBigo());
            
            cell = row.createCell(9);
            cell.setCellValue(swSmInfo.getFileName1());
            cell = row.createCell(10);
            cell.setCellValue(swSmInfo.getFileName2());
            cell = row.createCell(11);
            cell.setCellValue(swSmInfo.getFileName3());
            cell = row.createCell(12);
            cell.setCellValue(swSmInfo.getFileName4());
            cell = row.createCell(13);
            cell.setCellValue(swSmInfo.getFileName5());
            cell = row.createCell(14);
            cell.setCellValue(swSmInfo.getFileName6());
            cell = row.createCell(15);
            cell.setCellValue(swSmInfo.getFileName7());
            cell = row.createCell(16);
            cell.setCellValue(swSmInfo.getFileName8());
            cell = row.createCell(17);
            cell.setCellValue(swSmInfo.getFileName9());
            cell = row.createCell(18);
            cell.setCellValue(swSmInfo.getFileName10());
        }
        
        String browser = WebUtil.getBrowser(request);
		String encodedFilename = WebUtil.webEncoding(browser, "SW_형상.xlsx");
        
        response.setContentType("application/vnd.ms-excel");
        response.setHeader("Content-Disposition", "attachment;filename=" + encodedFilename);

        //Excel File Output
        ServletOutputStream output = response.getOutputStream();
        output.flush();
        wb.write(output);
        output.flush();
        output.close();
        wb.close();		

	}
	
	public List<SwSmInfo> swsmExcelImport(MultipartFile file, Upload upload) throws Exception {
		
		Workbook workbook = null;
		
		List<SwSmInfo>swsmInfoList = new ArrayList<SwSmInfo>();
		
	    if (upload.getFileExtension().equals("xlsx")) {
	      workbook = new XSSFWorkbook(file.getInputStream());
	    } else if (upload.getFileExtension().equals("xls")) {
	      workbook = new HSSFWorkbook(file.getInputStream());
	    }

	    Sheet worksheet = workbook.getSheetAt(0);

	    for (int i = 1; i < worksheet.getPhysicalNumberOfRows(); i++) { // 4

				  Row row = worksheet.getRow(i);
				
				  SwSmInfo swsmInfo = new SwSmInfo();
			
				  swsmInfo.setLogNo(cellNullCheck(row.getCell(0)));
				  swsmInfo.setProNo(cellNullCheck(row.getCell(1)));
				  swsmInfo.setProgName(cellNullCheck(row.getCell(2)));
				  swsmInfo.setDivide(cellNullCheck(row.getCell(3)));
				  swsmInfo.setDescr(cellNullCheck(row.getCell(4)));
				  swsmInfo.setCreateDate(cellNullCheck(row.getCell(5)));
				  swsmInfo.setHogi(cellNullCheck(row.getCell(6)));
				  swsmInfo.setBigo(cellNullCheck(row.getCell(7)));
				  swsmInfo.setFileName1(cellNullCheck(row.getCell(8)));
				  swsmInfo.setFileName2(cellNullCheck(row.getCell(0)));
				  swsmInfo.setFileName3(cellNullCheck(row.getCell(10)));
				  swsmInfo.setFileName4(cellNullCheck(row.getCell(11)));
				  swsmInfo.setFileName5(cellNullCheck(row.getCell(12)));
				  swsmInfo.setFileName6(cellNullCheck(row.getCell(13)));
				  swsmInfo.setFileName7(cellNullCheck(row.getCell(14)));
				  swsmInfo.setFileName8(cellNullCheck(row.getCell(15)));
				  swsmInfo.setFileName9(cellNullCheck(row.getCell(16)));
				  swsmInfo.setFileName10(cellNullCheck(row.getCell(17)));
				
				  swsmInfoList.add(swsmInfo);
	    }
	    return swsmInfoList;
	}
	
	public void equipExcelDownload(HttpServletRequest request, HttpServletResponse response, List<EquipInfo> equipInfoList) throws Exception{
		
		Workbook wb = new XSSFWorkbook();
        Sheet sheet = wb.createSheet("첫번째 시트");
        Row row = null;
        Cell cell = null;
        int rowNum = 0;
        
     // Header
        row = sheet.createRow(rowNum);
        cell = row.createCell(0);
        cell.setCellValue("관리번호");
        cell = row.createCell(1);
        cell = row.createCell(2);
        cell = row.createCell(3);
        cell = row.createCell(4);
        cell = row.createCell(5);

        sheet.addMergedRegion(new CellRangeAddress(rowNum, rowNum, 0, 5));
        
        
        cell = row.createCell(6);
        cell.setCellValue("사양");
        cell = row.createCell(7);
        cell = row.createCell(8);
        cell = row.createCell(9);
        cell = row.createCell(10);
        cell = row.createCell(11);
        cell = row.createCell(12);
        cell = row.createCell(13);
        cell = row.createCell(14);
        cell = row.createCell(15);
        cell = row.createCell(16);
        cell = row.createCell(17);
        cell = row.createCell(18);
        cell = row.createCell(19);
        cell = row.createCell(20);
        cell = row.createCell(21);
        cell = row.createCell(22);
        cell = row.createCell(23);
        cell = row.createCell(24);
        cell = row.createCell(25);
        cell = row.createCell(26);
        cell = row.createCell(27);
        cell = row.createCell(28);
        cell = row.createCell(29);
        cell = row.createCell(30);
        cell = row.createCell(31);
        cell = row.createCell(32);                
        cell = row.createCell(33);
        
        sheet.addMergedRegion(new CellRangeAddress(rowNum, rowNum, 6, 33));
        

        cell = row.createCell(34);
        cell.setCellValue("정비이력");
        cell = row.createCell(35);
        cell = row.createCell(36);
        cell = row.createCell(37);
        cell = row.createCell(38);
        cell = row.createCell(39);
        cell = row.createCell(40);
        cell = row.createCell(41);
        cell = row.createCell(42);
        cell = row.createCell(43);
        cell = row.createCell(44);        
        cell = row.createCell(45);
        
        sheet.addMergedRegion(new CellRangeAddress(rowNum, rowNum, 34, 45));

        cell = row.createCell(46);
        cell.setCellValue("특이사항");
        cell = row.createCell(47);
        cell = row.createCell(48);
        cell = row.createCell(49);
        cell = row.createCell(50);
        cell = row.createCell(51);
        cell = row.createCell(52);
        cell = row.createCell(53);
        cell = row.createCell(54);
        cell = row.createCell(55);
        cell = row.createCell(56);
        cell = row.createCell(57);
        
        sheet.addMergedRegion(new CellRangeAddress(rowNum, rowNum, 46, 57));
        
        rowNum++;        
        
        row = sheet.createRow(rowNum);
        
        cell = row.createCell(0);
        cell.setCellValue("관리번호");
        cell = row.createCell(1);
        cell.setCellValue("담당자");
        cell = row.createCell(2);
        cell.setCellValue("호기");
        cell = row.createCell(3);
        cell.setCellValue("설치장소");
        cell = row.createCell(4);
        cell.setCellValue("품명");
        cell = row.createCell(5);
        cell.setCellValue("태그번호");        

        cell = row.createCell(6);
        cell.setCellValue("제작사");
        cell = row.createCell(7);
        cell.setCellValue("계통명");
        cell = row.createCell(8);
        cell.setCellValue("Part No.");
        cell = row.createCell(9);
        cell.setCellValue("Serial No.");
        cell = row.createCell(10);
        cell.setCellValue("자재번호");
        cell = row.createCell(11);
        cell.setCellValue("설치위치");
        cell = row.createCell(12);
        cell.setCellValue("제작연도");
        cell = row.createCell(13);
        cell.setCellValue("REV . NO");
        cell = row.createCell(14);
        cell.setCellValue("취약부품");
        cell = row.createCell(15);
        cell.setCellValue("설치일자");
        cell = row.createCell(16);
        cell.setCellValue("FID");
        cell = row.createCell(17);
        cell.setCellValue("SPV");        
        cell = row.createCell(18);
        cell.setCellValue("품질등급");
        cell = row.createCell(19);
        cell.setCellValue("저장등급");
        cell = row.createCell(20);
        cell.setCellValue("저장수명");
        cell = row.createCell(21);
        cell.setCellValue("공급자");
        cell = row.createCell(22);
        cell.setCellValue("PO");
        cell = row.createCell(23);
        cell.setCellValue("최종입고일자");
        cell = row.createCell(24);
        cell.setCellValue("최종입고수량");
        cell = row.createCell(25);
        cell.setCellValue("현상태");        
        cell = row.createCell(26);
        cell.setCellValue("취약부품명");
        cell = row.createCell(27);
        cell.setCellValue("부품자재번호");
        cell = row.createCell(28);
        cell.setCellValue("부품교체일자");
        cell = row.createCell(29);
        cell.setCellValue("부품교체주기");
        cell = row.createCell(30);
        cell.setCellValue("ICT주기");
        cell = row.createCell(31);
        cell.setCellValue("교체주기");
        cell = row.createCell(32);
        cell.setCellValue("점검방법");
        cell = row.createCell(33);
        cell.setCellValue("점검주기");
        
        cell = row.createCell(34);
        cell.setCellValue("년월일 1");
        cell = row.createCell(35);
        cell.setCellValue("정비내용 1");
        cell = row.createCell(36);
        cell.setCellValue("비고 1");
        cell = row.createCell(37);
        cell.setCellValue("년월일 2");
        cell = row.createCell(38);
        cell.setCellValue("정비내용 2");
        cell = row.createCell(39);
        cell.setCellValue("비고 2");
        cell = row.createCell(40);
        cell.setCellValue("년월일 3");
        cell = row.createCell(41);
        cell.setCellValue("정비내용 3");
        cell = row.createCell(42);
        cell.setCellValue("비고 3");
        cell = row.createCell(43);
        cell.setCellValue("년월일 4");
        cell = row.createCell(44);
        cell.setCellValue("정비내용 4");
        cell = row.createCell(45);
        cell.setCellValue("비고 4");
        
        cell = row.createCell(46);
        cell.setCellValue("년월일 1");
        cell = row.createCell(47);
        cell.setCellValue("변동사항 1");
        cell = row.createCell(48);
        cell.setCellValue("비고 1");
        cell = row.createCell(49);
        cell.setCellValue("년월일 2");
        cell = row.createCell(50);
        cell.setCellValue("변동사항 2");
        cell = row.createCell(51);
        cell.setCellValue("비고 2");
        cell = row.createCell(52);
        cell.setCellValue("년월일 3");
        cell = row.createCell(53);
        cell.setCellValue("변동사항 3");
        cell = row.createCell(54);
        cell.setCellValue("비고 3");
        cell = row.createCell(55);
        cell.setCellValue("년월일 4");
        cell = row.createCell(56);
        cell.setCellValue("변동사항 4");
        cell = row.createCell(57);
        cell.setCellValue("비고 4");
        
        rowNum++;
        
        
        // Body
        for (EquipInfo equipInfo:equipInfoList) {
        	
            row = sheet.createRow(rowNum);
            cell = row.createCell(0);
            cell.setCellValue(equipInfo.getInvnr());
            cell = row.createCell(1);
            cell.setCellValue(equipInfo.getUserNm());
            cell = row.createCell(2);
            cell.setCellValue(equipInfo.getHogi());
            cell = row.createCell(3);
            cell.setCellValue(equipInfo.getInsLoc());
            cell = row.createCell(4);
            cell.setCellValue(equipInfo.getEquipNm());
            cell = row.createCell(5);
            cell.setCellValue(equipInfo.getTagNo());
            
            
            cell = row.createCell(6);            
            cell.setCellValue(equipInfo.getProduct());
            cell = row.createCell(7);
            cell.setCellValue(equipInfo.getHogi());
            cell = row.createCell(8);
            cell.setCellValue(equipInfo.getSysNm());            
            cell = row.createCell(9);
            cell.setCellValue(equipInfo.getPn());
            cell = row.createCell(10);
            cell.setCellValue(equipInfo.getSn());
            cell = row.createCell(11);
            cell.setCellValue(equipInfo.getMaterialNo());
            cell = row.createCell(12);
            cell.setCellValue(equipInfo.getRack());
            cell = row.createCell(13);
            cell.setCellValue(equipInfo.getProDate());
            cell = row.createCell(14);
            cell.setCellValue(equipInfo.getRev());
            cell = row.createCell(15);
            cell.setCellValue(equipInfo.getWeakPart());
            cell = row.createCell(16);
            cell.setCellValue(equipInfo.getInsDate());
            cell = row.createCell(17);
            cell.setCellValue(equipInfo.getFid());
            cell = row.createCell(18);
            cell.setCellValue(equipInfo.getqGrade());
            cell = row.createCell(19);
            cell.setCellValue(equipInfo.getsGrade());
            cell = row.createCell(20);
            cell.setCellValue(equipInfo.getsYear());
            cell = row.createCell(21);
            cell.setCellValue(equipInfo.getSupplier());
            cell = row.createCell(22);
            cell.setCellValue(equipInfo.getPo());
            cell = row.createCell(23);
            cell.setCellValue(equipInfo.getInDate());
            cell = row.createCell(24);
            cell.setCellValue(equipInfo.getInCnt());
            cell = row.createCell(25);
            cell.setCellValue(equipInfo.getState());
            cell = row.createCell(26);
            cell.setCellValue(equipInfo.getWpartNm());
            cell = row.createCell(27);
            cell.setCellValue(equipInfo.getPmNo());
            cell = row.createCell(28);
            cell.setCellValue(equipInfo.getPcDate());
            cell = row.createCell(29);
            cell.setCellValue(equipInfo.getPcCycle());
            cell = row.createCell(30);
            cell.setCellValue(equipInfo.getIctCycle());
            cell = row.createCell(31);
            cell.setCellValue(equipInfo.getChgCycle());
            cell = row.createCell(32);
            cell.setCellValue(equipInfo.getChkMeth());
            cell = row.createCell(33);
            cell.setCellValue(equipInfo.getChkCycle());
            
            
            cell = row.createCell(34);
            cell.setCellValue(equipInfo.getmDate1());
            cell = row.createCell(35);
            cell.setCellValue(equipInfo.getmContent1());
            cell = row.createCell(36);
            cell.setCellValue(equipInfo.getmBigo1());
            cell = row.createCell(37);
            cell.setCellValue(equipInfo.getmDate2());
            cell = row.createCell(38);
            cell.setCellValue(equipInfo.getmContent2());
            cell = row.createCell(39);
            cell.setCellValue(equipInfo.getmBigo2());
            cell = row.createCell(40);
            cell.setCellValue(equipInfo.getmDate3());
            cell = row.createCell(41);
            cell.setCellValue(equipInfo.getmContent3());
            cell = row.createCell(42);
            cell.setCellValue(equipInfo.getmBigo3());
            cell = row.createCell(43);
            cell.setCellValue(equipInfo.getmDate4());
            cell = row.createCell(44);
            cell.setCellValue(equipInfo.getmContent4());
            cell = row.createCell(45);
            cell.setCellValue(equipInfo.getmBigo4());
            
            cell = row.createCell(46);
            cell.setCellValue(equipInfo.geteDate1());
            cell = row.createCell(47);
            cell.setCellValue(equipInfo.geteContent1());
            cell = row.createCell(48);
            cell.setCellValue(equipInfo.geteBigo1());
            cell = row.createCell(49);
            cell.setCellValue(equipInfo.geteDate2());
            cell = row.createCell(50);
            cell.setCellValue(equipInfo.geteContent2());
            cell = row.createCell(51);
            cell.setCellValue(equipInfo.geteBigo2());
            cell = row.createCell(52);
            cell.setCellValue(equipInfo.geteDate3());
            cell = row.createCell(53);;
            cell.setCellValue(equipInfo.geteContent3());
            cell = row.createCell(54);
            cell.setCellValue(equipInfo.geteBigo3());
            cell = row.createCell(55);
            cell.setCellValue(equipInfo.geteDate4());
            cell = row.createCell(56);
            cell.setCellValue(equipInfo.geteContent4());
            cell = row.createCell(57);
            cell.setCellValue(equipInfo.geteBigo4());
            
            rowNum++;
        }
        
        String browser = WebUtil.getBrowser(request);
		String encodedFilename = WebUtil.webEncoding(browser, "전자회로기판 관리.xlsx");
        
        response.setContentType("application/vnd.ms-excel");
        response.setHeader("Content-Disposition", "attachment;filename=" + encodedFilename);

        //Excel File Output
        ServletOutputStream output = response.getOutputStream();
        output.flush();
        wb.write(output);
        output.flush();
        output.close();
        wb.close();		

	}
	
	
	public void iolistAIExcelDownload(HttpServletRequest request, HttpServletResponse response, List<IOListInfo> iolistInfoList) throws Exception{
		
		Workbook wb = new XSSFWorkbook();
        Sheet sheet = wb.createSheet("I_O LIST- AI");
        Row row = null;
        Cell cell = null;
        int rowNum = 0;

        
        // Header
        row = sheet.createRow(rowNum++);
        cell = row.createCell(0);
        cell.setCellValue("ADDR");
        cell = row.createCell(1);
        cell.setCellValue("DESCR");
        cell = row.createCell(2);
        cell.setCellValue("MESSAGE");
        cell = row.createCell(3);
        cell.setCellValue("REV");
        cell = row.createCell(4);
        cell.setCellValue("DRAWING");
        cell = row.createCell(5);
        cell.setCellValue("LOOPNAME");
        cell = row.createCell(6);
        cell.setCellValue("DEVICE");
        cell = row.createCell(7);
        cell.setCellValue("PURPOSE");
        cell = row.createCell(8);
        cell.setCellValue("PROGRAM");
        cell = row.createCell(9);
        cell.setCellValue("VLOW");

        
        cell = row.createCell(10);
        cell.setCellValue("VHIGH");
        cell = row.createCell(11);
        cell.setCellValue("ELOW");
        cell = row.createCell(12);
        cell.setCellValue("EHIGH");
        cell = row.createCell(13);
        cell.setCellValue("UNIT");
        cell = row.createCell(14);
        cell.setCellValue("CONV");
        cell = row.createCell(15);
        cell.setCellValue("RTD");
        cell = row.createCell(16);
        cell.setCellValue("TYPE");
        cell = row.createCell(17);
        cell.setCellValue("GROUP");
        cell = row.createCell(18);
        cell.setCellValue("WINDOW");
        cell = row.createCell(19);
        cell.setCellValue("PRIORITY");
        
        cell = row.createCell(20);
        cell.setCellValue("CR");
        cell = row.createCell(21);
        cell.setCellValue("LIMIT1");
        cell = row.createCell(22);
        cell.setCellValue("LIMIT2");
        cell = row.createCell(23);
        cell.setCellValue("J");
        cell = row.createCell(24);
        cell.setCellValue("N");
        cell = row.createCell(25);
        cell.setCellValue("EQU#");
        cell = row.createCell(26);
        cell.setCellValue("BSCAL");
        cell = row.createCell(27);
        cell.setCellValue("WIBA");
        cell = row.createCell(28);
        cell.setCellValue("WB#");
        cell = row.createCell(29);
        cell.setCellValue("원인");
        cell = row.createCell(30);
        cell.setCellValue("조치");        
        cell = row.createCell(31);
        cell.setCellValue("결과서");      
        
     // Body
        for (IOListInfo iolistInfo:iolistInfoList) {
        	
            row = sheet.createRow(rowNum++);
            
            cell = row.createCell(0);
            cell.setCellValue(iolistInfo.getAddress());
            cell = row.createCell(1);
            cell.setCellValue(iolistInfo.getDescr());
            cell = row.createCell(2);
            cell.setCellValue(iolistInfo.getMessage());
            cell = row.createCell(3);
            cell.setCellValue(iolistInfo.getRev());
            cell = row.createCell(4);
            cell.setCellValue(iolistInfo.getDrawing());
            cell = row.createCell(5);
            cell.setCellValue(iolistInfo.getLoopname());
            cell = row.createCell(6);
            cell.setCellValue(iolistInfo.getDevice());
            cell = row.createCell(7);
            cell.setCellValue(iolistInfo.getPurpose());
            cell = row.createCell(8);
            cell.setCellValue(iolistInfo.getProgram());
            
            cell = row.createCell(9);
            cell.setCellValue(iolistInfo.getVlow());
            cell = row.createCell(10);
            cell.setCellValue(iolistInfo.getVhigh());
            cell = row.createCell(11);
            cell.setCellValue(iolistInfo.getElow());
            cell = row.createCell(12);
            cell.setCellValue(iolistInfo.getEhigh());
            cell = row.createCell(13);
            cell.setCellValue(iolistInfo.getUnit());
            cell = row.createCell(14);
            cell.setCellValue(iolistInfo.getConv());
            cell = row.createCell(15);
            cell.setCellValue(iolistInfo.getRtd());
            cell = row.createCell(16);
            cell.setCellValue(iolistInfo.getType());
            cell = row.createCell(17);
            cell.setCellValue(iolistInfo.getIogroup());
            cell = row.createCell(18);
            cell.setCellValue(iolistInfo.getWindow());
            
            cell = row.createCell(19);
            cell.setCellValue(iolistInfo.getPriority());
            cell = row.createCell(20);
            cell.setCellValue(iolistInfo.getCr());
            cell = row.createCell(21);
            cell.setCellValue(iolistInfo.getLimit1());
            cell = row.createCell(22);
            cell.setCellValue(iolistInfo.getLimit2());
            cell = row.createCell(23);
            cell.setCellValue(iolistInfo.getJ());
            cell = row.createCell(24);
            cell.setCellValue(iolistInfo.getN());
            cell = row.createCell(25);
            cell.setCellValue(iolistInfo.getEqu());
            cell = row.createCell(26);
            cell.setCellValue(iolistInfo.getBscal());
            cell = row.createCell(27);
            cell.setCellValue(iolistInfo.getWiba());
            cell = row.createCell(28);
            cell.setCellValue(iolistInfo.getWb());
            
            cell = row.createCell(29);
            cell.setCellValue(iolistInfo.getZtext1());
            cell = row.createCell(30);
            cell.setCellValue(iolistInfo.getZtext2());
            cell = row.createCell(31);
            cell.setCellValue(iolistInfo.getZtext3());
        }
        
        String browser = WebUtil.getBrowser(request);
		String encodedFilename = WebUtil.webEncoding(browser, "I_O LIST(AI).xlsx");
        
        response.setContentType("application/vnd.ms-excel");
        response.setHeader("Content-Disposition", "attachment;filename=" + encodedFilename);

        //Excel File Output
        ServletOutputStream output = response.getOutputStream();
        output.flush();
        wb.write(output);
        output.flush();
        output.close();
        wb.close();		
		
	}	

	public void iolistAOExcelDownload(HttpServletRequest request, HttpServletResponse response, List<IOListInfo> iolistInfoList) throws Exception{
		
		Workbook wb = new XSSFWorkbook();
        Sheet sheet = wb.createSheet("I_O LIST - AO");
        Row row = null;
        Cell cell = null;
        int rowNum = 0;

        
        // Header
        row = sheet.createRow(rowNum++);
        cell = row.createCell(0);
        cell.setCellValue("ADDR");
        cell = row.createCell(1);
        cell.setCellValue("REV");
        cell = row.createCell(2);
        cell.setCellValue("DESCR");
        cell = row.createCell(3);
        cell.setCellValue("DRAWING");
        cell = row.createCell(4);
        cell.setCellValue("DEVICE");
        cell = row.createCell(5);
        cell.setCellValue("PURPOSE");
        cell = row.createCell(6);
        cell.setCellValue("CTRLNAME");
        cell = row.createCell(7);
        cell.setCellValue("INTERLOCK");
        cell = row.createCell(8);
        cell.setCellValue("FEEDBACK");
        cell = row.createCell(9);
        cell.setCellValue("COM1");
        cell = row.createCell(10);
        cell.setCellValue("COM2");
        cell = row.createCell(11);
         cell.setCellValue("WIBA");
        
     // Body
        for (IOListInfo iolistInfo:iolistInfoList) {
        	
            row = sheet.createRow(rowNum++);
            
            cell = row.createCell(0);
            cell.setCellValue(iolistInfo.getAddress());
            cell = row.createCell(1);
            cell.setCellValue(iolistInfo.getRev());
            cell = row.createCell(2);
            cell.setCellValue(iolistInfo.getDescr());
            cell = row.createCell(3);
            cell.setCellValue(iolistInfo.getDrawing());
            cell = row.createCell(4);
            cell.setCellValue(iolistInfo.getDevice());
            cell = row.createCell(5);
            cell.setCellValue(iolistInfo.getPurpose());
            cell = row.createCell(6);
            cell.setCellValue(iolistInfo.getCtrlname());
            cell = row.createCell(7);
            cell.setCellValue(iolistInfo.getInterlock());
            cell = row.createCell(8);
            cell.setCellValue(iolistInfo.getFeedback());
            cell = row.createCell(9);
            cell.setCellValue(iolistInfo.getCom1());
            cell = row.createCell(10);
            cell.setCellValue(iolistInfo.getCom2());
            cell = row.createCell(11);
            cell.setCellValue(iolistInfo.getWiba());
        }
        
        String browser = WebUtil.getBrowser(request);
		String encodedFilename = WebUtil.webEncoding(browser, "I_O LIST(AO).xlsx");
        
        response.setContentType("application/vnd.ms-excel");
        response.setHeader("Content-Disposition", "attachment;filename=" + encodedFilename);

        //Excel File Output
        ServletOutputStream output = response.getOutputStream();
        output.flush();
        wb.write(output);
        output.flush();
        output.close();
        wb.close();		
		
	}
	
	public void iolistCIExcelDownload(HttpServletRequest request, HttpServletResponse response, List<IOListInfo> iolistInfoList) throws Exception{
		
		Workbook wb = new XSSFWorkbook();
        Sheet sheet = wb.createSheet("I_O LIST - CI");
        Row row = null;
        Cell cell = null;
        int rowNum = 0;

        
        // Header
        row = sheet.createRow(rowNum++);
        cell = row.createCell(0);
        cell.setCellValue("ADDR");
        cell = row.createCell(1);
        cell.setCellValue("TR");
        cell = row.createCell(2);
        cell.setCellValue("CR");
        cell = row.createCell(3);
        cell.setCellValue("PRIORITY");
        cell = row.createCell(4);
        cell.setCellValue("GROUP");
        cell = row.createCell(5);
        cell.setCellValue("TYPE");
        cell = row.createCell(6);
        cell.setCellValue("MESSAGE");
        cell = row.createCell(7);
        cell.setCellValue("DRAWING");
        cell = row.createCell(8);
        cell.setCellValue("REV");
        cell = row.createCell(9);
        cell.setCellValue("DEVICE");
        cell = row.createCell(10);
        cell.setCellValue("CONDITION");
        cell = row.createCell(11);
        cell.setCellValue("WIBA");
        cell = row.createCell(12);
        cell.setCellValue("WB#");      
        cell = row.createCell(13);
        cell.setCellValue("원인");
        cell = row.createCell(14);
        cell.setCellValue("조치");
        cell = row.createCell(15);
        cell.setCellValue("관련절차서");                
        
     // Body
        for (IOListInfo iolistInfo:iolistInfoList) {
        	
            row = sheet.createRow(rowNum++);
            
            cell = row.createCell(0);
            cell.setCellValue(iolistInfo.getAddress());
            cell = row.createCell(1);
            cell.setCellValue(iolistInfo.getTr());
            cell = row.createCell(2);
            cell.setCellValue(iolistInfo.getCr());
            cell = row.createCell(3);
            cell.setCellValue(iolistInfo.getPriority());
            cell = row.createCell(4);
            cell.setCellValue(iolistInfo.getIogroup());
            cell = row.createCell(5);
            cell.setCellValue(iolistInfo.getType());
            cell = row.createCell(6);
            cell.setCellValue(iolistInfo.getMessage());
            cell = row.createCell(7);
            cell.setCellValue(iolistInfo.getDrawing());
            cell = row.createCell(8);
            cell.setCellValue(iolistInfo.getRev());
            cell = row.createCell(9);
            cell.setCellValue(iolistInfo.getDevice());
            cell = row.createCell(10);
            cell.setCellValue(iolistInfo.getCondition());
            cell = row.createCell(11);
            cell.setCellValue(iolistInfo.getWiba());
            cell = row.createCell(12);
            cell.setCellValue(iolistInfo.getWb());
            cell = row.createCell(13);
            cell.setCellValue(iolistInfo.getZtext1());
            cell = row.createCell(14);
            cell.setCellValue(iolistInfo.getZtext2());
            cell = row.createCell(15);
            cell.setCellValue(iolistInfo.getZtext3());
        }
        
        String browser = WebUtil.getBrowser(request);
		String encodedFilename = WebUtil.webEncoding(browser, "I_O LIST(DI).xlsx");
        
        response.setContentType("application/vnd.ms-excel");
        response.setHeader("Content-Disposition", "attachment;filename=" + encodedFilename);

        //Excel File Output
        ServletOutputStream output = response.getOutputStream();
        output.flush();
        wb.write(output);
        output.flush();
        output.close();
        wb.close();
	}
	
	public void iolistDIExcelDownload(HttpServletRequest request, HttpServletResponse response,  List<IOListInfo> iolistInfoList) throws Exception{
		
		Workbook wb = new XSSFWorkbook();
        Sheet sheet = wb.createSheet("I_O LIST - DI");
        Row row = null;
        Cell cell = null;
        int rowNum = 0;

        
        // Header
        row = sheet.createRow(rowNum++);
        cell = row.createCell(0);
        cell.setCellValue("ADDR");
        cell = row.createCell(1);
        cell.setCellValue("BIT");
        cell = row.createCell(2);
        cell.setCellValue("REV");
        cell = row.createCell(3);
        cell.setCellValue("DESCR");
        cell = row.createCell(4);
        cell.setCellValue("DRAWING");
        cell = row.createCell(5);
        cell.setCellValue("DEVICE");
        cell = row.createCell(6);
        cell.setCellValue("PURPOSE");
        cell = row.createCell(7);
        cell.setCellValue("CTRLNAME");
        cell = row.createCell(8);
        cell.setCellValue("ALARMCOND");
        cell = row.createCell(9);
        cell.setCellValue("INDICATE");
        cell = row.createCell(10);
        cell.setCellValue("OPEN상태");
        cell = row.createCell(11);
        cell.setCellValue("CLOSE상태");
        cell = row.createCell(12);
        cell.setCellValue("WIBA");                  
        
     // Body
        for (IOListInfo iolistInfo:iolistInfoList) {
        	
            row = sheet.createRow(rowNum++);
            
            cell = row.createCell(0);
            cell.setCellValue(iolistInfo.getAddress());
            cell = row.createCell(1);
            cell.setCellValue(iolistInfo.getIobit());
            cell = row.createCell(2);
            cell.setCellValue(iolistInfo.getRev());
            cell = row.createCell(3);
            cell.setCellValue(iolistInfo.getDescr());
            cell = row.createCell(4);
            cell.setCellValue(iolistInfo.getDrawing());
            cell = row.createCell(5);
            cell.setCellValue(iolistInfo.getDevice());
            cell = row.createCell(6);
            cell.setCellValue(iolistInfo.getPurpose());
            cell = row.createCell(7);
            cell.setCellValue(iolistInfo.getCtrlname());
            cell = row.createCell(8);
            cell.setCellValue(iolistInfo.getAlarmcond());
            cell = row.createCell(9);
            cell.setCellValue(iolistInfo.getIndicate());
            cell = row.createCell(10);
            cell.setCellValue(iolistInfo.getCom1());
            cell = row.createCell(11);
            cell.setCellValue(iolistInfo.getCom2());
            cell = row.createCell(12);
            cell.setCellValue(iolistInfo.getWiba());
            
        }
        
        String browser = WebUtil.getBrowser(request);
		String encodedFilename = WebUtil.webEncoding(browser, "I_O LIST(DI).xlsx");
        
        response.setContentType("application/vnd.ms-excel");
        response.setHeader("Content-Disposition", "attachment;filename=" + encodedFilename);

        //Excel File Output
        ServletOutputStream output = response.getOutputStream();
        output.flush();
        wb.write(output);
        output.flush();
        output.close();
        wb.close();
        
	}
	
	public void iolistDOExcelDownload(HttpServletRequest request, HttpServletResponse response,  List<IOListInfo> iolistInfoList) throws Exception{
		
		Workbook wb = new XSSFWorkbook();
        Sheet sheet = wb.createSheet("I_O LIST - DO");
        Row row = null;
        Cell cell = null;
        int rowNum = 0;

        
        // Header
        row = sheet.createRow(rowNum++);
        cell = row.createCell(0);
        cell.setCellValue("ADDR");
        cell = row.createCell(1);
        cell.setCellValue("BIT");
        cell = row.createCell(2);
        cell.setCellValue("REV");
        cell = row.createCell(3);
        cell.setCellValue("DESCR");
        cell = row.createCell(4);
        cell.setCellValue("DRAWING");
        cell = row.createCell(5);
        cell.setCellValue("DEVICE");
        cell = row.createCell(6);
        cell.setCellValue("PURPOSE");
        cell = row.createCell(7);
        cell.setCellValue("CTRLNAME");
        cell = row.createCell(8);
        cell.setCellValue("INTERLOCK");
        cell = row.createCell(9);
        cell.setCellValue("OPEN상태");
        cell = row.createCell(10);
        cell.setCellValue("CLOSE상태");
        cell = row.createCell(11);
        cell.setCellValue("WIBA");                  
        
     // Body
        for (IOListInfo iolistInfo:iolistInfoList) {
        	
            row = sheet.createRow(rowNum++);
            
            cell = row.createCell(0);
            cell.setCellValue(iolistInfo.getAddress());
            cell = row.createCell(1);
            cell.setCellValue(iolistInfo.getIobit());
            cell = row.createCell(2);
            cell.setCellValue(iolistInfo.getRev());
            cell = row.createCell(3);
            cell.setCellValue(iolistInfo.getDescr());
            cell = row.createCell(4);
            cell.setCellValue(iolistInfo.getDrawing());
            cell = row.createCell(5);
            cell.setCellValue(iolistInfo.getDevice());
            cell = row.createCell(6);
            cell.setCellValue(iolistInfo.getPurpose());
            cell = row.createCell(7);
            cell.setCellValue(iolistInfo.getCtrlname());
            cell = row.createCell(8);
            cell.setCellValue(iolistInfo.getInterlock());
            cell = row.createCell(9);
            cell.setCellValue(iolistInfo.getCom1());
            cell = row.createCell(10);
            cell.setCellValue(iolistInfo.getCom2());
            cell = row.createCell(11);
            cell.setCellValue(iolistInfo.getWiba());
            
        }
        
        String browser = WebUtil.getBrowser(request);
		String encodedFilename = WebUtil.webEncoding(browser, "I_O LIST(DO).xlsx");
        
        response.setContentType("application/vnd.ms-excel");
        response.setHeader("Content-Disposition", "attachment;filename=" + encodedFilename);

        //Excel File Output
        ServletOutputStream output = response.getOutputStream();
        output.flush();
        wb.write(output);
        output.flush();
        output.close();
        wb.close();
	}
	
	public void iolistDTExcelDownload(HttpServletRequest request, HttpServletResponse response,  List<IOListInfo> iolistInfoList) throws Exception{
		
		Workbook wb = new XSSFWorkbook();
        Sheet sheet = wb.createSheet("I_O LIST - DT");
        Row row = null;
        Cell cell = null;
        int rowNum = 0;
        
        // Header
        row = sheet.createRow(rowNum++);
        cell = row.createCell(0);
        cell.setCellValue("ADDR");
        cell = row.createCell(1);
        cell.setCellValue("PROGRAM");
        cell = row.createCell(2);
        cell.setCellValue("DESCR");
        cell = row.createCell(3);
        cell.setCellValue("LOOPNAME");
        cell = row.createCell(4);
        cell.setCellValue("BSCAL");
        cell = row.createCell(5);
        cell.setCellValue("ELOW");
        cell = row.createCell(6);
        cell.setCellValue("EHIGH");
        
     // Body
        for (IOListInfo iolistInfo:iolistInfoList) {
        	
            row = sheet.createRow(rowNum++);
            
            cell = row.createCell(0);
            cell.setCellValue(iolistInfo.getAddress());
            cell = row.createCell(1);
            cell.setCellValue(iolistInfo.getProgram());
            cell = row.createCell(2);
            cell.setCellValue(iolistInfo.getDescr());
            cell = row.createCell(3);
            cell.setCellValue(iolistInfo.getLoopname());
            cell = row.createCell(4);
            cell.setCellValue(iolistInfo.getBscal());
            cell = row.createCell(5);
            cell.setCellValue(iolistInfo.getElow());
            cell = row.createCell(6);
            cell.setCellValue(iolistInfo.getEhigh());
        }
        
        String browser = WebUtil.getBrowser(request);
		String encodedFilename = WebUtil.webEncoding(browser, "I_O LIST(DT).xlsx");
        
        response.setContentType("application/vnd.ms-excel");
        response.setHeader("Content-Disposition", "attachment;filename=" + encodedFilename);

        //Excel File Output
        ServletOutputStream output = response.getOutputStream();
        output.flush();
        wb.write(output);
        output.flush();
        output.close();
        wb.close();
		
	}
	
	public void iolistSCExcelDownload(HttpServletRequest request, HttpServletResponse response,  List<IOListInfo> iolistInfoList) throws Exception{
		
		Workbook wb = new XSSFWorkbook();
        Sheet sheet = wb.createSheet("I_O LIST - SC");
        Row row = null;
        Cell cell = null;
        int rowNum = 0;
        
        // Header
        row = sheet.createRow(rowNum++);
        cell = row.createCell(0);
        cell.setCellValue("ADDR");
        cell = row.createCell(1);
        cell.setCellValue("BIT");
        cell = row.createCell(2);
        cell.setCellValue("DESCR");
        cell = row.createCell(3);
        cell.setCellValue("PROGRAM");
        cell = row.createCell(4);
        cell.setCellValue("INDICATE");
        cell = row.createCell(5);
        cell.setCellValue("BSCAL");
        
        
     // Body
        for (IOListInfo iolistInfo:iolistInfoList) {
        	
            row = sheet.createRow(rowNum++);
            
            cell = row.createCell(0);
            cell.setCellValue(iolistInfo.getAddress());
            cell = row.createCell(1);
            cell.setCellValue(iolistInfo.getIobit());
            cell = row.createCell(2);
            cell.setCellValue(iolistInfo.getDescr());
            cell = row.createCell(3);
            cell.setCellValue(iolistInfo.getProgram());
            cell = row.createCell(4);
            cell.setCellValue(iolistInfo.getIndicate());
            cell = row.createCell(5);
            cell.setCellValue(iolistInfo.getBscal());
        }
        
        String browser = WebUtil.getBrowser(request);
		String encodedFilename = WebUtil.webEncoding(browser, "I_O LIST(SC).xlsx");
        
        response.setContentType("application/vnd.ms-excel");
        response.setHeader("Content-Disposition", "attachment;filename=" + encodedFilename);

        //Excel File Output
        ServletOutputStream output = response.getOutputStream();
        output.flush();
        wb.write(output);
        output.flush();
        output.close();
        wb.close();
		
	}
	
	public void iolistFTAIExcelDownload(HttpServletRequest request, HttpServletResponse response,  List<IOListInfo> iolistInfoList) throws Exception{
		
		Workbook wb = new XSSFWorkbook();
        Sheet sheet = wb.createSheet("I_O LIST - FTAI");
        Row row = null;
        Cell cell = null;
        int rowNum = 0;

        
        // Header
        row = sheet.createRow(rowNum++);
        cell = row.createCell(0);
        cell.setCellValue("ADDR");
        cell = row.createCell(1);
        cell.setCellValue("DESCR");
        cell = row.createCell(2);
        cell.setCellValue("MESSAGE");
        cell = row.createCell(3);
        cell.setCellValue("REV");
        cell = row.createCell(4);
        cell.setCellValue("DRAWING");
        cell = row.createCell(5);
        cell.setCellValue("LOOPNAME");
        cell = row.createCell(6);
        cell.setCellValue("DEVICE");
        cell = row.createCell(7);
        cell.setCellValue("PURPOSE");
        cell = row.createCell(8);
        cell.setCellValue("PROGRAM");
        cell = row.createCell(9);
        cell.setCellValue("VLOW");

        
        cell = row.createCell(10);
        cell.setCellValue("VHIGH");
        cell = row.createCell(11);
        cell.setCellValue("ELOW");
        cell = row.createCell(12);
        cell.setCellValue("EHIGH");
        cell = row.createCell(13);
        cell.setCellValue("UNIT");
        cell = row.createCell(14);
        cell.setCellValue("CONV");
        cell = row.createCell(15);
        cell.setCellValue("RTD");
        cell = row.createCell(16);
        cell.setCellValue("TYPE");
        cell = row.createCell(17);
        cell.setCellValue("GROUP");
        cell = row.createCell(18);
        cell.setCellValue("WINDOW");
        cell = row.createCell(19);
        cell.setCellValue("PRIORITY");
        
        cell = row.createCell(20);
        cell.setCellValue("CR");
        cell = row.createCell(21);
        cell.setCellValue("LIMIT1");
        cell = row.createCell(22);
        cell.setCellValue("LIMIT2");
        cell = row.createCell(23);
        cell.setCellValue("J");
        cell = row.createCell(24);
        cell.setCellValue("N");
        cell = row.createCell(25);
        cell.setCellValue("EQU#");
        cell = row.createCell(26);
        cell.setCellValue("BSCAL");
        cell = row.createCell(27);
        cell.setCellValue("WIBA");
        cell = row.createCell(28);
        cell.setCellValue("WB#");
        cell = row.createCell(29);
        
     // Body
        for (IOListInfo iolistInfo:iolistInfoList) {
        	
            row = sheet.createRow(rowNum++);
            
            cell = row.createCell(0);
            cell.setCellValue(iolistInfo.getAddress());
            cell = row.createCell(1);
            cell.setCellValue(iolistInfo.getDescr());
            cell = row.createCell(2);
            cell.setCellValue(iolistInfo.getMessage());
            cell = row.createCell(3);
            cell.setCellValue(iolistInfo.getRev());
            cell = row.createCell(4);
            cell.setCellValue(iolistInfo.getDrawing());
            cell = row.createCell(5);
            cell.setCellValue(iolistInfo.getLoopname());
            cell = row.createCell(6);
            cell.setCellValue(iolistInfo.getDevice());
            cell = row.createCell(7);
            cell.setCellValue(iolistInfo.getPurpose());
            cell = row.createCell(8);
            cell.setCellValue(iolistInfo.getProgram());
            
            cell = row.createCell(9);
            cell.setCellValue(iolistInfo.getVlow());
            cell = row.createCell(10);
            cell.setCellValue(iolistInfo.getVhigh());
            cell = row.createCell(11);
            cell.setCellValue(iolistInfo.getElow());
            cell = row.createCell(12);
            cell.setCellValue(iolistInfo.getEhigh());
            cell = row.createCell(13);
            cell.setCellValue(iolistInfo.getUnit());
            cell = row.createCell(14);
            cell.setCellValue(iolistInfo.getConv());
            cell = row.createCell(15);
            cell.setCellValue(iolistInfo.getRtd());
            cell = row.createCell(16);
            cell.setCellValue(iolistInfo.getType());
            cell = row.createCell(17);
            cell.setCellValue(iolistInfo.getIogroup());
            cell = row.createCell(18);
            cell.setCellValue(iolistInfo.getWindow());
            
            cell = row.createCell(19);
            cell.setCellValue(iolistInfo.getPriority());
            cell = row.createCell(20);
            cell.setCellValue(iolistInfo.getCr());
            cell = row.createCell(21);
            cell.setCellValue(iolistInfo.getLimit1());
            cell = row.createCell(22);
            cell.setCellValue(iolistInfo.getLimit2());
            cell = row.createCell(23);
            cell.setCellValue(iolistInfo.getJ());
            cell = row.createCell(24);
            cell.setCellValue(iolistInfo.getN());
            cell = row.createCell(25);
            cell.setCellValue(iolistInfo.getEqu());
            cell = row.createCell(26);
            cell.setCellValue(iolistInfo.getBscal());
            cell = row.createCell(27);
            cell.setCellValue(iolistInfo.getWiba());
            cell = row.createCell(28);
            cell.setCellValue(iolistInfo.getWb());

        }
        
        String browser = WebUtil.getBrowser(request);
		String encodedFilename = WebUtil.webEncoding(browser, "I_O LIST(FTAI).xlsx");
        
        response.setContentType("application/vnd.ms-excel");
        response.setHeader("Content-Disposition", "attachment;filename=" + encodedFilename);

        //Excel File Output
        ServletOutputStream output = response.getOutputStream();
        output.flush();
        wb.write(output);
        output.flush();
        output.close();
        wb.close();		
		
	}
	
	public void iolistFTDTExcelDownload(HttpServletRequest request, HttpServletResponse response,  List<IOListInfo> iolistInfoList) throws Exception{
		Workbook wb = new XSSFWorkbook();
        Sheet sheet = wb.createSheet("I_O LIST - FTDT");
        Row row = null;
        Cell cell = null;
        int rowNum = 0;
        
        // Header
        row = sheet.createRow(rowNum++);
        cell = row.createCell(0);
        cell.setCellValue("ADDR");
        cell = row.createCell(1);
        cell.setCellValue("PROGRAM");
        cell = row.createCell(2);
        cell.setCellValue("DESCR");
        cell = row.createCell(3);
        cell.setCellValue("LOOPNAME");
        cell = row.createCell(4);
        cell.setCellValue("BSCAL");
        cell = row.createCell(5);
        cell.setCellValue("ELOW");
        cell = row.createCell(6);
        cell.setCellValue("EHIGH");
        
     // Body
        for (IOListInfo iolistInfo:iolistInfoList) {
        	
            row = sheet.createRow(rowNum++);
            
            cell = row.createCell(0);
            cell.setCellValue(iolistInfo.getAddress());
            cell = row.createCell(1);
            cell.setCellValue(iolistInfo.getProgram());
            cell = row.createCell(2);
            cell.setCellValue(iolistInfo.getDescr());
            cell = row.createCell(3);
            cell.setCellValue(iolistInfo.getLoopname());
            cell = row.createCell(4);
            cell.setCellValue(iolistInfo.getBscal());
            cell = row.createCell(5);
            cell.setCellValue(iolistInfo.getElow());
            cell = row.createCell(6);
            cell.setCellValue(iolistInfo.getEhigh());
        }
        
        String browser = WebUtil.getBrowser(request);
		String encodedFilename = WebUtil.webEncoding(browser, "I_O LIST(FTDT).xlsx");
        
        response.setContentType("application/vnd.ms-excel");
        response.setHeader("Content-Disposition", "attachment;filename=" + encodedFilename);

        //Excel File Output
        ServletOutputStream output = response.getOutputStream();
        output.flush();
        wb.write(output);
        output.flush();
        output.close();
        wb.close();
	}
		
	private String cellNullCheck(Cell cell) {
		return cell != null? cell.getStringCellValue():"";
	}

	public void iolistExcelDownload(HttpServletRequest request, HttpServletResponse response, List<DccIolistInfo> dccIolistInfoList) throws Exception{
		
		Workbook wb = new XSSFWorkbook();
        Sheet sheet = wb.createSheet("첫번째 시트");
        Row row = null;
        Cell cell = null;
        int rowNum = 0;
        String fileName = new SimpleDateFormat("yyyyMMdd").format(new Date())+".xlsx";
        
        switch (dccIolistInfoList.get(0).getIoType().toString()) {
        case "AI":
        	fileName = "AI"+fileName;
        	
        	String[] AIHeaderList = {"ADDRESS","REV","descr","drawing","loopname","xygubun","vlow","vhigh"
        						,"elow","ehigh","unit","conv","rtd","type","iogroup","window","priority"
        						,"cr","limit1","limit2","j","n","message","equ#","bscal","wiba","device"
        						,"purpose","program","원인","조치","관련절차서"};
            row = sheet.createRow(rowNum++);
            for( int ai=0;ai<AIHeaderList.length;ai++ ) {
            	cell = row.createCell(ai);
                cell.setCellValue(AIHeaderList[ai].toUpperCase());
            }
            
            for (DccIolistInfo iolistInfo:dccIolistInfoList) {
                row = sheet.createRow(rowNum++);
                cell = row.createCell(0);
                cell.setCellValue(iolistInfo.getAddress());
                cell = row.createCell(1);
                cell.setCellValue(iolistInfo.getRev());
                cell = row.createCell(2);
                cell.setCellValue(iolistInfo.getDescr());
                cell = row.createCell(3);
                cell.setCellValue(iolistInfo.getDrawing());
                cell = row.createCell(4);
                cell.setCellValue(iolistInfo.getLoopName());
                cell = row.createCell(5);
                cell.setCellValue(iolistInfo.getXyGubun());
                cell = row.createCell(6);
                cell.setCellValue(iolistInfo.getvLow());
                cell = row.createCell(7);
                cell.setCellValue(iolistInfo.getvHigh());
                cell = row.createCell(8);
                cell.setCellValue(iolistInfo.geteLow());
                cell = row.createCell(9);
                cell.setCellValue(iolistInfo.geteHigh());
                cell = row.createCell(10);
                cell.setCellValue(iolistInfo.getUnit());
                cell = row.createCell(11);
                cell.setCellValue(iolistInfo.getConv());
                cell = row.createCell(12);
                cell.setCellValue(iolistInfo.getRtd());
                cell = row.createCell(13);
                cell.setCellValue(iolistInfo.getType());
                cell = row.createCell(14);
                cell.setCellValue(iolistInfo.getIoGroup());
                cell = row.createCell(15);
                cell.setCellValue(iolistInfo.getWindow());
                cell = row.createCell(16);
                cell.setCellValue(iolistInfo.getPriority());
                cell = row.createCell(17);
                cell.setCellValue(iolistInfo.getCr());
                cell = row.createCell(18);
                cell.setCellValue(iolistInfo.getLimit1());
                cell = row.createCell(19);
                cell.setCellValue(iolistInfo.getLimit2());
                cell = row.createCell(20);
                cell.setCellValue(iolistInfo.getJ());
                cell = row.createCell(21);
                cell.setCellValue(iolistInfo.getN());
                cell = row.createCell(22);
                cell.setCellValue(iolistInfo.getMessage());
                cell = row.createCell(23);
                cell.setCellValue(iolistInfo.getEqu());
                cell = row.createCell(24);
                cell.setCellValue(iolistInfo.getBscal());
                cell = row.createCell(25);
                cell.setCellValue(iolistInfo.getWiba());
                cell = row.createCell(26);
                cell.setCellValue(iolistInfo.getDevice());
                cell = row.createCell(27);
                cell.setCellValue(iolistInfo.getPurpose());
                cell = row.createCell(28);
                cell.setCellValue(iolistInfo.getProgram());
                cell = row.createCell(29);
                cell.setCellValue(iolistInfo.getzText1());
                cell = row.createCell(30);
                cell.setCellValue(iolistInfo.getzText2());
                cell = row.createCell(31);
                cell.setCellValue(iolistInfo.getzText3());
            }
        	break;
        case "AO":
        	fileName = "AO"+fileName;
        	
        	String[] AOHeaderList = {"ADDRESS","rev","descr","drawing","xygubun","ctrlname"
        							,"device","interlock","feedback","purpose","wiba"};
			row = sheet.createRow(rowNum++);
			for( int ao=0;ao<AOHeaderList.length;ao++ ) {
				cell = row.createCell(ao);
			    cell.setCellValue(AOHeaderList[ao].toUpperCase());
			}
			
			for (DccIolistInfo iolistInfo:dccIolistInfoList) {
                row = sheet.createRow(rowNum++);
                cell = row.createCell(0);
                cell.setCellValue(iolistInfo.getAddress());
                cell = row.createCell(1);
                cell.setCellValue(iolistInfo.getRev());
                cell = row.createCell(2);
                cell.setCellValue(iolistInfo.getDescr());
                cell = row.createCell(3);
                cell.setCellValue(iolistInfo.getDrawing());
                cell = row.createCell(4);
                cell.setCellValue(iolistInfo.getXyGubun());
                cell = row.createCell(6);
                cell.setCellValue(iolistInfo.getCtrlName());
                cell = row.createCell(7);
                cell.setCellValue(iolistInfo.getDevice());
                cell = row.createCell(8);
                cell.setCellValue(iolistInfo.getInterlock());
                cell = row.createCell(9);
                cell.setCellValue(iolistInfo.getFeedback());
                cell = row.createCell(10);
                cell.setCellValue(iolistInfo.getPurpose());
                cell = row.createCell(11);
                cell.setCellValue(iolistInfo.getWiba());
            }
        	break;
        case "CI":
        	fileName = "CI"+fileName;
        	
        	String[] CIHeaderList = {"ADDRESS","rev","type","iogroup","priority","tr","cr","message"
        							,"device","drawing","condition","wiba","원인","조치","관련절차서"};
			row = sheet.createRow(rowNum++);
			for( int ci=0;ci<CIHeaderList.length;ci++ ) {
				cell = row.createCell(ci);
				cell.setCellValue(CIHeaderList[ci].toUpperCase());
			}
			
			for (DccIolistInfo iolistInfo:dccIolistInfoList) {
                row = sheet.createRow(rowNum++);
                cell = row.createCell(0);
                cell.setCellValue(iolistInfo.getAddress());
                cell = row.createCell(1);
                cell.setCellValue(iolistInfo.getRev());
                cell = row.createCell(2);
                cell.setCellValue(iolistInfo.getType());
                cell = row.createCell(3);
                cell.setCellValue(iolistInfo.getIoGroup());
                cell = row.createCell(4);
                cell.setCellValue(iolistInfo.getPriority());
                cell = row.createCell(5);
                cell.setCellValue(iolistInfo.getTr());
                cell = row.createCell(6);
                cell.setCellValue(iolistInfo.getCr());
                cell = row.createCell(7);
                cell.setCellValue(iolistInfo.getMessage());
                cell = row.createCell(8);
                cell.setCellValue(iolistInfo.getDevice());
                cell = row.createCell(9);
                cell.setCellValue(iolistInfo.getDrawing());
                cell = row.createCell(10);
                cell.setCellValue(iolistInfo.getCondition());
                cell = row.createCell(11);
                cell.setCellValue(iolistInfo.getWiba());
                cell = row.createCell(12);
                cell.setCellValue(iolistInfo.getzText1());
                cell = row.createCell(13);
                cell.setCellValue(iolistInfo.getzText2());
                cell = row.createCell(14);
                cell.setCellValue(iolistInfo.getzText3());
            }
        	break;
        case "DI":
        	fileName = "DI"+fileName;
        	
        	String[] DIHeaderList = {"ADDRESS","iobit","rev","descr","purpose","device","ctrlname",
        							"alarmcond","indicate","drawing","xygubun","wiba","OPEN상태","CLOSE상태"};
			row = sheet.createRow(rowNum++);
			for( int di=0;di<DIHeaderList.length;di++ ) {
				cell = row.createCell(di);
				cell.setCellValue(DIHeaderList[di].toUpperCase());
			}
			
			for (DccIolistInfo iolistInfo:dccIolistInfoList) {
                row = sheet.createRow(rowNum++);
                cell = row.createCell(0);
                cell.setCellValue(iolistInfo.getAddress());
                cell = row.createCell(1);
                cell.setCellValue(iolistInfo.getIoBit());
                cell = row.createCell(2);
                cell.setCellValue(iolistInfo.getRev());
                cell = row.createCell(3);
                cell.setCellValue(iolistInfo.getDescr());
                cell = row.createCell(4);
                cell.setCellValue(iolistInfo.getPurpose());
                cell = row.createCell(5);
                cell.setCellValue(iolistInfo.getDevice());
                cell = row.createCell(6);
                cell.setCellValue(iolistInfo.getCtrlName());
                cell = row.createCell(7);
                cell.setCellValue(iolistInfo.getAlarmCond());
                cell = row.createCell(8);
                cell.setCellValue(iolistInfo.getIndicate());
                cell = row.createCell(9);
                cell.setCellValue(iolistInfo.getDrawing());
                cell = row.createCell(10);
                cell.setCellValue(iolistInfo.getXyGubun());
                cell = row.createCell(11);
                cell.setCellValue(iolistInfo.getWiba());
                cell = row.createCell(12);
                cell.setCellValue(iolistInfo.getCom1());
                cell = row.createCell(13);
                cell.setCellValue(iolistInfo.getCom2());
            }
        	break;
        case "DO":
        	fileName = "DO"+fileName;
        	
        	String[] DOHeaderList = {"ADDRESS","iobit","rev","descr","purpose","bscal","device",
        							"ctrlname","interlock","drawing","xygubun","wiba","OPEN상태","CLOSE상태"};
			row = sheet.createRow(rowNum++);
			for( int doi=0;doi<DOHeaderList.length;doi++ ) {
				cell = row.createCell(doi);
				cell.setCellValue(DOHeaderList[doi].toUpperCase());
			}
			
			for (DccIolistInfo iolistInfo:dccIolistInfoList) {
                row = sheet.createRow(rowNum++);
                cell = row.createCell(0);
                cell.setCellValue(iolistInfo.getAddress());
                cell = row.createCell(1);
                cell.setCellValue(iolistInfo.getIoBit());
                cell = row.createCell(2);
                cell.setCellValue(iolistInfo.getRev());
                cell = row.createCell(3);
                cell.setCellValue(iolistInfo.getDescr());
                cell = row.createCell(4);
                cell.setCellValue(iolistInfo.getPurpose());
                cell = row.createCell(5);
                cell.setCellValue(iolistInfo.getBscal());
                cell = row.createCell(6);
                cell.setCellValue(iolistInfo.getDevice());
                cell = row.createCell(7);
                cell.setCellValue(iolistInfo.getCtrlName());
                cell = row.createCell(8);
                cell.setCellValue(iolistInfo.getInterlock());
                cell = row.createCell(9);
                cell.setCellValue(iolistInfo.getDrawing());
                cell = row.createCell(10);
                cell.setCellValue(iolistInfo.getXyGubun());
                cell = row.createCell(11);
                cell.setCellValue(iolistInfo.getWiba());
                cell = row.createCell(12);
                cell.setCellValue(iolistInfo.getCom1());
                cell = row.createCell(13);
                cell.setCellValue(iolistInfo.getCom2());
            }
        	break;
        case "DT":
        	fileName = "DT"+fileName;
        	
        	String[] DTHeaderList = {"address","program","descr","loopname"};
			row = sheet.createRow(rowNum++);
			for( int dt=0;dt<DTHeaderList.length;dt++ ) {
				cell = row.createCell(dt);
				cell.setCellValue(DTHeaderList[dt].toUpperCase());
			}
			
			for (DccIolistInfo iolistInfo:dccIolistInfoList) {
                row = sheet.createRow(rowNum++);
                cell = row.createCell(0);
                cell.setCellValue(iolistInfo.getAddress());
                cell = row.createCell(1);
                cell.setCellValue(iolistInfo.getProgram());
                cell = row.createCell(2);
                cell.setCellValue(iolistInfo.getDescr());
                cell = row.createCell(3);
                cell.setCellValue(iolistInfo.getLoopName());
            }
        	break;
        case "FTAI":
        	fileName = "FTAI"+fileName;
        	
	    	String[] FTAIHeaderList = {"ADDRESS","REV","descr","drawing","loopname",
	    							"xygubun","vlow","vhigh","elow","ehigh","conv",
	    							"type","iogroup","priority","message","device"};
			row = sheet.createRow(rowNum++);
			for( int ftai=0;ftai<FTAIHeaderList.length;ftai++ ) {
				cell = row.createCell(ftai);
				cell.setCellValue(FTAIHeaderList[ftai].toUpperCase());
			}
			
			for (DccIolistInfo iolistInfo:dccIolistInfoList) {
				row = sheet.createRow(rowNum++);
                cell = row.createCell(0);
                cell.setCellValue(iolistInfo.getAddress());
                cell = row.createCell(1);
                cell.setCellValue(iolistInfo.getRev());
                cell = row.createCell(2);
                cell.setCellValue(iolistInfo.getDescr());
                cell = row.createCell(3);
                cell.setCellValue(iolistInfo.getDrawing());
                cell = row.createCell(4);
                cell.setCellValue(iolistInfo.getLoopName());
                cell = row.createCell(5);
                cell.setCellValue(iolistInfo.getXyGubun());
                cell = row.createCell(6);
                cell.setCellValue(iolistInfo.getvLow());
                cell = row.createCell(7);
                cell.setCellValue(iolistInfo.getvHigh());
                cell = row.createCell(8);
                cell.setCellValue(iolistInfo.geteLow());
                cell = row.createCell(9);
                cell.setCellValue(iolistInfo.geteHigh());
                cell = row.createCell(10);
                cell.setCellValue(iolistInfo.getConv());
                cell = row.createCell(11);
                cell.setCellValue(iolistInfo.getType());
                cell = row.createCell(12);
                cell.setCellValue(iolistInfo.getIoGroup());
                cell = row.createCell(13);
                cell.setCellValue(iolistInfo.getPriority());
                cell = row.createCell(14);
                cell.setCellValue(iolistInfo.getMessage());
                cell = row.createCell(15);
                cell.setCellValue(iolistInfo.getDevice());
            }
	        break;
        case "FTDT":
        	fileName = "FTDT"+fileName;
        	
        	String[] FTDTHeaderList = {"address","program","descr","loopname"};
			row = sheet.createRow(rowNum++);
			for( int ftdt=0;ftdt<FTDTHeaderList.length;ftdt++ ) {
				cell = row.createCell(ftdt);
				cell.setCellValue(FTDTHeaderList[ftdt].toUpperCase());
			}
			
			for (DccIolistInfo iolistInfo:dccIolistInfoList) {
                row = sheet.createRow(rowNum++);
                cell = row.createCell(0);
                cell.setCellValue(iolistInfo.getAddress());
                cell = row.createCell(1);
                cell.setCellValue(iolistInfo.getProgram());
                cell = row.createCell(2);
                cell.setCellValue(iolistInfo.getDescr());
                cell = row.createCell(3);
                cell.setCellValue(iolistInfo.getLoopName());
            }
        	break;
        }
        
        String browser = WebUtil.getBrowser(request);
		String encodedFilename = WebUtil.webEncoding(browser, fileName);
        
        response.setContentType("application/vnd.ms-excel");
        response.setHeader("Content-Disposition", "attachment;filename=" + encodedFilename);

        //Excel File Output
        ServletOutputStream output = response.getOutputStream();
        output.flush();
        wb.write(output);
        output.flush();
        output.close();
        wb.close();		

	}
	
	public void statusExcelDownload(HttpServletRequest request, HttpServletResponse response, List<Map> values,
			List<ComTagDccInfo> dccTagInfoList, String scanTime, String type) throws Exception{
		
		Workbook wb = new XSSFWorkbook();
		Sheet sheet = wb.createSheet("첫번째 시트");
		Row row = null;
		Cell cell = null;
		int rowNum = 0;
		int size = 0;
		String fileName = new SimpleDateFormat("yyMM").format(new Date())+".xlsx";
		String prefix = "";
		String title = "";
		
		switch( type ) {
			case "htc":
				prefix = "htc_";
				title = "Heat Transport Control Status";
				size = 36;
				break;
			case "rrs":
				prefix = "rr_";
				title = "Reactor Regulating Status";
				size = 28;
				break;
			case "stb":
				prefix = "stb_";
				title = "StepBack Status";
				size = 67;
				break;
			case "sb":
				prefix = "sb_";
				title = "SetBack Status";
				size = 55;
				break;
			case "mtc":
				prefix = "mtc_";
				title = "Moderator Temp Control Status";
				size = 15;
				break;
			case "sgp":
				prefix = "sgp_";
				title = "SG Pressure Control Status";
				size = 20;
				break;
			case "sgl":
				prefix = "sgl_";
				title = "SG Level Control Status";
				size = 64;
				break;
			case "phtpump":
				prefix = "phtpump_";
				title = "PHT Pump Status";
				size = 60;
				break;
		}
		
		fileName = prefix+fileName;
		
		// Set Title
		row = sheet.createRow(rowNum++);
		cell = row.createCell(0);
		cell.setCellValue(title);
		// Set empty row
		row = sheet.createRow(rowNum++);
		// Set lblDate
		row = sheet.createRow(rowNum++);
		cell = row.createCell(0);
		cell.setCellValue(scanTime);
		// Set empty row
		row = sheet.createRow(rowNum++);
		
		for( int lli=0;lli<values.size();lli++ ) {
			for( int lii=0;lii<size;lii++ ) {
				
				row = sheet.createRow(rowNum++);
				
				cell = row.createCell(0);
				cell.setCellValue(lii+1);
				
				cell = row.createCell(1);
				cell.setCellValue(dccTagInfoList.get(lii).getDataLoop());
				
				cell = row.createCell(2);
				cell.setCellValue(values.get(lli).get("fValue").toString());
				
				cell = row.createCell(3);
				cell.setCellValue(dccTagInfoList.get(lii).getUnit());
				
				cell = row.createCell(4);
				cell.setCellValue(dccTagInfoList.get(lii).getIOTYPE());
				
				cell = row.createCell(5);
				cell.setCellValue(dccTagInfoList.get(lii).getADDRESS());
				
				cell = row.createCell(6);
				cell.setCellValue(dccTagInfoList.get(lii).getIOBIT());
			}
		}
		
		String browser = WebUtil.getBrowser(request);
		String encodedFilename = WebUtil.webEncoding(browser, fileName);
		
		response.setContentType("application/vnd.ms-excel");
		response.setHeader("Content-Disposition", "attachment;filename=" + encodedFilename);
		
		//Excel File Output
		ServletOutputStream output = response.getOutputStream();
		output.flush();
		wb.write(output);
		output.flush();
		output.close();
		wb.close();		
		
	}
	
	public void mimicExcelDownload(HttpServletRequest request, HttpServletResponse response, List<String> lblDataList,
			List<ComTagDccInfo> tagDccInfoList, String searchTime, String type) throws Exception{
		
		Workbook wb = new XSSFWorkbook();
		Sheet sheet = wb.createSheet("첫번째 시트");
		Row row = null;
		Cell cell = null;
		int rowNum = 0;
		int size = 0;
		String fileName = new SimpleDateFormat("yyMM").format(new Date())+".xlsx";
		String prefix = "";
		String title = "";
		
		switch( type ) {
			case "lzc_1":
				prefix = "lzci_";
				title = "Liquid Zone Control System";
				size = 14;
				break;
			case "lzc_2":
				prefix = "lzcii_";
				title = "Liquid Zone Control System(3단계)";
				size = 42;
				break;
			
		}
		
		fileName = prefix+fileName;
		
		// Set Title
		row = sheet.createRow(rowNum++);
		cell = row.createCell(0);
		cell.setCellValue(title);
		// Set empty row
		row = sheet.createRow(rowNum++);
		// Set lblDate
		row = sheet.createRow(rowNum++);
		cell = row.createCell(0);
		cell.setCellValue(searchTime);
		// Set empty row
		row = sheet.createRow(rowNum++);

		
		for( int lli=0;lli<lblDataList.size();lli++ ) {
			for( int lii=0;lii<size;lii++ ) {
			row = sheet.createRow(rowNum++);
			cell = row.createCell(0);
			cell.setCellValue(lii+1);
			cell = row.createCell(1);
			cell.setCellValue(tagDccInfoList.get(lii).getDataLoop());
			cell = row.createCell(2);
			cell.setCellValue(lblDataList.get(lli));
			cell = row.createCell(3);
			cell.setCellValue(tagDccInfoList.get(lii).getUnit());
			cell = row.createCell(4);
			cell.setCellValue(tagDccInfoList.get(lii).getIOTYPE());
			cell = row.createCell(5);
			cell.setCellValue(tagDccInfoList.get(lii).getADDRESS());
			cell = row.createCell(6);
			cell.setCellValue(tagDccInfoList.get(lii).getIOBIT());
			}
		}
		
		String browser = WebUtil.getBrowser(request);
		String encodedFilename = WebUtil.webEncoding(browser, fileName);
		
		response.setContentType("application/vnd.ms-excel");
		response.setHeader("Content-Disposition", "attachment;filename=" + encodedFilename);
		
		//Excel File Output
		ServletOutputStream output = response.getOutputStream();
		output.flush();
		wb.write(output);
		output.flush();
		output.close();
		wb.close();		
		
	}
	
	public void alarmExcelDownload(HttpServletRequest request, HttpServletResponse response, String prefix, String title,
			List<DccAlarmInfo> dccAlarmInfoList, String type) throws Exception{
	
		Workbook wb = new XSSFWorkbook();
		Sheet sheet = wb.createSheet("첫번째 시트");
		Row row = null;
		Cell cell = null;
		int rowNum = 0;
		String fileName = prefix.toUpperCase();
		String suffix = "";
		
		// Set Title
		row = sheet.createRow(rowNum++);
		cell = row.createCell(0);
		cell.setCellValue(title);
		// Set empty row
		row = sheet.createRow(rowNum++);
		
		switch( type ) {
			case "alarm":
				suffix = "_ALARM.xlsx";
				
				for( int lli=0;lli<dccAlarmInfoList.size();lli++ ) {
					row = sheet.createRow(rowNum++);
					cell = row.createCell(0);
					cell.setCellValue(dccAlarmInfoList.get(lli).getAlmGubun());
					cell = row.createCell(1);
					cell.setCellValue(dccAlarmInfoList.get(lli).getAlmDate());
					cell = row.createCell(2);
					cell.setCellValue(dccAlarmInfoList.get(lli).getAlmCode());
					cell = row.createCell(3);
					cell.setCellValue(dccAlarmInfoList.get(lli).getAlmAddress());
					cell = row.createCell(4);
					cell.setCellValue(dccAlarmInfoList.get(lli).getAlmMesg());
				}
				break;
			case "alarmsearch":
				suffix = "_ALARM.xlsx";
				
				// Header
		        row = sheet.createRow(rowNum++);
		        cell = row.createCell(0);
		        cell.setCellValue("A/N");
		        cell = row.createCell(1);
		        cell.setCellValue("경보일자");
		        cell = row.createCell(2);
		        cell.setCellValue("경보명");
		        cell = row.createCell(3);
		        cell.setCellValue("경보내역");
		        
		        for( int lli=0;lli<dccAlarmInfoList.size();lli++ ) {
					row = sheet.createRow(rowNum++);
					cell = row.createCell(0);
					cell.setCellValue(dccAlarmInfoList.get(lli).getAlmGubun());
					cell = row.createCell(1);
					if( dccAlarmInfoList.get(lli).getAlmMsecchk().equals("0") ) {
						cell.setCellValue(dccAlarmInfoList.get(lli).getAlmDate());
					} else {
						cell.setCellValue(dccAlarmInfoList.get(lli).getAlmDate()+".000");
					}
					cell = row.createCell(2);
					cell.setCellValue(dccAlarmInfoList.get(lli).getAlmCode()+dccAlarmInfoList.get(lli).getAlmAddress());
					cell = row.createCell(3);
					cell.setCellValue(dccAlarmInfoList.get(lli).getAlmMesg());
				}
				break;
			case "stb":
				//suffix = "stb_";
				break;
		}
		fileName = fileName+suffix;
		
		String browser = WebUtil.getBrowser(request);
		String encodedFilename = WebUtil.webEncoding(browser, fileName);
		
		response.setContentType("application/vnd.ms-excel");
		response.setHeader("Content-Disposition", "attachment;filename=" + encodedFilename);
		
		//Excel File Output
		ServletOutputStream output = response.getOutputStream();
		output.flush();
		wb.write(output);
		output.flush();
		output.close();
		wb.close();
		
	}
	
	public void alarmEWExcelDownload(HttpServletRequest request, HttpServletResponse response, String prefix, String title,
			List<Map> dccTagInfoList, String type) throws Exception{
	
		Workbook wb = new XSSFWorkbook();
		Sheet sheet = wb.createSheet("User Alarm");
		Row row = null;
		Cell cell = null;
		int rowNum = 0;
		String fileName = prefix+"_";
		String suffix = "";
		
		// Set Title
		row = sheet.createRow(rowNum++);
		cell = row.createCell(0);
		cell.setCellValue(title);
		// Set empty row
		row = sheet.createRow(rowNum++);
		// Set lblDate
		row = sheet.createRow(rowNum++);
		cell = row.createCell(0);
		cell.setCellValue(dccTagInfoList.size() > 0 ? dccTagInfoList.get(0).get("SCANTIME").toString() : "");
		// Set empty row
		row = sheet.createRow(rowNum++);
		
		switch( type ) {
			case "earlywarning":
				suffix = new SimpleDateFormat("MM_dd").format(new Date())+".xlsx";
		        
		        int idx=0;
		        for( Map dccTagInfo : dccTagInfoList ) {
		        	row = sheet.createRow(rowNum++);
					cell = row.createCell(0);
					cell.setCellValue(idx+1);
					cell = row.createCell(1);
					cell.setCellValue(dccTagInfo.get("DataLoop").toString());
					cell = row.createCell(2);
					cell.setCellValue(dccTagInfo.get("Value").toString());
					cell = row.createCell(3);
					cell.setCellValue(dccTagInfo.get("Unit").toString());
					cell = row.createCell(4);
					cell.setCellValue(dccTagInfo.get("IOTYPE").toString());
					cell = row.createCell(5);
					cell.setCellValue(dccTagInfo.get("ADDRESS").toString());
					cell = row.createCell(6);
					cell.setCellValue(dccTagInfo.get("IoBit").toString());
					
					idx++;
				}
		        break;
		}
		fileName = fileName+suffix;
		
		String browser = WebUtil.getBrowser(request);
		String encodedFilename = WebUtil.webEncoding(browser, fileName);
		
		response.setContentType("application/vnd.ms-excel");
		response.setHeader("Content-Disposition", "attachment;filename=" + encodedFilename);
		
		//Excel File Output
		ServletOutputStream output = response.getOutputStream();
		output.flush();
		wb.write(output);
		output.flush();
		output.close();
		wb.close();
		
	}
	
	public void alarmFTCExcelDownload(HttpServletRequest request, HttpServletResponse response, String prefix, String title,
									String startDate, String endDate, List<Map> fixedAlarmList,
									String[] lblTitles, String[] lblLoops, String[] lblCIs, String type) throws Exception{
	
		Workbook wb = new XSSFWorkbook();
		Sheet sheet = wb.createSheet("ALARMTEST");
		Row row = null;
		Cell cell = null;
		int rowNum = 0;
		String fileName = prefix+"_";
		String suffix = new SimpleDateFormat("MM_dd").format(new Date())+".xlsx";
		
		// Set Title
		row = sheet.createRow(rowNum++);
		cell = row.createCell(0);
		cell.setCellValue(title);
		// Set empty row
		row = sheet.createRow(rowNum++);
		// Set lblDate
		row = sheet.createRow(rowNum++);
		cell = row.createCell(0);
		cell.setCellValue(startDate+" ~ "+endDate);
		// Set empty row
		row = sheet.createRow(rowNum++);
		
		if( fixedAlarmList.get(0).size() > 0 ) {
			switch( type ) {
				case "003":
			        for( int idx=0;idx<fixedAlarmList.get(0).size();idx++ ) {
			        	row = sheet.createRow(rowNum++);
						cell = row.createCell(0);
						if( idx%6 == 0 ) {
							cell.setCellValue(lblTitles[idx/6]);
						} else {
							cell.setCellValue("");
						}
						cell = row.createCell(1);
						cell.setCellValue(lblCIs[idx]);
						cell = row.createCell(2);
						cell.setCellValue(fixedAlarmList.get(0).get(idx).toString());
						cell = row.createCell(3);
						cell.setCellValue(fixedAlarmList.get(1).get(idx).toString());
						cell = row.createCell(4);
						cell.setCellValue(fixedAlarmList.get(2).get(idx).toString());
					}
			        break;
				case "032":
					for( int idx=0;idx<fixedAlarmList.get(0).size();idx++ ) {
			        	row = sheet.createRow(rowNum++);
						cell = row.createCell(0);
						if( idx%4 == 0 ) {
							cell.setCellValue(lblTitles[idx/4]);
						} else {
							cell.setCellValue("");
						}
						cell = row.createCell(1);
						cell.setCellValue(lblCIs[idx]);
						cell = row.createCell(2);
						cell.setCellValue(fixedAlarmList.get(0).get(idx).toString());
						cell = row.createCell(3);
						cell.setCellValue(fixedAlarmList.get(1).get(idx).toString());
						cell = row.createCell(4);
						cell.setCellValue(fixedAlarmList.get(2).get(idx).toString());
					}
			        break;
				case "114":
			        for( int idx=0;idx<fixedAlarmList.get(0).size();idx++ ) {
			        	row = sheet.createRow(rowNum++);
						cell = row.createCell(0);
						if( idx%3 == 0 ) {
							cell.setCellValue(lblTitles[idx/3]);
						} else {
							cell.setCellValue("");
						}
						cell = row.createCell(1);
						cell.setCellValue(lblCIs[idx]);
						cell = row.createCell(2);
						cell.setCellValue(fixedAlarmList.get(0).get(idx).toString());
						cell = row.createCell(3);
						cell.setCellValue(fixedAlarmList.get(1).get(idx).toString());
						cell = row.createCell(4);
						cell.setCellValue(fixedAlarmList.get(2).get(idx).toString());
					}
			        break;
				case "118":
			        for( int idx=0;idx<fixedAlarmList.get(0).size();idx++ ) {
			        	row = sheet.createRow(rowNum++);
						cell = row.createCell(0);
						cell.setCellValue(lblTitles[idx]);
						cell = row.createCell(1);
						cell.setCellValue(lblCIs[idx]);
						cell = row.createCell(2);
						cell.setCellValue(fixedAlarmList.get(0).get(idx).toString());
						cell = row.createCell(3);
						cell.setCellValue(fixedAlarmList.get(1).get(idx).toString());
					}
			        break;
				case "276":
			        for( int idx=0;idx<fixedAlarmList.get(0).size();idx++ ) {
			        	row = sheet.createRow(rowNum++);
						cell = row.createCell(0);
						if( idx%2 == 0 ) {
							cell.setCellValue(lblTitles[idx/2]);
						} else {
							cell.setCellValue("");
						}
						cell = row.createCell(1);
						cell.setCellValue(lblCIs[idx]);
						cell = row.createCell(2);
						cell.setCellValue(fixedAlarmList.get(0).get(idx).toString());
						cell = row.createCell(3);
						cell.setCellValue(fixedAlarmList.get(1).get(idx).toString());
						cell = row.createCell(4);
						cell.setCellValue(fixedAlarmList.get(2).get(idx).toString());
					}
			        break;
				case "cor":
			        for( int idx=0;idx<fixedAlarmList.get(0).size();idx++ ) {
			        	row = sheet.createRow(rowNum++);
						cell = row.createCell(0);
						if( idx%8 == 0 ) {
							cell.setCellValue(lblTitles[idx/8]);
						} else {
							cell.setCellValue("");
						}
						cell = row.createCell(1);
						if( idx%2 == 0 ) {
							cell.setCellValue(lblLoops[idx/2].split("\\|")[0]);
						} else {
							cell.setCellValue("");
						}
						cell = row.createCell(2);
						cell.setCellValue(lblCIs[idx]);
						cell = row.createCell(3);
						cell.setCellValue(fixedAlarmList.get(0).get(idx).toString());
						cell = row.createCell(4);
						cell.setCellValue(fixedAlarmList.get(1).get(idx).toString());
						cell = row.createCell(5);
						cell.setCellValue(fixedAlarmList.get(2).get(idx).toString());
						if( idx%2 == 1 ) {
							row = sheet.createRow(rowNum++);
							cell = row.createCell(0);
							cell.setCellValue("");
							cell = row.createCell(1);
							cell.setCellValue("");
							cell = row.createCell(2);
							cell.setCellValue("");
							cell = row.createCell(3);
							cell.setCellValue(lblLoops[idx/2].split("\\|")[1]);
							cell = row.createCell(4);
							cell.setCellValue("");
							cell = row.createCell(5);
							cell.setCellValue(fixedAlarmList.get(3).get(idx/2).toString());
						}
					}
			        break;
			}
		}
		fileName = fileName+suffix;
		
		String browser = WebUtil.getBrowser(request);
		String encodedFilename = WebUtil.webEncoding(browser, fileName);
		
		response.setContentType("application/vnd.ms-excel");
		response.setHeader("Content-Disposition", "attachment;filename=" + encodedFilename);
		
		//Excel File Output
		ServletOutputStream output = response.getOutputStream();
		output.flush();
		wb.write(output);
		output.flush();
		output.close();
		wb.close();
		
	}

	public void alarmTFExcelDownload(HttpServletRequest request, HttpServletResponse response, String prefix,
			List<Map> LblInfoList, List<Map> arrTrendData) throws Exception{

		Workbook wb = new XSSFWorkbook();
		Sheet sheet = wb.createSheet("Trend_Fixed");
		Row row = null;
		Cell cell = null;
		int rowNum = 0;
		String fileName = prefix;
		String suffix = new SimpleDateFormat("MM_dd").format(new Date())+".xlsx";
		
		// Set Title
		row = sheet.createRow(rowNum++);
		cell = row.createCell(0);
		cell.setCellValue("시 간");
		cell = row.createCell(0);
		for( int l=1;l<LblInfoList.size()+1;l++ ) {
			cell.setCellValue(LblInfoList.get(l).toString());
		}
		
		if( arrTrendData.size() > 0 ) {
			for( int idx=0;idx<arrTrendData.size();idx++ ) {
				row = sheet.createRow(rowNum++);
				cell = row.createCell(0);
				cell.setCellValue(arrTrendData.get(idx).get("m_time").toString());
				for( int li=1;li<LblInfoList.size()+1;li++ ) {
					cell = row.createCell(li);
					cell.setCellValue(((Map) arrTrendData.get(li).get("m_data")).get(idx).toString());
				}
			}
		}
		fileName = fileName+suffix;
		
		String browser = WebUtil.getBrowser(request);
		String encodedFilename = WebUtil.webEncoding(browser, fileName);
		
		response.setContentType("application/vnd.ms-excel");
		response.setHeader("Content-Disposition", "attachment;filename=" + encodedFilename);
		
		//Excel File Output
		ServletOutputStream output = response.getOutputStream();
		output.flush();
		wb.write(output);
		output.flush();
		output.close();
		wb.close();
		
		}
}
