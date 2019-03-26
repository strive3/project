package com.mywork.project.dao;

import java.util.List;
import java.util.Map;

import com.mywork.project.domain.Apply;
import org.apache.ibatis.annotations.Param;


public interface ApplyDao {
	
	/**
	 * 显示所有申报项目
	 * @param apply
	 * @param str
	 * @param start
	 * @param pageSize
	 * @return
	 */
	public List<Map<String, Object>> listApply(@Param("apply") Apply apply, @Param("str")String str, @Param("start")int start, @Param("pageSize")int pageSize);
	
	/**
	 * 申报项目总数
	 * @param apply
	 * @param str
	 * @return
	 */
	public Long count(@Param("apply")Apply apply, @Param("str")String str);

	/**
	 * 更新项目信息
	 * @param apply
	 * @return
	 */
	public int updateApply(Apply apply);

	/**
	 * 新增申报信息
	 * @param apply
	 * @return
	 */
	public int addApply(Apply apply);

	/**
	 * 根据id删除申报信息
	 * @param item_id
	 * @return
	 */
	public int deleteApplyById(Integer item_id);

	/**
	 * 批量删除
	 * @param ids
	 * @return
	 */
	public int deleteApplyBatchs(Integer[] ids);

	/**
	 * 更改提交状态（未提交->已提交）
	 * @param item_id
	 * @param item_submit
	 * @return
	 */
	public int submitApply(@Param("item_id")Integer item_id, @Param("item_submit")String item_submit);

	/**
	 * 批量提交
	 * @param ids
	 * @param item_submit
	 * @return
	 */
	public int submitApplyBatchs(@Param("array")Integer[] array, @Param("item_submit")String item_submit);

	/**
	 * 更新项目状态
	 * @param item_id
	 * @return
	 */
	public int changeStatus(@Param("item_id")Integer item_id, @Param("item_status")String item_status);

	/**
	 * 设置时间标志
	 * 将项目设置为  历史申报记录
	 * @return
	 */
	public int setHistory();

	/**
	 * （重新）上传项目申报书
	 * @param path 
	 * @param item_id 
	 */
	public int reUploadPath(@Param("item_id")Integer item_id, @Param("path")String path);

}
