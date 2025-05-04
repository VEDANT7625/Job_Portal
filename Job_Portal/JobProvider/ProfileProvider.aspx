<%@ Page Title="" Language="C#" MasterPageFile="~/JobProvider/JobProvider.Master" AutoEventWireup="true" CodeBehind="ProfileProvider.aspx.cs" Inherits="Job_Portal.JobProvider.ProfileProvider" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script>
    // Detect back button press
    window.history.pushState(null, "", window.location.href);
    window.onpopstate = function () {
        window.location.href = ~JobProvider/Dashboard.aspx; // Change to your homepage route
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
                            </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
