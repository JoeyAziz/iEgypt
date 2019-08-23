use DBProject

declare @typename varchar(16) = 'images'

EXEC Original_Content_Search 'images' , '';

EXEC Contributor_Search 'Mona Ahmed Omar';

declare @user_id INT
EXEC Register_User 'Viewer', 'mail@test.com', '1234', 'Joe',
'Ali', 'harb', '1/1/2104', 'AUC', 'Blah Blah',
'description', 'specialization##2', 'xxx', 10, '1/1/2018',
0, 900.00, @user_id output

EXEC Check_Type 'cartoons', 13

EXEC Order_Contributers

EXEC SHOW_ORIGINAL_CONTENT 8

declare @user_id  INT 
EXEC User_login 'AliSF@gmail.com', '123', @user_id output
print(@user_id)

declare @user_id INT, @email VARCHAR(32), @password VARCHAR(32), @firstname VARCHAR(32), @middlename VARCHAR(32),
@lastname VARCHAR(32), @birth_date DATE, @working_place_name VARCHAR(32), @working_place_type VARCHAR(32)
, @wokring_place_description VARCHAR(32), @specilization VARCHAR(32),
@portofolio_link VARCHAR(32), @years_experience INT, @hire_date DATE, @working_hours INT
, @payment_rate DEC(5,2)
EXEC Show_Profile 1, @email OUTPUT, @password OUTPUT, @firstname OUTPUT, @middlename OUTPUT,
@lastname OUTPUT, @birth_date OUTPUT, @working_place_name OUTPUT, @working_place_type
OUTPUT, @wokring_place_description OUTPUT, @specilization OUTPUT,
@portofolio_link OUTPUT, @years_experience OUTPUT, @hire_date OUTPUT, @working_hours
OUTPUT, @payment_rate OUTPUT
print(@email) 
--+ @password + @firstname + @middlename +@lastname + @birth_date + @working_place_name + @working_place_type
--+ @wokring_place_description + @specilization + @portofolio_link + @years_experience + @hire_date + @working_hours
--+ @payment_rate )

EXEC Show_Event 1
EXEC Show_Event null

EXEC Receive_New_Requests null, 4

EXEC Upload_Original_Content 1, 'Educational', 1, 1, 'test'

DECLARE @can_receive BIT 
EXEC Receive_New_Request 4, @can_receive OUTPUT
print(@can_receive)

EXEC Staff_Create_Category 'This is Test'

EXEC Viewer_Create_Event 'cairo','12:00:00','balabizo','tamora',2,1;
EXEC Viewer_Upload_Event_Video  1,'Link#61565511';
EXEC Viewer_Create_Ad_From_Event 1;
EXEC Apply_Existing_Request 1,4;
EXEC Delete_New_Request 10;
EXEC Rating_Original_Content 4,4,1;
EXEC Write_Comment 1,4,'1/1/2018','This is a comment';
EXEC Edit_Comment 'This is not a comment',1,4,'1/1/2018','11/23/2018';
EXEC Delete_Comment 1,4,'11/23/2018';
EXEC Create_Ads 1,'balabizo','home';
EXEC Delete_Ads 4;
EXEC Send_Message 'samsing',1,4,'viewer','1/1/2018';
EXEC Show_Message 4;
EXEC Highest_Rating_Original_content;

 