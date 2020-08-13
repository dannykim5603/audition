package com.sbs.jhs.at.dto;

import java.util.Map;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Getter
@Setter
public class Article {
	private int id;
	private String regDate;
	private String updateDate;
	private boolean delStatus;
	private String delDate;
	private boolean displayStatus;
	private int cateItemId;
	private String title;
	private String body;
	private int hit;
	private int memberId;
	private Map<String, Object> extra;
}
