* TESTS - Queries and calls to ensure everything is working*/

/*Tests to ensure the tables are built correctly*/
describe Users;
describe Profile;
describe Posts;
describe Photos;
describe Texts;
describe Groups;
describe comments_on;
describe friend_of;
describe joinedGroup;
describe has;
describe creates;

/*Test the stored procedure and trigger*/
CALL register("001","Marlon", "Williams", "password", "test@email.com");
CALL register("002","Terry", "Black", "Iam1ncontrol", "email@test.com");

/*To show that a user was registered*/
SELECT * FROM Users;

/* To show that a profile was created*/
SELECT * FROM Profile;

/*Test that one can change profile photo and status*/
CALL modifyProfilePhoto("001","C://photo.jpeg");

CALL modifyProfileStatus("001","This is Marlon's status");

SELECT * FROM Profile;

CALL addFriend("001","002","School");

SELECT * FROM friend_of;

CALL friendInfo("001");
CALL friendInfo("002");
CALL makePhotoPost("1","001","C:\\pictopost.jpeg","This is a photo.");
CALL makeTextPost("2","002","I just need a post of text to make.");

SELECT * FROM Posts;
SELECT * FROM Photos;
SELECT * FROM Texts;

CALL makeGroup("1","001","Group 1");
CALL makeGroup("2","002","Group 2");

SELECT * FROM Groups;

CALL joinGroup("002","1");
CALL joinGroup("001","2");

SELECT * FROM joinedGroup;

CALL changeRole("002","001","1");
CALL changeRole("001","002","1");
CALL changeRole("002","001","2");

SELECT * FROM joinedGroup;

CALL listGroupMembers("1");

CALL leaveComment("001","1","This is a sample comment");
CALL leaveComment("002","1","Sample Comment #2");
CALL viewComments("1");

CALL deleteComments("1","001");
CALL viewComments("1");

CALL deletePost("1");

SELECT * FROM Posts;

CALL unfriend("001","002");
