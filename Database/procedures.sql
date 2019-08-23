use DBProject

GO

--"PART1"

CREATE PROC Original_Content_Search @typename VARCHAR(16), @categoryname VARCHAR(16)
AS
SELECT o.* FROM Original_Content o 
INNER JOIN Content c ON o.ID = c.ID  
WHERE o.review_status = 1 AND o.filter_status = 1 
	AND ((c."type" = @typename ) OR (c.category_type = @categoryname))

GO

CREATE PROC Contributor_Search @fullname VARCHAR(32)
AS
SELECT CONT.* FROM Contributor CONT
inner join "User" USERR on CONT.ID = USERR.ID 
WHERE (USERR.first_name+' '+USERR.middle_name+' '+USERR.last_name = @fullname)

GO

CREATE PROC Register_User @usertype VARCHAR(16)			, @email VARCHAR(32)					, @password VARCHAR(32)	, @firstname VARCHAR(16),
@middlename VARCHAR(16)			, @lastname VARCHAR(16)					, @birth_date date		, @working_place_name VARCHAR(32), 
@working_place_type VARCHAR(32)	, @wokring_place_description VARCHAR(32), @specilization VARCHAR(16),
@portofolio_link VARCHAR(64)	, @years_experience INT, @hire_date date, @working_hours INT,
@payment_rate DEC(5,2)			, @user_id INT OUTPUT
AS
DECLARE @notif_pers_id INT
INSERT INTO "User" VALUES (@email, @firstname, @middlename, @lastname, @birth_date, @password, 1, CURRENT_TIMESTAMP);
SELECT @user_id = SCOPE_IDENTITY()
IF ( @usertype = 'Viewer' ) 
begin
	INSERT INTO Viewer VALUES (@user_id, @working_place_name, @working_place_type, @wokring_place_description);
end
ELSE IF ( @usertype = 'Contributor' ) 
begin
	INSERT INTO Notified_Person default Values;
	SELECT @notif_pers_id = SCOPE_IDENTITY()
	INSERT INTO Contributor VALUES		(@user_id, @years_experience, @portofolio_link, @specilization,@notif_pers_id );
end
ELSE IF ( @usertype = 'Authorized Reviewer' ) 
begin
	INSERT INTO Notified_Person default Values;
	SELECT @notif_pers_id = SCOPE_IDENTITY()
	INSERT INTO Staff(ID,hire_date,working_hours,payment_rate, notified_id) VALUES(@user_id ,@hire_date, @working_hours, @payment_rate, @notif_pers_id);
	INSERT INTO Reviewer VALUES (@user_id);
end
ELSE IF ( @usertype = 'Content Manager' ) 
begin
	INSERT INTO Notified_Person default Values;
	SELECT @notif_pers_id = SCOPE_IDENTITY()
	INSERT INTO Staff(ID,hire_date,working_hours,payment_rate, notified_id) VALUES(@user_id ,@hire_date, @working_hours, @payment_rate, @notif_pers_id);
	INSERT INTO Content_manager VALUES (@user_id, NULL);
end
GO

CREATE PROC  Check_Type @typename VARCHAR(16), @content_manager_id INT
AS
IF NOT EXISTS ( SELECT * FROM Content_type c WHERE c."type" = @typename )
begin
	INSERT INTO Content_type VALUES (@typename);
end
UPDATE Content_manager SET "type" = @typename
WHERE Content_manager.ID = @content_manager_id

GO

CREATE PROC Order_Contributers
AS
select * from Contributor order by years_of_experience desc

GO

CREATE PROC SHOW_ORIGINAL_CONTENT @contributer_id INT
AS
IF (@contributer_id IS NULL)
BEGIN
	SELECT oc.*, c.* FROM Content co
	INNER JOIN Original_Content oc
	ON co.ID = oc.ID
	INNER JOIN Contributor c
	ON co.contributer_id = c.ID
	WHERE oc.review_status = 1
END
ELSE begin
	SELECT oc.*, c.* FROM Content co
	INNER JOIN Original_Content oc
	ON co.ID = oc.ID
	INNER JOIN Contributor c
	ON co.contributer_id = c.ID 
	WHERE oc.review_status = 1 AND c.ID = @contributer_id
