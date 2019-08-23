using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Collections;

namespace CompViewer
{
    public partial class CreateEvent : System.Web.UI.Page
    {



        protected void Page_Load(object sender, EventArgs e)
        {

        }

        //search for original content ID
        protected int ProduceOriginalID(string input, string input2)
        {
           
            string connetionString;
            string searchInput = input;
            SqlConnection cnn;

            connetionString = WebConfigurationManager.ConnectionStrings["constr"].ConnectionString;

            cnn = new SqlConnection(connetionString);
            cnn.Open();

            SqlCommand cmd = new SqlCommand("Original_Content_Search", cnn);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;

            //Search For Original Content
            //search for corresponding type
            cmd.Parameters.Add(new SqlParameter("@typename", searchInput));
            cmd.Parameters.Add(new SqlParameter("@categoryname", input2));
            SqlDataReader dataReader = cmd.ExecuteReader();

            int cont_id = -1;

            while (dataReader.Read())
                cont_id = Convert.ToInt16(dataReader.GetValue(0).ToString());

            dataReader.Close();
            /*Close connections*/
            cnn.Close();

            return cont_id;
        }


        protected void CreateE(Object Sender, EventArgs e)
        {
            String Location = TextBox7.Text;
            String City = TextBox1.Text;
            String Date = TextBox2.Text;
            String Desc = TextBox3.Text;
            String Entartainer = TextBox4.Text;
            String PhotoL = TextBox5.Text;
            String VideoL = TextBox6.Text;


            if (Location.Equals(""))
            {
                Label7.Visible = true;
                return;
            }
            Label7.Visible = false;

            if (City.Equals(""))
            {
                Label4.Visible = true;
                return;
            }
            Label4.Visible = false;
            if (Date.Equals(""))
            {
                Label5.Visible = true;
                return;
            }
            Label5.Visible = false;
            if ((PhotoL.Equals("")) && ((VideoL.Equals(""))))
            {
                Label3.Visible = true;
                return;
            }
            Label3.Visible = false;

            string connetionString;
            SqlConnection cnn;
            connetionString = WebConfigurationManager.ConnectionStrings["constr"].ConnectionString;
            cnn = new SqlConnection(connetionString);

            cnn.Open();

            SqlCommand cmd = new SqlCommand("Viewer_Create_Event", cnn);
            SqlCommand cmd2 = new SqlCommand("Viewer_Upload_Event_Photo ", cnn);
            SqlCommand cmd3 = new SqlCommand("Viewer_Upload_Event_Video", cnn);

            // 2. set the command object so it knows to execute a stored procedure
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd2.CommandType = System.Data.CommandType.StoredProcedure;
            cmd3.CommandType = System.Data.CommandType.StoredProcedure;

            // 3. add parameter to command, which will be passed to the stored procedure
            cmd.Parameters.Add(new SqlParameter("@location", Location));
            cmd.Parameters.Add(new SqlParameter("@city", City));
            cmd.Parameters.Add(new SqlParameter("@event_date_time", Date));
            cmd.Parameters.Add(new SqlParameter("@description", Desc));
            cmd.Parameters.Add(new SqlParameter("@entartainer", Entartainer));
            cmd.Parameters.Add(new SqlParameter("@viewer_id", Session["ID"])); //Replace With Seeison["ID"]

            cmd.Parameters.Add("@event_id", System.Data.SqlDbType.Int).Direction = System.Data.ParameterDirection.Output;

            using (SqlDataReader rdr = cmd.ExecuteReader())
            {
                Session["EventID"] = Convert.ToInt16(cmd.Parameters["@event_id"].Value);
            }



            cmd2.Parameters.Add(new SqlParameter("@event_id", Session["EventID"]));
            cmd2.Parameters.Add(new SqlParameter("@link", PhotoL));


            cmd3.Parameters.Add(new SqlParameter("@event_id", Session["EventID"]));
            cmd3.Parameters.Add(new SqlParameter("@link", VideoL));



            SqlDataReader rdr2 = cmd2.ExecuteReader();
            rdr2.Close();


            rdr2 = cmd3.ExecuteReader();
            rdr2.Close();

            Label3.Text = "Event Created";
            Label3.Visible = true;
            Button2.Visible = true;
            cnn.Close();
        }

