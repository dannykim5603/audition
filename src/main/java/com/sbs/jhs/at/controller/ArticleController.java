package com.sbs.jhs.at.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sbs.jhs.at.dto.Article;
import com.sbs.jhs.at.dto.ArticleReply;
import com.sbs.jhs.at.service.ArticleService;

@Controller
public class ArticleController {
	@Autowired
	private ArticleService articleService;
	
	@RequestMapping("/article/list")
	public String showList(Model model) {
		List<Article> list = articleService.getList();
		int totalCount = articleService.getTotalCount();
		model.addAttribute("list", list);
		model.addAttribute("totalCount", totalCount);
		return "article/list";
	}
	
	@RequestMapping("/article/detail")
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
	
	@RequestMapping("/article/write")
	public String write() {
		return "article/write";
	}
	
	@RequestMapping("/article/doWrite")
	public String doWrite(@RequestParam Map<String,Object> param) {
		articleService.write(param);
		return "redirect:/article/list";
	}
	
	@RequestMapping("/article/modify")
	public String modify(Model model,int id) {
		Article article = articleService.detail(id);
		model.addAttribute("article",article);
		return "article/modify";
	}
	
	@RequestMapping("/article/doModify")
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
	
	@RequestMapping("/article/delete")
	public String delete(long id) {
		articleService.delete(id);
		return "redirect:/article/list";
	}
	
	@RequestMapping("/article/writeReply")
	public String writeReply(Model model,@RequestParam Map<String,Object> param) {
		
		return "redirect:/article/list";
	}
	
	
}
