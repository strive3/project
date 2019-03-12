package com.mywork.project.dao;

import java.util.List;

import com.mywork.project.domain.ResourceModel;

public interface ResourceModelDao {
	
	public List<ResourceModel> listResourceModel();
	
	public Long count();
	
	public int addResourceModel(ResourceModel ResourceModel);


}
