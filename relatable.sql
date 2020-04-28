/*
	COMP1161 Group Project
	Database for Relatable - A Facebook Clone

*/

create database relatable;

use relatable;

/*Entities */

create table Users(
	user_id varchar(10) not null,
	fname varchar(20) not null,
	lname varchar(30) not null,
	password varchar(20) not null,
	email varchar(40) not null,

	primary key(user_id)
);

/* Weak Entities*/

create table Profile(
	user_id varchar(10) not null,
	profile_photo varchar(50), /* stores the url*/
	status varchar(250),
	primary key(user_id),
	foreign key(user_id) references Users(user_id) on delete cascade
);

create table Posts(
	post_id varchar(20) not null,
	user_id varchar(10) not null,
	created_on date not null,
	primary key(post_id,user_id),
	foreign key(user_id) references Users(user_id) on delete cascade
);


create table Photos(
	post_id varchar(20) not null,
	url varchar(50) not null,
	caption varchar(250),
	primary key(post_id),
	foreign key(post_id) references Posts(post_id) on delete cascade
);

create table Texts(
	post_id varchar(20) not null,
	body varchar(250) not null,
	primary key(post_id),
	foreign key(post_id) references Posts(post_id) on delete cascade
);


create table Groups(
	group_id varchar(20) not null,
	user_id varchar(10) not null,
	name varchar(50) not null,
	primary key(group_id,user_id),
	foreign key(user_id) references Users(user_id) on delete cascade
);

/* Relationships*/

create table comments_on(
	user_id varchar(10) not null,
	post_id varchar(20) not null,
	comment varchar(250) not null,
	c_date date not null,
	primary key(user_id,post_id),
	foreign key(user_id) references Users(user_id) on delete cascade,
	foreign key(post_id) references Posts(post_id) on delete cascade
);


create table friend_of(
	user_id varchar(10) not null,
	friend_id varchar(10) not null,
	group_t varchar(10) not null,
	primary key(user_id,friend_id),
	foreign key(user_id) references Users(user_id) on delete cascade,
	foreign key(friend_id) references Users(user_id) on delete cascade
);

create table joinedGroup(
	user_id varchar(10) not null,
	group_id varchar(20) not null,
	role varchar(15) not null, 
	primary key(user_id,group_id),
	foreign key(user_id) references Users(user_id) on delete cascade,
	foreign key(group_id) references Groups(group_id) on delete cascade
);


create table makes(
	user_id varchar(10) not null,
	post_id varchar(20) not null,
	primary key(user_id,post_id),
	foreign key(user_id) references Users(user_id) on delete cascade,
	foreign key(post_id) references Posts(post_id) on delete cascade
);


create table postsMade(
	post_id varchar(20) not null,
	user_id varchar(10) not null,
	group_id varchar(20) not null,
	primary key(post_id,user_id,group_id),
	foreign key(post_id) references Posts(post_id) on delete cascade,
	foreign key(user_id) references Users(user_id) on delete cascade,
	foreign key(group_id) references Groups(group_id) on delete cascade
);


create table creates(
	user_id varchar(10) not null,
	group_id varchar(20) not null,
	primary key(user_id,group_id),
	foreign key(user_id) references Users(user_id) on delete cascade,
	foreign key(group_id) references Groups(group_id) on delete cascade
);



/*Stored Procedure to register a user*/
 DELIMITER $$

 create procedure register(user_id varchar(10), f_name varchar(20), l_name varchar(30), password varchar(20), email varchar(40))
 	BEGIN
 		insert into Users values(user_id,f_name,l_name,password,email);
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

create procedure modifyProfilePhoto(uid varchar(10), photo_url varchar(50))
	BEGIN
		update Profile
			set profile_photo = photo_url
			where user_id = uid;
	END $$

create procedure modifyProfileStatus(uid varchar(10), p_status varchar(250))
	BEGIN
		update Profile
			set status = p_status
			where user_id = uid;
	END $$

