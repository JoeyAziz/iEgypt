<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Upload2.aspx.cs" Inherits="WA1.Upload2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        body{
            background-color:lavender;
        }
        input[type="text"]{
            width:25%;
            height:25%;
            border-radius: 5px 5px 5px 5px;
            padding : 5px;
        }
        
        .StyleTitle{
            text-align:center;
            color:crimson;
            font-weight:bold;
            font-size:50px;
            background-color:lightskyblue;
            border-radius: 40px 40px 40px 40px
        }
        .StyleButton{
            width : 50%;
            background-color:forestgreen;
            border-radius: 25px;
            color:white;
        }
    </style>
</head>
<body>
    <h1 style = "text-align:center;color:#C0C0C0;">
                <a href="HomePage.aspx">iEgypt</a>

    </h1>
    <form id="form1" runat="server">
        <div style="text-align:center;">
            <div class="StyleTitle">Upload New Content</div><br /><br />
            <br /><br /><br /><hr /><br /><br />
             <input runat="server" type="text" id="inputInformation" placeholder="New Request Information **" />
             <input runat="server" type="text" id="inputCategoryType" placeholder="Category Type **" /><br />
             <input runat="server" type="text" id="inputSubCategoryName" placeholder="Sub-Category Name **" />
             <input runat="server" type="text" id="inputLink" placeholder="Link **" /><br />
             <asp:Button ID="uploadButton" class="StyleButton" runat="server" Text="UPLOAD" OnClick="UploadNewContent"/><br/>
             <asp:Label ID="label1" runat="server" Text=""></asp:Label><br /><br /><hr /><br />
             
        </div>
    </form>
</body>
</html>

