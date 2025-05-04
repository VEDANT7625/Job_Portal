<%@ Page Title="" Language="C#" MasterPageFile="~/JobSeeker/JobSeeker.Master" AutoEventWireup="true" CodeBehind="ResumeBuild.aspx.cs" Inherits="Job_Portal.JobSeeker.ResumeBuild" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script>
    // Detect back button press
    window.history.pushState(null, "", window.location.href);
    window.onpopstate = function () {
        window.location.href = '/Index.aspx'; // Change to your homepage route
    };
    </script>
    <div class="container py-5">
        <h2 class="text-center mb-4">Build Your Resume</h2>
        <asp:Label ID="lblMsg" runat="server" CssClass="alert alert-success d-none" EnableViewState="false" />

        <div class="row">
            <div class="col-md-6 mb-3">
                <label>Full Name</label>
                <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" />
            </div>

            <div class="col-md-6 mb-3">
                <label>Email</label>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" />
            </div>

            <div class="col-md-6 mb-3">
                <label>Mobile</label>
                <asp:TextBox ID="txtMobile" runat="server" CssClass="form-control" />
            </div>

            <!-- Country Dropdown with label on the left -->
            <div class="col-md-6 mb-3  d-flex align-items-center">
                <label class="mb-0">Select Country</label>
                <asp:DropDownList ID="ddlCountry" runat="server" CssClass="form-control w-auto" DataTextField="CountryName" DataValueField="CountryName" AppendDataBoundItems="true">
                    <asp:ListItem Text="-- Select Country --" Value="" />
                </asp:DropDownList>
            </div>


            <div class="col-12 mb-3">
                <label>Address</label>
                <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" />
            </div>

            <!-- Education -->
            <div class="col-md-4 mb-3">
                <label>10th Grade</label>
                <asp:TextBox ID="txtTenth" runat="server" CssClass="form-control" />
            </div>
            <div class="col-md-4 mb-3">
                <label>12th Grade</label>
                <asp:TextBox ID="txtTwelfth" runat="server" CssClass="form-control" />
            </div>
            <div class="col-md-4 mb-3">
                <label>Graduation</label>
                <asp:TextBox ID="txtGraduation" runat="server" CssClass="form-control" />
            </div>
            <div class="col-md-6 mb-3">
                <label>Post Graduation</label>
                <asp:TextBox ID="txtPostGrad" runat="server" CssClass="form-control" />
            </div>
            <div class="col-md-6 mb-3">
                <label>PhD</label>
                <asp:TextBox ID="txtPhd" runat="server" CssClass="form-control" />
            </div>

            <!-- Work -->
            <div class="col-md-6 mb-3">
                <label>Works On</label>
                <asp:TextBox ID="txtWorksOn" runat="server" CssClass="form-control" />
            </div>
            <div class="col-md-6 mb-3">
                <label>Experience</label>
                <asp:TextBox ID="txtExperience" runat="server" CssClass="form-control" />
            </div>

            <div class="col-12 text-center mt-4">
                <asp:Button ID="btnSave" runat="server" Text="Update" CssClass="btn btn-primary px-5" OnClick="btnSave_Click" />
            </div>
        </div>
    </div>
</asp:Content>
