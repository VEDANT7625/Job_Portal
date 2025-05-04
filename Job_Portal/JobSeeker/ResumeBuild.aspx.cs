using System;
using System.Configuration;
using System.Data;
using MySql.Data.MySqlClient;

namespace Job_Portal.JobSeeker
{
    public partial class ResumeBuild : System.Web.UI.Page
    {
        string str = ConfigurationManager.ConnectionStrings["cs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Username"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadCountryList();
                LoadUserDetails();
            }
        }

        private void LoadCountryList()
        {
            using (MySqlConnection con = new MySqlConnection(str))
            {
                string query = "SELECT CountryName FROM Country";
                MySqlCommand cmd = new MySqlCommand(query, con);
                con.Open();
                ddlCountry.DataSource = cmd.ExecuteReader();
                ddlCountry.DataBind();
                con.Close();
            }
        }

        private void LoadUserDetails()
        {
            using (MySqlConnection con = new MySqlConnection(str))
            {
                string query = "SELECT * FROM user WHERE Username = @Username";
                MySqlCommand cmd = new MySqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Username", Session["Username"].ToString());

                con.Open();
                MySqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    txtFullName.Text = reader["Name"].ToString();
                    txtEmail.Text = reader["Email"].ToString();
                    txtMobile.Text = reader["Mobile"].ToString();
                    txtAddress.Text = reader["Address"].ToString();
                    txtTenth.Text = reader["TenthGrade"].ToString();
                    txtTwelfth.Text = reader["TwelfthGrade"].ToString();
                    txtGraduation.Text = reader["GraduationGrade"].ToString();
                    txtPostGrad.Text = reader["PostGraduationGrade"].ToString();
                    txtPhd.Text = reader["Phd"].ToString();
                    txtWorksOn.Text = reader["WorksOn"].ToString();
                    txtExperience.Text = reader["Experience"].ToString();

                    if (ddlCountry.Items.FindByValue(reader["Country"].ToString()) != null)
                    {
                        ddlCountry.SelectedValue = reader["Country"].ToString();
                    }
                }
                con.Close();
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            using (MySqlConnection con = new MySqlConnection(str))
            {
                string query = @"UPDATE User SET 
                                    Name=@Name,
                                    Email=@Email,
                                    Mobile=@Mobile,
                                    TenthGrade=@TenthGrade,
                                    TwelfthGrade=@TwelfthGrade,
                                    GraduationGrade=@GraduationGrade,
                                    PostGraduationGrade=@PostGraduationGrade,
                                    Phd=@Phd,
                                    WorksOn=@WorksOn,
                                    Experience=@Experience,
                                    Address=@Address,
                                    Country=@Country
                                 WHERE Username=@Username";

                MySqlCommand cmd = new MySqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Name", txtFullName.Text.Trim());
                cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                cmd.Parameters.AddWithValue("@Mobile", txtMobile.Text.Trim());
                cmd.Parameters.AddWithValue("@TenthGrade", txtTenth.Text.Trim());
                cmd.Parameters.AddWithValue("@TwelfthGrade", txtTwelfth.Text.Trim());
                cmd.Parameters.AddWithValue("@GraduationGrade", txtGraduation.Text.Trim());
                cmd.Parameters.AddWithValue("@PostGraduationGrade", txtPostGrad.Text.Trim());
                cmd.Parameters.AddWithValue("@Phd", txtPhd.Text.Trim());
                cmd.Parameters.AddWithValue("@WorksOn", txtWorksOn.Text.Trim());
                cmd.Parameters.AddWithValue("@Experience", txtExperience.Text.Trim());
                cmd.Parameters.AddWithValue("@Address", txtAddress.Text.Trim());
                cmd.Parameters.AddWithValue("@Country", ddlCountry.SelectedItem.Text);
                cmd.Parameters.AddWithValue("@Username", Session["Username"].ToString());

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();

                lblMsg.Text = "Resume updated successfully!";
                lblMsg.CssClass = "alert alert-success d-block";
                Response.Redirect("Profile.aspx");
            }
        }
    }
}
