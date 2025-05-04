using System;
using System.IO;
using System.Data;
using System.Configuration;
using MySql.Data.MySqlClient;
using System.Web;
using System.Text;

namespace Job_Portal.JobSeeker
{
    public partial class Job_Details1 : System.Web.UI.Page
    {
        string constr = ConfigurationManager.ConnectionStrings["cs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["JobID"] != null)
                {
                    LoadJobDetails();
                    CheckIfAlreadyApplied();
                }
                else
                {
                    Response.Redirect("Job_Listing.aspx");
                }
            }
        }

        private void LoadJobDetails()
        {
            int jobId = Convert.ToInt32(Request.QueryString["JobID"]);

            using (MySqlConnection con = new MySqlConnection(constr))
            {
                string query = "SELECT * FROM Jobs WHERE JobID = @JobID";
                using (MySqlCommand cmd = new MySqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@JobID", jobId);
                    con.Open();

                    using (MySqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            // Basic Info
                            lblJobTitle.Text = reader["Title"].ToString();
                            lblJobTitle2.Text = reader["Title"].ToString();
                            lblCompany.Text = reader["CompanyName"].ToString();
                            lblLocation.Text = reader["State"].ToString();
                            lblLocation2.Text = reader["Country"].ToString();
                            lblSalary.Text = reader["Salary"].ToString();
                            lblSalary2.Text = reader["Salary"].ToString();
                            lblDescription.Text = reader["Description"].ToString();
                            lblPostedDate.Text = Convert.ToDateTime(reader["CreateDate"]).ToString("dd MMM yyyy");
                            lblVacancy.Text = reader["NoofPost"].ToString();
                            lblJobType.Text = reader["JobType"].ToString();
                            lblLastDate.Text = Convert.ToDateTime(reader["LastDateToApply"]).ToString("dd MMM yyyy");

                            // Company Info
                            lblCompanyName.Text = reader["CompanyName"].ToString();
                            lblWebsite.Text = reader["Website"].ToString();
                            lblEmail.Text = reader["Email"].ToString();

                            // Qualifications
                            string[] qualifications = reader["Qualification"]?.ToString().Split(',');
                            if (qualifications != null && qualifications.Length > 0)
                            {
                                var qualBuilder = new StringBuilder();
                                foreach (string q in qualifications)
                                    qualBuilder.Append($"<li>{q.Trim()}</li>");
                                litQualification.Text = qualBuilder.ToString();
                            }

                            // Experience
                            string[] experiences = reader["Experience"]?.ToString().Split(',');
                            if (experiences != null && experiences.Length > 0)
                            {
                                var expBuilder = new StringBuilder();
                                foreach (string exp in experiences)
                                    expBuilder.Append($"<li>{exp.Trim()}</li>");
                                litExperience.Text = expBuilder.ToString();
                            }

                            // Optional: Display Company Image if needed
                            if (reader["CompanyImage"] != DBNull.Value)
                            {
                                imgCompanyLogo.ImageUrl = GetCompanyImage(reader["CompanyImage"]);
                            }
                        }
                    }
                }
            }
        }

        private void CheckIfAlreadyApplied()
        {
            if (Session["UserID"] != null && Request.QueryString["JobID"] != null)
            {
                int userId = Convert.ToInt32(Session["UserID"]);
                int jobId = Convert.ToInt32(Request.QueryString["JobID"]);

                using (MySqlConnection con = new MySqlConnection(constr))
                {
                    string query = "SELECT COUNT(*) FROM AppliedCandidates WHERE UserID = @UserID AND JobID = @JobID";
                    MySqlCommand cmd = new MySqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@UserID", userId);
                    cmd.Parameters.AddWithValue("@JobID", jobId);

                    con.Open();
                    int count = Convert.ToInt32(cmd.ExecuteScalar());
                    con.Close();

                    if (count > 0)
                    {
                        btnApply.Enabled = false;
                        lblApplyStatus.Text = "Already Applied";
                        lblApplyStatus.CssClass = "text-success";
                    }
                }
            }
        }

        protected void btnApply_Click(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("~/JobSeeker/Login.aspx");
                return;
            }

            int userId = Convert.ToInt32(Session["UserID"]);
            int jobId = Convert.ToInt32(Request.QueryString["JobID"]);

            using (MySqlConnection con = new MySqlConnection(constr))
            {
                string resumeQuery = "SELECT Resume FROM User WHERE UserID = @UserID";
                MySqlCommand resumeCmd = new MySqlCommand(resumeQuery, con);
                resumeCmd.Parameters.AddWithValue("@UserID", userId);

                con.Open();
                object resumePath = resumeCmd.ExecuteScalar();

                if (resumePath == null || string.IsNullOrEmpty(resumePath.ToString()))
                {
                    lblApplyStatus.Text = "Please upload your resume before applying.";
                    lblApplyStatus.CssClass = "text-danger";
                    con.Close();
                    return;
                }

                string insertQuery = "INSERT INTO AppliedCandidates (UserID, JobID, Resume, ApplyDate) VALUES (@UserID, @JobID, @Resume, @ApplyDate)";
                MySqlCommand cmd = new MySqlCommand(insertQuery, con);
                cmd.Parameters.AddWithValue("@UserID", userId);
                cmd.Parameters.AddWithValue("@JobID", jobId);
                cmd.Parameters.AddWithValue("@Resume", resumePath.ToString());
                cmd.Parameters.AddWithValue("@ApplyDate", DateTime.Now);

                int rowsAffected = cmd.ExecuteNonQuery();
                con.Close();

                if (rowsAffected > 0)
                {
                    lblApplyStatus.Text = "Application submitted successfully.";
                    lblApplyStatus.CssClass = "text-success";
                    btnApply.Enabled = false;
                }
                else
                {
                    lblApplyStatus.Text = "Something went wrong. Please try again.";
                    lblApplyStatus.CssClass = "text-danger";
                }
            }
        }

        // ✅ NEW METHOD ADDED
        protected string GetCompanyImage(object imagePath)
        {
            string path = imagePath?.ToString();
            return string.IsNullOrEmpty(path)
                ? ResolveUrl("~/images/default-logo.png")
                : ResolveUrl(path);
        }
    }
}
