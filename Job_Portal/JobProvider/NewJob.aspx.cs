using System;
using System.Configuration;
using System.IO;
using MySql.Data.MySqlClient;
using System.Web.UI;

namespace OnlineJobPortal.JobProvider
{
    public partial class NewJob : System.Web.UI.Page
    {
        string str = ConfigurationManager.ConnectionStrings["cs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Role"] == null || Session["Role"].ToString() != "Job Provider")
            {
                Response.Redirect("../JobSeeker/Login.aspx");
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string logoPath = "";

                try
                {
                    if (fuCompanyLogo.HasFile && IsValidExtension(fuCompanyLogo.FileName))
                    {
                        string ext = Path.GetExtension(fuCompanyLogo.FileName);
                        string uniqueFileName = Guid.NewGuid().ToString() + ext;
                        logoPath = "~/CompanyLogos/" + uniqueFileName;
                        fuCompanyLogo.SaveAs(Server.MapPath(logoPath));
                    }

                    using (MySqlConnection con = new MySqlConnection(str))
                    {
                        string query = @"INSERT INTO Jobs 
                        (Title, NoOfPost, Description, Qualification, Experience, Specialization, LastDateToApply, Salary, JobType,
                         CompanyName, CompanyImage, Website, Email, Address, Country, State, CreateDate)
                         VALUES 
                        (@Title, @NoOfPost, @Description, @Qualification, @Experience, @Specialization, @LastDateToApply, @Salary,
                         @JobType, @CompanyName, @CompanyImage, @Website, @Email, @Address, @Country, @State, NOW())";

                        using (MySqlCommand cmd = new MySqlCommand(query, con))
                        {
                            cmd.Parameters.AddWithValue("@Title", txtJobTitle.Text.Trim());
                            cmd.Parameters.AddWithValue("@NoOfPost", int.Parse(txtNoOfPost.Text.Trim()));
                            cmd.Parameters.AddWithValue("@Description", txtDescription.Text.Trim());
                            cmd.Parameters.AddWithValue("@Qualification", txtQualification.Text.Trim());
                            cmd.Parameters.AddWithValue("@Experience", txtExperience.Text.Trim());
                            cmd.Parameters.AddWithValue("@Specialization", txtSpecialization.Text.Trim());
                            cmd.Parameters.AddWithValue("@LastDateToApply", Convert.ToDateTime(txtLastDate.Text.Trim()));
                            cmd.Parameters.AddWithValue("@Salary", txtSalary.Text.Trim());
                            cmd.Parameters.AddWithValue("@JobType", txtJobType.Text.Trim());
                            cmd.Parameters.AddWithValue("@CompanyName", txtCompanyName.Text.Trim());
                            cmd.Parameters.AddWithValue("@CompanyImage", logoPath);
                            cmd.Parameters.AddWithValue("@Website", txtWebsite.Text.Trim());
                            cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                            cmd.Parameters.AddWithValue("@Address", txtAddress.Text.Trim());
                            cmd.Parameters.AddWithValue("@Country", txtCountry.Text.Trim());
                            cmd.Parameters.AddWithValue("@State", txtState.Text.Trim());

                            con.Open();
                            int rows = cmd.ExecuteNonQuery();

                            lblMsg.Text = rows > 0
                                ? "<div class='alert alert-success'>Job added successfully!</div>"
                                : "<div class='alert alert-danger'>Failed to add job.</div>";

                            if (rows > 0) ClearForm();
                        }
                    }
                }
                catch (Exception ex)
                {
                    lblMsg.Text = $"<div class='alert alert-danger'>Error: {ex.Message}</div>";
                }
            }
        }

        private bool IsValidExtension(string fileName)
        {
            string[] allowedExts = { ".jpg", ".jpeg", ".png", ".gif", ".bmp", ".webp" };
            string ext = Path.GetExtension(fileName).ToLower();
            return Array.Exists(allowedExts, e => e == ext);
        }

        private void ClearForm()
        {
            txtJobTitle.Text = txtNoOfPost.Text = txtDescription.Text = txtQualification.Text = txtExperience.Text =
            txtSpecialization.Text = txtLastDate.Text = txtSalary.Text = txtJobType.Text = txtCompanyName.Text =
            txtWebsite.Text = txtEmail.Text = txtAddress.Text = txtCountry.Text = txtState.Text = "";
        }
    }
}
