package com.sbs.jhs.at.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbs.jhs.at.dao.ArticleDao;
import com.sbs.jhs.at.dto.Article;
import com.sbs.jhs.at.dto.ArticleReply;
import com.sbs.jhs.at.dto.Member;
import com.sbs.jhs.at.dto.ResultData;
import com.sbs.jhs.at.util.Util;

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

	public int write(Map<String, Object> param) {
		articleDao.write(param);
		
		return Util.getAsInt(param.get("id"));
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

	public List<ArticleReply> getForPrintArticleReplies(Map<String, Object> param) {
List<ArticleReply> articleReplies = articleDao.getForPrintArticleReplies(param);
		
		Member actor = (Member)param.get("actor");
		
		for ( ArticleReply articleReply : articleReplies ) {
			// 출력용 부가데이터를 추가한다.
			updateForPrintInfo(actor, articleReply);
		}
		
		return articleReplies;
	}

	public void updateForPrintInfo(Member actor, ArticleReply articleReply) {
		articleReply.getExtra().put("actorCanDelete", actorCanDelete(actor, articleReply));
		articleReply.getExtra().put("actorCanModify", actorCanModify(actor, articleReply));
	}

	// 액터가 해당 댓글을 수정할 수 있는지 알려준다.
	public boolean actorCanModify(Member actor, ArticleReply articleReply) {
		return actor != null && actor.getId() == articleReply.getMemberId() ? true : false;
	}

	// 액터가 해당 댓글을 삭제할 수 있는지 알려준다.
	public boolean actorCanDelete(Member actor, ArticleReply articleReply) {
		return actorCanModify(actor, articleReply);
	}

	public int writeReply(Map<String, Object> param) {
		articleDao.writeReply(param);
		
		return Util.getAsInt(param.get("id"));
	}

	public void deleteReply(int id) {
		articleDao.deleteReply(id);
	}
	public ArticleReply getForPrintArticleReplyById(int id) {
		return articleDao.getForPrintArticleReplyById(id);
	}

	public ResultData modfiyReply(Map<String, Object> param) {
		articleDao.modifyReply(param);
		return new ResultData("S-1", String.format("%d번 댓글을 수정하였습니다.", Util.getAsInt(param.get("id"))), param);
	}
}



