package com.sbs.jhs.at.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sbs.jhs.at.service.MemberService;

@Controller
public class MemberController {
	@Autowired
	private MemberService memberService;
	
	@RequestMapping("/usr/member/join")
	public String join() {
		return "member/join";
	}

	@RequestMapping("/usr/member/doJoin")
	public String doJoin(@RequestParam Map<String,Object> param) {
		memberService.join(param);
		return "redirect:/home/main";
	}
	@RequestMapping("/usr/member/login")
	public String login() {
		return "member/login";
	}
	@RequestMapping("/usr/member/doLogin")
	public String doLogin(@RequestParam Map<String,Object> param) {
		int loginedMemberId = memberService.login(param).getId();
		
		if (loginedMemberId == -1) {
			return "html:<script> alert('아이디 혹은 비밀번호를 확인해 주세요'); location.replace('../home/main') </script>";
		}

		return "redirect:/home/main";
	}
}
