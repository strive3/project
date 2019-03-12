package com.mywork.project.controller;
import java.util.Map;

import javax.annotation.Resource;

import com.mywork.project.domain.ResourceModel;
import com.mywork.project.service.ResourceModelService;
import com.mywork.project.util.JsonResult;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/resourceModel")
public class ResourceModelController {
	
	@Resource
	private ResourceModelService resourceModelService;
	
	@RequestMapping("/resourceModel")
	public String configSwitch(String config_flag) {
		return "admin/model";
	}
	
	@RequestMapping("/listResourceModel")
	@ResponseBody
	public Map<String, Object> listResourceModel() {
		Map<String, Object> map = resourceModelService.listResourceModel();
		return map;
	}
	
	@RequestMapping("/addResourceModel")
	@ResponseBody
	public JsonResult addResourceModel(ResourceModel resourceModel) {
		resourceModelService.addResourceModel(resourceModel);
		return new JsonResult();
	}
	
}
