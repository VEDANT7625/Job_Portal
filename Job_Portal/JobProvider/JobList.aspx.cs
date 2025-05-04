using System;
using System.Configuration;
using System.Data;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;

namespace Job_Portal.JobProvider
{
    public partial class JobList : System.Web.UI.Page
    {
        string conStr = ConfigurationManager.ConnectionStrings["cs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                BindGrid();
        }

        private void BindGrid()
        {
            using (MySqlConnection con = new MySqlConnection(conStr))
            {
                MySqlCommand cmd = new MySqlCommand("SELECT * FROM Jobs ORDER BY CreateDate DESC", con);
                MySqlDataAdapter sda = new MySqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);

                dt.Columns.Add("Sr.No", typeof(int));
                for (int i = 0; i < dt.Rows.Count; i++)
                    dt.Rows[i]["Sr.No"] = i + 1;

                GridView1.DataSource = dt;
                GridView1.DataBind();
            }
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            BindGrid();
        }

        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
            BindGrid();
        }

        protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;
            BindGrid();
        }

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int jobId = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value);
            GridViewRow row = GridView1.Rows[e.RowIndex];

            string title = ((TextBox)row.FindControl("txtTitle")).Text;
            int noOfPost = Convert.ToInt32(((TextBox)row.FindControl("txtNoOfPost")).Text);
            string qualification = ((TextBox)row.FindControl("txtQualification")).Text;
            string experience = ((TextBox)row.FindControl("txtExperience")).Text;
            string lastDateInput = ((TextBox)row.FindControl("txtLastDate")).Text.Trim();
            string companyName = ((TextBox)row.FindControl("txtCompanyName")).Text;
            string country = ((TextBox)row.FindControl("txtCountry")).Text;
            string state = ((TextBox)row.FindControl("txtState")).Text;

            DateTime lastDate;

            // Try to parse the entered date
            if (!DateTime.TryParse(lastDateInput, out lastDate))
            {
                // If parsing fails, get the original date from the database
                using (MySqlConnection con = new MySqlConnection(conStr))
                {
                    con.Open();
                    MySqlCommand cmdGetDate = new MySqlCommand("SELECT LastDateToApply FROM Jobs WHERE JobId = @JobId", con);
                    cmdGetDate.Parameters.AddWithValue("@JobId", jobId);

                    object result = cmdGetDate.ExecuteScalar();
                    if (result != null && result != DBNull.Value)
                    {
                        lastDate = Convert.ToDateTime(result);
                    }
                    else
                    {
                        // Fallback if date is somehow null - set to today's date (or handle as needed)
                        lastDate = DateTime.Today;
                    }

                    con.Close();
                }
            }

            using (MySqlConnection con = new MySqlConnection(conStr))
            {
                con.Open();
                string query = @"UPDATE Jobs SET Title=@Title, NoOfPost=@NoOfPost, Qualification=@Qualification,
                         Experience=@Experience, LastDateToApply=@LastDate, CompanyName=@CompanyName,
                         Country=@Country, State=@State WHERE JobId=@JobId";

                MySqlCommand cmd = new MySqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Title", title);
                cmd.Parameters.AddWithValue("@NoOfPost", noOfPost);
                cmd.Parameters.AddWithValue("@Qualification", qualification);
                cmd.Parameters.AddWithValue("@Experience", experience);
                cmd.Parameters.AddWithValue("@LastDate", lastDate);
                cmd.Parameters.AddWithValue("@CompanyName", companyName);
                cmd.Parameters.AddWithValue("@Country", country);
                cmd.Parameters.AddWithValue("@State", state);
                cmd.Parameters.AddWithValue("@JobId", jobId);

                cmd.ExecuteNonQuery();
                con.Close();
            }

            GridView1.EditIndex = -1;
            BindGrid();
            lblMsg.Text = "Job updated successfully!";
        }


        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int jobId = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value);

            using (MySqlConnection con = new MySqlConnection(conStr))
            {
                con.Open();
                MySqlCommand cmd = new MySqlCommand("DELETE FROM Jobs WHERE JobId = @JobId", con);
                cmd.Parameters.AddWithValue("@JobId", jobId);
                cmd.ExecuteNonQuery();
                con.Close();
            }

            BindGrid();
            lblMsg.Text = "Job deleted successfully!";
        }
    }
}
