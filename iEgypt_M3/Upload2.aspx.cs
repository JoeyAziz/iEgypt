using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WA1
{
    public partial class Upload2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected int GetNewRequestID(string input)
        {
            int id = -1;
            string connectionString = WebConfigurationManager.ConnectionStrings["constr"].ConnectionString;

            SqlConnection cnn = new SqlConnection(connectionString);
            cnn.Open();
            string query = "SELECT c1.id FROM New_Request c1 WHERE c1.information = " + "\'" + input + "\'";
            SqlCommand cmd = new SqlCommand(query, cnn);
            SqlDataReader dataReader = cmd.ExecuteReader();
            dataReader.Read();
            id = Convert.ToInt16(dataReader.GetValue(0).ToString());
            dataReader.Close();
            cnn.Close();
            return id;
        }
        /*YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY*/
        protected void UploadNewContent(object sender, EventArgs e)
        {
            try
            {
                string information = inputInformation.Value;
                string content_type = inputCategoryType.Value;
                int cont_id = Convert.ToInt16(Session["ID"]);//CHANGE TO Session["ID"]
                string subcategory_name = inputSubCategoryName.Value;
                string link = inputLink.Value;

                string connetionString;
                SqlConnection cnn;
                connetionString = WebConfigurationManager.ConnectionStrings["constr"].ConnectionString;

                cnn = new SqlConnection(connetionString);
                cnn.Open();

                SqlCommand cmd = new SqlCommand("Upload_New_Content", cnn);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;


                cmd.Parameters.Add(new SqlParameter("@type", content_type));
                cmd.Parameters.Add(new SqlParameter("@subcategory_name", subcategory_name));
                cmd.Parameters.Add(new SqlParameter("@new_request_id", GetNewRequestID(information)));
                cmd.Parameters.Add(new SqlParameter("@contributor_id", cont_id));
                cmd.Parameters.Add(new SqlParameter("@link", link));
                SqlDataReader dataReader = cmd.ExecuteReader();
                label1.Text = "upload complete";

                dataReader.Close();
                cnn.Close();
            }
            catch { label1.Text = "something went wrong"; }
        }

    }
}