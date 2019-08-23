USE DBProject

--Categories
INSERT INTO Category VALUES ('Educational'	, 'Largest overall education system in Africa');
INSERT INTO Category VALUES ('Investment'	, 'Largest Global Companies are investing in Egypt');
INSERT INTO Category VALUES ('Tourism'		, 'Luxor alone has 1/3 of the worlds ancient monuments');
----------------------------------

--Sub-Categories
INSERT INTO Sub_Category VALUES ('Educational'	, 'PHD Studies');
INSERT INTO Sub_Category VALUES ('Tourism'		, 'Monumental ');
----------------------------------

--Content Type
INSERT INTO Content_type VALUES ('images');
INSERT INTO Content_type VALUES ('logos');
INSERT INTO Content_type VALUES ('videos');
----------------------------------

--USERS INSERTION:
INSERT INTO "User" VALUES ('AhmedAS@gmail.com'	 , 'Ahmed'	, 'Ali'		, 'Samy'	,'11/8/1990' ,'123' ,1, CURRENT_TIMESTAMP);
INSERT INTO "User" VALUES ('OmarMS@gmail.com'	 , 'Omar'	, 'Mohamed' , 'Sayed'	,'1/2/1989'	 , '123',1, CURRENT_TIMESTAMP);
INSERT INTO "User" VALUES ('AmgadAF@gmail.com'	 , 'Amgad'	, 'Ahmed'	, 'Fared'	,'3/3/2000'	 , '123',1, CURRENT_TIMESTAMP);
INSERT INTO "User" VALUES ('MonaAO@gmail.com'	 , 'Mona'	, 'Ahmed'	, 'Omar'	,'5/7/1985'	 , '123',1, CURRENT_TIMESTAMP);
INSERT INTO "User" VALUES ('SarahFM@gmail.com'	 ,'Sarah'	, 'Farouk'	, 'Magdy '	,'9/8/1991'	 , '123',1, CURRENT_TIMESTAMP);
INSERT INTO "User" VALUES ('ShriedAM@gmail.com'  , 'Shrief'	, 'Ahmed'	, 'Mohamed'	,'2/12/1994' , '123',1, CURRENT_TIMESTAMP);
INSERT INTO "User" VALUES ('AlaaMA@gmail.com'	 , 'Alaa'	, 'Mahmoud' , 'Ahmed'	,'3/12/1997' , '123',1, CURRENT_TIMESTAMP);
INSERT INTO "User" VALUES ('ManarHS@gmail.com'	 , 'Manar'	, 'Hatem'	, 'Samy'	,'4/8/1990'	 , '123',1, CURRENT_TIMESTAMP);
INSERT INTO "User" VALUES ('AbdallahAM@gmail.com','Abdallah', 'Ali'		, 'Mohamed' ,'8/6/1999'	 , '123',1, CURRENT_TIMESTAMP);
INSERT INTO "User" VALUES ('MalakYM@gmail.com'	 , 'Malak'	, 'Youssef' , 'Maged'	,'12/12/1992', '123',1, CURRENT_TIMESTAMP);
INSERT INTO "User" VALUES ('SayedSA@gmail.com'	 , 'Sayed'	, 'Salah'	, 'Ahmed'	,'2/7/2000'	 , '123',1, CURRENT_TIMESTAMP);
INSERT INTO "User" VALUES ('MarkJN@gmail.com'	 , 'Mark'	, 'John'	, 'Nabil'	,'1/1/1990'	 , '123',1, CURRENT_TIMESTAMP);
INSERT INTO "User" VALUES ('AliSF@gmail.com'	 , 'Ali'	, 'Sameh'	, 'Fahd'	,'9/7/1991'	 , '123',1, CURRENT_TIMESTAMP);
----------------------------------

--Users:Viewer Type:
INSERT INTO Viewer VALUES(1	,'GUC'		,'Great university'	,'university');
INSERT INTO Viewer VALUES(2	,'CIB'		,'Bank in Egypt'	,'BANK');
INSERT INTO Viewer VALUES(3	,'SamCrete'	,'Eng. Company'		,'Company');
----------------------------------

INSERT INTO Notified_Person default VALUES;
INSERT INTO Notified_Person default VALUES;
INSERT INTO Notified_Person default VALUES;
INSERT INTO Notified_Person default VALUES;
INSERT INTO Notified_Person default VALUES;
INSERT INTO Notified_Person default VALUES;
INSERT INTO Notified_Person default VALUES;
INSERT INTO Notified_Person default VALUES;
INSERT INTO Notified_Person default VALUES;
INSERT INTO Notified_Person default VALUES;

