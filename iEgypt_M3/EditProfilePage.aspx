<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditProfilePage.aspx.cs" Inherits="iEgypt_M3.EditProfilePage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>iEgypt|Edit Profile</title>

<style>
body{
	max-width		: 500px;
	padding			: 10px 20px;
	background		: #f4f7f8;
	margin			: 10px auto;
	padding			: 20px;
	background		: #f4f7f8;
	border-radius	: 8px;
	font-family		: Georgia, "Times New Roman", Times, serif;
}

.number {
	background		: #1abc9c;
	color			: #fff;
	height			: 30px;
	width			: 30px;
	display			: inline-block;
	font-size		: 0.8em;
	margin-right	: 4px;
	line-height		: 30px;
	text-align		: center;
	text-shadow		: 0 1px 0 rgba(255,255,255,0.2);
	border-radius	: 0px 15px 15px 15px;
}

fieldset{
	border			: none;
}

legend {
	font-size		: 1.4em;
	margin-bottom	: 10px;
}

input[type=text],[type=password], [type=number], select, textarea {
    width				: 	50%;
    padding				: 	6px;
    border				: 	1px solid #ccc;
    border-radius		:	4px;
    resize				: 	vertical;
	margin-top			: 	6px;

}

label {
	display: block;
	margin-bottom: 8px;
}

.buttonStyle
{
	position			: relative;
	display				: block;
	padding				: 19px 39px 18px 39px;
	color				: #FFF;
	margin				: 0 auto;
	background			: #1abc9c;
	font-size			: 18px;
	text-align			: center;
	font-style			: normal;
	width				: 100%;
	border				: 1px solid #16a085;
	border-width		: 1px 1px 3px;
	margin-bottom		: 10px;
}

</style>

</head>

<body>

<div class="form-style-5">
	<form runat="server">
		<fieldset>
			<legend><span class="number">1</span> Personal Info</legend>
            <div>
			    <input runat="server" type="text"  id="firstnameField" 		placeholder="First Name *"  style='width:14%;'/>
                <input runat="server" type="text"  id="middlenameField" 	placeholder="Middle Name *" style='width:14%;'/>
                <input runat="server" type="text"  id="lastnameField" 		placeholder="Last Name *"   style='width:14%;'/>
            </div>
			<input runat="server" type="text" 	id="passwordField" 	placeholder="Your Password *"/>
			<input runat="server" type="text"  id="emailField" 		placeholder="Your E-Mail *"/>
			<input runat="server" type="text"  id="birthdateField" 	placeholder="Your Birthdate *"/>
			<!--More Infor-->
			<br />
			<br />
			<br />
			<!--Viewer Part-->
			<div runat="server" id = 'viewerPart' style ="display:none;">
			    <legend><span class="number">2</span> More Info as a (viewer)</legend>
			    <input runat="server" type="text"  id="wplaceField" 					placeholder="Your Working Place *">
			    <input runat="server" type="text" 	id="wplaceTypeField" 				placeholder="Your Working placetype *">
			    <input runat="server" type="text"  id="wplaceDescriptionField" 		    placeholder="Your Working place description *">
			</div>
			<!--Contributor-->
			<div runat="server" id = 'contributorPart' style ="display:none;">
			    <legend><span class="number">2</span> More Info as a (contributor)</legend>
			    <input runat="server" type="number"  id="experienceField" 		    placeholder="Your Years Of Experience *">
			    <input runat="server" type="text" 	id="pLinkField" 				placeholder="Your Portofolio Link *">
			    <input runat="server" type="text"  id="specializationField" 		placeholder="Your Specialization *">
			</div>
			<!--STAFF MEMBERS-->
			<div runat="server" id = 'staffPart' style ="display:none;">
			    <legend><span class="number">2</span> More Info as a (staff member)</legend>
			    <input runat="server" type="text"   id="hireDateField" 	        placeholder ="Hire Date *" 		 >
			    <input runat="server" type="number" id="wHoursField" 			placeholder="Working Hours *"	 >
			    <input runat="server" type="text"   id="paymentRateField"       placeholder ="Payment Rate *"	 >
			</div>
			<!--Content Managers-->
			<div runat="server" id = 'cmanagerPart' style ="display:none;">
			    <input runat="server" type="text"  id="typeField" 				placeholder="Your Content type *">
			</div>
			<br />
			<br />
			<br />
		</fieldset>
		<asp:button class="buttonStyle" runat="server" Text="Apply Change"	onclick="OnEditProfileButtonClicked" id='profileEditButton'/>
        <p>
            <asp:Label style="font-size:10px;color:red" Text="**You must Fill in ALL the information above inorder to continue" id="errorLabel" runat="server" />
        </p>
		<asp:button runat="server" Text="Deactivate my account" onclick="OnDeactivateButtonClicked"	id='deactivationButton'/>
	</form>
</div>

</body>
</html>
