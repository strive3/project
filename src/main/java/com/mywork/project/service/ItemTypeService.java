package com.mywork.project.service;

import java.util.List;
import java.util.Map;

import com.mywork.project.domain.ItemType;

public interface ItemTypeService {
	
	public List<ItemType> list();
	
	public Map<String, Object> listItemType(String itemType_name, int currentPage, int pageSize);

	public void updateItemType(ItemType itemType);

	public void addItemType(ItemType itemType);

	public void deleteItemType(Integer itemType_id);

	public void deleteItemTypeBatchs(String idsStr);

	public void addCount(Integer item_id);

	public void addCountBatchs(String idsStr);


}
