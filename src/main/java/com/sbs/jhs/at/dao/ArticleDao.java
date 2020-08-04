package com.sbs.jhs.at.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sbs.jhs.at.dto.Article;

@Mapper
public interface ArticleDao {
	
	List<Article> getList();

	Article detail(long id);

	int getTotalCount();

	long write(Map<String, Object> param);

	int modify(Map<String, Object> param);

	void delete(long id);
}
