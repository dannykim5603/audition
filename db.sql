# DB 세팅
DROP DATABASE IF EXISTS `at`;
CREATE DATABASE `at`;
USE `at`;

# article 테이블 세팅
CREATE TABLE article (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    delDate DATETIME NOT NULL,
	delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
	displayStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
    title CHAR(200) NOT NULL,
    `body` LONGTEXT NOT NULL
);

# article 테이블에 테스트 데이터 삽입
INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
title = '제목1',
`body` = '내용1';

INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
title = '제목2',
`body` = '내용2',
displayStatus = 1;

INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
title = '제목3',
`body` = '내용3',
displayStatus = 1;

SELECT * FROM article;

ALTER TABLE article ADD hit TINYINT(1) NOT NULL DEFAULT 0 AFTER BODY;

# article 테이블 세팅
CREATE TABLE articleReply (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME,
    updateDate DATETIME,
    memberId INT(10) UNSIGNED NOT NULL,
    articleId INT(10) UNSIGNED NOT NULL,
    delDate DATETIME,
	delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
	displayStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
    `body` LONGTEXT NOT NULL
);

SELECT * FROM articleReply;

SELECT * FROM cateItem;

ALTER TABLE articleReply ADD articleId TINYINT(1) NOT NULL AFTER id;

CREATE TABLE cateItem (
	id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
	regDate DATETIME NOT NULL,
	`name` CHAR(100) NOT NULL
);

INSERT INTO cateItem SET regDate = NOW(), `name` = '자유 게시판';
INSERT INTO cateItem SET regDate = NOW(), `name` = '공지 게시판';

ALTER TABLE article ADD cateItemId TINYINT(1) NOT NULL AFTER displayStatus;


CREATE TABLE MEMBER (
	id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
	regDate DATETIME NOT NULL,
	loginId CHAR(100) NOT NULL UNIQUE,
	email CHAR(200) NOT NULL,
	`name` CHAR(100) NOT NULL,
	nickname CHAR(100) NOT NULL,
	loginPw CHAR(200) NOT NULL
);
SELECT * FROM MEMBER;

ALTER TABLE articleReply ADD memberId INT(10) NOT NULL AFTER writer;
ALTER TABLE articleReply DROP COLUMN writer;


ALTER TABLE MEMBER ADD updateDate DATETIME AFTER regDate;
ALTER TABLE MEMBER ADD delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE MEMBER ADD authStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE MEMBER ADD phoneNo CHAR(20) NOT NULL DEFAULT 0;


# member 테이블 세팅
CREATE TABLE `member` (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME,
    updateDate DATETIME,
    delDate DATETIME,
	delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
	authStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
    loginId CHAR(20) NOT NULL UNIQUE,
    loginPw CHAR(100) NOT NULL,
    `name` CHAR(20) NOT NULL,
    `nickname` CHAR(20) NOT NULL,
    `email` CHAR(100) NOT NULL,
    `phoneNo` CHAR(20) NOT NULL
);

alter table `member` modify `phoneNo` default 000-0000-0000 not null;

INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'admin',
loginPw = SHA2('admin', 256),
`name` = '관리자',
`nickname` = '관리자',
`email` = '',
`phoneNo` = '';