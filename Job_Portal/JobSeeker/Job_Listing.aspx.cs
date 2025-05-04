using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using System.Data;
using System.Configuration;

namespace Job_Portal.JobSeeker
{
    public partial class Job_Listing : System.Web.UI.Page
    {
        private const int PageSize = 5;

        private int CurrentPage
        {
            get => ViewState["CurrentPage"] != null ? (int)ViewState["CurrentPage"] : 0;
            set => ViewState["CurrentPage"] = value;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                PopulateJobLocations();
                PopulateExperienceLevels();
                PopulateJobTypes();
                BindJobList();
            }
        }

        private string GetConnectionString()
        {
            return ConfigurationManager.ConnectionStrings["cs"].ConnectionString;
        }

        private void PopulateJobLocations()
        {
            using (MySqlConnection con = new MySqlConnection(GetConnectionString()))
            {
                try
                {
                    con.Open();
                    string query = "SELECT DISTINCT Country FROM Jobs ORDER BY Country";
                    MySqlCommand cmd = new MySqlCommand(query, con);
                    MySqlDataReader dr = cmd.ExecuteReader();
                    DropDownList1.DataSource = dr;
                    DropDownList1.DataTextField = "Country";
                    DropDownList1.DataValueField = "Country";
                    DropDownList1.DataBind();
                    DropDownList1.Items.Insert(0, new ListItem("Anywhere", ""));
                }
                catch (Exception ex)
                {
                    lblNoJobs.Text = "Error populating countries: " + ex.Message;
                    lblNoJobs.Visible = true;
                }
            }
        }

        private void PopulateExperienceLevels()
        {
            ddlExperience.Items.Clear();
            ddlExperience.Items.Add(new ListItem("Any", ""));
            ddlExperience.Items.Add(new ListItem("0-2 Years", "0-2"));
            ddlExperience.Items.Add(new ListItem("2-4 Years", "2-4"));
            ddlExperience.Items.Add(new ListItem("4-6 Years", "4-6"));
            ddlExperience.Items.Add(new ListItem("6+ Years", "6-100"));
        }

        private void PopulateJobTypes()
        {
            using (MySqlConnection con = new MySqlConnection(GetConnectionString()))
            {
                try
                {
                    con.Open();
                    string query = "SELECT DISTINCT JobType FROM Jobs ORDER BY JobType";
                    MySqlCommand cmd = new MySqlCommand(query, con);
                    MySqlDataReader dr = cmd.ExecuteReader();

                    chkJobType.Items.Clear();
                    while (dr.Read())
                    {
                        string jobType = dr["JobType"].ToString();
                        chkJobType.Items.Add(new ListItem(jobType, jobType));
                    }
                }
                catch (Exception ex)
                {
                    lblNoJobs.Text = "Error loading job types: " + ex.Message;
                    lblNoJobs.Visible = true;
                }
            }
        }

        private void BindJobList()
        {
            using (MySqlConnection con = new MySqlConnection(GetConnectionString()))
            {
                try
                {
                    con.Open();
                    string query = "SELECT * FROM Jobs WHERE 1=1 ";
                    List<MySqlParameter> parameters = new List<MySqlParameter>();

                    // Job Type Filter
                    if (chkJobType.SelectedIndex >= 0)
                    {
                        List<string> selectedTypes = new List<string>();
                        for (int i = 0; i < chkJobType.Items.Count; i++)
                        {
                            if (chkJobType.Items[i].Selected)
                            {
                                string paramName = "@JobType" + i;
                                selectedTypes.Add(paramName);
                                parameters.Add(new MySqlParameter(paramName, chkJobType.Items[i].Value));
                            }
                        }

                        if (selectedTypes.Count > 0)
                        {
                            query += $"AND JobType IN ({string.Join(",", selectedTypes)}) ";
                        }
                    }

                    // Country Filter
                    if (!string.IsNullOrEmpty(DropDownList1.SelectedValue))
                    {
                        query += "AND Country = @Country ";
                        parameters.Add(new MySqlParameter("@Country", DropDownList1.SelectedValue));
                    }

                    // --- Experience Filter (Range-based) ---
                    List<string> selectedExperienceRanges = new List<string>();
                    foreach (ListItem item in ddlExperience.Items)
                    {
                        if (item.Selected && !string.IsNullOrEmpty(item.Value))
                        {
                            selectedExperienceRanges.Add(item.Value);
                        }
                    }

                    if (selectedExperienceRanges.Count > 0)
                    {
                        List<string> expConditions = new List<string>();
                        int index = 0;

                        foreach (string range in selectedExperienceRanges)
                        {
                            var parts = range.Split('-');
                            if (parts.Length == 2 && int.TryParse(parts[0], out int minExp) && int.TryParse(parts[1], out int maxExp))
                            {
                                expConditions.Add($"(Experience BETWEEN @ExpMin{index} AND @ExpMax{index})");
                                parameters.Add(new MySqlParameter($"@ExpMin{index}", minExp));
                                parameters.Add(new MySqlParameter($"@ExpMax{index}", maxExp));
                                index++;
                            }
                        }

                        if (expConditions.Count > 0)
                        {
                            query += "AND (" + string.Join(" OR ", expConditions) + ") ";
                        }
                    }

                    // Posted Date Filter
                    List<int> postedDays = new List<int>();
                    foreach (ListItem item in chkPosted.Items)
                    {
                        if (item.Selected && item.Value != "Any")
                        {
                            postedDays.Add(Convert.ToInt32(item.Value));
                        }
                    }

                    if (postedDays.Count > 0)
                    {
                        int maxDay = postedDays.Max(); // Take the max duration
                        query += $"AND CreateDate >= DATE_SUB(NOW(), INTERVAL {maxDay} DAY) ";
                    }

                    query += " ORDER BY CreateDate DESC";

                    MySqlCommand cmd = new MySqlCommand(query, con);
                    cmd.Parameters.AddRange(parameters.ToArray());

                    MySqlDataAdapter da = new MySqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    PagedDataSource pg = new PagedDataSource
                    {
                        DataSource = dt.DefaultView,
                        AllowPaging = true,
                        PageSize = PageSize,
                        CurrentPageIndex = CurrentPage
                    };

                    lnkPrev.Enabled = !pg.IsFirstPage;
                    lnkNext.Enabled = !pg.IsLastPage;
                    lblPageInfo.Text = $"Page {CurrentPage + 1} of {pg.PageCount}";

                    DataList1.DataSource = pg;
                    DataList1.DataBind();

                    lblNoJobs.Visible = (dt.Rows.Count == 0);
                    lblNoJobs.Text = "No jobs found matching your criteria.";
                }
                catch (Exception ex)
                {
                    lblNoJobs.Text = "Error retrieving jobs: " + ex.Message;
                    lblNoJobs.Visible = true;
                }
            }
        }

        protected string GetCompanyImage(object imagePath)
        {
            string path = imagePath?.ToString();
            return string.IsNullOrEmpty(path)
                ? ResolveUrl("~/images/default-logo.png")
                : ResolveUrl(path);
        }

        // Filters Trigger
        protected void FilterChanged(object sender, EventArgs e)
        {
            CurrentPage = 0;
            BindJobList();
        }

        protected void SalaryRangeChanged(object sender, EventArgs e)
        {
            CurrentPage = 0;
            BindJobList();
        }

        protected void lnkPrev_Click(object sender, EventArgs e)
        {
            CurrentPage--;
            BindJobList();
        }

        protected void lnkNext_Click(object sender, EventArgs e)
        {
            CurrentPage++;
            BindJobList();
        }
    }
}
