using System;
using System.Collections;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace WA1
{
    public partial class Contributer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void ShowEvent(object sender, EventArgs e)
        {
            SqlConnection cnn;

            String connetionString = WebConfigurationManager.ConnectionStrings["constr"].ConnectionString;


            cnn = new SqlConnection(connetionString);
            cnn.Open();
            SqlCommand cmd = new SqlCommand("select * from Event ", cnn);
            SqlDataReader dataReader = cmd.ExecuteReader();
            string output = "";
            while (dataReader.Read())
            {
                 output = output        + " " +
                dataReader.GetValue(1)  + " " +
                dataReader.GetValue(2)  + " " +
                dataReader.GetValue(3)  + " " +
                dataReader.GetValue(4)  + "<br>";
            }
            dataReader.Close();
            Label1.Text = output;
            cnn.Close();
        }
        protected void ShowAds(object sender, EventArgs e)
        {
            SqlConnection cnn;

            String connetionString = WebConfigurationManager.ConnectionStrings["constr"].ConnectionString;


            cnn = new SqlConnection(connetionString);
            cnn.Open();
            SqlCommand cmd = new SqlCommand("select * from Event ", cnn);
            SqlDataReader dataReader = cmd.ExecuteReader();
            string output = "";
            while (dataReader.Read())
            {
                output = output + " " +
               dataReader.GetValue(1) + " " + 
               dataReader.GetValue(2) + "<br>";
            }
            dataReader.Close();
            Label2.Text = output;
            cnn.Close();
        }
        /*YYYYYYYYYYYYYY*/
        protected void ShowNotif(object sender, EventArgs e)
        {
            int user_id = Convert.ToInt16(Session["ID"]);
            string connectionString = WebConfigurationManager.ConnectionStrings["constr"].ConnectionString;

            SqlConnection cnn = new SqlConnection(connectionString);
            cnn.Open();

            SqlCommand cmd = new SqlCommand("Show_Notification", cnn);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;

            cmd.Parameters.Add(new SqlParameter("@user_id", Session["ID"]));  //CHANGE TO Session["ID"]
            string output = "";

            SqlDataReader dataReader = cmd.ExecuteReader();
            int i = 0;
            int j = 0;
            while (dataReader.Read())//CHANGE 4 down here to Session["ID"]
            {
                if (GetEventDescription(user_id).Count > 0 && i < GetEventDescription(user_id).Count)
                {
                   output = output + "<b>Description : </b>" + 
                        GetEventDescription(user_id)[i] + 
                        " <br><b>At: </b>" + 
                        dataReader.GetValue(2).ToString() +
                        "<br><br>";
                    i++;
                }
                if (GetNewRequestInformation(user_id).Count > 0 && j < GetNewRequestInformation(user_id).Count)
                {
                    output = output + "<b>Information : </b>" + GetNewRequestInformation(user_id)[j] + " <br><b>At: </b>" + dataReader.GetValue(2).ToString() +
                        "<br><br>";
                    j++;
                }
                else output = "no notifications";
            }
            Label3.Text = "<br>" + output;
            dataReader.Close();
            cnn.Close();
        }
        protected ArrayList GetEventDescription(int id)
        {
            ArrayList desc = new ArrayList();
            string query = "SELECT e.\"description\" FROM \"Event\" e INNER JOIN Notification_Object n on e.notification_object_id = n.ID " +
            "WHERE Exists(SELECT a.*FROM Announcement a INNER JOIN Notified_Person p on a.notified_person_id = p.ID " +
            "INNER JOIN Contributor s on s.notified_id = p.ID WHERE s.ID = " + id + ")";
            string connectionString = WebConfigurationManager.ConnectionStrings["constr"].ConnectionString;

            SqlConnection cnn = new SqlConnection(connectionString);
            cnn.Open();

            SqlCommand cmd = new SqlCommand(query, cnn);
            SqlDataReader dataReader = cmd.ExecuteReader();
            while (dataReader.Read())
            {
                desc.Add(dataReader.GetValue(0).ToString());
            }
            dataReader.Close();
            cnn.Close();
            return desc;
        }
        protected ArrayList GetNewRequestInformation(int id)
        {
            ArrayList desc = new ArrayList();
            string query = "SELECT n1.\"information\" FROM \"New_Request\" n1 INNER JOIN Notification_Object n on n1.notif_obj_id = n.ID " +
            "WHERE Exists(SELECT a.*FROM Announcement a INNER JOIN Notified_Person p on a.notified_person_id = p.ID " +
            "INNER JOIN Contributor s on s.notified_id = p.ID WHERE s.ID = " + id + ")";
            string connectionString = WebConfigurationManager.ConnectionStrings["constr"].ConnectionString;

            SqlConnection cnn = new SqlConnection(connectionString);
            cnn.Open();

            SqlCommand cmd = new SqlCommand(query, cnn);
            SqlDataReader dataReader = cmd.ExecuteReader();
            while (dataReader.Read())
            {
                desc.Add(dataReader.GetValue(0).ToString());
            }
            dataReader.Close();
            cnn.Close();
            return desc;
        }
        protected void SendMessage(object sender, EventArgs e)
        {
            SqlConnection cnn;

            String connetionString = WebConfigurationManager.ConnectionStrings["constr"].ConnectionString;


            cnn = new SqlConnection(connetionString);
            cnn.Open();
            SqlCommand cmd = new SqlCommand("Send_Message", cnn);
            SqlDataReader dataReader = cmd.ExecuteReader();
            cmd.Parameters.Add(new SqlParameter("@sender_type", 1));


            dataReader.Close();
            cnn.Close();
        }
        protected void AcceptOrRejectRequest(object sender, EventArgs e)
        {
            try
            {
                int status =(inputStatus.Value.Equals("accept"))?1:0;
                int id = GetNewRequestID(inputNewRequest.Value);
                SqlConnection cnn;
                String connetionString = WebConfigurationManager.ConnectionStrings["constr"].ConnectionString;

                cnn = new SqlConnection(connetionString);
                cnn.Open();
                string query = "UPDATE  New_Request SET accept_status = " + status + " WHERE ID = " + id;
                SqlCommand cmd = new SqlCommand(query, cnn);
                SqlDataReader dataReader = cmd.ExecuteReader();
                dataReader.Close();
                cnn.Close();
                AcceptRejectLabel.Text = "New request was " + inputStatus.Value+"ed";
            }
            catch { AcceptRejectLabel.Text = "something went wrong"; }
        }
        protected int GetNewRequestID(string input)
        {
            SqlConnection cnn;
            String connetionString = WebConfigurationManager.ConnectionStrings["constr"].ConnectionString;

            cnn = new SqlConnection(connetionString);
            cnn.Open();
            string query = "SELECT c1.id FROM New_Request c1 WHERE c1.information = " + "\'" + input + "\'";
            int id = -1;
            SqlCommand cmd = new SqlCommand(query, cnn);
            SqlDataReader dataReader = cmd.ExecuteReader();
            dataReader.Read();
            id = Convert.ToInt16(dataReader.GetValue(0).ToString());
            dataReader.Close();
            cnn.Close();
            return id;
        }
        protected void redirectUpload(object sender, EventArgs e)
        {
            Response.Redirect("Upload.aspx");
        }
        protected void redirectUpload2(object sender, EventArgs e)
        {
            Response.Redirect("Upload2.aspx");
        }

    }
}