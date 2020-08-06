package com.sbs.jhs.at.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sbs.jhs.at.dto.Member;

@Mapper
public interface MemberDao {

	int join(Map<String, Object> param);

	Member login(Map<String, Object> param);
	
}
