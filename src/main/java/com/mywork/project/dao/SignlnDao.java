package com.mywork.project.dao;

import com.mywork.project.domain.Signln;
import com.mywork.project.domain.User;

import java.util.List;


public interface SignlnDao {
	
	/**
	 * 用户登录
	 * @param signln
	 * @return
	 */
	public Signln login(Signln signln);

	/**
	 * 显示登录账户
	 * @return
	 */
	public List<Signln> show();

	/**
	 * 通过用户名获取对应的User对象
	 * @param user_name
	 * @return
	 */
	public User getUserByName(String user_name);

}
