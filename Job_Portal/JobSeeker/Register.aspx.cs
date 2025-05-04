using System;
using System.Configuration;
using MySql.Data.MySqlClient;

namespace Job_Portal.JobSeeker   
{
    public partial class Register : System.Web.UI.Page
    {
        string str = ConfigurationManager.ConnectionStrings["cs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Do nothing on first load
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            lblMsg.Visible = true;

            try
            {
                using (MySqlConnection con = new MySqlConnection(str))
                {
                    string queryStr = @"INSERT INTO `User` 
                        (Username, Password, Name, Address, Mobile, Email, Country, Role) 
                        VALUES 
                        (@Username, @Password, @Name, @Address, @Mobile, @Email, @Country, @Role)";

                    MySqlCommand cmd = new MySqlCommand(queryStr, con);

                    cmd.Parameters.AddWithValue("@Username", txtUserName.Text.Trim());
                    cmd.Parameters.AddWithValue("@Password", txtPassword.Text.Trim());
                    cmd.Parameters.AddWithValue("@Name", txtFullName.Text.Trim());
                    cmd.Parameters.AddWithValue("@Address", txtAddress.Text.Trim());
                    cmd.Parameters.AddWithValue("@Mobile", txtMobile.Text.Trim());
                    cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                    cmd.Parameters.AddWithValue("@Country", ddlCountry.SelectedValue);
                    cmd.Parameters.AddWithValue("@Role", ddlUserType.SelectedValue); // ✅ New user type (role)

                    con.Open();
                    int r = cmd.ExecuteNonQuery();

                    if (r > 0)
                    {
                        lblMsg.Text = "Registered Successfully.";
                        lblMsg.CssClass = "alert alert-success";
                        clear();
                    }
                    else
                    {
                        lblMsg.Text = "Error saving data, please try again later.";
                        lblMsg.CssClass = "alert alert-danger";
                    }
                }
            }
            catch (MySqlException ex)
            {
                if (ex.Message.ToLower().Contains("duplicate") || ex.Message.Contains("UNIQUE"))
                {
                    lblMsg.Text = $"<b>{txtUserName.Text.Trim()}</b> username already exists.";
                    lblMsg.CssClass = "alert alert-danger";
                }
                else
                {
                    lblMsg.Text = "Database Error: " + ex.Message;
                    lblMsg.CssClass = "alert alert-danger";
                }
            }
            catch (Exception ex)
            {
                lblMsg.Text = ex.Message;
                lblMsg.CssClass = "alert alert-danger";
            }
        }

        private void clear()
        {
            txtUserName.Text = "";
            txtPassword.Text = "";
            txtConfirmPassword.Text = "";
            txtFullName.Text = "";
            txtAddress.Text = "";
            txtMobile.Text = "";
            txtEmail.Text = "";
            ddlCountry.SelectedIndex = 0;
            ddlUserType.SelectedIndex = 0;
        }

        protected void ddlCountry_SelectedIndexChanged2(object sender, EventArgs e)
        {
            // Optional logic
        }
    }
}
