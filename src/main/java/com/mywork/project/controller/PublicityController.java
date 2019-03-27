package com.mywork.project.controller;

import java.util.Map;

import javax.annotation.Resource;

import com.mywork.project.domain.Apply;
import com.mywork.project.domain.Publicity;
import com.mywork.project.domain.User;
import com.mywork.project.service.PublicityService;
import com.mywork.project.util.JsonResult;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
@RequestMapping("/publicity")
public class PublicityController {
	
	@Resource
	private PublicityService publicityService;

	/**
	 * 分配评审专家
	 */
	@RequestMapping("/itemManager/assignExpert")
	public String assignExpert() {
		return "itemManager/assignExpert";
	}

	/**
	 * 查看分配情况   跳转到jsp页面
	 */
	@RequestMapping("/itemManager/assignResult")
	public String assignResult(){
		return "itemManager/assignResult";
	}

	/**
	 * 所有处理审批   调用的接口
	 */
	@RequestMapping("/itemManager/publicityManage")
	public String publicityManage(Model model, Apply apply,
			@RequestParam(value = "publicity_status", required = false) String publicity_status) {
		/**
		 * 传入的apply对象指history_flag字段，而传入的publicity_status可能为“1”(未审批状态)，也可能为“2,3”(已审批状态)
		 */
		model.addAttribute("publicity_status", publicity_status);
		model.addAttribute("apply", apply);
		return "itemManager/publicityManage";
	}
	
	@RequestMapping("/listPublicity")
	@ResponseBody
	public Map<String, Object> listPublicity(
			//page第几页，rows每页多少行
			@RequestParam(value = "page", required = false) String page,
			@RequestParam(value = "rows", required = false) String rows,
			@RequestParam(value = "publicity_status", required = false) String publicity_status,
			@RequestParam(value = "str", required = false) String str,
			Apply apply, User user) {
		
		if(publicity_status == null) {
			publicity_status ="";
		}
		
		int currentPage = Integer.parseInt(page);
		int pageSize = Integer.parseInt(rows);
		Map<String, Object> map = publicityService.listPublicity(publicity_status, apply, user, str, currentPage, pageSize);
		return map;
	}
	
	@RequestMapping("/addPublicity")
	@ResponseBody
	public JsonResult addPublicity(Integer item_id) {
		publicityService.addPublicity(item_id);
		return new JsonResult();
	}
	
	@RequestMapping("/updatePublicity")
	@ResponseBody
	public JsonResult updatePublicity(Publicity publicity) {
		//System.out.println(publicity);
		publicityService.updatePublicity(publicity);
		return new JsonResult();
	}

}
