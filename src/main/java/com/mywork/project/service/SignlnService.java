package com.mywork.project.service;
import com.mywork.project.domain.Signln;
import com.mywork.project.domain.User;

import java.util.List;

public interface SignlnService {
	
	/**
	 * 用户登录
	 * @param signln
	 * @return
	 */
	public Signln login(Signln signln);

	/**
	 * 显示所有登录账户
	 * @return
	 */
	public List<Signln> show();

	/**
	 * 通过用户名获取对应User对象
	 * @param user_name
	 * @return
	 */
	public User getUserByName(String user_name);

	/**
	 * 获得config_flag
	 * @return
	 */
	public String getConfigStatus();

}