--Users:contributors Type:
INSERT INTO Contributor(ID, years_of_experience, portfolio_link, specialization, notified_id) VALUES(4,1,'Link#1','graphic designer',1);
INSERT INTO Contributor(ID, years_of_experience, portfolio_link, specialization, notified_id) VALUES(5,2,'Link#2','photographer',2);
INSERT INTO Contributor(ID, years_of_experience, portfolio_link, specialization, notified_id) VALUES(6,3,'Link#3','video editor',3);
INSERT INTO Contributor(ID, years_of_experience, portfolio_link, specialization, notified_id) VALUES(7,4,'Link#4','director',4);
INSERT INTO Contributor(ID, years_of_experience, portfolio_link, specialization, notified_id) VALUES(8,5,'Link#5','photographer',5);
----------------------------------

--Users:Staff members:
INSERT INTO Staff(ID,hire_date,working_hours,payment_rate, notified_id) VALUES(9 ,'1/1/2018',8,600.99,6);
INSERT INTO Staff(ID,hire_date,working_hours,payment_rate, notified_id) VALUES(10,'2/1/2017',10,696.98,7);
INSERT INTO Staff(ID,hire_date,working_hours,payment_rate, notified_id) VALUES(11,'2/1/2017',6,500.99,8);
INSERT INTO Staff(ID,hire_date,working_hours,payment_rate, notified_id) VALUES(12,'2/1/2017',10,800.50,9);
INSERT INTO Staff(ID,hire_date,working_hours,payment_rate, notified_id) VALUES(13,'2/1/2017',9,820.98,10);
----------------------------------

--Users:authorized reviewer:
INSERT INTO Reviewer VALUES(9);
INSERT INTO Reviewer VALUES(10);
----------------------------------

--Users: Content Managers
INSERT INTO Content_manager VALUES(11, 'images');
INSERT INTO Content_manager VALUES(12, 'logos');
INSERT INTO Content_manager VALUES(13, 'videos');
----------------------------------

--Content
INSERT INTO Content VALUES ('Link#1', '1/2/2018', 5, 'Educational', 'PHD Studies', 'images');
INSERT INTO Content VALUES ('#Link#2', '2/2/2018', 5, 'Educational', 'PHD Studies', 'logos');
INSERT INTO Content VALUES ('L#ink#3', '1/3/2018', 5, 'Tourism'	  , 'Monumental' , 'videos');
INSERT INTO Content VALUES ('Link#4', '2/3/2018', 7, 'Tourism'	  , 'Monumental' , 'images');
INSERT INTO Content VALUES ('Link#5', '3/3/2018', 8, 'Tourism'	  , 'Monumental' , 'logos');
----------------------------------

--Original Content
INSERT INTO Original_Content VALUES (4,11,9,1,1,4);--1 = True
INSERT INTO Original_Content VALUES (5,12,9,1,1,1);
----------------------------------

--Existing Requests
INSERT INTO Existing_Request VALUES (4,1);
INSERT INTO Existing_Request VALUES (5,2);
----------------------------------

INSERT INTO Notification_Object DEFAULT VALUES;
INSERT INTO Notification_Object DEFAULT VALUES;
INSERT INTO Notification_Object DEFAULT VALUES;
INSERT INTO Notification_Object DEFAULT VALUES;
INSERT INTO Notification_Object DEFAULT VALUES;
INSERT INTO Notification_Object DEFAULT VALUES;
INSERT INTO Notification_Object DEFAULT VALUES;
INSERT INTO Notification_Object DEFAULT VALUES;
INSERT INTO Notification_Object DEFAULT VALUES;
INSERT INTO Notification_Object DEFAULT VALUES;
INSERT INTO Notification_Object DEFAULT VALUES;
INSERT INTO Notification_Object DEFAULT VALUES;
INSERT INTO Notification_Object DEFAULT VALUES;
--New Requests
INSERT INTO New_Request VALUES (1,1,'information#1', 1, 1, 4);
INSERT INTO New_Request VALUES (1,1,'information#2', 2, 2, 4);

INSERT INTO New_Request VALUES (1,1,'information#3', 1, 3, 5);
INSERT INTO New_Request VALUES (1,1,'information#4', 2, 4, 5);
INSERT INTO New_Request VALUES (1,1,'information#5', 3, 5, 5);

INSERT INTO New_Request VALUES (1,1,'information#6', 1, 6, 6);
INSERT INTO New_Request VALUES (1,1,'information#7', 2, 7, 7);
INSERT INTO New_Request VALUES (1,1,'information#8', 3, 8, 8);

