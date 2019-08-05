package com.mywork.project.service;

import com.mywork.project.domain.Apply;
import com.mywork.project.domain.User;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.web.multipart.MultipartFile;

public interface ExcelService {

	public void importUserExcel(MultipartFile file);

	public XSSFWorkbook exportUserExcel(User user, String str, int currentPage,
			int pageSize) throws Exception;

	public XSSFWorkbook exportPublicityExcel(String publicity_status,
											 Apply apply, User user, String str, int currentPage, int pageSize)
			throws Exception;
}
