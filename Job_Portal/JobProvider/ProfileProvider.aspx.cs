using System;
using System.Configuration;
using System.Data;
using System.IO;
using System.Web.UI;
using MySql.Data.MySqlClient;

namespace Job_Portal.JobProvider
{
    public partial class ProfileProvider : System.Web.UI.Page
    {
        string str = ConfigurationManager.ConnectionStrings["cs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadUserProfile();
            }
        }

        private void LoadUserProfile()
        {
            try
            {
                if (Session["UserID"] != null)
                {
                    int userId = Convert.ToInt32(Session["UserID"]);

                    using (MySqlConnection conn = new MySqlConnection(str))
                    {
                        string query = "SELECT UserID, Name, Username, Email, Mobile, Address, Country FROM user WHERE UserID = @UserID";
                        MySqlCommand cmd = new MySqlCommand(query, conn);
                        cmd.Parameters.AddWithValue("@UserID", userId);
                        MySqlDataAdapter da = new MySqlDataAdapter(cmd);
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        if (dt.Rows.Count > 0)
                        {
                            DataRow row = dt.Rows[0];
                            lblName.Text = row["Name"].ToString();
                            lblUsername.Text = row["Username"].ToString();
                            lblEmail.Text = row["Email"].ToString();
                            lblMobile.Text = row["Mobile"].ToString();
                            lblAddress.Text = row["Address"].ToString();
                            lblCountry.Text = row["Country"].ToString();

                            string fullName = row["Name"].ToString();
                            string avatarUrl = "https://ui-avatars.com/api/?name=" + fullName.Replace(" ", "+") + "&background=6f42c1&color=fff&size=140";
                            imgAvatar.ImageUrl = avatarUrl;

                        }
                        else
                        {
                            lblName.Text = "User not found";
                        }
                    }
                }
                else
                {
                    Response.Redirect("~/JobSeeker/Login.aspx");
                }
            }
            catch (Exception ex)
            {
                Response.Write("Error: " + ex.Message);
            }
        }

        
    }
}