        protected void CreateEAdv(Object Sender, EventArgs e)
        {
            string connetionString;
            SqlConnection cnn;
            connetionString = WebConfigurationManager.ConnectionStrings["constr"].ConnectionString;
            cnn = new SqlConnection(connetionString);
            cnn.Open();
            SqlCommand cmd2 = new SqlCommand("SELECT MAX(e.id) FROM EVENT e",cnn);
            SqlDataReader rdr2 = cmd2.ExecuteReader();

            int eventID = -1;

            while (rdr2.Read())
                eventID = Convert.ToInt16(rdr2.GetValue(0).ToString());

            rdr2.Close();


            SqlCommand cmd = new SqlCommand("Viewer_Create_Ad_From_Event", cnn);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@event_id", eventID));

            
            SqlDataReader rdr = cmd.ExecuteReader();
            rdr.Close();

            Label6.Visible = true;
            cnn.Close();
        }

        /*Get Contributor ID From FULL NAME*/
        protected int GetContributorID(string input)
        {
            string connetionString;
            string searchInput = input;
           
            SqlConnection cnn;
            connetionString = WebConfigurationManager.ConnectionStrings["constr"].ConnectionString;            
            cnn = new SqlConnection(connetionString);
            cnn.Open();
            //Search For Contributors
            int contributor_id = -1;
            SqlCommand cmd = new SqlCommand("Contributor_Search", cnn);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@fullname", searchInput));
            SqlDataReader dataReader = cmd.ExecuteReader();
            while (dataReader.Read())
                contributor_id = Convert.ToInt16(dataReader.GetValue(0).ToString());

            /*Close connections*/
            dataReader.Close();            
            cnn.Close();
            return contributor_id;
        }
       
        protected void ApplyNewRequest(Object Sender, EventArgs e)
        {
            String information = TextBox9.Text;
            String fullname = TextBox10.Text;

            string connetionString;
            SqlConnection cnn;
            connetionString = WebConfigurationManager.ConnectionStrings["constr"].ConnectionString;
            cnn = new SqlConnection(connetionString);
            cnn.Open();

            SqlCommand cmd = new SqlCommand("Apply_New_Request", cnn);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@information", information));
            cmd.Parameters.Add(new SqlParameter("@viewer_id", Session["ID"]));//CHANGE 1 with >>> Session["ID"] <<<

            if (GetContributorID(fullname) == -1) { TextBox10.Text = "";Label10.Visible = true; return; }
            if (fullname.Length > 0)
                cmd.Parameters.Add(new SqlParameter("@contributor_id", GetContributorID(fullname)));
            else cmd.Parameters.Add(new SqlParameter("@contributor_id", DBNull.Value));

            SqlDataReader dataReader = cmd.ExecuteReader();
            dataReader.Close();
            Label10.Visible = false;
            Label11.Visible = true;

            cnn.Close();

        }

        protected void DeleteNewRequest(Object Sender, EventArgs e)
        {


           // int ViewerID = Session["ID"];//REPLACE with Session["ID"]

            string connetionString;
            SqlConnection cnn;
            connetionString = WebConfigurationManager.ConnectionStrings["constr"].ConnectionString;
            cnn = new SqlConnection(connetionString);

            cnn.Open();
            SqlCommand cmd = new SqlCommand("SELECT r.ID FROM New_Request r WHERE (r.accept_status = 0 ) AND r.viewer_id = " + Session["ID"], cnn);
            SqlDataReader rdr = cmd.ExecuteReader();

            int req_id = -1;
            //array for ids
            ArrayList requests = new ArrayList();
            while (rdr.Read())
            {
                req_id = Convert.ToInt16(rdr.GetValue(0).ToString());
                requests.Add(req_id);                
            }
            rdr.Close();

            //reads for each id
            for (int id = 0; id < requests.Count; id++)
            {
                cmd = new SqlCommand("Delete_New_Request", cnn);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@request_id", requests[id]));
                
                rdr = cmd.ExecuteReader();
                rdr.Close();
            }
            Label13.Visible = true;
            cnn.Close();

        }