end
GO
------------------------------------------------------------------------------------

--PART2:

CREATE PROC User_login @email VARCHAR(32), @password VARCHAR(32), @user_id INT OUTPUT
AS
DECLARE @days INT
DECLARE @Active BIT
IF NOT EXISTS (SELECT * FROM "User" u WHERE u.email = @email AND u."password" = @password ) 
BEGIN
	SELECT @user_id = -1
END
ELSE BEGIN
SELECT @days = day(CURRENT_TIMESTAMP)-day(u.Last_Login) FROM "User" u WHERE u.email = @email AND u."password" = @password;
SELECT @Active = u.Active FROM "User" u WHERE u.email = @email AND u."password" = @password;
if(@days > 14 AND @Active = 1)
BEGIN
	SELECT @user_id = -1
END
ELSE if(@days <= 14 AND @Active = 0)
BEGIN
	UPDATE "User" SET Last_Login = CURRENT_TIMESTAMP, Active = 1
	WHERE "User".email = @email AND "User"."password" = @password
END
ELSE BEGIN
	SELECT @user_id = ID from "User" where email=@email and "password"=@password
END

END

GO

CREATE PROC Show_Profile
@user_id INT, @email VARCHAR(32) OUTPUT, @password VARCHAR(32) OUTPUT, @firstname VARCHAR(16) OUTPUT, @middlename VARCHAR(16) OUTPUT,
@lastname VARCHAR(16) OUTPUT, @birth_date DATE OUTPUT, @working_place_name VARCHAR(16) OUTPUT, @working_place_type VARCHAR(16)
OUTPUT, @wokring_place_description VARCHAR(32) OUTPUT, @specilization BIT OUTPUT,
@portofolio_link VARCHAR(64) OUTPUT, @years_experience INT OUTPUT, @hire_date DATE OUTPUT, @working_hours INT
OUTPUT, @payment_rate DEC(5,2) OUTPUT
AS
DECLARE @days INT
DECLARE @Active BIT
IF NOT EXISTS (SELECT * FROM "User" where ID = @user_id) BEGIN --USER DOESNT EXISTS  
	print('User Does not Exist')
END

--If user is deleted
SELECT @days = day(CURRENT_TIMESTAMP)-day(u.Last_Login) FROM "User" u WHERE u.email = @email AND u."password" = @password;
SELECT @Active = u.Active FROM "User" u WHERE u.email = @email AND u."password" = @password;

if(@days > 14 AND @Active = 0)
BEGIN
	SELECT @email =null, @password =null, @firstname =null, @middlename =null,
	@lastname =null, @birth_date =null, @working_place_name =null, @working_place_type =null,
	@wokring_place_description =null, @specilization =null, @portofolio_link =null, 
	@years_experience =null, @hire_date =null, @working_hours =null, @payment_rate =null
END
--------------------

IF EXISTS (SELECT * FROM Viewer WHERE  ID = @user_id) BEGIN --USER is Viewer
	SELECT @email = u.email, @password = u."password", @firstname = u.first_name, @middlename = u.middle_name,
	@lastname = u.last_name, @birth_date = u.birth_date, @wokring_place_description = v.working_place_description,
	@working_place_name = v.working_place, @working_place_type = v.working_place_type
	FROM "User" u
	INNER JOIN Viewer v ON u.ID = v.ID where u.ID = @user_id
END

IF EXISTS(SELECT * FROM Staff WHERE ID = @user_id) BEGIN --USER is Staff
	SELECT @email = u.email, @password = u."password", @firstname = u.first_name, @middlename = u.middle_name,
	@lastname = u.last_name, @birth_date = u.birth_date, @hire_date = s.hire_date, @working_hours = s.working_hours,
	@payment_rate = s.payment_rate
	FROM "User" u
	INNER JOIN Staff s ON u.ID = s.ID WHERE u.ID = @user_id
END

IF EXISTS(SELECT * FROM Contributor WHERE ID = @user_id) BEGIN --User is Contributor
	SELECT @email = u.email, @password = u."password", @firstname = u.first_name, @middlename = u.middle_name,
	@lastname = u.last_name, @birth_date = u.birth_date, @specilization = c.specialization, @portofolio_link = c.portfolio_link,
	@years_experience = c.years_of_experience
	FROM "User" u
	INNER JOIN Contributor c ON u.ID = c.ID WHERE u.ID = @user_id
