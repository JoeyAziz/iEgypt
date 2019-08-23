using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace iEgypt_M3
{
    public partial class ProfilePage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ShowProfile(sender, e);
        }
        private void ShowProfile(object sender, EventArgs e)
        {
            string output, user_type = "Viewer";

            /*
             *  SQL CONNECTION OPENING
             */
            string connetionString = WebConfigurationManager.ConnectionStrings["constr"].ConnectionString;
            SqlConnection cnn = new SqlConnection(connetionString);
            cnn.Open();

            SqlCommand cmd = new SqlCommand("Show_Profile", cnn);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@user_id", Session["ID"]));
            cmd.Parameters.Add("@email", System.Data.SqlDbType.NVarChar,64).Direction = System.Data.ParameterDirection.Output;
            cmd.Parameters.Add("@password", System.Data.SqlDbType.NVarChar, 64).Direction = System.Data.ParameterDirection.Output;
            cmd.Parameters.Add("@firstname", System.Data.SqlDbType.NVarChar, 64).Direction = System.Data.ParameterDirection.Output;
            cmd.Parameters.Add("@middlename", System.Data.SqlDbType.NVarChar, 64).Direction = System.Data.ParameterDirection.Output;
            cmd.Parameters.Add("@lastname", System.Data.SqlDbType.NVarChar, 64).Direction = System.Data.ParameterDirection.Output;
            cmd.Parameters.Add("@birth_date", System.Data.SqlDbType.Date).Direction = System.Data.ParameterDirection.Output;
            cmd.Parameters.Add("@working_place_name", System.Data.SqlDbType.NVarChar, 64).Direction = System.Data.ParameterDirection.Output;
            cmd.Parameters.Add("@working_place_type", System.Data.SqlDbType.NVarChar, 64).Direction = System.Data.ParameterDirection.Output;
            cmd.Parameters.Add("@wokring_place_description", System.Data.SqlDbType.NVarChar, 64).Direction = System.Data.ParameterDirection.Output;
            cmd.Parameters.Add("@specilization", System.Data.SqlDbType.NVarChar, 64).Direction = System.Data.ParameterDirection.Output;
            cmd.Parameters.Add("@portofolio_link", System.Data.SqlDbType.NVarChar, 64).Direction = System.Data.ParameterDirection.Output;
            cmd.Parameters.Add("@years_experience", System.Data.SqlDbType.Int).Direction = System.Data.ParameterDirection.Output;
            cmd.Parameters.Add("@hire_date", System.Data.SqlDbType.Date).Direction = System.Data.ParameterDirection.Output;
            cmd.Parameters.Add("@working_hours", System.Data.SqlDbType.Int).Direction = System.Data.ParameterDirection.Output;
            cmd.Parameters.Add("@payment_rate", System.Data.SqlDbType.Decimal).Direction = System.Data.ParameterDirection.Output;

            string email, password, first_name, middle_name, last_name, birth_date, working_place_name,
                working_place_type, wokring_place_description, specilization, portofolio_link, hire_date,
                years_exp, working_hours, payment_rate;
            using (SqlDataReader rdr = cmd.ExecuteReader())
            {
                email = Convert.ToString(cmd.Parameters["@email"].Value);
                password = Convert.ToString(cmd.Parameters["@password"].Value);
                first_name = Convert.ToString(cmd.Parameters["@firstname"].Value);
                middle_name = Convert.ToString(cmd.Parameters["@middlename"].Value);
                last_name = Convert.ToString(cmd.Parameters["@lastname"].Value);
                birth_date = Convert.ToString(cmd.Parameters["@birth_date"].Value);
                working_place_name = (cmd.Parameters["@working_place_name"].Value == null) ? "" : Convert.ToString(cmd.Parameters["@working_place_name"].Value);
                working_place_type = (cmd.Parameters["@working_place_type"].Value == null) ? "" : Convert.ToString(cmd.Parameters["@working_place_type"].Value);
                wokring_place_description = (cmd.Parameters["@wokring_place_description"].Value == null) ? "" : Convert.ToString(cmd.Parameters["@wokring_place_description"].Value);
                specilization = (cmd.Parameters["@specilization"].Value == null) ? "" : Convert.ToString(cmd.Parameters["@specilization"].Value);
                portofolio_link = (cmd.Parameters["@portofolio_link"].Value == null) ? "" : Convert.ToString(cmd.Parameters["@portofolio_link"].Value);
                years_exp = (cmd.Parameters["@years_experience"].Value == null)? "" : Convert.ToString(cmd.Parameters["@years_experience"].Value);
                hire_date = (cmd.Parameters["@hire_date"].Value == null)? "" : Convert.ToString(cmd.Parameters["@hire_date"].Value);
                working_hours = (cmd.Parameters["@working_hours"].Value == null)? "" : Convert.ToString(cmd.Parameters["@working_hours"].Value);
                payment_rate = (cmd.Parameters["@payment_rate"].Value == null) ? "" : Convert.ToString(cmd.Parameters["@payment_rate"].Value);
            }
            if (working_place_name.Length > 0)//viewer            
                user_type = "Viewer";
            else if (specilization.Length > 0)//contributor            
                user_type = "Contributor";
            else if (working_hours.Length > 0)//staff            
                user_type = "Staff";

            Session["USER_TYPE"] = user_type;


            output =
                "<p style=\"color:brown;\"> <b>" +
                "E-Mail: " + "<span style='color: darkgray'>" + email + "</span><br>" +
                "Password: " + "<span style='color: darkgray'>" + password + "</span><br>" +
                "Full Name: " + "<span style='color: darkgray'>" + first_name + ' ' + middle_name + ' ' + last_name + "</span><br>" +
                "Birth date: " + "<span style='color: darkgray'>" + birth_date.Substring(0,10)+ "</span><br>" +
                ((working_place_name.Length == 0)?" ": "working place name: " + "<span style='color: darkgray'>" + working_place_name + "</span><br>") +
                ((working_place_type.Length == 0) ? " " : "working place type: " + "<span style='color: darkgray'>" + working_place_type + "</span><br>") +
                ((wokring_place_description.Length == 0) ? "" : "wokring place description: " + "<span style='color: darkgray'>" + wokring_place_description + "</span><br>") +
                ((specilization.Length == 0) ? " " : "specilization: " + "<span style='color: darkgray'>" + specilization + "</span><br>") +
                ((portofolio_link.Length == 0) ? " " : "portofolio link: " + "<span style='color: darkgray'>" + portofolio_link + "</span><br>") +
                ((years_exp.Length == 0) ? " " : "years experience: " + "<span style='color: darkgray'>" + years_exp + "</span><br>") +
                ((hire_date.Length == 0) ? " " : "hire date: " + "<span style='color: darkgray'>" + hire_date.Substring(0, 10) + "</span><br>") +
                ((working_hours.Length == 0) ? " " : "working hours: " + "<span style='color: darkgray'>" + working_hours + "</span><br>") +
                ((payment_rate.Length == 0) ? " " : "payment rate: " + "<span style='color: darkgray'>" + payment_rate + "</span><br>") +
                "</b></p>"
                ;
            profileOutput.Text = output;
        }

        protected void GotoEditProfile(object sender, EventArgs e)
        {
            Response.Redirect("EditProfilePage.aspx");
        }

        protected void GotoViewer()
        {
           Response.Redirect("CreateEvent.aspx");
        }

        protected void GotoContributor()
        {
            Response.Redirect("Contributer.aspx");
        }

        protected void GotoStaff()
        {
            Response.Redirect("StaffMember.aspx");
        }

        protected void GotoFunctionsClicked(object sender, EventArgs e)
        {
            string user_type = Session["USER_TYPE"].ToString();
            switch (user_type)
            {
                case "Viewer":
                    {
                        GotoViewer();
                        break;
                    }
                case "Contributor":
                    {
                        GotoContributor();
                        break;
                    }
                case "Staff":
                    {
                        GotoStaff();
                        break;
                    }
            }
        }
    }
}