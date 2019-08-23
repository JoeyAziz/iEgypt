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
    public partial class Upload : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        /*Get Original Content ID*/
        public int GetOriginalContentID(string name, string type)
        {
            string connetionString;
            SqlConnection cnn;
            connetionString = WebConfigurationManager.ConnectionStrings["constr"].ConnectionString;

            cnn = new SqlConnection(connetionString);
            cnn.Open();

            SqlCommand cmd = new SqlCommand("Original_Content_Search", cnn);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;

            cmd.Parameters.Add(new SqlParameter("@typename", type));
            cmd.Parameters.Add(new SqlParameter("@categoryname", name));
            SqlDataReader dataReader = cmd.ExecuteReader();

            int cont_id = -1;

            dataReader.Read();
            cont_id = Convert.ToInt16(dataReader.GetValue(0).ToString());
            dataReader.Close();
            cnn.Close();

            return cont_id;
        }
        /*YYYYYYYYYYYYYYYYYYYYYY*/
        protected void UploadOriginalContent(object sender, EventArgs e)
        {
            try
            {
                string content_name = inputCategoryName.Value;
                string content_type = inputCategoryType.Value;
                int cont_id = Convert.ToInt16(Session["ID"]);//CHANGE TO Session["ID"]
                string subcategory_name = inputSubCategoryName.Value;
                string link = inputLink.Value;

                string connetionString;
                SqlConnection cnn;
                connetionString = WebConfigurationManager.ConnectionStrings["constr"].ConnectionString;

                cnn = new SqlConnection(connetionString);
                cnn.Open();

                SqlCommand cmd = new SqlCommand("Upload_Original_Content", cnn);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;


                cmd.Parameters.Add(new SqlParameter("@type", content_type));
                cmd.Parameters.Add(new SqlParameter("@subcategory_name", subcategory_name));
                cmd.Parameters.Add(new SqlParameter("@category_type", content_name));
                cmd.Parameters.Add(new SqlParameter("@contributor_id", cont_id));
                cmd.Parameters.Add(new SqlParameter("@link", link));
                SqlDataReader dataReader = cmd.ExecuteReader();
                label1.Text = "upload complete";

                dataReader.Close();
                cnn.Close();
            }
            catch { label1.Text = "something went wrong";  }
        }

    }
}