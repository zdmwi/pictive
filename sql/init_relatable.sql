/*
	COMP1161 Group Project
	Database for Relatable - A Facebook Clone

*/
drop database if exists relatable;

create database relatable;

use relatable;

/*Entities */

create table users(
	user_id int not null AUTO_INCREMENT,
	fname varchar(20) not null,
	lname varchar(30) not null,
	password varchar(20) not null,
	email varchar(50) not null,

	primary key(user_id)
);


/* Weak Entities*/

create table profile(
	user_id int,
	profile_photo varchar(250), /* stores the url*/
	status varchar(250),
	primary key(user_id),
	foreign key(user_id) references users(user_id) on delete cascade
);

create table posts(
	post_id int not null AUTO_INCREMENT,
	user_id int,
	created_on datetime not null,
	primary key(post_id,user_id),
	foreign key(user_id) references users(user_id) on delete cascade
);


create table photos(
	post_id int,
	url varchar(250) not null,
	caption varchar(250),
	primary key(post_id),
	foreign key(post_id) references posts(post_id) on delete cascade
);

create table texts(
	post_id int,
	body varchar(250) not null,
	primary key(post_id),
	foreign key(post_id) references posts(post_id) on delete cascade
);


create table `groups`(
	group_id int not null AUTO_INCREMENT,
	user_id int,
	name varchar(50) not null,
	primary key(group_id,user_id),
	foreign key(user_id) references users(user_id) on delete cascade
);

/* Relationships*/

create table comments_on(
	comment_id int not null AUTO_INCREMENT,
	user_id int,
	post_id int,
	comment varchar(250) not null,
	c_date datetime not null,
	primary key(comment_id, user_id,post_id),
	foreign key(user_id) references users(user_id) on delete cascade,
	foreign key(post_id) references posts(post_id) on delete cascade
);


create table friend_of(
	user_id int,
	friend_id int,
	group_t varchar(10) not null,
	primary key(user_id,friend_id),
	foreign key(user_id) references users(user_id) on delete cascade,
	foreign key(friend_id) references users(user_id) on delete cascade
);

create table joined_group(
	user_id int,
	group_id int,
	role varchar(15) not null,
	primary key(user_id,group_id),
	foreign key(user_id) references users(user_id) on delete cascade,
	foreign key(group_id) references `groups`(group_id) on delete cascade
);


create table posts_made(
	post_id int,
	user_id int,
	group_id int,
	primary key(post_id,user_id,group_id),
	foreign key(post_id) references posts(post_id) on delete cascade,
	foreign key(user_id) references users(user_id) on delete cascade,
	foreign key(group_id) references `groups`(group_id) on delete cascade
);


create table creates(
	user_id int,
	group_id int,
	primary key(user_id,group_id),
	foreign key(user_id) references users(user_id) on delete cascade,
	foreign key(group_id) references `groups`(group_id) on delete cascade
);



/*Stored Procedure to register a user*/
 DELIMITER $$

 create procedure register(f_name varchar(20), l_name varchar(30), password varchar(20), email varchar(40))
 	BEGIN
 		insert into users(fname,lname,password,email) values(f_name,l_name,password,email);
 	END $$

 DELIMITER ;


/*Trigger to create Profile for a user that registers*/

DELIMITER $$

create trigger createProfile
	after insert ON users
	FOR EACH ROW
	BEGIN
		insert into profile(user_id) values (new.user_id);
	END $$

DELIMITER ;

/*Stored Procedures to modify a profile*/
DELIMITER $$

create procedure modifyProfilePhoto(uid int, photo_url varchar(250))
	BEGIN
		update profile
			set profile_photo = photo_url
			where user_id = uid;
	END $$

create procedure modifyProfileStatus(uid int, p_status varchar(250))
	BEGIN
		update profile
			set status = p_status
			where user_id = uid;
	END $$

create procedure deleteProfile(uid int)
	BEGIN
		DELETE FROM profile WHERE user_id = uid;
	END $$

create procedure deleteUser(uid int)
	BEGIN
		DELETE FROM users WHERE user_id = uid;
	END $$

DELIMITER ;


/* Stored Procedures to add a friend*/
DELIMITER $$

create procedure addFriend(uid int,fid int,type varchar(10))
	BEGIN
		insert into friend_of values (uid,fid,type);
		insert into friend_of values (fid,uid,type);
	END $$


create procedure unfriend(uid int, fid int)
	BEGIN
		DELETE FROM friend_of WHERE user_id = uid AND friend_id = fid;
		DELETE FROM friend_of WHERE user_id = fid AND friend_id = uid;
	END $$

DELIMITER ;

