/*
	COMP1161 Group Project
	Database for Relatable - A Facebook Clone

*/

create database relatable;

use relatable;

/*Entities */

create table Users(
	user_id mediumint not null AUTO_INCREMENT,
	fname varchar(20) not null,
	lname varchar(30) not null,
	password varchar(20) not null,
	email varchar(40) not null,

	primary key(user_id)
);


/* Weak Entities*/

create table Profile(
	user_id mediumint,
	profile_photo varchar(250), /* stores the url*/
	status varchar(250),
	primary key(user_id),
	foreign key(user_id) references Users(user_id) on delete cascade
);

create table Posts(
	post_id mediumint not null AUTO_INCREMENT,
	user_id mediumint,
	created_on date not null,
	primary key(post_id,user_id),
	foreign key(user_id) references Users(user_id) on delete cascade
);


create table Photos(
	post_id mediumint,
	url varchar(250) not null,
	caption varchar(250),
	primary key(post_id),
	foreign key(post_id) references Posts(post_id) on delete cascade
);

create table Texts(
	post_id mediumint,
	body varchar(250) not null,
	primary key(post_id),
	foreign key(post_id) references Posts(post_id) on delete cascade
);


create table Groups(
	group_id mediumint not null AUTO_INCREMENT,
	user_id mediumint,
	name varchar(50) not null,
	primary key(group_id,user_id),
	foreign key(user_id) references Users(user_id) on delete cascade
);

/* Relationships*/

create table comments_on(
	user_id mediumint,
	post_id mediumint,
	comment varchar(250) not null,
	c_date date not null,
	primary key(user_id,post_id),
	foreign key(user_id) references Users(user_id) on delete cascade,
	foreign key(post_id) references Posts(post_id) on delete cascade
);


create table friend_of(
	user_id mediumint,
	friend_id mediumint,
	group_t varchar(10) not null,
	primary key(user_id,friend_id),
	foreign key(user_id) references Users(user_id) on delete cascade,
	foreign key(friend_id) references Users(user_id) on delete cascade
);

create table joinedGroup(
	user_id mediumint,
	group_id mediumint,
	role varchar(15) not null, 
	primary key(user_id,group_id),
	foreign key(user_id) references Users(user_id) on delete cascade,
	foreign key(group_id) references Groups(group_id) on delete cascade
);


create table makes(
	user_id mediumint,
	post_id mediumint,
	primary key(user_id,post_id),
	foreign key(user_id) references Users(user_id) on delete cascade,
	foreign key(post_id) references Posts(post_id) on delete cascade
);


create table postsMade(
	post_id mediumint,
	user_id mediumint,
	group_id mediumint,
	primary key(post_id,user_id,group_id),
	foreign key(post_id) references Posts(post_id) on delete cascade,
	foreign key(user_id) references Users(user_id) on delete cascade,
	foreign key(group_id) references Groups(group_id) on delete cascade
);


create table creates(
	user_id mediumint,
	group_id mediumint,
	primary key(user_id,group_id),
	foreign key(user_id) references Users(user_id) on delete cascade,
	foreign key(group_id) references Groups(group_id) on delete cascade
);



/*Stored Procedure to register a user*/
 DELIMITER $$

 create procedure register(f_name varchar(20), l_name varchar(30), password varchar(20), email varchar(40))
 	BEGIN
 		insert into Users(fname,lname,password,email) values(f_name,l_name,password,email);
 	END $$

 DELIMITER ;


/*Trigger to create Profile for a user that registers*/

DELIMITER $$

create trigger createProfile
	after insert ON Users
	FOR EACH ROW
	BEGIN
		insert into Profile(user_id) values (new.user_id);
	END $$

DELIMITER ;

/*Stored Procedures to modify a profile*/
DELIMITER $$

create procedure modifyProfilePhoto(uid mediumint, photo_url varchar(250))
	BEGIN
		update Profile
			set profile_photo = photo_url
			where user_id = uid;
	END $$

create procedure modifyProfileStatus(uid mediumint, p_status varchar(250))
	BEGIN
		update Profile
			set status = p_status
			where user_id = uid;
	END $$

