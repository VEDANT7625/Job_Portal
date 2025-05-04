<%@ Page Title="" Language="C#" MasterPageFile="~/JobSeeker/JobSeeker.Master" AutoEventWireup="true" CodeBehind="Job_Listing.aspx.cs" Inherits="Job_Portal.JobSeeker.Job_Listing" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/ion-rangeslider@2.3.1/css/ion.rangeSlider.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/ion-rangeslider@2.3.1/js/ion.rangeSlider.min.js"></script>
    <style>
        /* Styles for the filter sidebar */
        .filter-sidebar {
            padding: 30px;
            background: #f9f9ff;
            border-radius: 8px;
        }

        .filter-title {
            font-size: 20px;
            margin-bottom: 20px;
            color: #2d2d2d;
            font-weight: 700;
        }

        .filter-group {
            margin-bottom: 30px;
        }

        .filter-group h4 {
            font-size: 16px;
            color: #2d2d2d;
            margin-bottom: 10px;
            font-weight: 600;
        }

        .checkbox-style label {
            display: block;
            margin-bottom: 8px;
            cursor: pointer;
            color: #555;
        }

        .checkbox-style input[type="checkbox"] {
            margin-right: 8px;
        }

        .form-control {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            margin-bottom: 15px;
            font-size: 14px;
            color: #555;
            appearance: none; /* Remove default arrow for dropdowns */
            -webkit-appearance: none;
            -moz-appearance: none;
            background-image: url('data:image/svg+xml;utf8,<svg fill="#ccc" height="24" viewBox="0 0 24 24" width="24" xmlns="http://www.w3.org/2000/svg"><path d="M7 10l5 5 5-5z"/><path d="M0 0h24v24H0z" fill="none"/></svg>');
            background-repeat: no-repeat;
            background-position-x: 95%;
            background-position-y: 50%;
        }

        .form-control:focus {
            outline: none;
            border-color: #007bff; /* Example focus color */
        }

        /* Style for the Posted Within checkboxes to be single selection */
        #<%= chkPosted.ClientID %> label {
            display: block;
            margin-bottom: 8px;
            cursor: pointer;
            color: #555;
        }

        #<%= chkPosted.ClientID %> input[type="checkbox"] {
            margin-right: 8px;
        }

        /* Style for the salary range slider container */
        .salary-range-container {
            margin-top: 20px;
        }

        .irs {
            margin-top: 10px;
        }

        .irs-with-grid {
            margin-bottom: 20px;
        }

        .filter-jobs-title-wrapper {
            margin-bottom: 30px;
        }

        .filter-jobs-title {
            font-size: 24px;
            color: #2d2d2d;
            font-weight: 700;
        }

        /* Style for the job listing results */
        .job-listing-results {
            padding-left: 30px;
        }

        .single-job-items {
            background: #fff;
            padding: 20px;
            margin-bottom: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .job-items {
            display: flex;
            align-items: center;
        }

        .company-img img {
            max-width: 80px;
            height: auto;
            margin-right: 20px;
            border-radius: 4px;
        }

        .job-tittle h4 {
            font-size: 18px;
            color: #2d2d2d;
            margin-bottom: 5px;
        }

        .job-tittle ul {
            list-style: none;
            padding: 0;
            margin: 0;
            color: #777;
            font-size: 14px;
        }

        .job-tittle ul li {
            margin-right: 15px;
            display: inline-flex;
            align-items: center;
        }

        .job-tittle ul li i {
            margin-right: 5px;
        }

        .items-link a {
            background: #e0f7fa;
            color: #00acc1;
            padding: 8px 15px;
            border-radius: 4px;
            font-size: 14px;
            text-decoration: none;
        }

        .items-link span {
            color: #777;
            font-size: 14px;
            margin-left: 10px;
        }

        .pagination-area {
            margin-top: 30px;
        }

        .pagination .page-item .page-link {
            border-radius: 4px;
            padding: 8px 12px;
            margin-right: 5px;
            color: #555;
            border: 1px solid #ddd;
            text-decoration: none;
        }

        .pagination .page-item.active .page-link {
            background-color: #007bff;
            color: white;
            border-color: #007bff;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script>
        // Detect back button press
        window.history.pushState(null, "", window.location.href);
        window.onpopstate = function () {
            window.location.href = '/Index.aspx'; // Change to your homepage route
        };
    </script>
    <asp:Label ID="lblJobCount" runat="server" Text="" Visible="false" />
    <asp:Label ID="lblNoJobs" runat="server" Text="" Visible="false" />
    <asp:DropDownList ID="ddlCountry" runat="server" Visible="false" />
    <asp:CheckBoxList ID="CheckBoxListExperience" runat="server" Visible="false" />

    <div class="slider-area">
        <div class="single-slider section-overly slider-height2 d-flex align-items-center" data-background="../assets/img/hero/about.jpg">
            <div class="container">
                <div class="row">
                    <div class="col-xl-12">
                        <div class="hero-cap text-center">
                            <h2>Find Your Dream Job</h2>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="job-listing-area pt-120 pb-120">
        <div class="container">
            <div class="row">
                <div class="col-xl-3 col-lg-3 col-md-4">
                    <div class="filter-sidebar">
                        <div class="filter-jobs-title-wrapper">
                            <h3 class="filter-jobs-title">Filter Jobs</h3>
                        </div>

                        <div class="filter-group">
                            <h4>Job Type</h4>
                            <asp:CheckBoxList ID="chkJobType" runat="server" CssClass="checkbox-style" AutoPostBack="true" OnSelectedIndexChanged="FilterChanged">
                                <asp:ListItem Text="Full-Time" Value="Full Time" />
                                <asp:ListItem Text="Part-Time" Value="Part Time" />
                                <asp:ListItem Text="Remote" Value="Remote" />
                                <asp:ListItem Text="Freelance" Value="Freelance" />
                            </asp:CheckBoxList>
                        </div>

                        <div class="filter-group">
                            <h4>Job Location</h4>
                            <asp:DropDownList ID="DropDownList1" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="FilterChanged">
                                <asp:ListItem Text="Anywhere" Value="" />
                                </asp:DropDownList>
                        </div>

                        <div class="filter-group">
                            <h4>Experience</h4>
                            <asp:CheckBoxList ID="ddlExperience" runat="server" AutoPostBack="true" OnSelectedIndexChanged="FilterChanged">
                              <asp:ListItem Text="Any" Value="" />
    <asp:ListItem Text="0-2 Years" Value="0-2" />
    <asp:ListItem Text="2-4 Years" Value="2-4" />
    <asp:ListItem Text="4-6 Years" Value="4-6" />
    <asp:ListItem Text="6+ Years" Value="6-100" />
</asp:CheckBoxList>

                        </div>

                        <div class="filter-group">
                            <h4>Posted Within</h4>
                            <asp:CheckBoxList ID="chkPosted" runat="server" AutoPostBack="true" OnSelectedIndexChanged="FilterChanged">
                                 <asp:ListItem Value="1">Last 24 hours</asp:ListItem>
                                 <asp:ListItem Value="3">Last 3 days</asp:ListItem>
                                 <asp:ListItem Value="7">Last 7 days</asp:ListItem>
                                 <asp:ListItem Value="30">Last 30 days</asp:ListItem>
                            </asp:CheckBoxList>

                        </div>

                    </div>
                </div>

                <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
<div class="col-xl-9 col-lg-9 col-md-8 job-listing-results">
    <asp:DataList ID="DataList1" runat="server" RepeatDirection="Vertical">
        <ItemTemplate>
            <div class="single-job-items mb-30">
                <div class="job-items">
                    <div class="company-img">
                        <a href="#">
                           <asp:Image ID="imgCompany" runat="server"
                                ImageUrl='<%# GetCompanyImage(Eval("CompanyImage")) %>'
                                 AlternateText="Company Logo" Width="100" Height="100" />

                        </a>
                    </div>
                    <div class="job-tittle job-tittle2">
                        <a href='Job_Details.aspx?JobId=<%# Eval("JobId") %>'>
                            <h4><%# Eval("Title") %></h4>
                        </a>
                        <ul>
                            <li><%# Eval("CompanyName") %></li>
                            <li><i class="fas fa-map-marker-alt"></i><%# Eval("State") %>, <%# Eval("Country") %></li>
                            <li><%# Eval("Salary") %></li>
                        </ul>
                    </div>
                </div>
                <div class="items-link items-link2 f-right">
                    <a href='Job_Details.aspx?JobId=<%# Eval("JobId") %>'><%# Eval("JobType") %></a>
                    <span><%# Eval("CreateDate", "{0:dd MMM yyyy}") %></span>
                </div>
            </div>
        </ItemTemplate>
    </asp:DataList>

    <div class="pagination-area pb-115 text-center">
        <asp:Panel ID="PaginationPanel" runat="server" CssClass="container">
            <div class="row">
                <div class="col-xl-12">
                    <div class="single-wrap d-flex justify-content-center">
                        <asp:LinkButton ID="lnkPrev" runat="server" CssClass="page-link" OnClick="lnkPrev_Click">Previous</asp:LinkButton>
                        <asp:Label ID="lblPageInfo" runat="server" CssClass="mx-2 align-self-center"></asp:Label>
                        <asp:LinkButton ID="lnkNext" runat="server" CssClass="page-link" OnClick="lnkNext_Click">Next</asp:LinkButton>
                    </div>
                </div>
            </div>
        </asp:Panel>
    </div>
</div>


            </div>
        </div>
    </div>

    <script type="text/javascript">
        function enforceSingleCheckBoxSelection(chkBoxListId) {
            var checkboxes = document.querySelectorAll('#' + chkBoxListId + ' input[type="checkbox"]');
            checkboxes.forEach(function (checkbox) {
                checkbox.addEventListener('change', function () {
                    if (this.checked) {
                        checkboxes.forEach(function (cb) {
                            if (cb !== checkbox) cb.checked = false;
                        });
                        __doPostBack(checkbox.name, '');
                    }
                });
            });
        }

        

        window.onload = function () {
            enforceSingleCheckBoxSelection('<%= chkPosted.ClientID %>');
        };
    </script>
</asp:Content>