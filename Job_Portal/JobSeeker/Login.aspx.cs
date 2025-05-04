using System;
using System.Configuration;
using MySql.Data.MySqlClient;

namespace Job_Portal.JobSeeker
{
    public partial class Login : System.Web.UI.Page
    {
        string str = ConfigurationManager.ConnectionStrings["cs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblMsg.Visible = false;

                // Inject the "New User" link
                string html = @"<span class='clickLink d-block mt-3'>
                                    <a href='../JobSeeker/Register.aspx'>New User? Click Here..</a>
                                </span>";
                litRegisterLink.Text = html;
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            lblMsg.Visible = true;

            string loginType = ddlLoginType.SelectedValue;
            string username = txtUserName.Text.Trim();
            string password = txtPassword.Text.Trim();

            if (loginType == "0")
            {
                lblMsg.Text = "Please select a user type.";
                lblMsg.CssClass = "alert alert-danger";
                return;
            }

            try
            {
                using (MySqlConnection con = new MySqlConnection(str))
                {
                    string query = @"SELECT * FROM User 
                                     WHERE Username = @Username 
                                       AND Password = @Password 
                                       AND Role = @Role";

                    MySqlCommand cmd = new MySqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@Username", username);
                    cmd.Parameters.AddWithValue("@Password", password);
                    cmd.Parameters.AddWithValue("@Role", loginType);

                    con.Open();
                    MySqlDataReader reader = cmd.ExecuteReader();

                    if (reader.HasRows)
                    {
                        reader.Read();
                        Session["Username"] = reader["Username"].ToString();
                        Session["UserID"] = reader["UserID"].ToString();
                        Session["Role"] = reader["Role"].ToString();

                        if (loginType == "Job Provider")
                        {
                            Response.Redirect("~/JobProvider/Dashboard.aspx", true);
                        }
                        else if (loginType == "Job Seeker")
                        {
                            Response.Redirect("~/JobSeeker/Index.aspx", true);
                        }
                    }
                    else
                    {
                        lblMsg.Text = "Invalid credentials or user type mismatch.";
                        lblMsg.CssClass = "alert alert-danger";
                    }
                }
            }
            catch (Exception ex)
            {
                lblMsg.Text = "Error: " + ex.Message;
                lblMsg.CssClass = "alert alert-danger";
            }
        }
    }
}
