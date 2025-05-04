<%@ Page Title="" Language="C#" MasterPageFile="~/JobSeeker/JobSeeker.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="Job_Portal.JobSeeker.Profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        /* You can keep your custom styling here */
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
    <div class="container pt-5 pb-5">
        <div class="main-body">
            <div class="row gutters-sm">
                <div class="col-md-4 mb-3">
                    <div class="card profile-card">
                        <div class="card-body">
                            <div class="d-flex flex-column align-items-center text-center">
                                <!-- Avatar from ui-avatars -->
                                <asp:Image ID="imgAvatar" runat="server" CssClass="rounded-circle mb-3" Width="140" />
                                <div class="mt-3">
                                    <p class="text-secondary mb-1">
                                        <asp:Label ID="lblName" runat="server"></asp:Label>
                                    </p>
                                    <p class="text-muted font-size-sm text-capitalize">
                                        <i class="fas fa-map-marker-alt mr-2"></i><strong>Location:</strong>
                                        <asp:Label ID="lblCountry" runat="server"></asp:Label>
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-8">
                    <div class="card mb-3 profile-card">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-sm-4">
                                    <h6 class="mb-0">UserName</h6>
                                </div>
                                <div class="col-sm-8 text-secondary text-capitalize">
                                    <asp:Label ID="lblUsername" runat="server"></asp:Label>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-4">
                                    <h6 class="mb-0">Email</h6>
                                </div>
                                <div class="col-sm-8 text-secondary">
                                    <asp:Label ID="lblEmail" runat="server"></asp:Label>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-4">
                                    <h6 class="mb-0">Mobile</h6>
                                </div>
                                <div class="col-sm-8 text-secondary">
                                    <asp:Label ID="lblMobile" runat="server"></asp:Label>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-4">
                                    <h6 class="mb-0">Address</h6>
                                </div>
                                <div class="col-sm-8 text-secondary text-capitalize">
                                    <asp:Label ID="lblAddress" runat="server"></asp:Label>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-4">
                                    <h6 class="mb-0">Resume</h6>
                                </div>
                                <div class="col-sm-8 text-secondary">
                                    <asp:Label ID="lblResume" runat="server" CssClass="font-weight-bold"></asp:Label>
                                </div>
                            </div>
                                <div class="col-sm-6">
                                    <asp:FileUpload ID="FileUploadResume" runat="server" CssClass="form-control mb-2" />
                                    <asp:Button ID="btnUploadResume" runat="server" Text="Upload Resume" CssClass="btn btn-primary w-100" OnClick="btnUploadResume_Click" />
                                </div>
                            </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