INSERT INTO New_Request VALUES (0,0,'information#9' , 1, 9 , NULL);
INSERT INTO New_Request VALUES (0,0,'information#10', 2, 10, NULL);
INSERT INTO New_Request VALUES (0,0,'information#11', 2, 11, NULL);
----------------------------------

--New Content
INSERT INTO New_Content VALUES (1,3); 
INSERT INTO New_Content VALUES (2,4);
INSERT INTO New_Content VALUES (3,5);
----------------------------------

--Events
INSERT INTO "Event" VALUES ('EVENT#1', 'LOCATION#1', 'ALEX',   '5:00', 'ENTERTAINER#1', 12,1);
INSERT INTO "Event" VALUES ('EVENT#2', 'LOCATION#2', 'CAIRO', '10:00', 'ENTERTAINER#2', 13,2);
----------------------------------

--Advertisements
INSERT INTO Advertisement VALUES ('AD#1', 'LOC#1', 1, 1);
INSERT INTO Advertisement VALUES ('AD#2', 'LOC#2', 2, 2);
----------------------------------

--Announcements

--New Requests#
INSERT INTO announcement VALUES (NULL,'2/12/2018',1,1);
INSERT INTO announcement VALUES (NULL,'6/1/2018',1,2);
INSERT INTO announcement VALUES (NULL,'1/11/2018',2,3);
INSERT INTO announcement VALUES (NULL,'3/13/2018',2,4);
INSERT INTO announcement VALUES (NULL,'5/11/2018',2,5);
INSERT INTO announcement VALUES (NULL,'7/17/2018',3,6);
INSERT INTO announcement VALUES (NULL,'8/18/2018',4,7);
INSERT INTO announcement VALUES (NULL,'3/19/2018',5,8);

INSERT INTO announcement VALUES (NULL,'1/1/2018',1,9);
INSERT INTO announcement VALUES (NULL,'1/1/2018',2,9);
INSERT INTO announcement VALUES (NULL,'1/1/2018',3,9);
INSERT INTO announcement VALUES (NULL,'1/1/2018',4,9);
INSERT INTO announcement VALUES (NULL,'1/1/2018',5,9);

INSERT INTO announcement VALUES (NULL,'2/2/2018',1,10);
INSERT INTO announcement VALUES (NULL,'2/2/2018',2,10);
INSERT INTO announcement VALUES (NULL,'2/2/2018',3,10);
INSERT INTO announcement VALUES (NULL,'2/2/2018',4,10);
INSERT INTO announcement VALUES (NULL,'2/2/2018',5,10);

INSERT INTO announcement VALUES (NULL,'3/3/2018',1,11);
INSERT INTO announcement VALUES (NULL,'3/3/2018',2,11);
INSERT INTO announcement VALUES (NULL,'3/3/2018',3,11);
INSERT INTO announcement VALUES (NULL,'3/3/2018',4,11);
INSERT INTO announcement VALUES (NULL,'3/3/2018',5,11);

--Event#1
INSERT INTO announcement VALUES (NULL,'1/10/2018',1,12);
INSERT INTO announcement VALUES (NULL,'1/10/2018',2,12);
INSERT INTO announcement VALUES (NULL,'1/10/2018',3,12);
INSERT INTO announcement VALUES (NULL,'1/10/2018',4,12);
INSERT INTO announcement VALUES (NULL,'1/10/2018',5,12);
INSERT INTO announcement VALUES (NULL,'1/10/2018',6,12);
INSERT INTO announcement VALUES (NULL,'1/10/2018',7,12);
INSERT INTO announcement VALUES (NULL,'1/10/2018',8,12);
INSERT INTO announcement VALUES (NULL,'1/10/2018',9,12);
INSERT INTO announcement VALUES (NULL,'1/10/2018',10,12);

--Event#2
INSERT INTO announcement VALUES (NULL,'3/13/2018',1,13);
INSERT INTO announcement VALUES (NULL,'3/13/2018',2,13);
INSERT INTO announcement VALUES (NULL,'3/13/2018',3,13);
INSERT INTO announcement VALUES (NULL,'3/13/2018',4,13);
INSERT INTO announcement VALUES (NULL,'3/13/2018',5,13);
INSERT INTO announcement VALUES (NULL,'3/13/2018',6,13);
INSERT INTO announcement VALUES (NULL,'3/13/2018',7,13);
INSERT INTO announcement VALUES (NULL,'3/13/2018',8,13);
INSERT INTO announcement VALUES (NULL,'3/13/2018',9,13);
INSERT INTO announcement VALUES (NULL,'3/13/2018',10,13);
----------------------------------