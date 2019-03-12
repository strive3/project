package com.mywork.project.service;

import java.util.Map;

import com.mywork.project.domain.ResourceModel;

public interface ResourceModelService {
	
	public Map<String, Object> listResourceModel();

	public void addResourceModel(ResourceModel resourceModel);

}
