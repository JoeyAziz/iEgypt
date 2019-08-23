using System;
using System.Collections;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace iEgypt_M3
{
    public partial class EditProfilePage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["USER_TYPE"].Equals("Viewer"))
            {
                viewerPart.Style.Add("display", "inline");
            }
            else if (Session["USER_TYPE"].Equals("Contributor"))
            {
                contributorPart.Style.Add("display", "inline");
            }
            else if (Session["USER_TYPE"].Equals("Staff"))
            {
                staffPart.Style.Add("display", "inline");
                cmanagerPart.Style.Add("display", "inline");
            }
            errorLabel.Visible = false;
        }

        protected void OnEditProfileButtonClicked(object sender, EventArgs args)
        {
            errorLabel.Visible = false;
            ArrayList values = new ArrayList(); ArrayList values2 = new ArrayList();
            string user_type = Session["USER_TYPE"].ToString(),
                email = emailField.Value,
                pass = passwordField.Value,
                first = firstnameField.Value,
                middle = middlenameField.Value,
                last = lastnameField.Value,
                birth = birthdateField.Value,
                wpName = wplaceField.Value,
                wpType = wplaceTypeField.Value,
                wpDescription = wplaceDescriptionField.Value,
                specialization = specializationField.Value,
                portofolio = pLinkField.Value,
                hireDate = hireDateField.Value,
                workingHours = wHoursField.Value,                
                type = typeField.Value
                ;
            int yearsOfExperience = (experienceField.Value.Length > 0) ? Convert.ToInt16(experienceField.Value) : 0;
            double paymentRate = (paymentRateField.Value.Length > 0) ? Convert.ToDouble(paymentRateField.Value) : 0; 

            values.AddRange(new ArrayList { email, pass, first, middle, last, birth });
            foreach (var val in values)
                if (val.ToString().Length == 0)
                {
                    errorLabel.Visible = true;
                    return;
                }
            if (user_type.Equals("Viewer"))
            {
                values2.AddRange(new ArrayList { wpName, wpType, wpDescription });
                foreach (var val in values2)
                    if (val.ToString().Length == 0)
                    {
                        errorLabel.Visible = true;
                        return;
                    }
            }
            else if (user_type.Equals("Contributor"))
            {
                values2.AddRange(new ArrayList { specialization, portofolio});
                foreach (var val in values2)
                    if (val.ToString().Length == 0)
                    {
                        errorLabel.Visible = true;
                        return;
                    }
            }
            else if (user_type.Equals("Staff"))
            {
                values2.AddRange(new ArrayList { hireDate, workingHours, paymentRate, type });
                foreach (var val in values2)
                    if (val.ToString().Length == 0)
                    {
                        errorLabel.Visible = true;
                        return;
                    }
            }
            /*
             *  SQL CONNECTION OPENING
             */
            string connetionString = System.Web.Configuration.WebConfigurationManager.ConnectionStrings["constr"].ConnectionString;
            SqlConnection cnn = new SqlConnection(connetionString);
            cnn.Open();

            SqlCommand cmd = new SqlCommand("Edit_Profile", cnn);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;

            cmd.Parameters.Add(new SqlParameter("@user_id", Session["ID"]));
            cmd.Parameters.Add(new SqlParameter("@email", email));
            cmd.Parameters.Add(new SqlParameter("@password", pass));

            cmd.Parameters.Add(new SqlParameter("@firstname", first));
            cmd.Parameters.Add(new SqlParameter("@middlename", middle));
            cmd.Parameters.Add(new SqlParameter("@lastname", last));

            cmd.Parameters.Add(new SqlParameter("@birth_date", birth + " 12:00:00 AM"));
            cmd.Parameters.Add(new SqlParameter("@working_place_name", wpName));
            cmd.Parameters.Add(new SqlParameter("@working_place_type", wpType));
            cmd.Parameters.Add(new SqlParameter("@working_place_description", wpDescription));
            cmd.Parameters.Add(new SqlParameter("@specilization", specialization));
            cmd.Parameters.Add(new SqlParameter("@portofolio_link", portofolio));
            cmd.Parameters.Add(new SqlParameter("@years_experience", yearsOfExperience));

            cmd.Parameters.Add(new SqlParameter("@hire_date", hireDate));
            cmd.Parameters.Add(new SqlParameter("@working_hours", workingHours));
            cmd.Parameters.Add(new SqlParameter("@payment_rate", paymentRate));

            SqlDataReader datareader = cmd.ExecuteReader();

            Response.Redirect("ProfilePage.aspx");
            /*
             *Close Connections
             */
            datareader.Close();
            cnn.Close();
        }

        protected void OnDeactivateButtonClicked(object sender, EventArgs args)
        {
            /*
             *  SQL CONNECTION OPENING
             */
            string connetionString = System.Web.Configuration.WebConfigurationManager.ConnectionStrings["constr"].ConnectionString;
            SqlConnection cnn = new SqlConnection(connetionString);
            cnn.Open();

            SqlCommand cmd = new SqlCommand("Deactivate_Profile", cnn);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@user_id", Session["ID"]));
            SqlDataReader datareader = cmd.ExecuteReader();

            Session["ID"] = null;
            Session["LOGGED_IN"] = false;
            Response.Redirect("HomePage.aspx");
            /*
             *Close Connections
             */
            datareader.Close();
            cnn.Close();

        }
    }
}