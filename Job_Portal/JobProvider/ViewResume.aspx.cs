using System;
using System.IO;
using System.Data;
using System.Configuration;
using MySql.Data.MySqlClient;
using System.Web.UI.WebControls;
using System.Web.UI;

namespace Job_Portal.JobProvider
{
    public partial class ViewResume : System.Web.UI.Page
    {
        string conStr = ConfigurationManager.ConnectionStrings["cs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGrid();  // Call BindGrid instead of LoadResumeData
            }
        }

        // Refactored BindGrid function
        private void BindGrid()
        {
            using (MySqlConnection con = new MySqlConnection(conStr))
            {
                try
                {
                    con.Open();
                    string query = "SELECT ApplicationId, Name, Email, Mobile, ApplyDate, CompanyName, Title, UserId FROM ViewAppliedCandidates";
                    MySqlCommand cmd = new MySqlCommand(query, con);
                    MySqlDataAdapter da = new MySqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    // Add Sr.No and Resume column
                    dt.Columns.Add("Sr.No", typeof(int));
                    dt.Columns.Add("Resume", typeof(string));

                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        dt.Rows[i]["Sr.No"] = i + 1;
                        int userId = Convert.ToInt32(dt.Rows[i]["UserId"]);
                        dt.Rows[i]["Resume"] = "~/Resumes/resume" + userId + ".pdf";
                    }

                    GridView1.DataSource = dt;
                    GridView1.DataBind();
                }
                catch (Exception ex)
                {
                    Response.Write("An error occurred: " + ex.Message);
                }
            }
        }

        // Handle pagination
        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            BindGrid();  // Rebind Grid after pagination
        }

        // Handle data row binding for resumes
        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                int userId = Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "UserId"));
                string resumePath = $"Resumes/resume{userId}.pdf";

                if (File.Exists(Server.MapPath("~/" + resumePath)))
                {
                    string html = $"<a href='/{resumePath}' target='_blank' class='btn btn-sm btn-primary'>" +
                                  $"<i class='fas fa-eye'></i> View</a>";

                    e.Row.Cells[7].Controls.Add(new LiteralControl(html));
                    e.Row.Cells[7].HorizontalAlign = HorizontalAlign.Center;
                }
                else
                {
                    e.Row.Cells[7].Text = "No Resume";
                }
            }
        }

        // Handle delete action on the GridView
        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            // Get the ApplicationId from the DataKey of the row
            int applicationId = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value);

            // Open the connection to delete the row from AppliedCandidates table
            using (MySqlConnection con = new MySqlConnection(conStr))
            {
                con.Open();

                // Prepare the delete query for AppliedCandidates table
                MySqlCommand cmd = new MySqlCommand("DELETE FROM AppliedCandidates WHERE ApplicationId = @ApplicationId", con);
                cmd.Parameters.AddWithValue("@ApplicationId", applicationId);

                // Execute the delete query
                cmd.ExecuteNonQuery();
                con.Close();
            }

            // Rebind the GridView after deletion
            BindGrid();  // Refresh the grid to show updated data

            // Display a success message
            lblMsg.Text = "Application deleted successfully!";
        }
    }
}
