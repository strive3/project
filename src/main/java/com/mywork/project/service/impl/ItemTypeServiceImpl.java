package com.mywork.project.service.impl;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import com.mywork.project.dao.ItemTypeDao;
import com.mywork.project.domain.ItemType;
import com.mywork.project.domain.PageBean;
import com.mywork.project.service.ItemTypeService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


@Service
public class ItemTypeServiceImpl implements ItemTypeService {
	
	@Resource
	private ItemTypeDao itemTypeDao;
	
	@Override
	public List<ItemType> list() {
		List<ItemType> list = itemTypeDao.list();
		return list;
	}

	@Override
	public Map<String, Object> listItemType(String itemType_name, int currentPage, int pageSize) {
		//定义分页pageBean
		PageBean pageBean = new PageBean(currentPage, pageSize);
		//得到总记录数
		Long total = itemTypeDao.count(itemType_name);
		//得到该用户类型下的所有数据
		List<ItemType> list = itemTypeDao.listItemType(itemType_name, pageBean.getStart(), pageBean.getPageSize());
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
	public void updateItemType(ItemType itemType) {
		int i = itemTypeDao.updateItemType(itemType);
		if(i == 0) {
			throw new RuntimeException("更新分类信息失败，请重新操作！");
		}
	}

	@Override
	@Transactional
	public void addItemType(ItemType itemType) {
		int i = itemTypeDao.addItemType(itemType);
		if(i == 0) {
			throw new RuntimeException("新增分类失败，请重新操作！");
		}
	}

	@Override
	@Transactional
	public void deleteItemType(Integer itemType_id) {
		int i = itemTypeDao.deleteItemType(itemType_id);
		if(i == 0) {
			throw new RuntimeException("项目类型删除失败，请重新操作！");
		}
	}

	@Override
	@Transactional
	public void deleteItemTypeBatchs(String idsStr) {
		String[] idArray = idsStr.split(",");
		Integer[] ids = new Integer[idArray.length];
		for (int i = 0; i < idArray.length; i++) {
			ids[i] = Integer.parseInt(idArray[i]);
		}
		int i = itemTypeDao.deleteItemTypeBatchs(ids);
		if(i == 0) {
			throw new RuntimeException("批量删除分类失败，请重新操作！");
		}
	}

	@Override
	@Transactional
	public void addCount(Integer item_id) {
		int i = itemTypeDao.addCount(item_id);
		if(i == 0) {
			throw new RuntimeException("更新项目数量失败，请重新操作！");
		}
	}

	@Override
	@Transactional
	public void addCountBatchs(String idsStr) {
		String[] idArray = idsStr.split(",");
		Integer[] ids = new Integer[idArray.length];
		for (int i = 0; i < idArray.length; i++) {
			ids[i] = Integer.parseInt(idArray[i]);
		}
		int i = itemTypeDao.addCountBatchs(ids);
		if(i == 0) {
			throw new RuntimeException("批量更新项目数量失败，请重新操作！");
		}
		
	}

	

}