        protected void RateOrgContent(Object Sender, EventArgs e)
        {
            String ContentCategory = TextBox11.Text;
            String ContentType = TextBox17.Text;
            double RateValue = 0;
            try
            {
                RateValue = Convert.ToDouble(TextBox12.Text);
                throw new Exception();
            }
            catch (Exception)
            {
                TextBox12.Text = "";
                TextBox12.Style.Add("placeholder", "Enter a decimal number");
            }

            int ContentID = ProduceOriginalID(ContentType, ContentCategory);


            if (ContentID == -1)
            {
                TextBox11.Text = "";
                TextBox17.Text = "";
                Label15.Text = "Wrong or Missing Data";
                Label15.Visible = true;
                return;
            }

            string connetionString;
            SqlConnection cnn;
            connetionString = WebConfigurationManager.ConnectionStrings["constr"].ConnectionString;
            cnn = new SqlConnection(connetionString);

            cnn.Open();
            SqlCommand cmd = new SqlCommand("Rating_Original_Content", cnn);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;

            cmd.Parameters.Add(new SqlParameter("@orignal_content_id", ContentID));

            cmd.Parameters.Add(new SqlParameter("@rating_value", RateValue));
            cmd.Parameters.Add(new SqlParameter("@viewer_id", Session["ID"])); //replace with Session[ID]
            SqlDataReader rdr = cmd.ExecuteReader();
            rdr.Close();
            Label15.Text = "Rate Successful";
            Label15.Visible = true;
            cnn.Close();

        }

        protected void WriteComment(Object Sender, EventArgs e)
        {
            String ContentCategory = TextBox13.Text;
            String ContentType = TextBox14.Text;
            String Date = TextBox15.Text;
            String Comment = TextBox16.Text;

            int ContentID = ProduceOriginalID(ContentType,ContentCategory);

            

            if (ContentCategory.Equals(""))
            {
                Label19.Visible = true;
                return;
            }
            Label19.Visible = false;
            if (ContentType.Equals(""))
            {
                Label20.Visible = true;
                return;
            }
            Label20.Visible = false;
            if (Comment.Equals(""))
            {
                Label18.Visible = true;
                return;
            }
            Label18.Visible = false;


            string connetionString;
            SqlConnection cnn;
            connetionString = WebConfigurationManager.ConnectionStrings["constr"].ConnectionString;
            cnn = new SqlConnection(connetionString);

            cnn.Open();
            SqlCommand cmd = new SqlCommand("Write_Comment", cnn);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@original_content_id", ContentID));
            cmd.Parameters.Add(new SqlParameter("@written_time", Date));
            cmd.Parameters.Add(new SqlParameter("@comment_text", Comment));
            cmd.Parameters.Add(new SqlParameter("@viewer_id", Session["ID"])); //replace with Session[ID]
            SqlDataReader rdr = cmd.ExecuteReader();
            rdr.Close();
            Label17.Visible = true;
            cnn.Close();
        }

        protected void EditComment(Object Sender, EventArgs e)
        {
            Label23.Visible = false;
            String ContentCategory = TextBox18.Text;
            String ContentType = TextBox19.Text;
            String UpdatedDate = TextBox20.Text;
            String UpdatedComment = TextBox21.Text;

            int ContentID = ProduceOriginalID(ContentType, ContentCategory);

            if (ContentCategory.Equals(""))
            {
                Label8.Visible = true;
                return;
            }
            Label8.Visible = false;
            if (ContentType.Equals(""))
            {
                Label32.Visible = true;
                return;
            }
            Label32.Visible = false;

            string connetionString;
            SqlConnection cnn;
            connetionString = WebConfigurationManager.ConnectionStrings["constr"].ConnectionString;
            cnn = new SqlConnection(connetionString);

            cnn.Open();
            SqlCommand cmd = new SqlCommand("Edit_Comment", cnn);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@original_content_id", ContentID));
            cmd.Parameters.Add(new SqlParameter("@last_written_time", DBNull.Value));
            cmd.Parameters.Add(new SqlParameter("@updated_written_time", UpdatedDate));
            cmd.Parameters.Add(new SqlParameter("@comment_text", UpdatedComment));
            cmd.Parameters.Add(new SqlParameter("@viewer_id", Session["ID"])); //replace with Session[ID]
            SqlDataReader rdr = cmd.ExecuteReader();
            rdr.Close();
            Label22.Visible = true;
            cnn.Close();
        }

