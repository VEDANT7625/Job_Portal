<%@ Page Title="" Language="C#" MasterPageFile="~/JobSeeker/JobSeeker.Master" AutoEventWireup="true" CodeBehind="Job_Details.aspx.cs" Inherits="Job_Portal.JobSeeker.Job_Details1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script>
        // Detect back button press
        window.history.pushState(null, "", window.location.href);
        window.onpopstate = function () {
            window.location.href = '/Job_Listing.aspx'; // Change to your homepage route
        };
    </script>

    <!-- Hero Area -->
    <div class="slider-area">
        <div class="single-slider section-overly slider-height2 d-flex align-items-center" data-background="../assets/img/hero/about.jpg">
            <div class="container">
                <div class="row">
                    <div class="col-xl-12">
                        <div class="hero-cap text-center">
                            <h2>
                                <asp:Label ID="lblJobTitle" runat="server" Text="Job Title"></asp:Label></h2>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Job Details -->
    <div class="job-post-company pt-120 pb-120">
        <div class="container">
            <div class="row justify-content-between">
                <!-- Left Content -->
                <div class="col-xl-7 col-lg-8">
                    <div class="single-job-items mb-50">
                        <div class="job-items">
                            <div class="company-logo text-center">
                                <asp:Image ID="imgCompanyLogo" runat="server" CssClass="img-fluid rounded mb-10" Width="90px" Height="90px" />
                                <h4>
                                    <asp:Label ID="Label1" runat="server" /></h4>
                            </div>

                            <div class="job-tittle">
                                <h4>
                                    <asp:Label ID="lblJobTitle2" runat="server" Text=""></asp:Label></h4>
                                <ul>
                                    <li>
                                        <asp:Label ID="lblCompany" runat="server" Text=""></asp:Label></li>
                                    <li><i class="fas fa-map-marker-alt"></i>
                                        <asp:Label ID="lblLocation" runat="server" Text=""></asp:Label></li>
                                    <li>
                                        <asp:Label ID="lblSalary" runat="server" Text=""></asp:Label></li>
                                </ul>
                            </div>
                        </div>
                    </div>

                    <!-- Job Description -->
                    <div class="job-post-details">
                        <div class="post-details1 mb-50">
                            <div class="small-section-tittle">
                                <h4>Job Description</h4>
                            </div>
                            <p>
                                <asp:Label ID="lblDescription" runat="server" Text=""></asp:Label>
                            </p>
                        </div>

                        <!-- Required Knowledge, Skills -->
                        <div class="post-details2 mb-50">
                            <div class="small-section-tittle">
                                <h4>Required Knowledge, Skills, and Abilities</h4>
                            </div>
                            <ul class="list">
                                <asp:Literal ID="litQualification" runat="server" />
                            </ul>
                        </div>

                        <!-- Education + Experience -->
                        <div class="post-details2 mb-50">
                            <div class="small-section-tittle">
                                <h4>Education + Experience</h4>
                            </div>
                            <ul class="list">
                                <asp:Literal ID="litExperience" runat="server" />
                            </ul>
                        </div>
                    </div>
                </div>

                <!-- Right Content -->
                <div class="col-xl-4 col-lg-4">
                    <div class="post-details3 mb-50">
                        <div class="small-section-tittle">
                            <h4>Job Overview</h4>
                        </div>
                        <ul>
                            <li>Posted date : <span>
                                <asp:Label ID="lblPostedDate" runat="server" /></span></li>
                            <li>Location : <span>
                                <asp:Label ID="lblLocation2" runat="server" /></span></li>
                            <li>Vacancy : <span>
                                <asp:Label ID="lblVacancy" runat="server" /></span></li>
                            <li>Job nature : <span>
                                <asp:Label ID="lblJobType" runat="server" /></span></li>
                            <li>Salary : <span>
                                <asp:Label ID="lblSalary2" runat="server" /></span></li>
                            <li>Last Date To Apply : <span>
                                <asp:Label ID="lblLastDate" runat="server" /></span></li>
                        </ul>
                        <div class="apply-btn2 mt-3">
                            <asp:Button ID="btnApply" runat="server" Text="Apply Now" CssClass="btn btn-primary" OnClick="btnApply_Click" />
                            <br />
                            <asp:Label ID="lblApplyStatus" runat="server" CssClass="text-danger mt-2" />
                        </div>
                    </div>
                    <!-- Company Info -->
                    <div class="post-details4 mb-50">
                        <div class="small-section-tittle">
                            <h4>Company Information</h4>
                        </div>
                        <span>
                            <asp:Label ID="lblCompanyName" runat="server" /></span>
                        <ul>
                            <li>Web : <span>
                                <asp:Label ID="lblWebsite" runat="server" /></span></li>
                            <li>Email: <span>
                                <asp:Label ID="lblEmail" runat="server" /></span></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
