<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RegisterPage.aspx.cs" Inherits="iEgypt_M3.RegisterPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>iEgypt|Register</title>
<style>


* {
    box-sizing: border-box;
}
input[type=text],[type=password],[type=number], select, textarea {
    width				: 	50%;
    padding				: 	6px;
    border				: 	1px solid #ccc;
    border-radius		:	4px;
    resize				: 	vertical;
	margin-top			: 	6px;
}

/**************************************/

</style>

</head>

<body style="background: #f4f7f8;">
<h1 style = "text-align:center;color:#C0C0C0;">
    <a href="HomePage.aspx">iEgypt</a>
</h1>
<h5 style = "text-align:center;color:lightblue;margin-left: 25px;">Register Your Personal Information</h5>
<br />
<br />
<div>
	<form runat="server" >
        <div>
            <asp:DropDownList ID="userSelectType" runat="server" style='float:left' AutoPostBack="True" onselectedindexchanged="OnSelectionChange">
                <asp:ListItem Text="Viewer" Value="viewerType"></asp:ListItem>
                <asp:ListItem Text="Contributor" Value="contributorType"></asp:ListItem>
            </asp:DropDownList>
            <label style='float:left;font-size:14px;color:brown'>Choose your membership type</label>
        </div>
        <br>
        <br>
		<input runat="server"  type="text"     	id="inputEmail"		 placeholder="EX:myEmail@domain.com " autocomplete="off" >
		<input runat="server"  type="password" 	id="inputPassword" 	 placeholder="Password" autocomplete="off">  
		<div>
			<input runat="server" style='float:left;width:15%;'  type="text" 	id="inputFirstName" 	 placeholder="First Name" autocomplete="off">
			<input runat="server" style='float:left;width:20%;'  type="text" 	id="inputMiddleName" 	 placeholder="Middle Name" autocomplete="off">
			<input runat="server" style='float:left;width:15%;'  type="text" 	id="inputLastName" 	 	 placeholder="Last Name" autocomplete="off">
		</div>
		<br><br>
		<input runat="server"  type="text"     	id="inputBirthDate"		 		placeholder="Birth Date EX: dd-Sep-yy" autocomplete="off" >
        <div runat="server" id="contributorInputPart" >
            <input runat="server"  type="text"     id="inputWorkingName"		 	placeholder="Working Place Name" autocomplete="off" >
		    <input runat="server"  type="text"     	id="inputWorkingType"		 	placeholder="Working Place Type" autocomplete="off" >
		    <input runat="server"  type="text"     	id="inputWorkingDescription"	placeholder="Working Place Description" autocomplete="off" >
		    <input runat="server"  type="text"     	id="inputSpecialization"		placeholder="Specialization" autocomplete="off" >
		    <input runat="server"  type="text"     	id="inputPortofolio"		 	placeholder="Portofolio Link" autocomplete="off" >
		    <input runat="server"  type="number"    id="inputYearsExp"		 		placeholder="Years Of Experience" autocomplete="off" >
		</div>
        <br><br>
		<asp:button runat="server" Text="Register" 		id='registerButton' style='border-radius:15px;' OnClick="OnRegisterButtonClicked"/>
		<label runat="server" id='registerLabel' style='color:red;font-size:12px;display:none;'  >Could not Register your information</label>
	</form>

</div>

</body>
</html>
