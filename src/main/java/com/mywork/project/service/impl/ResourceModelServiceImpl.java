package com.mywork.project.service.impl;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import com.mywork.project.dao.ResourceModelDao;
import com.mywork.project.domain.ResourceModel;
import com.mywork.project.service.ResourceModelService;
import org.springframework.stereotype.Service;


@Service
public class ResourceModelServiceImpl implements ResourceModelService {
	
	@Resource
	private ResourceModelDao resourceModelDao;

	@Override
	public Map<String, Object> listResourceModel() {
		Long total = resourceModelDao.count();
		List<ResourceModel> list = resourceModelDao.listResourceModel();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("total", total);
		map.put("rows", list);
		return map;
	}

	@Override
	public void addResourceModel(ResourceModel resourceModel) {
		int i = resourceModelDao.addResourceModel(resourceModel);
		if(i == 0) {
			throw new RuntimeException("上传模板失败，请重新操作！");
		}

	}

}
