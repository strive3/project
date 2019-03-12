package com.mywork.project.dao;

import java.util.List;

import com.mywork.project.domain.Apply;
import com.mywork.project.domain.ItemVO;
import com.mywork.project.domain.User;
import org.apache.ibatis.annotations.Param;


public interface ExcelDao {
	
	public List<User> exportUserExcel(@Param("user")User user, @Param("str")String str, @Param("start")int start, @Param("pageSize")int pageSize);

	public int importUserExcel(User user);
	public int importSignlnExcel(User user);

	public List<ItemVO> exportPublicityExcel(@Param("status")String[] status, @Param("apply") Apply apply, @Param("user")User user, @Param("str")String str, @Param("start")int start, @Param("pageSize")int pageSize);


}
