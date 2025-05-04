using System;
using System.Configuration;
using MySql.Data.MySqlClient;

namespace Job_Portal.JobSeeker
{
    public partial class Contact : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        


        protected void btnsend_Click(object sender, EventArgs e)
        {
            // Get user input
            string name = txtName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string subject = txtSubject.Text.Trim();
            string message = txtMessage.Text.Trim();

            try
            {
                // Insert into database
                using (MySqlConnection con = new MySqlConnection(ConfigurationManager.ConnectionStrings["cs"].ConnectionString))
                {
                    string query = "INSERT INTO Contact (Name, Email, Subject, Message) VALUES (@Name, @Email, @Subject, @Message)";
                    using (MySqlCommand cmd = new MySqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@Name", name);
                        cmd.Parameters.AddWithValue("@Email", email);
                        cmd.Parameters.AddWithValue("@Subject", subject);
                        cmd.Parameters.AddWithValue("@Message", message);

                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }

                // Show success message
                lblMsg.Text = "Message sent successfully!";
                lblMsg.Visible = true;

                // Clear form
                txtName.Text = "";
                txtEmail.Text = "";
                txtSubject.Text = "";
                txtMessage.Text = "";
            }
            catch (Exception ex)
            {
                lblMsg.Text = "Error: " + ex.Message;
                lblMsg.CssClass = "text-danger font-weight-bold";
                lblMsg.Visible = true;
            }
        }
    }
}