END

GO

CREATE PROC Edit_Profile 
@user_id INT, @email VARCHAR(32), @password VARCHAR(32), @firstname VARCHAR(32), @middlename VARCHAR(32),
@lastname VARCHAR(32), @birth_date DATE, @working_place_name VARCHAR(32), @working_place_type VARCHAR(32), 
@working_place_description VARCHAR(32), @specilization VARCHAR(32),@portofolio_link VARCHAR(32), 
@years_experience INT, @hire_date DATE, @working_hours INT, @payment_rate DEC(5,2)
AS

IF EXISTS (SELECT * FROM Viewer WHERE  ID = @user_id) BEGIN --USER is Viewer
	UPDATE "User" SET email = @email, "password" = @password, first_name =  @firstname, middle_name = @middlename,
	last_name = @lastname, birth_date = @birth_date WHERE ID = @user_id
	UPDATE Viewer SET working_place_description = @working_place_description,
	working_place = @working_place_name, working_place_type = @working_place_type
	WHERE ID = @user_id
END

IF EXISTS(SELECT * FROM Staff WHERE ID = @user_id) BEGIN --USER is Staff
	UPDATE "User" SET email = @email, "password" = @password, first_name =  @firstname, middle_name = @middlename,
	last_name = @lastname, birth_date = @birth_date WHERE ID = @user_id
	UPDATE Staff SET hire_date = @hire_date, working_hours = @working_hours,
	payment_rate = @payment_rate
	WHERE ID = @user_id
END

IF EXISTS(SELECT * FROM Contributor WHERE ID = @user_id) BEGIN --User is Contributor
	UPDATE "User" SET email = @email,  "password" = @password, first_name =  @firstname, middle_name = @middlename,
	last_name = @lastname, birth_date = @birth_date WHERE ID = @user_id
	UPDATE Contributor SET specialization = @specilization , portfolio_link = @portofolio_link,
	years_of_experience = @years_experience
	WHERE ID = @user_id
END

GO

CREATE PROC Deactivate_Profile @user_id INT
AS
BEGIN
IF EXISTS (SELECT * FROM "User" where ID = @user_id)
UPDATE "User" SET Active = 0, Last_Login = null where ID = @user_id
END

GO

CREATE PROC Show_Event @event_id INT
AS

IF (@event_id IS NULL) 
BEGIN
	SELECT u.first_name,u.middle_name, u.last_name , e.*  
	FROM "Event" e 
	INNER JOIN "User" u on u.ID=e.viewer_id
	WHERE e."time" > CURRENT_TIMESTAMP --upcoming events

END
ELSE BEGIN
	SELECT u.first_name,u.middle_name, u.last_name , e.*  
	FROM "Event" e 
	INNER JOIN "User" u on u.ID=e.viewer_id  
	WHERE e.id = @event_id
END

GO

CREATE PROC Show_Notification @user_id INT
AS
IF EXISTS(SELECT * FROM Contributor WHERE ID = @user_id) BEGIN
	SELECT a.* from Announcement a 
	INNER JOIN Notified_Person p on a.notified_person_id = p.ID
	INNER JOIN Contributor c on c.notified_id = p.ID 
	WHERE c.ID = @user_id
END
ELSE IF EXISTS(SELECT * FROM Staff WHERE ID = @user_id) BEGIN
	SELECT a.* FROM Announcement a 
	INNER JOIN Notified_Person p on a.notified_person_id = p.ID
	INNER JOIN Staff s on s.notified_id = p.ID 
	WHERE s.ID = @user_id
END
GO

CREATE PROC Show_New_Content @viewer_id INT , @content_id INT

AS

IF (@content_id IS NULL) BEGIN
	SELECT c.*, con.first_name,con.middle_name,con.last_name 
	FROM New_Content newc 
	INNER JOIN Content c on newc.ID = c.ID 
	INNER JOIN New_Request r
	on r.ID = newc.new_request_id 
	INNER JOIN "User" con on con.ID = c.contributer_id 
	WHERE r.viewer_id = @viewer_id 
