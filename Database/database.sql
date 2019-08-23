--CREATE DATABASE DBProject

--USE master;
--ALTER DATABASE DBProject SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
--DROP DATABASE DBProject

USE	DBProject


CREATE TABLE "User"(
	ID INT PRIMARY KEY IDENTITY,
	email		VARCHAR(32) unique not null,
	first_name	VARCHAR(16) not null,
	middle_name	VARCHAR(16) not null,
	last_name	VARCHAR(16) not null,
	birth_date	datetime NOT NULL,
	age			as( Year(current_timestamp) - Year(birth_date)),
	"password"	VARCHAR(32) not null,
	Active		BIT NOT NULL,
	Last_Login	datetime
	
);

CREATE TABLE Viewer(
	ID							INT PRIMARY KEY,
	working_place				VARCHAR(16)		NOT NULL,
	working_place_type			VARCHAR(16)		NOT NULL,
	working_place_description	VARCHAR(16),
	FOREIGN KEY(ID) REFERENCES "User"(ID)		ON DELETE CASCADE ON UPDATE CASCADE,

);


CREATE TABLE Notified_Person(
	ID INT PRIMARY KEY IDENTITY
);

--NOTE: years_of_experience update
--NOTE: notified_id is same as id?
CREATE TABLE Contributor(
	ID					INT PRIMARY KEY,
	years_of_experience INT					NOT NULL,
	portfolio_link		VARCHAR(64) unique	NOT NULL,
	specialization		VARCHAR(32)			NOT NULL,
	notified_id			INT					NOT NULL,
	FOREIGN KEY(ID)			 REFERENCES "User"(ID)			ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(notified_id) REFERENCES Notified_Person(ID)	ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Staff(
	ID				INT PRIMARY KEY,
	hire_date		datetime				NOT NULL,
	working_hours	INT						NOT NULL,
	payment_rate	Decimal(5,2)			NOT NULL,
	total_salary	as( payment_rate*working_hours ),
	notified_id		INT						NOT NULL,
	FOREIGN KEY(ID)			 REFERENCES "User"(ID)			ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(notified_id) REFERENCES Notified_Person(ID)	ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Content_type(
	"type" VARCHAR(16) PRIMARY KEY
);

CREATE TABLE Content_manager(
	ID		INT PRIMARY KEY,
	"type"	VARCHAR(16) NOT NULL, 
	FOREIGN KEY(ID)		REFERENCES Staff(ID)			ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY("type") REFERENCES Content_type("type")	ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Reviewer(
	ID INT PRIMARY KEY,
	FOREIGN KEY(ID) REFERENCES Staff(ID)				ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE "Message"(
	sent_at			datetime	,
	contributer_id	INT			,
	viewer_id		INT			,
	sender_type		VARCHAR(16) ,
	read_at			datetime	,
	"text"			VARCHAR(64) ,
	read_status		BIT			NOT NULL,
	PRIMARY KEY(sent_at, contributer_id, viewer_id, sender_type),
	FOREIGN KEY(contributer_id) REFERENCES Contributor(ID)	ON DELETE NO ACTION ON UPDATE NO ACTION,
	FOREIGN KEY(viewer_id)		REFERENCES Viewer(ID)		ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE Category(
	"type"			VARCHAR(16) PRIMARY KEY NOT NULL,
	"description"	VARCHAR(64)
);

CREATE TABLE Sub_Category(
	category_type	VARCHAR(16),
	name			VARCHAR(16),
	PRIMARY KEY(category_type, name),
	FOREIGN KEY(category_type) REFERENCES Category("type")	ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Notification_Object(
	ID INT PRIMARY KEY IDENTITY
);

CREATE TABLE Content(
	ID				 INT PRIMARY KEY IDENTITY,
	link			 VARCHAR(64)unique	NOT NULL, 
	uploaded_at		 datetime			NOT NULL,
	contributer_id	 INT				NOT NULL,
	category_type	 VARCHAR(16),
	subcategory_name VARCHAR(16),
	"type"			 VARCHAR(16)		NOT NULL,
	FOREIGN KEY("type")								REFERENCES content_type("type")	ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(category_type,subcategory_name)		REFERENCES Sub_Category			ON DELETE SET NULL ON UPDATE CASCADE,
	FOREIGN KEY(contributer_id)						REFERENCES Contributor(ID)		ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Original_Content(
	ID		INT PRIMARY KEY,
	content_manager_id  INT,
	reviewer_id			INT,
	review_status		BIT,
	filter_status		BIT,
	rating				DECIMAL(3,1),
	FOREIGN KEY(ID)					REFERENCES content(ID)			ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(reviewer_id)		REFERENCES Reviewer(ID),
	FOREIGN KEY(content_manager_id) REFERENCES content_manager(ID)	
);

CREATE TABLE Existing_Request(
	ID		INT PRIMARY KEY IDENTITY,
	original_content_id INT NOT NULL,
	viewer_id			INT NOT NULL,
	FOREIGN KEY(original_content_id) REFERENCES Original_Content(ID),
	FOREIGN KEY(viewer_id)			 REFERENCES viewer(ID)				ON UPDATE CASCADE
);

--select CONSTRAINT_NAME
--from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
--where TABLE_NAME = 'New_Request'

CREATE TABLE New_Request(
	ID				INT PRIMARY KEY IDENTITY,
	accept_status	bit NOT NULL,
	specified		bit NOT NULL,
	information		VARCHAR(64),
	viewer_id		INT NOT NULL,
	notif_obj_id	INT NOT NULL,
	contributer_id	INT,
	FOREIGN KEY(viewer_id)      REFERENCES viewer(ID)				ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(notif_obj_id)   REFERENCES notification_object(ID)	ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(contributer_id) REFERENCES Contributor(ID)			
);

CREATE TABLE New_Content(
	ID					INT PRIMARY KEY,
	new_request_id	    INT NOT NULL,
	FOREIGN KEY(ID)			    REFERENCES content(ID)		ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(new_request_id) REFERENCES new_request(ID)	
);

CREATE TABLE Comment(
	Viewer_id			 INT,
	original_content_id  INT,
	"date"				 datetime,
	"text"				 VARCHAR(64) NOT NULL,
	PRIMARY KEY(Viewer_id, original_content_id, "date"),
	FOREIGN KEY(Viewer_id)			    REFERENCES Viewer(ID)			ON UPDATE CASCADE,
	FOREIGN KEY(original_content_id)	REFERENCES original_content(ID)	ON DELETE CASCADE 
);

CREATE TABLE Rate(
	viewer_id			INT,
	original_content_id INT,
	"date"				datetime		NOT NULL,
	rate				Decimal(3,1)	NOT NULL,
	PRIMARY KEY(viewer_id, original_content_id),
	FOREIGN KEY(Viewer_id)			    REFERENCES Viewer(ID)			ON UPDATE CASCADE,
	FOREIGN KEY(original_content_id)	REFERENCES original_content(ID)	ON DELETE CASCADE 
);

CREATE TABLE "Event"(
	id						INT PRIMARY KEY IDENTITY,
	"description"			VARCHAR(64),
	"location"				VARCHAR(64),
	city					VARCHAR(16) NOT NULL,
	"time"					datetime	NOT NULL,
	entertainer				VARCHAR(16),
	notification_object_id	INT,
	viewer_id				INT			NOT NULL,
	FOREIGN KEY(notification_object_id)	REFERENCES notification_object(ID)	ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(viewer_id)				REFERENCES viewer(ID)				ON UPDATE CASCADE
);

CREATE TABLE Event_Photos_link(
	event_id	INT,
	link		VARCHAR(64) UNIQUE,
	PRIMARY KEY(event_id, link),
	FOREIGN KEY(event_id)		REFERENCES "Event"(ID)	ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Event_Videos_link(
	event_id	INT,
	link		VARCHAR(64) UNIQUE,
	PRIMARY KEY(event_id, link),
	FOREIGN KEY(event_id)		REFERENCES "Event"(ID)	ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Advertisement(
	ID				INT PRIMARY KEY IDENTITY,
	"description"	VARCHAR(16),
	"location"		VARCHAR(16)	NOT NULL,
	event_id		INT			,
	viewer_id		INT			NOT NULL,
	FOREIGN KEY(event_id)	REFERENCES "Event"(id)	,
	FOREIGN KEY(viewer_id)  REFERENCES "viewer"(id)	,
);

Create table ads_video_link(
	advertisement_id	INT,
	link				VARCHAR(64) UNIQUE,
	PRIMARY KEY(advertisement_id,link),
	FOREIGN KEY(advertisement_id)		REFERENCES "Advertisement"(id)	ON DELETE CASCADE ON UPDATE CASCADE,
);

Create table ads_photos_link(
	advertisement_id	INT,
	link				VARCHAR(64) UNIQUE,
	PRIMARY KEY(advertisement_id,link),
	FOREIGN KEY(advertisement_id)		REFERENCES "Advertisement"(id)	ON DELETE CASCADE ON UPDATE CASCADE,
);

Create table announcement(
	id						INT PRIMARY KEY IDENTITY,
	seen_at					datetime,
	sent_at					datetime	NOT NULL,
	notified_person_id		INT			NOT NULL,
	notification_object_id	INT			NOT NULL,
	FOREIGN KEY(notified_person_id)		REFERENCES "notified_person"(id)		ON UPDATE CASCADE,
	FOREIGN KEY(notification_object_id) REFERENCES "notification_object"(id)	ON DELETE CASCADE ON UPDATE CASCADE,
);

