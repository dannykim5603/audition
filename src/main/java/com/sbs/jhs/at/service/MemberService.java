package com.sbs.jhs.at.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbs.jhs.at.dao.MemberDao;
import com.sbs.jhs.at.dto.Member;

@Service
public class MemberService {
	@Autowired
	private MemberDao memberDao;
	

	public int join(Map<String, Object> param) {
		return memberDao.join(param);
	}

	public int login(Map<String, Object> param) {
		int loginedMemberId = memberDao.login(param);
		return loginedMemberId;
	}

	public Member getMemberById(int id) {
		return memberDao.getMemberById(id);
	}
	
}