END
ELSE BEGIN
	SELECT c.*, con.first_name,con.middle_name,con.last_name 
	FROM New_Content newc 
	INNER JOIN Content c on newc.ID = c.ID 
	INNER JOIN New_Request r
	on r.ID = newc.new_request_id 
	INNER JOIN "User" con on con.ID = c.contributer_id
	WHERE r.viewer_id = @viewer_id and c.ID = @content_id
END

GO
------------------------------------------------------------------------------------
--PART3:

-----------------------
--Viewer 1-------------GOOD
-----------------------
GO
CREATE PROC Viewer_Create_Event
@city VARCHAR(16), 
@event_date_time DATETIME, 
@description VARCHAR(64), 
@entartainer VARCHAR(16),
@viewer_id INT, 
@event_id INT OUTPUT
AS
INSERT INTO "Event"(city,"time","description",entertainer,viewer_id)
VALUES  (@city,@event_date_time,@description,@entartainer,@viewer_id)
PRINT @event_id
GO
--EXEC Viewer_Create_Event 'cairo','12:00:00','balabizo','tamora',2,1;

-----------------------
--Viewer 2-------------GOOD
-----------------------

GO 
CREATE PROC Viewer_Upload_Event_Photo 
@event_id INT,
@link VARCHAR(64)
AS
INSERT INTO Event_Photos_link (event_id, link)
VALUES(@event_id,@link)
GO
EXEC Viewer_Upload_Event_Photo  1,'Link#61565511';
GO 
CREATE PROC Viewer_Upload_Event_Video 
@event_id INT,
@link VARCHAR(64)
AS
INSERT INTO  Event_Videos_link VALUES (@event_id,@link)
GO
--EXEC Viewer_Upload_Event_Video  1,'Link#61565511';


-----------------------
--Viewer 3-------------GOOD
-----------------------

GO
CREATE PROC Viewer_Create_Ad_From_Event
@event_id INT
AS
DECLARE @viewer INT;
DECLARE @loc VARCHAR(16);
DECLARE @desc VARCHAR(64);
SELECT @desc = E."description" ,@loc= E."location",@viewer = E.viewer_id 
FROM "Event" E
WHERE E.id = @event_id
INSERT INTO Advertisement (event_id,viewer_id,"location","description") 
VALUES (@event_id,@viewer,@loc,@desc)
GO
--EXEC Viewer_Create_Ad_From_Event 1;

-----------------------
--Viewer 4-------------GOOD
-----------------------
GO
CREATE PROC Apply_Existing_Request
@viewer_id INT,
@original_content_id INT
AS
IF ((SELECT rating FROM Original_Content WHERE ID = @original_content_id) >= 4)
BEGIN
	INSERT INTO Existing_Request VALUES(@original_content_id, @viewer_id)
END
ELSE
BEGIN
	print('Rating is lower than 4')
END
--EXEC Apply_Existing_Request 1,4;

-----------------------
--Viewer 5-------------
-----------------------
GO
CREATE PROC Apply_New_Request 
@information VARCHAR(64), 
@contributor_id INT,
@viewer_id INT
AS
DECLARE @id INT
IF @contributor_id is null
BEGIN
INSERT INTO Notification_Object default values
SELECT @id = SCOPE_IDENTITY()
INSERT INTO New_Request VALUES(0,0,@information,@viewer_id,@id+1,@contributor_id)
INSERT INTO announcement(notification_object_id, notified_person_id) 
SELECT o.ID, c.notified_id from Notification_Object o , Contributor c
WHERE o.ID = @id
END
ELSE
BEGIN
INSERT INTO Notification_Object default values
SELECT @id = SCOPE_IDENTITY()
INSERT INTO New_Request VALUES(0,1,@information,@viewer_id,@id+1,@contributor_id)
END
GO




-----------------------
--Viewer 6-------------GOOD
-----------------------
GO
CREATE PROC Delete_New_Request 
@request_id INT
AS
DELETE FROM New_Request WHERE ID = @request_id AND (accept_status = 0 )
GO
--EXEC Delete_New_Request 10;

