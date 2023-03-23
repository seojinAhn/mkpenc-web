package com.mkpenc.common.module;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.RandomStringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.mkpenc.common.model.CommonConstant;
import com.mkpenc.common.model.Upload;

@Service
public class FileHelperUtil {
	
	private static Logger logger = LoggerFactory.getLogger(FileHelperUtil.class);
	
	@Autowired
    private CommonConstant commonConstant;	
	
	/*	다운로드	*/
	public boolean download(HttpServletRequest request, HttpServletResponse response, Upload upload, String contentType) throws Exception{
		boolean result = false;
		
		String path = getPath(upload);
		
		File dir = new File(commonConstant.getAttachPath(), path);
		File downFile = new File(dir, upload.getFileRealName());
		
		//File downFile = new File(upload.getFileRealName());

		if(!downFile.exists()){
			throw new FileNotFoundException();
		}

		ServletOutputStream outStream = null;
		FileInputStream inputStream = null;

		try {
			String browser = WebUtil.getBrowser(request);
			String encodedFilename = WebUtil.webEncoding(browser, upload.getFileRealName());

			outStream = response.getOutputStream();
			inputStream = new FileInputStream(downFile);

			response.setContentType("text/plain;charset=utf-8");
			response.setHeader("Content-Transfer-Encoding", "binary");
			response.addHeader("Content-disposition", "attachment;filename=\"" + encodedFilename + "\"");
			response.addHeader("Content-description", "EventAttendees");
			response.setContentLength((int)downFile.length());

			byte[] outByte = new byte[8192];
			while (inputStream.read(outByte, 0, 8192) != -1) {
				outStream.write(outByte, 0, 8192);
			}
			
			result = true;
			
        } catch (FileNotFoundException e){
            logger.info("File Not Found : {}, {}", new Object[] {path, upload.getFileRealName()});
        } catch (IOException e) {
            logger.info("Java IOException : {}, {}", new Object[] {path, upload.getFileRealName()});
        } finally {
			inputStream.close();
			outStream.flush();
			outStream.close();
		}

		return result;
	}
	
	public void upload(MultipartFile file, Upload upload) throws Exception {
		String path = getPath(upload);
		//String currentPath =  FileHelperUtil.createDateDir();

		//path = path + currentPath;

		logger.debug("### path : {}", path);
		
		upload.setFilePath(commonConstant.getAttachPath() + path);

		File dir = new File(commonConstant.getAttachPath(), path);
		//File upFile = new File(dir, FileHelperUtil.getTempFileName(file.getOriginalFilename()));
		File upFile = new File(dir, file.getOriginalFilename());

		if(!dir.exists()) {
			dir.mkdirs();
		}
		file.transferTo(upFile);

		//upload.setFilePath(currentPath);
		upload.setFileSaveName(upFile.getName());
		upload.setFileRealName(file.getOriginalFilename());
		upload.setFileSize(String.valueOf(file.getSize()));
		upload.setFileFullPath(dir.getAbsolutePath()+File.separator + file.getOriginalFilename());

	}

	private String getPath(Upload upload) {
		String path = "";
		switch (upload.getDiv()){
			case "ADMIN":
				path = File.separator + upload.getDiv();
				break;
			case "ALARM":
				path = File.separator + upload.getDiv();
				break;
		}

		return path;
	}
	
	public static String getTempFileName(String fileName){
		String tempFile = "";
		if(fileName.lastIndexOf(".") > 0){
			tempFile = fileName.substring(fileName.lastIndexOf(".") + 1);
		}

		return RandomStringUtils.randomAlphanumeric(15) + "." + tempFile;
	}

	
	
	public static String createDateDir(){
		LocalDate current = LocalDate.now();
		return DateTimeFormatter.ofPattern("yyyy/MM/dd").format(current);
	}
	
	public boolean writeTxtFile(String fileName, String[] contents, String div) {
		boolean rtv = false;
		String path = File.separator+div;
		
		try {
			File dir = new File(commonConstant.getAttachPath(), path);
			File file = new File(dir, fileName);
			
			if(!dir.exists()) {
				dir.mkdirs();
			}
			
			if( !file.exists() ) {
				file.createNewFile();
			}
			
			FileWriter fw = new FileWriter(file);
			BufferedWriter bw = new BufferedWriter(fw);
			
			for( String line : contents ) {
				bw.write(line);
				bw.newLine();
			}
			
			bw.close();
			
			if( file.exists() ) {
				rtv = true;
			} else {
				Thread.sleep(500);
			}
		} catch( Exception e ) {
			logger.error(e.toString());
		}
		
		return rtv;
	}
	
	public void deleteTxtFile(Upload upload, String fileName) {
		String path = getPath(upload);
		
		File dir = new File(commonConstant.getAttachPath(), path);
		File file = new File(dir, fileName);
		
		if( file.exists() ) {
			file.delete();
		}
	}

}