/*Stored Procedure to return list of userids that are friends of a user*/
DELIMITER $$

create procedure friendList(id int)
	BEGIN
		SELECT friend_id
		FROM friend_of
		WHERE user_id = id;
	END $$


create procedure getSuggestedFriends(uid int)
  BEGIN
    SELECT DISTINCT profile.profile_photo, users.fname, users.lname, users.user_id
    FROM friend_of
    JOIN users ON friend_of.friend_id = users.user_id
    JOIN profile ON profile.user_id = users.user_id
    WHERE friend_of.friend_id <> uid AND friend_of.friend_id NOT IN
      (SELECT t1.friend_id FROM
        (SELECT * FROM friend_of WHERE user_id=uid) AS t1);
  END $$

DELIMITER ;

/*Stored Procedure to return info for friend*/
DELIMITER $$

create procedure friendInfo(id int)
	BEGIN
		select u.fname, u.lname, u.user_id, u.email, f.group_t as friend_group
    from users as u join friend_of as f on u.user_id = f.friend_id
    where f.user_id=id;
	END $$

DELIMITER ;


/* Stored Procedure to create a post*/
DELIMITER $$

create procedure makePhotoPost(uid int, url varchar(250), caption varchar(250))
	BEGIN
		insert into posts(user_id,created_on) values (uid, NOW());
		insert into photos values (LAST_INSERT_ID(),url,caption);
	END $$

create procedure makeTextPost(uid int, body varchar(250))
	BEGIN
		insert into posts(user_id,created_on) values (uid, NOW());
		insert into texts values (LAST_INSERT_ID(),body);
	END $$

create procedure deletePost(pid int)
	BEGIN
		DELETE  from posts where post_id = pid;
	END $$

create procedure listPosts(uid int)
	BEGIN
		SELECT post_id FROM posts WHERE user_id = uid;
	END $$


DELIMITER ;

/*Stored Procedure to create a group*/
DELIMITER $$

create procedure makeGroup(uid int, gname varchar(50))
	BEGIN
		insert into `groups`(user_id,name) values(uid,gname);
		insert into joined_group values(uid,LAST_INSERT_ID(),"editor");
	END $$

/*Stored Procedure to join a group*/
create procedure joinGroup(uid int,gid int)
	BEGIN
		insert into joined_group values(uid,gid,"viewer");
	END $$

/*Stored Procedure to make someone a content editor*/
create procedure changeRole(creator int,uid int, gid int)
	BEGIN
		update joined_group
		set role = CASE
		when (role = "viewer" and creator = (SELECT user_id FROM `groups` WHERE group_id = gid)) then "editor"
		else role
		end
		where joined_group.user_id = uid;

	END $$

/*Procedure to list all members of a group*/
create procedure listGroupMembers(gid int)
	BEGIN
		SELECT user_id,fname,lname
		FROM users
		WHERE user_id in (SELECT user_id FROM joined_group WHERE joined_group.group_id = gid);
	END $$

DELIMITER ;

/*Procedure to comment on a post*/
DELIMITER $$

create procedure leaveComment(uid int,pid int,comment varchar(250))
	BEGIN
		insert into comments_on(user_id, post_id, comment, c_date) values(uid,pid,comment,NOW());
	END $$

create procedure viewComments(pid int)
	BEGIN
		SELECT user_id,comment, c_date FROM comments_on WHERE post_id = pid;
	END $$

create procedure deleteComments(pid int,uid int)
	BEGIN
		DELETE FROM comments_on WHERE post_id = pid AND user_id = uid;
	END $$

create procedure deleteComment(cid int)
	BEGIN
		DELETE FROM comments_on WHERE comment_id = cid;
	END $$

DELIMITER ;

/* Prcedure for fetching user's friends posts */
DELIMITER $$
/* Procedure to fetch the photo posts of a user's friends */
create PROCEDURE getFriendPhotos(uid int)
  BEGIN
    select p.*, u.fname, u.lname
    from users u join (
      select ph.*, po.user_id, po.created_on
      from photos ph join posts po on ph.post_id=po.post_id
      where po.user_id in (
        SELECT friend_id FROM friend_of WHERE friend_of.user_id=uid
      )
    ) as p on p.user_id=u.user_id;
  END $$

create PROCEDURE getFriendTexts(uid int)
  BEGIN
    select p.*, u.fname, u.lname
    from users u join (
      select t.body, po.*
      from texts t join posts po on t.post_id=po.post_id
      where po.user_id in (
        SELECT friend_id FROM friend_of WHERE friend_of.user_id=uid
      )
    ) as p on p.user_id=u.user_id;
  END $$

DELIMITER ;