-----------------------
--Viewer 7-------------
-----------------------
GO
CREATE PROC Rating_Original_Content 
@orignal_content_id INT,
@rating_value DEC(3,2),
@viewer_id INT
AS
INSERT INTO Rate VALUES (@viewer_id,@orignal_content_id,CURRENT_TIMESTAMP,@rating_value)
GO
EXEC Rating_Original_Content 4,4,1;


-----------------------
--Viewer 8-------------GOOD
-----------------------
GO
CREATE PROC Write_Comment 
@viewer_id INT,
@original_content_id INT,
@written_time DATETIME,
@comment_text VARCHAR(64)
AS
INSERT INTO Comment VALUES (@viewer_id, @original_content_id, @written_time, @comment_text)
GO
--EXEC Write_Comment 1,4,'1/1/2018','This is a comment'


-----------------------
--Viewer 9-------------GOOD
-----------------------
GO
CREATE PROC Edit_Comment 
@comment_text VARCHAR(64),
@viewer_id INT, 
@original_content_id INT, 
@last_written_time DATETIME, 
@updated_written_time DATETIME
AS
UPDATE Comment 
SET "date" = @updated_written_time , "text" = @comment_text
GO
--exec Edit_Comment 'This is not a comment',1,4,'1/1/2018','11/23/2018'
GO
-----------------------
--Viewer 10------------GOOD
-----------------------
GO
CREATE PROC Delete_Comment 
@viewer_id INT,
@original_content_id INT,
@written_time DATETIME
AS
DELETE FROM Comment WHERE Comment.date = @written_time AND Comment.Viewer_id = @viewer_id AND Comment.original_content_id = @original_content_id
GO
--exec Delete_Comment 1,4,'11/23/2018'
-----------------------
--Viewer 11------------GOOD
-----------------------
GO
CREATE PROC Create_Ads
@viewer_id INT,
@description VARCHAR(16), 
@location VARCHAR(16)
AS
INSERT INTO Advertisement VALUES(@description,@location,Null,@viewer_id)
GO
--exec Create_Ads 1,'balabizo','home'
-----------------------
--Viewer 12------------GOOD
-----------------------
GO
CREATE PROC Edit_Ad 
@ad_id INT,
@description VARCHAR(16), 
@location VARCHAR(16)
AS
UPDATE Advertisement 
SET description = @description, location = @location
WHERE Advertisement.ID = @ad_id
GO
--exec Edit_Ad 1,'more balabizo','home'
-----------------------
--Viewer 13------------GOOD
-----------------------
GO
CREATE PROC	Delete_Ads 
@ad_id INT
AS
DELETE FROM Advertisement
WHERE ID = @ad_id
GO
--exec Delete_Ads 4
-----------------------
--Viewer 14------------GOOD
-----------------------
GO
CREATE PROC Send_Message 
@msg_text VARCHAR(64), 
@viewer_id INT, 
@contributor_id INT, 
@sender_type VARCHAR(16), 
@sent_at datetime
AS
INSERT INTO "MESSAGE" VALUES(@sent_at,@contributor_id,@viewer_id,@sender_type,NULL,@msg_text,0)
GO
--exec Send_Message 'samsing',1,4,'viewer','1/1/2018'
-----------------------
--Viewer 15------------GOOD
-----------------------
GO
CREATE PROC Show_Message 
@contributor_id INT
AS
SELECT * FROM Message WHERE contributer_id = @contributor_id
GO
--exec Show_Message 4
-----------------------
--Viewer 16------------GOOD
-----------------------
GO
CREATE PROC Highest_Rating_Original_content
AS
SELECT TOP 1 * FROM Original_Content ORDER BY rating desc
GO


------------------------------------------------------------------------------------

--PART4:

CREATE PROC Receive_New_Requests @request_id INT, @contributor_id INT
AS

IF(@request_id IS NULL) BEGIN
	SELECT r.* FROM New_Request r 
	WHERE r.contributer_id = @contributor_id
END
ELSE BEGIN
	SELECT r.* FROM New_Request r 
	WHERE r.contributer_id = @contributor_id 
	AND r.ID = @request_id
END

GO

CREATE PROC Respond_New_Request @contributor_id INT, @accept_status BIT, @request_id INT
AS

IF EXISTS( SELECT * FROM New_Request c WHERE c.ID = @request_id and c.contributer_id IS NULL and c.accept_status = 1)BEGIN --Accepted request
	print ('Request is already accepted!')