create procedure deleteProfile(uid mediumint)
	BEGIN
		DELETE FROM Profile WHERE user_id = uid;
	END $$

create procedure deleteUser(uid mediumint)
	BEGIN
		DELETE FROM Users WHERE user_id = uid;
	END $$

DELIMITER ;


/* Stored Procedures to add a friend*/
DELIMITER $$

create procedure addFriend(uid mediumint,fid mediumint,type varchar(10))
	BEGIN
		insert into friend_of values (uid,fid,type);
		insert into friend_of values (fid,uid,type);
	END $$


create procedure unfriend(uid mediumint, fid mediumint)
	BEGIN
		DELETE FROM friend_of WHERE user_id = uid AND friend_id = fid;
		DELETE FROM friend_of WHERE user_id = fid AND friend_id = uid;
	END $$

DELIMITER ;

/*Stored Procedure to return list of userids that are friends of a user*/
DELIMITER $$

create procedure friendList(id mediumint)
	BEGIN
		SELECT friend_id 
		FROM friend_of
		WHERE user_id = id;
	END $$

DELIMITER ;

/*Stored Procedure to return info for friend*/
DELIMITER $$

create procedure friendInfo(id mediumint)
	BEGIN
		SELECT user_id,fname,lname
		FROM Users
		WHERE user_id in (SELECT friend_id FROM friend_of WHERE friend_of.user_id = id);
	END $$

DELIMITER ;


/* Stored Procedure to create a post*/
DELIMITER $$

create procedure makePhotoPost(uid mediumint, url varchar(250), caption varchar(250))
	BEGIN
		insert into Posts(user_id,created_on) values (uid,CURRENT_DATE());
		insert into Photos values (LAST_INSERT_ID(),url,caption);
	END $$

create procedure makeTextPost(uid mediumint, body varchar(250))
	BEGIN
		insert into Posts(user_id,created_on) values (uid,CURRENT_DATE());
		insert into Texts values (LAST_INSERT_ID(),body);
	END $$

create procedure deletePost(pid mediumint)
	BEGIN
		DELETE  from Posts where post_id = pid;
	END $$

create procedure listPosts(uid mediumint)
	BEGIN
		SELECT post_id FROM Posts WHERE user_id = uid;
	END $$


DELIMITER ;

/*Stored Procedure to create a group*/
DELIMITER $$

create procedure makeGroup(uid mediumint, gname varchar(50))
	BEGIN
		insert into Groups(user_id,name) values(uid,gname);
		insert into joinedGroup values(uid,LAST_INSERT_ID(),"editor");
	END $$

/*Stored Procedure to join a group*/
create procedure joinGroup(uid mediumint,gid mediumint)
	BEGIN
		insert into joinedGroup values(uid,gid,"viewer");
	END $$

/*Stored Procedure to make someone a content editor*/
create procedure changeRole(creator mediumint,uid mediumint, gid mediumint)
	BEGIN
		update joinedGroup 
		set role = CASE
		when (role = "viewer" and creator = (SELECT user_id FROM Groups WHERE group_id = gid)) then "editor"
		else role
		end
		where joinedGroup.user_id = uid;

	END $$

/*Procedure to list all members of a group*/
create procedure listGroupMembers(gid mediumint)
	BEGIN
		SELECT user_id,fname,lname
		FROM Users
		WHERE user_id in (SELECT user_id FROM joinedGroup WHERE joinedGroup.group_id = gid);
	END $$

DELIMITER ;

/*Procedure to comment on a post*/
DELIMITER $$

create procedure leaveComment(uid mediumint,pid mediumint,comment varchar(250))
	BEGIN
		insert into comments_on values(uid,pid,comment,CURRENT_DATE());
	END $$	

create procedure viewComments(pid mediumint)
	BEGIN
		SELECT user_id,comment FROM comments_on WHERE post_id = pid; 
	END $$

create procedure deleteComments(pid mediumint,uid mediumint)
	BEGIN
		DELETE FROM comments_on WHERE post_id = pid AND user_id = uid;
	END $$

DELIMITER ;