create procedure deleteProfile(uid varchar(10))
	BEGIN
		DELETE FROM Profile WHERE user_id = uid;
	END $$

DELIMITER ;


/* Stored Procedures to add a friend*/
DELIMITER $$

create procedure addFriend(uid varchar(10),fid varchar(10),type varchar(10))
	BEGIN
		insert into friend_of values (uid,fid,type);
		insert into friend_of values (fid,uid,type);
	END $$


create procedure unfriend(uid varchar(10), fid varchar(10))
	BEGIN
		DELETE FROM friend_of WHERE user_id = uid AND friend_id = fid;
		DELETE FROM friend_of WHERE user_id = fid AND friend_id = uid;
	END $$

DELIMITER ;

/*Stored Procedure to return list of userids that are friends of a user*/
DELIMITER $$

create procedure friendList(id varchar(10))
	BEGIN
		SELECT friend_id 
		FROM friend_of
		WHERE user_id = id;
	END $$

DELIMITER ;

/*Stored Procedure to return info for friend*/
DELIMITER $$

create procedure friendInfo(id varchar(10))
	BEGIN
		SELECT user_id,fname,lname
		FROM Users
		WHERE user_id in (SELECT friend_id FROM friend_of WHERE friend_of.user_id = id);
	END $$

DELIMITER ;


/* Stored Procedure to create a post*/
DELIMITER $$

create procedure makePhotoPost(pid varchar(20), uid varchar(10), url varchar(50), caption varchar(250))
	BEGIN
		insert into Posts values (pid,uid,CURRENT_DATE());
		insert into Photos values (pid,url,caption);
	END $$

create procedure makeTextPost(pid varchar(20), uid varchar(10), body varchar(250))
	BEGIN
		insert into Posts values (pid,uid,CURRENT_DATE());
		insert into Texts values (pid,body);
	END $$

create procedure deletePost(pid varchar(20))
	BEGIN
		DELETE  from Posts where post_id = pid;
	END $$

create procedure listPosts(uid varchar(10))
	BEGIN
		SELECT post_id FROM Posts WHERE user_id = uid;
	END $$


DELIMITER ;

/*Stored Procedure to create a group*/
DELIMITER $$

create procedure makeGroup(gid varchar(20), uid varchar(10), gname varchar(50))
	BEGIN
		insert into Groups values(gid,uid,gname);
		insert into joinedGroup values(uid,gid,"editor");
	END $$

/*Stored Procedure to join a group*/
create procedure joinGroup(uid varchar(10),gid varchar(20))
	BEGIN
		insert into joinedGroup values(uid,gid,"viewer");
	END $$

/*Stored Procedure to make someone a content editor*/
create procedure changeRole(creator varchar(10),uid varchar(10), gid varchar(20))
	BEGIN
		update joinedGroup 
		set role = CASE
		when (role = "viewer" and creator = (SELECT user_id FROM Groups WHERE group_id = gid)) then "editor"
		else role
		end
		where joinedGroup.user_id = uid;

	END $$

/*Procedure to list all members of a group*/
create procedure listGroupMembers(gid varchar(20))
	BEGIN
		SELECT user_id,fname,lname
		FROM Users
		WHERE user_id in (SELECT user_id FROM joinedGroup WHERE joinedGroup.group_id = gid);
	END $$

DELIMITER ;

/*Procedure to comment on a post*/
DELIMITER $$

create procedure leaveComment(uid varchar(10),pid varchar(20),comment varchar(250))
	BEGIN
		insert into comments_on values(uid,pid,comment,CURRENT_DATE());
	END $$	

create procedure viewComments(pid varchar(20))
	BEGIN
		SELECT user_id,comment FROM comments_on WHERE post_id = pid; 
	END $$

create procedure deleteComments(pid varchar(20),uid varchar(10))
	BEGIN
		DELETE FROM comments_on WHERE post_id = pid AND user_id = uid;
	END $$

DELIMITER ;

