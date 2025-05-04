<%@ Page Title="New Job" Language="C#" MasterPageFile="~/JobProvider/JobProvider.Master" AutoEventWireup="true" CodeBehind="NewJob.aspx.cs" Inherits="OnlineJobPortal.JobProvider.NewJob" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="background-image: url('../Images/bg.jpg'); width: 100%; height: auto; background-repeat: no-repeat; background-size: cover; background-attachment: fixed;">
        <div class="container py-4">

            <asp:Label ID="lblMsg" runat="server" CssClass="text-danger font-weight-bold"></asp:Label>

            <h3 class="text-center mb-4 text-white">Add New Job</h3>

            <div class="row">
                <div class="col-md-6 pt-3">
                    <label class="text-white font-weight-bold">Job Title</label>
                    <asp:TextBox ID="txtJobTitle" runat="server" CssClass="form-control" />
                </div>
                <div class="col-md-6 pt-3">
                    <label class="text-white font-weight-bold">Number of Posts</label>
                    <asp:TextBox ID="txtNoOfPost" runat="server" CssClass="form-control" TextMode="Number" />
                </div>
            </div>

            <div class="row">
                <div class="col-md-6 pt-3">
                    <label class="text-white font-weight-bold">Description</label>
                    <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4" />
                </div>
                <div class="col-md-6 pt-3">
                    <label class="text-white font-weight-bold">Qualification</label>
                    <asp:TextBox ID="txtQualification" runat="server" CssClass="form-control" />
                </div>
            </div>

            <div class="row">
                <div class="col-md-6 pt-3">
                    <label class="text-white font-weight-bold">Experience</label>
                    <asp:TextBox ID="txtExperience" runat="server" CssClass="form-control" />
                </div>
                <div class="col-md-6 pt-3">
                    <label class="text-white font-weight-bold">Specialization</label>
                    <asp:TextBox ID="txtSpecialization" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="2" />
                </div>
            </div>

            <div class="row">
                <div class="col-md-6 pt-3">
                    <label class="text-white font-weight-bold">Last Date to Apply</label>
                    <asp:TextBox ID="txtLastDate" runat="server" CssClass="form-control" TextMode="Date" />
                </div>
                <div class="col-md-6 pt-3">
                    <label class="text-white font-weight-bold">Salary</label>
                    <asp:TextBox ID="txtSalary" runat="server" CssClass="form-control" />
                </div>
            </div>

            <div class="row">
                <div class="col-md-6 pt-3">
                    <label class="text-white font-weight-bold">Job Type</label>
                    <asp:TextBox ID="txtJobType" runat="server" CssClass="form-control" />
                </div>
                <div class="col-md-6 pt-3">
                    <label class="text-white font-weight-bold">Company Name</label>
                    <asp:TextBox ID="txtCompanyName" runat="server" CssClass="form-control" />
                </div>
            </div>

            <div class="row">
                <div class="col-md-6 pt-3">
                    <label class="text-white font-weight-bold">Company Logo</label>
                    <asp:FileUpload ID="fuCompanyLogo" runat="server" CssClass="form-control" />
                </div>
                <div class="col-md-6 pt-3">
                    <label class="text-white font-weight-bold">Website</label>
                    <asp:TextBox ID="txtWebsite" runat="server" CssClass="form-control" TextMode="Url" />
                </div>
            </div>

            <div class="row">
                <div class="col-md-6 pt-3">
                    <label class="text-white font-weight-bold">Email</label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" />
                </div>
                <div class="col-md-6 pt-3">
                    <label class="text-white font-weight-bold">Address</label>
                    <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="2" />
                </div>
            </div>

            <div class="row">
                <div class="col-md-6 pt-3">
                    <label class="text-white font-weight-bold">Country</label>
                    <asp:TextBox ID="txtCountry" runat="server" CssClass="form-control" />
                </div>
                <div class="col-md-6 pt-3">
                    <label class="text-white font-weight-bold">State</label>
                    <asp:TextBox ID="txtState" runat="server" CssClass="form-control" />
                </div>
            </div>

            <div class="row mt-4">
                <div class="col-md-3 pt-3">
                    <asp:Button ID="btnAdd" runat="server" Text="Add Job" CssClass="btn btn-primary btn-block" OnClick="btnAdd_Click" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>


