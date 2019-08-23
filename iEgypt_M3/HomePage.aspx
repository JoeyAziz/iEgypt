<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HomePage.aspx.cs" Inherits="iEgypt_M3.HomePage" %>

<!DOCTYPE html>

<html lang = "en-US">

<Head runat="server">
<title>iEgypt</title>
<style>

/*
	Header Panel
*/

* {
    box-sizing: border-box;
}

#HPanel {
	background-color	:	lightseagreen;
	overflow			: 	hidden;
	list-style-type		: 	none;
	margin				: 	0;
	padding				: 	0;
}

#HPanel .leftbox{
    float				:	left;
    display				: 	inline;
	background-color	:	transparent;
}

#HPanel .rightbox{
    float				:	right;
    display				: 	inline;
    width				: 	200px;
	background-color	:	transparent;
}

input[type=text],[type=password], select, textarea {
    width				: 	100%;
    padding				: 	6px;
    border				: 	1px solid #ccc;
    border-radius		:	4px;
    resize				: 	vertical;
	margin-top			: 	6px;
}

/**************************************/
/*Vertical Line*/
.vl {
    border-left			: 	1px solid white;
    height				: 	200px;
	position			: 	absolute;
	left				: 	80%;
	float				:	left;
}
/****************************************/
/*Button Style*/
.buttonTemplate{
    border-radius       :   25px;
    vertical-align      :   bottom;
    background-color    :   #800000;
    border              :   1px solid #800000;
    color               :   white;
}

</style>

</Head>

<body style="background: #f4f7f8;">
<form runat="server" id="form1" >
<!--Header Panel-->
<div runat="server" id = 'welcomeBack' style ="display:none;">
    <h1 style = "text-align:center;color:#C0C0C0;">iEgypt</h1>
    <asp:label runat="server" id = "welcomeTitle" style = "text-align:center;color:lightblue;margin-left: 25px;font-size:18px;" />

</div>
<div runat="server" id = 'HPanel'>
	<div class="leftbox" style="width:30%">
		<h4 style='color:white'>Why waste time?
		<a style='color:Blue' href = "RegisterPage.aspx">REGISTER</a>&nbsp now
		</h4>        
	</div>
    <div class="leftbox" style="width:20%">
	    <span style="color:goldenrod;display:inline;font-size:50px;float:right;margin-left: 50px;">iEgypt</span>
    </div>
	<div class="rightbox">		
			<div class="vl"></div>
			<input  runat="server"  type="text"    	 id="inputEmail"		 placeholder="EX:myEmail@domain.com "  autocomplete="off">
			<input  runat="server"  type="password"	 id="inputPassword" 	 placeholder="Password" autocomplete="off">     
			<asp:Button runat="server" text="Sign in" id='signinButton'      style='border-radius:15px;'  OnClick="SignInClickedButton"/>
			<asp:label  runat="server"  text="Wrong username/password" id='signinErrorLabel'  style='color:red;font-size:8px;'  />
	</div>
	
</div>

<div style="background-color:transparent;">
		<br>
		<br>
		<label style ='float:left;display:inline;color:#800000;font-size:25px;'>Looking for something? </label>
		<div style ='float:left;display:inline;width:50%;border-radius:15px;'>
			<input runat="server" type="text" 		id="inputSearch" 	 placeholder="search for original content/contributor" autocomplete="off"> 
		</div>
		
		<div style ='float:left;display:inline;width:10%;position: absolute;padding:5px;'>
			<asp:Button runat="server" text="SEARCH" id='searchButton' class="buttonTemplate" OnClick="SearchClickedButton"/>
        </div>
		<br>
		<label runat="server"  id='searchLabel' style='color:red;font-size:12px;'  >No Result Found</label>
		<br>
		<br>
</div>

<br>
<br>
<asp:Label id="originalSearchLabel" runat="server"/>
<br>
<br>
<asp:Label id="contributorSearchLabel" runat="server"/>
<br>
<br>
<label runat="server" style="color:rosybrown;font-size:16px;">You can view everything with a click, right here</label>

<p>
    <asp:Button runat="server" class="buttonTemplate" text="SHOW ALL CONTRIBUTORS" id='showContributorsButton' OnClick="ShowAllContributors" />
    <asp:Button runat="server" class="buttonTemplate" text="SHOW ALL ORIGINAL CONTENT" id='showOriginalContentButton' OnClick="ShowAllOriginalContent" />
</p>

<p>
    <asp:Label id="allContributorsLabel" runat="server"/>
    <br />
    <asp:Label id="allOriginalContentLabel" runat="server"/>
</p>

</form>
</body>

</html>