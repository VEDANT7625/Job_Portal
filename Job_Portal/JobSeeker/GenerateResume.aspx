<%@ Page Language="C#" AutoEventWireup="true" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Configuration" %>
<%@ Import Namespace="MySql.Data.MySqlClient" %>
<%@ Import Namespace="iTextSharp.text" %>
<%@ Import Namespace="iTextSharp.text.pdf" %>
<%@ Import Namespace="iTextSharp.text.pdf.draw" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Generate Resume</title>
</head>
<body>
    <form id="form1" runat="server"></form>

    <script runat="server">
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string userId = Session["UserID"]?.ToString(); // Get from session
                if (!string.IsNullOrEmpty(userId))
                {
                    GenerateResumePDF(userId);
                }
                else
                {
                    Response.Write("User is not logged in or session expired.");
                }
            }
        }

        private void GenerateResumePDF(string userId)
        {
            using (MySqlConnection con = new MySqlConnection(ConfigurationManager.ConnectionStrings["cs"].ConnectionString))
            {
                con.Open();
                MySqlCommand cmd = new MySqlCommand("SELECT * FROM user WHERE UserID=@UserID", con);
                cmd.Parameters.AddWithValue("@UserID", userId);

                using (MySqlDataReader dr = cmd.ExecuteReader())
                {
                    if (dr.Read())
                    {
                        Document doc = new Document(PageSize.A4, 40f, 40f, 50f, 40f);
                        MemoryStream ms = new MemoryStream();
                        PdfWriter.GetInstance(doc, ms);
                        doc.Open();

                        BaseColor purple = new BaseColor(111, 66, 193);
                        Font titleFont = FontFactory.GetFont(FontFactory.HELVETICA_BOLD, 20, purple);
                        Font sectionTitle = FontFactory.GetFont(FontFactory.HELVETICA_BOLD, 14, purple);
                        Font textFont = FontFactory.GetFont(FontFactory.HELVETICA, 12, BaseColor.BLACK);
                        Font labelFont = FontFactory.GetFont(FontFactory.HELVETICA_BOLD, 12, BaseColor.DARK_GRAY);

                        // Title
                        Paragraph title = new Paragraph("RESUME", titleFont);
                        title.Alignment = Element.ALIGN_CENTER;
                        doc.Add(title);
                        doc.Add(new Paragraph("\n"));

                        // Personal Info
                        doc.Add(new Paragraph("PERSONAL DETAILS", sectionTitle));
                        doc.Add(CreateLineSeparator());
                        doc.Add(new Paragraph(" "));

                        PdfPTable personalTable = new PdfPTable(2);
                        personalTable.WidthPercentage = 100;
                        personalTable.SetWidths(new float[] { 1f, 2f });

                        personalTable.AddCell(GetCell("Name:", labelFont));
                        personalTable.AddCell(GetCell(dr["Name"].ToString(), textFont));
                        personalTable.AddCell(GetCell("Email:", labelFont));
                        personalTable.AddCell(GetCell(dr["Email"].ToString(), textFont));
                        personalTable.AddCell(GetCell("Mobile:", labelFont));
                        personalTable.AddCell(GetCell(dr["Mobile"].ToString(), textFont));
                        personalTable.AddCell(GetCell("Country:", labelFont));
                        personalTable.AddCell(GetCell(dr["Country"].ToString(), textFont));
                        personalTable.AddCell(GetCell("Address:", labelFont));
                        personalTable.AddCell(GetCell(dr["Address"].ToString(), textFont));

                        doc.Add(personalTable);
                        doc.Add(new Paragraph("\n"));

                        // Education
                        doc.Add(new Paragraph("EDUCATIONAL QUALIFICATIONS", sectionTitle));
                        doc.Add(CreateLineSeparator());
                        doc.Add(new Paragraph(" "));

                        doc.Add(new Paragraph("10th Grade: " + dr["TenthGrade"].ToString(), textFont));
                        doc.Add(new Paragraph("12th Grade: " + dr["TwelfthGrade"].ToString(), textFont));
                        doc.Add(new Paragraph("Graduation: " + dr["GraduationGrade"].ToString(), textFont));
                        doc.Add(new Paragraph("Post Graduation: " + dr["PostGraduationGrade"].ToString(), textFont));
                        doc.Add(new Paragraph("PhD: " + dr["Phd"].ToString(), textFont));
                        doc.Add(new Paragraph("\n"));

                        // Experience
                        doc.Add(new Paragraph("WORK EXPERIENCE", sectionTitle));
                        doc.Add(CreateLineSeparator());
                        doc.Add(new Paragraph(" "));

                        doc.Add(new Paragraph("Works On: " + dr["WorksOn"].ToString(), textFont));
                        doc.Add(new Paragraph("Experience: " + dr["Experience"].ToString(), textFont));

                        doc.Close();

                        // Return PDF to browser
                        byte[] bytes = ms.ToArray();
                        Response.Clear();
                        Response.ContentType = "application/pdf";
                        Response.AddHeader("Content-Disposition", "attachment; filename=Resume_" + userId + ".pdf");
                        Response.BinaryWrite(bytes);
                        Response.Flush();
                        Response.End();
                    }
                    else
                    {
                        Response.Write("No user data found.");
                    }
                }
            }
        }

        private PdfPCell GetCell(string text, Font font)
        {
            PdfPCell cell = new PdfPCell(new Phrase(text, font));
            cell.Border = Rectangle.NO_BORDER;
            return cell;
        }

        private Paragraph CreateLineSeparator()
        {
            return new Paragraph(new Chunk(new LineSeparator(0.0f, 100.0f, new BaseColor(111, 66, 193), Element.ALIGN_CENTER, 1)));
        }
    </script>
</body>
</html>