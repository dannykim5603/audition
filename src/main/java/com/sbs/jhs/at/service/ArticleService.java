package com.sbs.jhs.at.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbs.jhs.at.dao.ArticleDao;
import com.sbs.jhs.at.dto.Article;

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
}



