package com.mywork.project.service;

import com.mywork.project.domain.Apply;
import com.mywork.project.domain.Review2;
import com.mywork.project.domain.User;

import java.util.Map;

public interface Review2Service {
	
	/**
	 * 显示专家评审列表
	 *
	 *  当 review2 为null的时候 查询的是 分配情况
	 */
	public Map<String, Object> listReview2(Review2 review2, Apply apply, User user, String str, int currentPage, int pageSize);

	/**
	 * 新增专家评审项目
	 * @param item_id
	 * @param review2_user
	 */
	public void addReview2(Integer item_id, String review2_user);

	/**
	 * 更新专家评审项目信息
	 * @param review2
	 */
	public void updateReview2(Review2 review2);

}
