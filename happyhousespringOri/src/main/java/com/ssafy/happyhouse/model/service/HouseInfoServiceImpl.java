package com.ssafy.happyhouse.model.service;

import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.model.dao.HouseInfoDao;
import com.ssafy.happyhouse.model.dto.HouseInfo;
@Service
public class HouseInfoServiceImpl implements HouseInfoService {
	@Autowired
	private HouseInfoDao dao;

	@Override
	public List<HouseInfo> searchAllHouseInfo()  throws Exception {
		return dao.searchAllHouseInfo();
	}

	@Override
	public void addHouseInfo(HouseInfo h)  throws Exception {
		dao.addHouseInfo(h);
	}

	@Override
	public void updateHouseInfo(HouseInfo h)  throws Exception {
		dao.updateHouseInfo(h);
	}

	@Override
	public void deleteHouseInfo(int n)  throws Exception {
		dao.deleteHouseInfo(n);
	}

	@Override
	public HouseInfo searchHouseInfo(String[] list)  throws Exception {
		return dao.searchHouseInfo(list);
	}

}
