package com.sbs.jhs.at.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.sbs.jhs.at.dto.Member;

@Mapper
public interface MemberDao {

	int join(Map<String, Object> param);

	int login(Map<String, Object> param);

	Member getMemberById(@Param("id") int id);
	
}
