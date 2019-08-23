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
    public partial class StaffMember : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {

        }
        /*YYYYYYYYY*/
        protected void FilterOriginalContent(object sender, EventArgs e)
        {
            string link = TLink.Text;
            int status = (TStatus.Text.Equals("accept"))?1:0;
            string connectionString = WebConfigurationManager.ConnectionStrings["constr"].ConnectionString;

            SqlConnection cnn = new SqlConnection(connectionString);
            cnn.Open();

            SqlCommand cmd = new SqlCommand("reviewer_filter_content", cnn);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;

            cmd.Parameters.Add(new SqlParameter("@reviewer_id", Session["ID"])); //Change to session
            cmd.Parameters.Add(new SqlParameter("@original_content", GetOriginalContentId(link)));
            cmd.Parameters.Add(new SqlParameter("@status", status));
            SqlDataReader dataReader = cmd.ExecuteReader();
            dataReader.Close();

            cnn.Close();
        }
        protected int GetOriginalContentId(string link)
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["constr"].ConnectionString;

            SqlConnection cnn = new SqlConnection(connectionString);
            cnn.Open();
            string query = "SELECT c1.id FROM Content c1 INNER JOIN Original_Content c2 on c1.ID = c2.ID WHERE c1.link= " + "\'" + link + "\'";

            SqlCommand cmd = new SqlCommand(query, cnn);

            SqlDataReader dataReader = cmd.ExecuteReader();
            dataReader.Read();
            int id = Convert.ToInt16(dataReader.GetValue(0).ToString());
            

            dataReader.Close();
            cnn.Close();
            return id;       

        }
        protected void CreateContentType(object sender, EventArgs e)
        {
            string typeName = inputContentType.Value;
            /*
             *  SQL CONNECTION OPENING
             */

            SqlConnection cnn;

            string connetionString = WebConfigurationManager.ConnectionStrings["constr"].ConnectionString;


            cnn = new SqlConnection(connetionString);
            cnn.Open();

            SqlCommand cmd = new SqlCommand("Staff_Create_Type", cnn);//command to call procedure OR u can >>>> SqlCommand cmd = new SqlCommand("SELECT * FROM USERS", cnn); <<< example
            cmd.CommandType = System.Data.CommandType.StoredProcedure;//must indicate the command type when u use a procedure
            
            cmd.Parameters.Add(new SqlParameter("@type_name", typeName));// "@type_name" must be as same as the procedure's parameter spelling <<< CREATE PROC Staff_Create_Type >>>> @type_name <<<< VARCHAR(32)
            SqlDataReader dataReader = cmd.ExecuteReader();//use Sql reader to execute the command used

            /*Close Connections*/
            dataReader.Close();//close reader
            cnn.Close();//close connections
        }
        protected void CreateCategory(object sender, EventArgs e)
        {
            LCategory.Visible = false;
            string connectionString = WebConfigurationManager.ConnectionStrings["constr"].ConnectionString;

            SqlConnection cnn = new SqlConnection(connectionString);
            cnn.Open();

            SqlCommand cmd = new SqlCommand("Staff_Create_Category", cnn);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;

            cmd.Parameters.Add(new SqlParameter("@category_name", TCategory.Text));
            SqlDataReader dataReader = cmd.ExecuteReader();
            dataReader.Close();

            cmd = new SqlCommand("Staff_Create_SubCategory", cnn);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            
            cmd.Parameters.Add(new SqlParameter("@category_name", TCategory.Text));
            cmd.Parameters.Add(new SqlParameter("@subcategory_name", TSubCategory.Text));
            LCategory.Visible = true;
            
            dataReader = cmd.ExecuteReader();

            dataReader.Close();
            cnn.Close();
        }
        protected void ShowExistingRequestNumber(object sender, EventArgs e)
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["constr"].ConnectionString;

            SqlConnection cnn = new SqlConnection(connectionString);
            cnn.Open();

            SqlCommand cmd = new SqlCommand("SELECT COUNT(*) c,r.original_content_id  FROM Existing_Request r Group By (r.original_content_id) Order by c desc", cnn);
            string output = "";
            SqlDataReader dataReader = cmd.ExecuteReader();
            while (dataReader.Read())
            {
                output = output + "Link ( " + GetOriginalContentName(Convert.ToInt16(dataReader.GetValue(1).ToString())) + " ) , number of requests: " + dataReader.GetValue(0).ToString() +                
                    "<br>";
            }
            LShowExistingReq.Text = "<br>"+output;
            dataReader.Close();
            cnn.Close();
        }
        /*Gets the original content name from its ID*/
        protected string GetOriginalContentName(int id)
        {
            string name = "";
            string connectionString = WebConfigurationManager.ConnectionStrings["constr"].ConnectionString;

            SqlConnection cnn = new SqlConnection(connectionString);
            cnn.Open();
            string query = "SELECT c1.link FROM Content c1 WHERE c1.id = " + id;
            SqlCommand cmd = new SqlCommand(query, cnn);
            SqlDataReader dataReader = cmd.ExecuteReader();
            dataReader.Read();
            name = dataReader.GetValue(0).ToString();
            dataReader.Close();
            cnn.Close();
            return name;
        }
        /*YYYYYYYYYYY*/
        protected void ShowNotifications(object sender, EventArgs e)
        {
            int u_id = Convert.ToInt16(Session["ID"]);
            string connectionString = WebConfigurationManager.ConnectionStrings["constr"].ConnectionString;

            SqlConnection cnn = new SqlConnection(connectionString);
            cnn.Open();

            SqlCommand cmd = new SqlCommand("Show_Notification", cnn);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;

            cmd.Parameters.Add(new SqlParameter("@user_id", Session["ID"]));  //CHANGE TO Session["ID"]
            string output = "";

            SqlDataReader dataReader = cmd.ExecuteReader();
            int i = 0;
            while (dataReader.Read())//CHANGE 9 down here to Session["ID"]
            {
                output = output + "<b>Description : </b>" + GetEventDescription(u_id)[i]+" <br><b>At: </b>" + dataReader.GetValue(2).ToString() +
                    "<br><br>";
                i++;
            }
            LShowNotifications.Text = "<br>" + output;
            dataReader.Close();
            cnn.Close();
        }
        protected ArrayList GetEventDescription(int id)
        {
            ArrayList desc = new ArrayList();
            string query = "SELECT e.\"description\" FROM \"Event\" e INNER JOIN Notification_Object n on e.notification_object_id = n.ID " +
            "WHERE Exists(SELECT a.*FROM Announcement a INNER JOIN Notified_Person p on a.notified_person_id = p.ID " +
            "INNER JOIN Staff s on s.notified_id = p.ID WHERE s.ID = " + id +")";
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
        protected void DeleteComment(object sender, EventArgs e)
        {
            try
            {
                string fullname = TFullname.Text;
                string content_name = TOriginalName.Text;
                string content_type = TOriginalType.Text;
                int viewer = 1;
                int idd = 5;
                //DateTime date = Convert.ToDateTime(TDate.Text);
                Upload id = new Upload();
                int original_content_id = id.GetOriginalContentID(content_name, content_type);
                //System.Diagnostics.Debug.WriteLine("TEST:::"+original_content_id);
                int viewer_id = GetIdFromName(fullname);
                string connectionString = WebConfigurationManager.ConnectionStrings["constr"].ConnectionString;
                SqlConnection cnn = new SqlConnection(connectionString);
                cnn.Open();
                SqlCommand cmd = new SqlCommand("Delete_Comment", cnn);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
            
                cmd.Parameters.Add(new SqlParameter("@viewer_id", viewer));
                cmd.Parameters.Add(new SqlParameter("@original_content_id", idd));
                //cmd.Parameters.Add(new SqlParameter("@written_time", date));
                SqlDataReader dataReader = cmd.ExecuteReader();
                dataReader.Close();
                LDeleteComment.Text = "Comment was deleted";
                cnn.Close();
            }
            catch { LDeleteComment.Text = "something went wrong, try again"; }
        }
        protected int GetIdFromName(string fullname)
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["constr"].ConnectionString;
            SqlConnection cnn = new SqlConnection(connectionString);
            cnn.Open();
            SqlCommand cmd = new SqlCommand("SELECT id FROM \"User\" where first_name+' '+middle_name+' '+last_name = " + "\'" + fullname + "\'", cnn);
            SqlDataReader dataReader = cmd.ExecuteReader();
            dataReader.Read();
            int id = Convert.ToInt16(dataReader.GetValue(0));
            dataReader.Close();
            cnn.Close();
            return id;
        }
        protected void AssignContributor(object sender, EventArgs e)
        {
            try
            {
                int contributor = GetContributorID(TContributorName.Text);
                int new_request = GetNewRequestID(TInformation.Text);//information

                string connectionString = WebConfigurationManager.ConnectionStrings["constr"].ConnectionString;
                SqlConnection cnn = new SqlConnection(connectionString);
                cnn.Open();
                SqlCommand cmd = new SqlCommand("Assign_Contributor_Request", cnn);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;

                cmd.Parameters.Add(new SqlParameter("@contributor_id", contributor));
                cmd.Parameters.Add(new SqlParameter("@new_request_id", new_request));
                SqlDataReader dataReader = cmd.ExecuteReader();
                dataReader.Close();               
                cnn.Close();
                LAssign.Text = TContributorName.Text + " was assigned to the request.";
            }
            catch { LAssign.Text = " Something Went Wrong."; }
        }
        protected int GetNewRequestID(string input)
        {
            int id = -1;
            string connectionString = WebConfigurationManager.ConnectionStrings["constr"].ConnectionString;

            SqlConnection cnn = new SqlConnection(connectionString);
            cnn.Open();
            string query = "SELECT c1.id FROM New_Request c1 WHERE c1.information = " + "\'"+ input + "\'";
            SqlCommand cmd = new SqlCommand(query, cnn);
            SqlDataReader dataReader = cmd.ExecuteReader();
            dataReader.Read();
            id = Convert.ToInt16(dataReader.GetValue(0).ToString());
            dataReader.Close();
            cnn.Close();
            return id;
        }
        protected int GetContributorID(string name)
        {
            
            string connetionString;
            SqlConnection cnn;

            connetionString = WebConfigurationManager.ConnectionStrings["constr"].ConnectionString;
            
            cnn = new SqlConnection(connetionString);
            cnn.Open();

            SqlCommand cmd = new SqlCommand("Contributor_Search", cnn);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@fullname", name));
            SqlDataReader dataReader = cmd.ExecuteReader();
            dataReader.Read();
            int id = Convert.ToInt16(dataReader.GetValue(0).ToString());
            dataReader.Close();
            cnn.Close();
            return id;
        }

    }
}
