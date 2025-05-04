using System;
using System.Data;
using System.Configuration;
using MySql.Data.MySqlClient;
using Newtonsoft.Json;
using System.Collections.Generic;

namespace Job_Portal.JobProvider
{
    public partial class Dashboard : System.Web.UI.Page
    {
        string constr = ConfigurationManager.ConnectionStrings["cs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadDashboardCounts();
                LoadChartData();
            }
        }

        private void LoadDashboardCounts()
        {
            using (MySqlConnection con = new MySqlConnection(constr))
            {
                con.Open();

                // Total Users
                MySqlCommand cmdUsers = new MySqlCommand("SELECT COUNT(*) FROM User", con);
                lblUsers.Text = cmdUsers.ExecuteScalar().ToString();

                // Total Jobs
                MySqlCommand cmdJobs = new MySqlCommand("SELECT COUNT(*) FROM Jobs", con);
                int totalJobs = Convert.ToInt32(cmdJobs.ExecuteScalar());
                lblJobs.Text = totalJobs.ToString();
                hfTotalJobs.Value = totalJobs.ToString();

                // Applied Candidates
                MySqlCommand cmdApplied = new MySqlCommand("SELECT COUNT(*) FROM AppliedCandidates", con);
                int appliedJobs = Convert.ToInt32(cmdApplied.ExecuteScalar());
                lblAppliedCandidates.Text = appliedJobs.ToString();
                hfAppliedJobs.Value = appliedJobs.ToString();

                // Contact Messages
                MySqlCommand cmdContact = new MySqlCommand("SELECT COUNT(*) FROM Contact", con);
                lblContact.Text = cmdContact.ExecuteScalar().ToString();

                con.Close();
            }
        }

        private void LoadChartData()
        {
            Dictionary<string, int> jobsPerDate = new Dictionary<string, int>();

            using (MySqlConnection con = new MySqlConnection(constr))
            {
                con.Open();

                MySqlCommand cmd = new MySqlCommand(@"
            SELECT 
                DATE(CreateDate) AS PostDate, 
                COUNT(*) AS JobCount 
            FROM Jobs 
            WHERE CreateDate >= CURDATE() - INTERVAL 14 DAY
            GROUP BY DATE(CreateDate) 
            ORDER BY DATE(CreateDate);
        ", con);

                MySqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    string date = Convert.ToDateTime(dr["PostDate"]).ToString("yyyy-MM-dd");
                    int count = Convert.ToInt32(dr["JobCount"]);
                    jobsPerDate.Add(date, count);
                }

                dr.Close();
                con.Close();
            }

            // Prepare chart data JSON
            var chartData = new
            {
                labels = jobsPerDate.Keys,
                values = jobsPerDate.Values
            };

            hfJobPostsByMonth.Value = JsonConvert.SerializeObject(chartData);
        }

    }
}
