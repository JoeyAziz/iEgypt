using System;
using System.Collections;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace iEgypt_M3
{
    public partial class RegisterPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            contributorInputPart.Style.Add("display", "none");
        }

        protected void OnSelectionChange(object sender, EventArgs e)
        {
            if (userSelectType.SelectedValue.Equals("contributorType"))
            {
                contributorInputPart.Style.Add("display", "block;");
            } 
        }

        protected void OnRegisterButtonClicked(object sender, EventArgs args)
        {
            registerLabel.Style.Add("display", "none");
            ArrayList values = new ArrayList(); ArrayList values2 = new ArrayList();
            string user_type = (userSelectType.SelectedValue.Equals("contributorType")? "Contributor" : "Viewer"), 
                email = inputEmail.Value, 
                pass = inputPassword.Value, 
                first = inputFirstName.Value, 
                middle = inputMiddleName.Value, 
                last = inputLastName.Value, 
                birth = inputBirthDate.Value, 
                wpName = inputWorkingName.Value, 
                wpType = inputWorkingType.Value, 
                wpDescription = inputWorkingDescription.Value,
                specialization = inputSpecialization.Value, 
                portofolio = inputSpecialization.Value;
            int yearsOfExperience = (inputYearsExp.Value.Length > 0)?Convert.ToInt16(inputYearsExp.Value):0;

            values.AddRange(new ArrayList{ email,pass,first,middle,last,birth} );
            
            foreach(var val in values)
                if(val.ToString().Length == 0)
                {
                    registerLabel.Style.Add("display", "inline");
                    return;
                }
            if (user_type.Equals("Contributor"))
            {
                values2.AddRange(new ArrayList { wpName, wpType, wpDescription, specialization, portofolio });
                foreach (var val in values2)
                    if (val.ToString().Length == 0)
                    {
                        registerLabel.Style.Add("display", "inline");
                        return;
                    }
            }
            /*
             *  SQL CONNECTION OPENING
             */
            string connetionString = WebConfigurationManager.ConnectionStrings["constr"].ConnectionString;
            SqlConnection cnn = new SqlConnection(connetionString);
            cnn.Open();

            SqlCommand cmd = new SqlCommand("Register_User", cnn);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;

            cmd.Parameters.Add(new SqlParameter("@usertype", user_type));
            cmd.Parameters.Add(new SqlParameter("@email", email));
            cmd.Parameters.Add(new SqlParameter("@password", pass));

            cmd.Parameters.Add(new SqlParameter("@firstname", first));
            cmd.Parameters.Add(new SqlParameter("@middlename", middle));
            cmd.Parameters.Add(new SqlParameter("@lastname", last));

            cmd.Parameters.Add(new SqlParameter("@birth_date", birth+ " 12:00:00 AM"));
            cmd.Parameters.Add(new SqlParameter("@working_place_name", wpName));
            cmd.Parameters.Add(new SqlParameter("@working_place_type", wpType));
            cmd.Parameters.Add(new SqlParameter("@wokring_place_description", wpDescription));
            cmd.Parameters.Add(new SqlParameter("@specilization", specialization));
            cmd.Parameters.Add(new SqlParameter("@portofolio_link", portofolio));
            cmd.Parameters.Add(new SqlParameter("@years_experience", yearsOfExperience));

            cmd.Parameters.Add(new SqlParameter("@hire_date", DBNull.Value));
            cmd.Parameters.Add(new SqlParameter("@working_hours", DBNull.Value));
            cmd.Parameters.Add(new SqlParameter("@payment_rate", DBNull.Value));

            cmd.Parameters.Add("@user_id", System.Data.SqlDbType.Int).Direction = System.Data.ParameterDirection.Output;

            int e_id = 0;
            // execute the command
            try
            {
                using (SqlDataReader rdr = cmd.ExecuteReader())
                    e_id = Convert.ToInt32(cmd.Parameters["@user_id"].Value);
                Session["ID"] = e_id;
                Session["LOGGED_IN"] = true;
                Response.Redirect("HomePage.aspx");
            }
            catch(System.Data.SqlClient.SqlException)
            {
                registerLabel.Style.Add("display", "inline");
            }
             

             /*Close Connections*/
            cnn.Close();
          
        }
    }
}