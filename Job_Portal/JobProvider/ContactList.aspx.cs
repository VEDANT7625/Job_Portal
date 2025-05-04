using System;
using System.Configuration;
using System.Data;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;

namespace Job_Portal.JobProvider
{
    public partial class ContactList : System.Web.UI.Page
    {
        string conStr = ConfigurationManager.ConnectionStrings["cs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                BindContactList();
        }

        private void BindContactList()
        {
            using (MySqlConnection con = new MySqlConnection(conStr))
            {
                MySqlCommand cmd = new MySqlCommand("SELECT * FROM Contact ORDER BY ContactId DESC", con);
                MySqlDataAdapter sda = new MySqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);

                dt.Columns.Add("Sr.No", typeof(int));
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    dt.Rows[i]["Sr.No"] = i + 1;
                }

                GridView1.DataSource = dt;
                GridView1.DataBind();
            }
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            BindContactList();
        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int contactId = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value);

            using (MySqlConnection con = new MySqlConnection(conStr))
            {
                con.Open();
                MySqlCommand cmd = new MySqlCommand("DELETE FROM Contact WHERE ContactId = @ContactId", con);
                cmd.Parameters.AddWithValue("@ContactId", contactId);
                cmd.ExecuteNonQuery();
                con.Close();
            }

            BindContactList();
            lblMsg.Text = "Contact deleted successfully!";
        }
    }
}
