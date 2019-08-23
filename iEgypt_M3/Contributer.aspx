<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Contributer.aspx.cs" Inherits="WA1.Contributer" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>iEgypt</title>
    <style>
        body{
            background-color : darkgray;
        }
        input[type="text"], TextBox{
            width : 35%;
            height: 35%;
            border-radius : 0px 0px 10px 10px;
            font-size : 12px;
            font-weight:bold;
            background-color:azure;
            color:darkseagreen;
        }
        .Stylebutton{
            background-color: rebeccapurple;
            color:wheat;
            border-radius:10px 0px 15px;
        }
        .StyleTitle{
            text-align:center;
            color:crimson;
            font-weight:bold;
            font-size:50px;
            background-color:lightskyblue;
            border-radius: 40px 40px 40px 40px
        }
    </style>
</head>
<body>
    <h1 style = "text-align:center;color:#C0C0C0;">
                <a href="HomePage.aspx">iEgypt</a>

    </h1>
    <form id="form1" runat="server">
        <div class="StyleTitle">Contributer</div><br /><br />
        <asp:Button ID="Button1" class="Stylebutton" runat="server" Text="Upload Original Content"  OnClick="redirectUpload"/>&nbsp&nbsp
        <asp:Button ID="Button5" class="Stylebutton" runat="server" Text="Upload New Content"  OnClick="redirectUpload2"/><br/><br/><hr /><br />
        <asp:Button ID="Button2" class="Stylebutton" runat="server" Text="Show Events" OnClick="ShowEvent" /><br/>
        <asp:Label ID="Label1" runat="server" Text=""></asp:Label><br/><br/><hr /><br />
        <asp:Button ID="Button3" class="Stylebutton" runat="server" Text="Show Advertisment" OnClick="ShowAds" /><br/>
        <asp:Label ID="Label2" runat="server" Text=""></asp:Label><br/><br/><hr /><br />
        <asp:Button ID="Button4" class="Stylebutton" runat="server" Text="Show Notifications" OnClick="ShowNotif"/><br/>
        <asp:Label ID="Label3" runat="server" Text=""></asp:Label><br /><br /><hr /><br />
        <input runat="server" type="text" id="inputNewRequest" placeholder="New request Information" /><br />
        <input runat="server" type="text" id="inputStatus" placeholder="Enter accept/reject" /><br />
        <asp:Button ID="AcceptRejectButton" class="Stylebutton" runat="server" Text="Apply changes" OnClick="AcceptOrRejectRequest"/><br/>
        <asp:Label ID="AcceptRejectLabel" runat="server" Text=""></asp:Label><br /><br /><hr /><br />

    </form>
</body>
</html>
