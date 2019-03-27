package com.mywork.project.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import com.mywork.project.domain.ItemType;
import com.mywork.project.service.ItemTypeService;
import com.mywork.project.util.JsonResult;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/itemType")
public class ItemTypeController {
	
	@Resource
	private ItemTypeService itemTypeService;
	
	@RequestMapping("/list")
	@ResponseBody
	public List<ItemType> list(Model model) {
		List<ItemType> list = itemTypeService.list();
		model.addAttribute("itemType",list);
		return list;
	}
	
	//显示所有分类
	@RequestMapping("/listItemType")
	@ResponseBody
	public Map<String, Object> listItemType(
			//page第几页，rows每页多少行，itemType_name类型名称
			@RequestParam(value = "page", required = false) String page,
			@RequestParam(value = "rows", required = false) String rows,
			@RequestParam(value = "itemType_name", required = false) String itemType_name) {

		int currentPage = Integer.parseInt(page);
		int pageSize = Integer.parseInt(rows);
		Map<String, Object> map = itemTypeService.listItemType(itemType_name, currentPage, pageSize);
		return map;
	}
	
	//更新已有分类基本信息
	@RequestMapping("/updateItemType")
	@ResponseBody
	public JsonResult updateItemType(ItemType itemType) {
		itemTypeService.updateItemType(itemType);
		return new JsonResult();
	}
	
	//新增分类
	@RequestMapping("/addItemType")
	@ResponseBody
	public JsonResult addItemType(ItemType itemType) {
		itemTypeService.addItemType(itemType);
		return new JsonResult();
	}
	
	//删除分类
	@RequestMapping("/deleteItemType")
	@ResponseBody
	public JsonResult deleteItemType(Integer itemType_id) {
		itemTypeService.deleteItemType(itemType_id);
		return new JsonResult();
	}
	
	//批量删除分类
	@RequestMapping("/deleteItemTypeBatchs")
	@ResponseBody
	public JsonResult deleteItemTypeBatchs(String idsStr) {
		itemTypeService.deleteItemTypeBatchs(idsStr);
		return new JsonResult();
	}
	
	//更新该类型下的项目数量
	@RequestMapping("/addCount")
	@ResponseBody
	public JsonResult addCount(Integer item_id) {
		itemTypeService.addCount(item_id);
		return new JsonResult();
	}
	
	//批量更新该类型下的项目数量
	@RequestMapping("/addCountBatchs")
	@ResponseBody
	public JsonResult addCountBatchs(String idsStr) {
		itemTypeService.addCountBatchs(idsStr);
		return new JsonResult();
	}

}
