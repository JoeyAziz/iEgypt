<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProfilePage.aspx.cs" Inherits="iEgypt_M3.ProfilePage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>iEgypt|Profile Page</title>
<style>

/*Button Style*/
.buttonTemplate{
    border-radius       :   25px;
    vertical-align      :   bottom;
    background-color    :   #800000;
    border              :   1px solid #800000;
    color               :   white;
}

</style>

</head>
<body>
    <form id="form2" runat="server">
        <div runat="server" id = 'welcomeBack'>
            <h1 style = "text-align:center;color:#C0C0C0;">
                <a href="HomePage.aspx">iEgypt</a>

            </h1>
            <h5 runat="server" id = "titleName" style = "text-align:center;color:lightblue;margin-left: 25px;">Your Personal Information</h5>
        </div>
        <div>
            <asp:Label runat ="server" id="profileOutput"/>
        </div>
        <asp:Button runat="server" class="buttonTemplate" text="EDIT PROFILE" id='editProfileButton' OnClick="GotoEditProfile" /><br />
        <asp:Button runat="server" class="buttonTemplate" text="My Functions Page" id='functionsButton' OnClick="GotoFunctionsClicked" />

    </form>
</body>
</html>
