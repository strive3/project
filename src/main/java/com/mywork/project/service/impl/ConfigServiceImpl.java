package com.mywork.project.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import com.mywork.project.dao.ApplyDao;
import com.mywork.project.dao.ConfigDao;
import com.mywork.project.domain.Config;
import com.mywork.project.service.ConfigService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


@Service
public class ConfigServiceImpl implements ConfigService {
	
	@Resource(name="configDao")
	private ConfigDao configDao;
	
	@Resource(name="applyDao")
	private ApplyDao applyDao;

	@Override
	@Transactional
	public void updateConfig(Config config) {
		int i = configDao.updateConfig(config);
		if(i == 0) {
			throw new RuntimeException("更新状态失败，请重新操作！");
		}
		if(config != null) {
			if("5".equals(config.getConfig_flag())) {
				//如果系统开关为5（结束了本次的工作）的话 调用这个方法
				//将所有的 item_status = 5 / 6 的 项目的history_flag  都设置为历史申报记录
				int j = applyDao.setHistory();
				if(j == 0) {
					throw new RuntimeException("设置时间标志失败，请重新操作！");
				}
			}
		}
	}

	@Override
	public Map<String, Object> show() {
		Long total = configDao.count();
		List<Config> list = configDao.show();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("total", total);
		map.put("rows", list);
		return map;
	}

	@Override
	public String getConfigStatus() {
		String config_flag = configDao.getConfigStatus();
		return config_flag;
	}

}