        protected void DeleteComment(Object Sender, EventArgs e)
        {
            Label22.Visible = false;
            String ContentCategory = TextBox18.Text;
            String ContentType = TextBox19.Text;
            String WrittenTime = TextBox20.Text;


            int ContentID = ProduceOriginalID(ContentType, ContentCategory);


            string connetionString;
            SqlConnection cnn;
            connetionString = WebConfigurationManager.ConnectionStrings["constr"].ConnectionString;
            cnn = new SqlConnection(connetionString);

            cnn.Open();
            SqlCommand cmd = new SqlCommand("Delete_Comment", cnn);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@original_content_id", ContentID));
            cmd.Parameters.Add(new SqlParameter("@written_time",TextBox20.Text));
            cmd.Parameters.Add(new SqlParameter("@viewer_id", Session["ID"])); //replace with Session[ID]
            SqlDataReader rdr = cmd.ExecuteReader();
            rdr.Close();
            Label23.Visible = true;
            cnn.Close();
        }

        protected void AdsForPublicity(Object Sender , EventArgs e)
        {
            String Location = TextBox22.Text;
            String Desc = TextBox23.Text;

            
            string connetionString;
            SqlConnection cnn;
            connetionString = WebConfigurationManager.ConnectionStrings["constr"].ConnectionString;
            cnn = new SqlConnection(connetionString);

            cnn.Open();
            SqlCommand cmd = new SqlCommand("Create_Ads", cnn);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@location", Location));
            cmd.Parameters.Add(new SqlParameter("@description", Desc));
            cmd.Parameters.Add(new SqlParameter("@viewer_id", Session["ID"])); //replace with Seeion[ID]
            SqlDataReader rdr = cmd.ExecuteReader();
            rdr.Close();
            Label27.Visible = true;
            cnn.Close();

        }

        protected void DeleteAds(Object Sender, EventArgs e)
        {
            //int ViewerID = 1;//REPLACE with Session["ID"]

            string connetionString;
            SqlConnection cnn;
            connetionString = WebConfigurationManager.ConnectionStrings["constr"].ConnectionString;
            cnn = new SqlConnection(connetionString);

            cnn.Open();
            SqlCommand cmd = new SqlCommand("SELECT a.ID FROM Advertisement a WHERE a.viewer_id = " + Session["ID"], cnn);
            SqlDataReader rdr = cmd.ExecuteReader();

            int adID = -1;
            //array for ids
            ArrayList Ads = new ArrayList();
            while (rdr.Read())
            {
                adID = Convert.ToInt16(rdr.GetValue(0).ToString());
                Ads.Add(adID);
            }
            rdr.Close();

            //reads for each id
            for (int id = 0; id < Ads.Count; id++)
            {
                cmd = new SqlCommand("Delete_Ads", cnn);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@ad_id", Ads[id]));

                rdr = cmd.ExecuteReader();
                rdr.Close();
            }
            Label29.Visible = true;
            cnn.Close();

        }

        protected void EditAds (Object Sender , EventArgs e)
        {
            //int ViewerID = 1;//REPLACE with Session["ID"]
            String EditedLoc = TextBox24.Text;
            String EditedDesc = TextBox26.Text;

            string connetionString;
            SqlConnection cnn;
            connetionString = WebConfigurationManager.ConnectionStrings["constr"].ConnectionString;
            cnn = new SqlConnection(connetionString);

            cnn.Open();
            SqlCommand cmd = new SqlCommand("SELECT a.ID FROM Advertisement a WHERE a.viewer_id = " + Session["ID"], cnn);
            SqlDataReader rdr = cmd.ExecuteReader();

            int adID = -1;
            //array for ids
            ArrayList Ads = new ArrayList();
            while (rdr.Read())
            {
                adID = Convert.ToInt16(rdr.GetValue(0).ToString());
                Ads.Add(adID);
            }
            rdr.Close();

            //reads for each id
            for (int id = 0; id < Ads.Count; id++)
            {
                cmd = new SqlCommand("Edit_Ad", cnn);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@ad_id", Ads[id]));
                cmd.Parameters.Add(new SqlParameter("@description", EditedDesc));
                cmd.Parameters.Add(new SqlParameter("@location", EditedLoc));

                rdr = cmd.ExecuteReader();
                rdr.Close();
            }
            Label31.Visible = true;
            cnn.Close();

        }




    }
}