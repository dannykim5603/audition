package com.sbs.jhs.at.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbs.jhs.at.dao.ArticleDao;
import com.sbs.jhs.at.dto.Article;
import com.sbs.jhs.at.dto.ArticleReply;

@Service
public class ArticleService {
	@Autowired
	private ArticleDao articleDao;
	
	
	public int getTotalCount() {
		return articleDao.getTotalCount();
	}
	
	public List<Article> getList(){
		return articleDao.getList();
	}

	public Article detail(long id) {
		return articleDao.detail(id);
	}

	public long write(Map<String, Object> param) {
		return articleDao.write(param);
	}

	public int modify(Map<String, Object> param) {
		return articleDao.modify(param);
	}

	public void delete(long id) {
		articleDao.delete(id);
	}

	public void increaseHit(int id) {
		articleDao.increaseHit(id);
	}

	public List<ArticleReply> getArticleReplyByArticleId(int id) {
		return articleDao.getArticleReplyByArticleId(id);
	}
}



