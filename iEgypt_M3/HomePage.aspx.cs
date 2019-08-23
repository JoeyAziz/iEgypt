using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data.SqlClient;
using System.Web.Configuration;
using System.Data;

namespace iEgypt_M3
{
    public partial class HomePage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["LOGGED_IN"].Equals(true)) { 
                HideLabel(sender, e, 2);

                string name = getNameFromID(Convert.ToInt16(Session["ID"].ToString()));
                welcomeTitle.Text = "Welcome Back, <a href='ProfilePage.aspx'>"+name+"</a>!";
            }
            else HideLabel(sender, e, 1);
        }

        private void HideLabel(object sender, EventArgs args, int key)
        {
            switch (key) {
                case 1:
                    {
                        //on page load, remove error labels
                        signinErrorLabel.Style.Add("display", "none");
                        searchLabel.Style.Add("display", "none");
                        break;
                    }
                case 2:
                    {
                        //on login, remove login form
                        HPanel.Style.Add("display", "none");
                        searchLabel.Style.Add("display", "none");
                        welcomeBack.Style.Add("display", "Block;");
                        break;
                    }
                case 3:
                    {
                        //remove any output label
                        originalSearchLabel.Text = "";
                        contributorSearchLabel.Text = "";
                        allContributorsLabel.Text = "";
                        allOriginalContentLabel.Text = "";
                        break;
                    }
            }
        }

        protected void SignInClickedButton(object sender, EventArgs args)
        {
           // System.Diagnostics.Debug.WriteLine("=======================BEGIN=====================");
            Login(sender, args);
        }

        public void Login(object sender, EventArgs args)
        {
            string email = inputEmail.Value;
            string password = inputPassword.Value;

            string connetionString;
            SqlConnection cnn;

            connetionString = WebConfigurationManager.ConnectionStrings["constr"].ConnectionString;

            /*
             *  SQL CONNECTION OPENING
             */
            cnn = new SqlConnection(connetionString);
            cnn.Open();

            SqlCommand cmd = new SqlCommand("User_login", cnn);

            // 2. set the command object so it knows to execute a stored procedure
            cmd.CommandType = System.Data.CommandType.StoredProcedure;

            // 3. add parameter to command, which will be passed to the stored procedure
            cmd.Parameters.Add(new SqlParameter("@email", email));
            cmd.Parameters.Add(new SqlParameter("@password", password));
            cmd.Parameters.Add("@user_id", System.Data.SqlDbType.Int).Direction = System.Data.ParameterDirection.Output;


            int e_id = 0;
            string active = "";
            // execute the command
            using (SqlDataReader rdr = cmd.ExecuteReader())
            {
                e_id = Convert.ToInt32(cmd.Parameters["@user_id"].Value);
            }

            if (e_id != -1)//Logged In
            {
                cmd = new SqlCommand("Select * From \"User\" Where ID = " + e_id, cnn);
                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    active = reader.GetValue(8).ToString().ToLower();
                }
                //If deactivated account
                if (active.Equals("false"))
                {
                    signinErrorLabel.Style.Add("display", "inline;");
                    signinErrorLabel.Text = "De-activated account!";
                }
                else //else
                {
                    Session["ID"] = e_id;
                    //Response.Redirect("Default.aspx");
                    Session["LOGGED_IN"] = true;
                    Response.Redirect("ProfilePage.aspx");

                    //Response.Redirect(Request.RawUrl);
                }
            }
            else { signinErrorLabel.Style.Add("display", "inline;"); signinErrorLabel.Text = "Wrong email/password"; }

            cnn.Close();
        }

        protected void SearchClickedButton(object sender, EventArgs args)
        {
            HideLabel(sender, args, 3);
            searchLabel.Style.Add("display", "none");
            //Base, Open SQL connection
            string connetionString;
            string searchInput = inputSearch.Value;
            string output_1 = " ";
            string output_2 = " ";
            bool flag = false;
            SqlConnection cnn;

            connetionString = WebConfigurationManager.ConnectionStrings["constr"].ConnectionString;

            /*
             *  SQL CONNECTION OPENING
             */
            cnn = new SqlConnection(connetionString);
            cnn.Open();

            SqlCommand cmd = new SqlCommand("Original_Content_Search", cnn);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;

            //Part 1: Search For Original Content
                //search for corresponding type
            cmd.Parameters.Add(new SqlParameter("@typename", searchInput));
            cmd.Parameters.Add(new SqlParameter("@categoryname", ' '));
            SqlDataReader dataReader = cmd.ExecuteReader();

            //contributor ID
            int cont_id = -1;

            while (dataReader.Read())
            {
                flag = true;
                cont_id = Convert.ToInt16(dataReader.GetValue(1).ToString());
                   
                output_1 = output_1 + "<br>" +
                    "<span style='color:brown'>" + "<b>Original Content Type: </b></span>" + searchInput + "<br>" +
                    "<span style='color:brown'>" + "<b>Rating:</b></span> "        + dataReader.GetValue(5).ToString() + "<br>" +
                    "<br><hr><br>";
            }
            dataReader.Close();
            //OR
            //search for corresponding name
            cmd = new SqlCommand("Original_Content_Search", cnn);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;

            if (!flag)
            {
                cmd.Parameters.Add(new SqlParameter("@typename", ' '));
                cmd.Parameters.Add(new SqlParameter("@categoryname", searchInput));
                dataReader = cmd.ExecuteReader();

                while (dataReader.Read())
                {
                    flag = true;
                    output_1 = output_1 + "<br>" +
                        "<span style='color:brown'>" + "<b>Original Content Category Name: </b></span>" + searchInput + "<br>" +
                        "<span style='color:brown'>" + "<b>Rating:</b></span> " + dataReader.GetValue(5).ToString() + "<br>" +
                        "<br><hr><br>";
                }
            }
            dataReader.Close();
            //Part 2: Search For Contributors
            cmd = new SqlCommand("Contributor_Search", cnn);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@fullname", searchInput));
            dataReader = cmd.ExecuteReader();
            while (dataReader.Read())
            {
                flag = true;
                output_2 = output_2 + "<br>" +

                "<span style='color:red'>"  + "<b> Contributor Name: </b></span>"   + searchInput                       + "<br>" +
                "<span style='color:red'>"  + "<b>Years of Experience:</b></span> " + dataReader.GetValue(1).ToString() + "<br>" +
                "<span style='color:red'>"  + "<b>Portofolio Link:</b></span> "     + dataReader.GetValue(2).ToString() + "<br>" +
                "<span style='color:red'>"  + "<b>Specialization:</b></span> "      + dataReader.GetValue(3).ToString() + "<br>" +
                "<br><hr><br>";                
            }
            dataReader.Close();
            //Part 3: Put on label what results
            if (!flag)
                searchLabel.Style.Add("display", "inline");
               
            originalSearchLabel.Text    = output_1;
            contributorSearchLabel.Text = output_2;
            /*Close connections*/
            cnn.Close();
        }

        protected void ShowAllContributors(object sender, EventArgs args)
        {
            HideLabel(sender, args, 3);

            string output = " ";

            string connetionString;
            SqlConnection cnn;

            connetionString = WebConfigurationManager.ConnectionStrings["constr"].ConnectionString;

            /*
             *  SQL CONNECTION OPENING
             */
            cnn = new SqlConnection(connetionString);
            cnn.Open();

            SqlCommand cmd = new SqlCommand("Order_Contributers", cnn);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            SqlDataReader dataReader = cmd.ExecuteReader(); 
            
            while (dataReader.Read())
            {
                string name = getNameFromID(Convert.ToInt16(dataReader.GetValue(0).ToString()));
                output = output + "<br>" +
                "<span style='color:red'>" + "<b> Contributor Name: </b></span>" + name + "<br>" +
                "<span style='color:red'>" + "<b>Years of Experience:</b></span> " + dataReader.GetValue(1).ToString() + "<br>" +
                "<span style='color:red'>" + "<b>Portofolio Link:</b></span> " + dataReader.GetValue(2).ToString() + "<br>" +
                "<span style='color:red'>" + "<b>Specialization:</b></span> " + dataReader.GetValue(3).ToString() + "<br>" +
                "<br><hr><br>";                    
            }
            
            /*Close connections*/
            dataReader.Close();
            cnn.Close();

            allContributorsLabel.Text = output;
        }

        private string getNameFromID(int id)
        {
            string name = "something wrong" ;

            string connetionString;
            SqlConnection cnn;

            connetionString = WebConfigurationManager.ConnectionStrings["constr"].ConnectionString;

            /*
             *  SQL CONNECTION OPENING
             */
            cnn = new SqlConnection(connetionString);
            cnn.Open();
            SqlCommand cmd = new SqlCommand("select * from \"User\" WHERE ID = " + id, cnn);
            SqlDataReader dataReader = cmd.ExecuteReader();
            while (dataReader.Read())
                    name = dataReader.GetValue(2) + " " + dataReader.GetValue(3) + " " + dataReader.GetValue(4);
            /*Close connections*/
            dataReader.Close();
            cnn.Close();
            return name;
        }

        protected void ShowAllOriginalContent(object sender, EventArgs args)
        {
            HideLabel(sender, args, 3);

            string output = " ";

            string connetionString;
            SqlConnection cnn;

            connetionString = WebConfigurationManager.ConnectionStrings["constr"].ConnectionString;

            /*
             *  SQL CONNECTION OPENING
             */
            cnn = new SqlConnection(connetionString);
            cnn.Open();

            SqlCommand cmd = new SqlCommand("SHOW_ORIGINAL_CONTENT", cnn);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;

            cmd.Parameters.Add(new SqlParameter("@contributer_id", DBNull.Value));
            SqlDataReader dataReader = cmd.ExecuteReader();

            while (dataReader.Read())
            {
                string name = getNameFromID(Convert.ToInt16(dataReader.GetValue(1).ToString()));
                output = output + "<br>" +
                "<span style='color:red'>" + "<b> Content Manager Name: </b></span>" + name + "<br>" +
                "<span style='color:red'>" + "<b> Content Rating: </b></span>" + dataReader.GetValue(5).ToString() + "<br>" +
                "<span style='color:red'>" + "<b>Years of Experience:</b></span> " + dataReader.GetValue(7).ToString() + "<br>" +
                "<span style='color:red'>" + "<b>Portofolio Link:</b></span> " + dataReader.GetValue(8).ToString() + "<br>" +
                "<span style='color:red'>" + "<b>Specialization:</b></span> " + dataReader.GetValue(9).ToString() + "<br>" +
                "<br><hr><br>";
            }

            /*Close connections*/
            dataReader.Close();
            cnn.Close();

            allOriginalContentLabel.Text = output;
        }
    }
}