package com.sbs.jhs.at.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sbs.jhs.at.dto.Article;
import com.sbs.jhs.at.dto.ArticleReply;
import com.sbs.jhs.at.dto.ResultData;
import com.sbs.jhs.at.service.ArticleService;

@Controller
public class ArticleController {
	@Autowired
	private ArticleService articleService;
	
	@RequestMapping("/usr/article/list")
	public String showList(Model model) {
		List<Article> list = articleService.getList();
		int totalCount = articleService.getTotalCount();
		model.addAttribute("list", list);
		model.addAttribute("totalCount", totalCount);
		return "article/list";
	}
	
	@RequestMapping("/usr/article/detail")
	public String detail(Model model,int id) {
		articleService.increaseHit(id);
		Article article = articleService.detail(id);
		List<ArticleReply> articleReplies = articleService.getArticleReplyByArticleId(id);
		int totalCount = articleService.getTotalCount();
		model.addAttribute("totlaCount",totalCount);
		model.addAttribute("article",article);
		model.addAttribute("articleReply",articleReplies);
		return "article/detail";
	}
	
	@RequestMapping("/usr/article/write")
	public String write() {
		return "article/write";
	}
	
	@RequestMapping("/usr/article/doWrite")
	public String doWrite(@RequestParam Map<String,Object> param) {
		articleService.write(param);
		return "redirect:/article/list";
	}
	
	@RequestMapping("/usr/article/modify")
	public String modify(Model model,int id) {
		Article article = articleService.detail(id);
		model.addAttribute("article",article);
		return "article/modify";
	}
	
	@RequestMapping("/usr/article/doModify")
	public String doModify(Model model,@RequestParam Map<String,Object> param) {
		int id = Integer.parseInt((String)param.get("id"));
		String title = (String)param.get("title");
		Article article = articleService.detail(id);
		String titleOri = article.getTitle();
		if (title.trim() == "") {
			param.put("title", titleOri);
		}
		articleService.modify(param);
		return "redirect:/article/list";
	}
	
	@RequestMapping("/usr/article/delete")
	public String delete(long id) {
		articleService.delete(id);
		return "redirect:/article/list";
	}
	
	@RequestMapping("/usr/article/writeReply")
	public String writeReply(Model model,@RequestParam Map<String,Object> param) {
		
		return "redirect:/article/list";
	}
	
	@RequestMapping("/usr/article/doWriteReplyAjax")
	@ResponseBody
	public ResultData doWriteReplyAjax(@RequestParam Map<String, Object> param, HttpServletRequest request) {
		Map<String, Object> rsDataBody = new HashMap<>();
		param.put("memberId", request.getAttribute("loginedMemberId"));
		int newArticleReplyId = articleService.writeReply(param);
		rsDataBody.put("articleReplyId", newArticleReplyId);

		return new ResultData("S-1", String.format("%d번 댓글이 생성되었습니다.", newArticleReplyId), rsDataBody);
	}

	@RequestMapping("/usr/article/getForPrintArticleReplies")
	@ResponseBody
	public ResultData getForPrintArticleReplies(@RequestParam Map<String, Object> param) {
		Map<String, Object> rsDataBody = new HashMap<>();
		
		List<ArticleReply> articleReplies = articleService.getForPrintArticleReplies(param);
		rsDataBody.put("articleReplies", articleReplies);

		return new ResultData("S-1", String.format("%d개의 댓글을 불러왔습니다.", articleReplies.size()), rsDataBody);
	}
	
	@RequestMapping("/usr/article/doDeleteReplyAjax")
	@ResponseBody
	public ResultData doDeleteReplyAjax(int id) {
		articleService.deleteReply(id);
		
		return new ResultData("S-1", String.format("%d번 댓글을 삭제하였습니다.", id));
	}
}
