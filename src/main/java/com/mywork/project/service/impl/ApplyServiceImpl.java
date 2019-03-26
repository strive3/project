package com.mywork.project.service.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import com.mywork.project.dao.*;
import com.mywork.project.domain.Apply;
import com.mywork.project.domain.Config;
import com.mywork.project.domain.PageBean;
import com.mywork.project.service.ApplyService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mywork.project.dao.ApplyDao;

@Service
public class ApplyServiceImpl implements ApplyService {
	
	/**
	 * 这里需要写多个@Resource注解，因为一个注解只对应一个变量
	 */
	@Resource(name="applyDao")
	private ApplyDao applyDao;
	
	@Resource(name="review1Dao")
	private Review1Dao review1Dao;
	
	@Resource(name="itemTypeDao")
	private ItemTypeDao itemTypeDao;
	
	@Resource(name="configDao")
	private ConfigDao configDao;

	@Override
	public Map<String, Object> listApply(Apply apply, String str, int currentPage, int pageSize) {
		//定义分页PageBean
		PageBean pageBean = new PageBean(currentPage, pageSize);
		//总记录数
		Long total = applyDao.count(apply, str);
System.out.println("total:  "+total);
		//得到查询出来的数据
		List<Map<String, Object>> list = applyDao.listApply(apply, str, pageBean.getStart(), pageBean.getPageSize());
		try {
			if(list.size() == 0) {
				throw new RuntimeException("未查询到相关数据");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("total", total);
		map.put("rows", list);
		return map;
	}

	@Override
	@Transactional
	public void updateApply(Apply apply) {
		int length = apply.getItem_description().length();
//		System.out.println("长度：" + length);
		if(length >= 1024) {		//长度限制约400
			throw new RuntimeException("项目描述已超字数限制，请重新操作！");
		}
		int i = applyDao.updateApply(apply);
		if(i == 0) {
			throw new RuntimeException("更新项目申报书失败，请重新操作！");
		}
	}

	@Override
	@Transactional
	public void addApply(Apply apply) {
		int length = apply.getItem_description().length();
//		System.out.println("长度：" + length);
		if(length >= 1024) {		//长度限制约400
			throw new RuntimeException("项目描述已超字数限制，请重新操作！");
		}
		if("2".equals(apply.getItem_submit())) {
			Date apply_time = new Date();
			apply.setApply_time(apply_time);
		}
		//手动将history_flag设置为“1”,表示该项目为当前正在申报
		apply.setHistory_flag("1");
		int i = applyDao.addApply(apply);
		if(i != 0) {
			if("2".equals(apply.getItem_submit())) {

				int item_id = apply.getItem_id();
				int j = review1Dao.addReview1(item_id);

				String item_status = "1";
				int k = applyDao.changeStatus(item_id, item_status);
				if(j == 0 || k == 0) {
					throw new RuntimeException("添加到系部审核列表失败，请重新操作！");
				}
				int m = itemTypeDao.addCount(item_id);
				if(m == 0) {
					throw new RuntimeException("更新项目数量失败，请重新操作！");
				}
			}
		} else {
			throw new RuntimeException("新增申报项目失败，请重新操作！");
		}
	}

	@Override
	@Transactional
	public void deleteApplyById(Integer item_id) {
		int i = applyDao.deleteApplyById(item_id);
		if(i == 0) {
			throw new RuntimeException("删除项目申请失败，请重新操作！");
		}
	}

	@Override
	@Transactional
	public void deleteApplyBatchs(String idsStr) {
		String[] idArray = idsStr.split(",");
		Integer[] ids = new Integer[idArray.length];
		for (int i = 0; i < idArray.length; i++) {
			ids[i] = Integer.parseInt(idArray[i]);
		}
		int i = applyDao.deleteApplyBatchs(ids);
		if(i == 0) {
			throw new RuntimeException("批量删除项目申请失败，请重新操作！");
		}
	}

	@Override
	@Transactional
	public void submitApply(Integer item_id, String item_submit) {
		String config_flag = configDao.getConfigStatus();
		if("1".equals(config_flag)) {
			int i = applyDao.submitApply(item_id, item_submit);
			if(i != 0) {
				int j = review1Dao.addReview1(item_id);
				String item_status = "1";
				int k = applyDao.changeStatus(item_id, item_status);
				if(j == 0 || k == 0) {
					throw new RuntimeException("添加到系部审核列表失败，请重新操作！");
				}
				int m = itemTypeDao.addCount(item_id);
				if(m == 0) {
					throw new RuntimeException("更新项目数量失败，请重新操作！");
				}
			} 
		} else {
			throw new RuntimeException("提交项目申报书失败，请重新操作！");
		}
	}

	@Override
	@Transactional
	public void submitApplyBatchs(String idsStr, String item_submit) {
		String[] idArray = idsStr.split(",");
		Integer[] ids = new Integer[idArray.length];
		for (int i = 0; i < idArray.length; i++) {
			ids[i] = Integer.parseInt(idArray[i]);
		}
		String config_flag = configDao.getConfigStatus();
		if("1".equals(config_flag)) {
			int i = applyDao.submitApplyBatchs(ids, item_submit);
			if(i != 0) {
				int j = review1Dao.addReview1Batchs(ids);
				String item_status = "1";
				for (Integer item_id : ids) {
					applyDao.changeStatus(item_id, item_status);
				}
				if(j == 0) {
					throw new RuntimeException("批量添加到系部审核列表失败，请重新操作！");
				}
				int k = itemTypeDao.addCountBatchs(ids);
				if(k == 0) {
					throw new RuntimeException("批量更新项目数量失败，请重新操作！");
				}
			} 
		} else {
			throw new RuntimeException("批量提交申报书失败，请重新操作！");
		}
	}

	@Override
	@Transactional
	public void setHistory() {
		List<Config> list = configDao.show();
		if(list != null) {
			String config_flag = list.get(0).getConfig_flag();
			if("5".equals(config_flag)) {	//注意config_flag为String引用类型，config_flag的值为5，但config_flag不等于“5”
				int i = applyDao.setHistory();
				if(i == 0) {
					throw new RuntimeException("项目标记为历史记录失败，请重新操作！");
				}
			}
		}
	}

	@Override
	public void reUploadPath(Integer item_id, String path) {
		int i = applyDao.reUploadPath(item_id, path);
		if(i == 0) {
			throw new RuntimeException("上传申报书失败，请重新操作！");
		}
	}

}