END
ELSE IF EXISTS( SELECT * FROM New_Request c WHERE c.ID = @request_id and c.contributer_id = @contributor_id)BEGIN --Accepted request
	UPDATE New_Request SET accept_status = @request_id
	WHERE ID = @request_id AND contributer_id = @contributor_id
END

GO

CREATE PROC Upload_Original_Content @type_id INT, @subcategory_name VARCHAR(16), 
@category_id INT, @contributor_id iNT, @link VARCHAR(64)
AS
DECLARE @id INT
INSERT iNTO Content VALUES (@link, CURRENT_TIMESTAMP, @contributor_id, @category_id, @subcategory_name, @type_id)
SELECT @id = SCOPE_IDENTITY()
INSERT INTO Original_Content values (@id, NULL, NULL, NULL, NULL, 00.0)

GO

CREATE PROC Upload_New_Content @new_request_id INT, @contributor_id INT,
@subcategory_name VARCHAR(32), @category_id INT, @link VARCHAR(64)
AS
DECLARE @id INT
INSERT iNTO Content VALUES (@link, CURRENT_TIMESTAMP, @contributor_id, @category_id, @subcategory_name, NULL)
SELECT @id = SCOPE_IDENTITY()
insert into New_Content values (@id, @new_request_id) 

GO

CREATE PROC Delete_Content @content_id INT
AS
IF EXISTS (SELECT * FROM New_Content WHERE ID = @content_id) BEGIN
	DELETE FROM Content WHERE ID = @content_id
END
IF EXISTS (SELECT * FROM Original_Content o WHERE ID = @content_id and o.filter_status = 0) BEGIN
	DELETE FROM Content WHERE ID = @content_id
END
GO

CREATE PROC Receive_New_Request @contributor_id INT, @can_receive BIT OUTPUT

AS
DECLARE @COUNT INT
SELECT @COUNT = COUNT(r.ID)
FROM New_Request r
WHERE r.contributer_id = @contributor_id AND r.accept_status = 1
AND r.ID NOT IN (SELECT c.new_request_id FROM New_Content C)

IF(@COUNT > 3) SELECT @can_receive = 0
ELSE SELECT @can_receive = 1

GO
------------------------------------------------------------------------------------

--PART5:
CREATE PROC reviewer_filter_content @reviewer_id INT, @original_content INT, @status BIT
AS
IF EXISTS (SELECT * FROM Original_Content o WHERE o.reviewer_id = @reviewer_id)
	UPDATE Original_Content SET filter_status = @status
	WHERE reviewer_id = @reviewer_id
GO



CREATE PROC Staff_Create_Category @category_name VARCHAR(32)
AS
begin try
	INSERT INTO Category VALUES (@category_name, null)
end try
begin catch
	print ('Category name already exists')
end catch
GO

CREATE PROC Staff_Create_Subcategory @category_name VARCHAR(32), @subcategory_name VARCHAR(32)
AS
begin try
	INSERT INTO Sub_Category VALUES (@category_name, @subcategory_name)
end try
begin catch
	print ('Category does not exists or SubCategory exists')
end catch
GO

CREATE PROC Staff_Create_Type @type_name VARCHAR(32)
AS
begin try
	INSERT INTO Content_type VALUES (@type_name)
end try
begin catch
	print ('Content_type already exists')
end catch
GO

CREATE PROC Most_Requested_Content
AS

GO

CREATE PROC Delete_Original_Content @content_id INT
AS
IF EXISTS (SELECT * FROM Original_Content where ID = @content_id)
	DELETE FROM Content WHERE ID = @content_id

GO

CREATE PROC Delete_New_Content @content_id INT
AS

IF EXISTS (SELECT * FROM New_Content WHERE ID = @content_id) BEGIN
	DELETE FROM Content WHERE ID = @content_id
END
GO

CREATE PROC Assign_Contributor_Request @contributor_id INT, @new_request_id INT
AS
IF EXISTS (SELECT * FROM New_Request WHERE ID = @new_request_id) BEGIN
	UPDATE New_Request SET contributer_id = @contributor_id WHERE ID = @new_request_id
END

GO

------------------------------------------------------------------------------------