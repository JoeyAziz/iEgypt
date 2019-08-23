<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StaffMember.aspx.cs" Inherits="WA1.StaffMember" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        body{
            background-color:navajowhite;
        }
        input[type="text"], TextBox{
            width : 30%;
            height: 30%;
            border-radius : 10px;
            font-size   : 12px;
            font-weight: bold;
        }
        .StyleButton{
            background-color :brown;
            color:white;
            border-radius: 10px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h1 style = "text-align:center;color:#C0C0C0;">
                <a href="HomePage.aspx">iEgypt</a>

            </h1>
            <h1 style="align-content:center">Staff Member</h1>
            <input runat="server" type="text" id="inputContentType" placeholder="Create Content Type" autocomplete="off" /><br />
            <asp:Button runat="server" class="StyleButton" ID="createType" onClick="CreateContentType" Text="CREATE" />
        </div>
        <br />
        <hr />
        <br />
        <asp:TextBox ID="TCategory" runat="server" placeholder="category name"></asp:TextBox><br />
        <asp:TextBox ID="TSubCategory" runat="server" placeholder="sub category name"></asp:TextBox><br />
        <asp:Button ID="BCategory" class="StyleButton" runat="server" Text="CREATE" OnClick ="CreateCategory" />
        <asp:Label ID="LCategory" runat="server" Text="success" Visible="False"></asp:Label>
        <br />
        <hr />
        <br />
        <asp:TextBox ID="TLink" runat="server" placeholder="original content link"></asp:TextBox><br />
        <asp:TextBox ID="TStatus" runat="server" placeholder="enter accept/reject"></asp:TextBox><br />
        <asp:Button ID="BFilter" class="StyleButton" runat="server" Text="APPLY" OnClick ="FilterOriginalContent" />
        <br />
        <hr />
        <br />
        <asp:Button ID="BShowExistingReq" class="StyleButton" style="border-color:aquamarine;border-radius:5px 5px 0px;" runat="server" Text="Show Exisiting Requests" OnClick ="ShowExistingRequestNumber" />
        <asp:Label ID="LShowExistingReq" runat="server" Text="" />
        <br />
        <br />
        <hr />
        <asp:Button ID="BShowNotifications" class="StyleButton" style="border-color:crimson;border-radius:5px 0px 0px;" runat="server" Text="Show Notifications" OnClick ="ShowNotifications" />
        <asp:Label ID="LShowNotifications" runat="server" Text="" />
        <br />
        <br />
        <hr />
        <asp:TextBox ID="TFullname" runat="server" placeholder="Enter Commenter Fullname"></asp:TextBox><br />
        <asp:TextBox ID="TOriginalName" runat="server" placeholder="Enter Original Content Name"></asp:TextBox><br />
        <asp:TextBox ID="TOriginalType" runat="server" placeholder="Enter Original Content Type"></asp:TextBox><br />
        <asp:TextBox ID="TDate" runat="server" placeholder="Enter Comment's Date"></asp:TextBox><br />
        <asp:Button ID="BDeleteComment" runat="server" Text="Delete Comment" Class="StyleButton" onclick="DeleteComment"/>
        <asp:Label ID="LDeleteComment" runat="server" Text="" />
        <br />
        <br />
        <hr />
        <asp:TextBox ID="TContributorName" runat="server" placeholder="Enter Contributor Name"></asp:TextBox><br />
        <asp:TextBox ID="TInformation" runat="server" placeholder="Enter New Request Information"></asp:TextBox><br />
        <asp:Button ID="BAssign" runat="server" Text="Apply Changes" Class="StyleButton" onclick="AssignContributor"/>
        <asp:Label ID="LAssign" runat="server" Text="" />
    </form>
</body>
</html>
