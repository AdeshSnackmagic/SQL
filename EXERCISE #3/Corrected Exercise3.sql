CREATE DATABASE ARTICLY;
USE ARTICLY;

CREATE TABLE USERS
(
Name VARCHAR(32),
user_id INT AUTO_INCREMENT PRIMARY KEY,
user_type ENUM('admin','normal') NOT NULL
);

select * from USERS;

CREATE TABLE CATEGORIES
(
category_id INT AUTO_INCREMENT PRIMARY KEY,
Category varchar(255) Unique NOT NULL
);


CREATE TABLE ARTICLES
(
article_id INT AUTO_INCREMENT PRIMARY KEY,
Title VARCHAR(255),
Content TEXT,
category_id INT ,
user_id int,
FOREIGN KEY (user_id) references USERS(user_id) ON DELETE Cascade,
FOREIGN KEY (category_id) references CATEGORIES(category_id) ON DELETE CASCADE
);

CREATE TABLE COMMENTS
(
comment_id INT PRIMARY KEY AUTO_INCREMENT,
Content Text,
Article_id int,
User_id int,
FOREIGN KEY (Article_id) references ARTICLES(article_id) ON DELETE CASCADE,
FOREIGN KEY (User_id) references USERS(user_id) On delete cascade
);


-- manage(create, update, delete) users
Insert into  USERS (Name, user_type)
values
('user1','normal'),
('user2', 'admin'),
('user3','normal');

SET SQL_SAFE_UPDATES = 0;

Update USERS
set user_type='normal'
where name='user2';

DELETE from USERS where user_id=5;

-- manage(create, update, delete)  articles
Insert INTO ARTICLES
values 
(1,'Growing Economy',"Indian Economy is developing at fast pace...",1,6),
(2,'Fire in LOS Angeles',"LA is burning like a .....",2,6),
(3,"Modi's Government","IS MODI A NEW DICTATOR OR LEADER??",2,6),
(4,"Unemployment India's biggest challenge??",'India is developing at very fast pace but Unemployment is ....',2,4);
 select * from ARTICLES;

Update ARTICLES
set category_id=2 where article_id=1;

Delete from ARTICLES where article_id=1;


-- manage(create, update, delete) categories
insert into CATEGORIES
values
(1,"Economic"),
(2,"International News");

update CATEGORIES 
set category='Tech'
where category_id=1;

Delete from CATEGORIES where category_id=1;

-- manage(create, update, delete comments

Insert Into COMMENTS
values
('1',"very informative",2,6),
('2', "excellent",2,4);

insert into COMMENTS (Content, Article_id,User_id)
values
("eye opning article",3,6),
("very descriptive",3,4);

update COMMENTS
set content ="very good article"
where comment_id=2;

delete from COMMENTS
where comment_id=2;

select * from COMMENTS;

-- select all articles whose author's name is user3 (Do this exercise using variable also).

select A.title,A.content, C.Content from USERS U join ARTICLES A on A.user_id= U.user_id Left join COMMENTS C On A.article_id= C.article_id where U.name="user3";

set @author_name='user3';
select A.title,A.content, C.Content from USERS U join ARTICLES A on A.user_id= U.user_id Left join COMMENTS C On A.article_id= C.article_id where U.name=@author_name;

-- For all the articles being selected above, select all the articles and also the comments associated with those articles in a single query (Do this using subquery also)

select A.article_id as Article_id,A.title as article_title,A.content,(select group_concat(COMMENTS.content) from COMMENTS where COMMENTS.Article_id=A.article_id) as Comments from ARTICLES A join USERS U on A.user_id=U.user_id where U.name='user3';


-- Write a query to select all articles which do not have any comments 
select *  from ARTICLES A left join  COMMENTS C on A.article_id = C.Article_id where C.comment_id is NULL;

-- Write a query to select all articles which do not have any comments Do using subquery 
select * from ARTICLES where article_id NOT IN (select Article_id from COMMENTS);


-- Write a query to select article which has maximum comments
select A.article_id as Id,A.title as Title,count(C.article_id) as Total_comment from ARTICLES A left join COMMENTS C on C.Article_id=A.article_id Group by (A.article_id) order by count(A.article_id) desc limit 1;

-- Write a query to select article which does not have more than one comment by the same user ( do this using left join and group by )
select  Distinct A.title,A.content,A.article_id from ARTICLES  A  left join COMMENTS C on A.article_id=C.Article_id group by A.article_id,C.User_id having count(C.comment_id)=1;


