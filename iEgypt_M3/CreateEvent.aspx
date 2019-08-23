<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CreateEvent.aspx.cs" Inherits="CompViewer.CreateEvent" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        #form1 {
            direction: ltr;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
             <asp:Label ID="Label1" runat="server" Text="Viewer Options :-" ForeColor="Blue" ></asp:Label>
        </div>
        <p>
             <asp:Label ID="Label2" runat="server" Text="==> Create an Event"></asp:Label>
        </p>
        <p>
             <asp:TextBox ID="TextBox7" runat="server" ForeColor="Red" placeholder ="Enter Location" ></asp:TextBox> 
             <asp:Label ID="Label7" runat="server" ForeColor="Red" Text="A 'Location' is required" Visible="False"></asp:Label>
        </p>
        <p>    
             <asp:TextBox ID="TextBox1" runat="server" ForeColor="Red" placeholder ="Enter City" ></asp:TextBox>
             <asp:Label ID="Label4" runat="server" ForeColor="Red" Text="A 'City' is required" Visible="False"></asp:Label>
        </p>
             <asp:TextBox ID="TextBox2" runat="server" ForeColor="Red" placeholder ="Enter Date" ></asp:TextBox>
             <asp:Label ID="Label5" runat="server" Text="A 'Date' is required" ForeColor="Red" Visible="False"></asp:Label>
        <p>
            <asp:TextBox ID="TextBox3" runat="server" ForeColor="Red" placeholder ="Enter Event Desc." ></asp:TextBox>
        </p>
            <asp:TextBox ID="TextBox4" runat="server" ForeColor="Red" placeholder ="Enter Entartainer" ></asp:TextBox><p>
            <asp:TextBox ID="TextBox5" runat="server" ForeColor="Red" placeholder ="Enter Photo Link" ></asp:TextBox>
        </p>
        <p>
            <asp:TextBox ID="TextBox6" runat="server" ForeColor="Red" placeholder ="Video Link" ></asp:TextBox>
        </p>
        <p>
            <asp:Button ID="Button1" runat="server" Text="Create Event" OnClick ="CreateE" />
            <asp:Label ID="Label3" runat="server" Text="Please Enter a Video Link Or A Photo Link" Visible="False" ForeColor="Red"></asp:Label>
       </p>
       <p>
       </p>
           <asp:Button ID="Button2" runat="server" Text="Click Here To Create an Adv For Your Event (Optional)" OnClick ="CreateEAdv" Visible="False" />
           <asp:Label ID="Label6" runat="server" ForeColor="Red" Text="Adv. Created" Visible="False"></asp:Label>
       <hr>
       <p>
          <asp:Label ID="Label9" runat="server" Text="==> Apply For a new Request"></asp:Label>
       </p>
           <asp:TextBox ID="TextBox9" runat="server" placeholder ="Enter Info" ForeColor="Red"></asp:TextBox>
        <p>
            <asp:TextBox ID="TextBox10" runat="server" placeholder ="Enter contributor's full name" ForeColor="Red" Width="160px"></asp:TextBox>
            <asp:Label ID="Label10" runat="server" Text="Missing or Wrong name" ForeColor="Red" Visible="False"></asp:Label>
        </p>

        <p>
              <asp:Button ID="Button3" runat="server" Text="Apply" OnClick ="ApplyNewRequest" />
              <asp:Label ID="Label11" runat="server" ForeColor="Red" Text="Successful" Visible="False"></asp:Label>
        </p>
        <hr>
        <p>
             <asp:Label ID="Label12" runat="server" Text="==> Delete Non-Processed Requests"></asp:Label>
        </p>
        <p>
            <asp:Button ID="Button4" runat="server" Text="Click to Delete Your Non-Processed Requests" OnClick ="DeleteNewRequest" />
            <asp:Label ID="Label13" runat="server" ForeColor="Red" Text="Requests Deleted" Visible="False"></asp:Label>
        </p>
        <hr>
         <p>
             <asp:Label ID="Label14" runat="server" Text="==> Rate Original Content"></asp:Label>
        </p>
        <p>
            <asp:TextBox ID="TextBox11" runat="server" placeholder ="Enter Content Category" Width="175px"></asp:TextBox>
            <asp:TextBox ID="TextBox17" runat="server" placeholder ="Enter Content Type Here" Width="175px"></asp:TextBox>
            <asp:TextBox ID="TextBox12" runat="server" placeholder ="Enter Your Rating Here"></asp:TextBox>
            <asp:Button ID="Button6" runat="server" Text="Rate" OnClick ="RateOrgContent" />
            <asp:Label ID="Label15" runat="server" ForeColor="Red" Text="Rating Successful" Visible="False"></asp:Label>
        </p>
        <hr>
        <p>
             <asp:Label ID="Label16" runat="server" Text="==> Write a Comment On Any Original Content"></asp:Label>
        </p>
        <p>
        <asp:TextBox ID="TextBox13" runat="server" placeholder ="Enter Content Category"></asp:TextBox>
            <asp:Label ID="Label19" runat="server" Text="Missing or Wrong Data" ForeColor="Red" Visible="False"></asp:Label>
        </p>
         <p>
        <asp:TextBox ID="TextBox14" runat="server" placeholder ="Enter Content Type"></asp:TextBox>
             <asp:Label ID="Label20" runat="server" ForeColor="Red" Text="Missing or Wrong Data" Visible="False"></asp:Label>
        </p>
        <p>
        <asp:TextBox ID="TextBox15" runat="server" placeholder ="Enter Date/Time Of your Comment" Width="200px"></asp:TextBox>
        <asp:Label ID="Label25" runat="server" Text="*You need to Keep track of this Date/time If you want to delete your comment later" ForeColor="Red"></asp:Label>
        </p>
        <p>
        <asp:TextBox ID="TextBox16" runat="server" placeholder ="Enter Your Comment"></asp:TextBox>
            <asp:Label ID="Label18" runat="server" Text="Comment Missing!" ForeColor="Red" Visible="False"></asp:Label>
        </p>
        <p>
        <asp:Button ID="Button5" runat="server" Text="Write Comment" OnClick ="WriteComment" />
        <asp:Label ID="Label17" runat="server" Text="Commentd Successfuly" ForeColor="Red" Visible="False"></asp:Label>
        </p>
        <hr>
        <p>
             <asp:Label ID="Label21" runat="server" Text="==> Edit And Delete Comment On Any Original Content"></asp:Label>
        </p>
        <asp:TextBox ID="TextBox18" runat="server" placeholder ="Enter Content Category"></asp:TextBox>
        <asp:Label ID="Label8" runat="server" Text="Missing or Wrong Data" ForeColor="Red" Visible="False"></asp:Label>
        <p>
            <asp:TextBox ID="TextBox19" runat="server"  placeholder ="Enter Content Type"></asp:TextBox>
            <asp:Label ID="Label32" runat="server" Text="Missing or Wrong Data" ForeColor="Red" Visible="False"></asp:Label>
        </p>
        <asp:TextBox ID="TextBox20" runat="server" placeholder ="Enter Current Edit Date" ></asp:TextBox>
        <asp:Label ID="Label24" runat="server" Text="*You need to Keep track of this Date/time If you want to delete your comment later" ForeColor="Red"></asp:Label>
        <p>
            <asp:TextBox ID="TextBox21" runat="server" placeholder ="Enter Your Edited Comment" Width="160px"></asp:TextBox>
        </p>
        <asp:Button ID="Button7" runat="server" Text="Edit" OnClick ="EditComment" />
        <asp:Label ID="Label22" runat="server" Text="Comment Edited!" ForeColor="Red" Visible="False"></asp:Label>
        <p>
            <asp:Button ID="Button8" runat="server" Text="Delete" OnClick ="DeleteComment" />
            <asp:Label ID="Label23" runat="server" Text="Comment Deleted!" ForeColor="Red" Visible="False"></asp:Label>
        </p>
        <hr>
        <p>
             <asp:Label ID="Label26" runat="server" Text="==> Create an Advertisement For Publicity"></asp:Label>
        </p>
        <p>
            <asp:TextBox ID="TextBox22" runat="server" placeholder ="Enter Location"></asp:TextBox>
        </p>
            <asp:TextBox ID="TextBox23" runat="server" placeholder ="Enter Description"></asp:TextBox>
        <p>
            <asp:Button ID="Button9" runat="server" Text="Create Ad" OnClick ="AdsForPublicity" />
            <asp:Label ID="Label27" runat="server" Text="Ad Created" ForeColor="Red" Visible="False"></asp:Label>
        </p>
         <hr>
        <p>
             <asp:Label ID="Label30" runat="server" Text="==> Edit Your Ads"></asp:Label>
        </p>
             <asp:TextBox ID="TextBox24" runat="server" placeholder ="Enter Edited Location"></asp:TextBox>
        <p>
             <asp:TextBox ID="TextBox26" runat="server" placeholder ="Enter Edited Desc"></asp:TextBox>
        </p>
        <asp:Button ID="Button11" runat="server" Text="Edit My Ads" OnClick="EditAds" />
        <asp:Label ID="Label31" runat="server" Text="Edited Successfully" ForeColor="Red" Visible="False"></asp:Label>
        <hr>
        <p>
             <asp:Label ID="Label28" runat="server" Text="==> Delete Your Ads"></asp:Label>
        </p>
        <p>
            <asp:Button ID="Button10" runat="server" Text="Delete My Ads" OnClick ="DeleteAds" />
            <asp:Label ID="Label29" runat="server" Text="Deleted Successfully" ForeColor="Red" Visible="False"></asp:Label>
        </p>
       


   </form>
</body>
</html>
