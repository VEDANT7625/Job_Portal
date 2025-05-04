using System;
using System.Configuration;
using System.Data;
using System.IO;
using System.Web.UI;
using MySql.Data.MySqlClient;

namespace Job_Portal.JobSeeker
{
    public partial class Profile : System.Web.UI.Page
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
                        string query = "SELECT UserID, Name, Username, Email, Mobile, Address, Country, Resume FROM user WHERE UserID = @UserID";
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

                            string resumePath = row["Resume"]?.ToString();
                            lblResume.Text = !string.IsNullOrEmpty(resumePath) ? "Resume Uploaded ✅" : "Not Uploaded ❌";
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

        protected void btnUploadResume_Click(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("~/JobSeeker/Login.aspx");
                return;
            }

            if (FileUploadResume.HasFile)
            {
                string fileExtension = Path.GetExtension(FileUploadResume.FileName).ToLower();
                if (fileExtension == ".pdf")
                {
                    try
                    {
                        int userId = Convert.ToInt32(Session["UserID"]);
                        string folderPath = Server.MapPath("~/Resumes/");
                        if (!Directory.Exists(folderPath))
                        {
                            Directory.CreateDirectory(folderPath);
                        }

                        string fileName = "Resume" + userId + fileExtension;
                        string filePath = Path.Combine(folderPath, fileName);

                        // Optional delete before save
                        if (File.Exists(filePath))
                        {
                            File.Delete(filePath);
                        }

                        FileUploadResume.SaveAs(filePath);

                        string dbPath = "Resume/" + fileName;

                        using (MySqlConnection conn = new MySqlConnection(str))
                        {
                            string query = "UPDATE user SET Resume = @Resume WHERE UserID = @UserID";
                            MySqlCommand cmd = new MySqlCommand(query, conn);
                            cmd.Parameters.AddWithValue("@Resume", dbPath);
                            cmd.Parameters.AddWithValue("@UserID", userId);
                            conn.Open();
                            cmd.ExecuteNonQuery();
                        }


                        LoadUserProfile();
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Resume uploaded successfully.');", true);
                    }
                    catch (Exception ex)
                    {
                        Response.Write("Error: " + ex.Message);
                    }
                }
                else
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Only PDF files are allowed.');", true);
                }
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Please select a resume file to upload.');", true);
            }
        }
    }
}
