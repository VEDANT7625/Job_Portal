<%@ Page Title="" Language="C#" MasterPageFile="~/JobSeeker/JobSeeker.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Job_Portal.JobSeeker.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="section-padding">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">



                    <!-- Alert Message -->
                    <div class="pb-3">
                        <asp:Label ID="lblMsg" runat="server" Visible="false" CssClass="alert" />
                    </div>

                    <h2 class="form-title text-center">Sign In</h2>

                    <div class="form-contact contact_form">
                        <div class="row">

                            <!-- Username -->
                            <div class="col-12">
                                <div class="form-group">
                                    <label class="form-label">Username</label>
                                    <asp:TextBox ID="txtUserName" runat="server" CssClass="form-control" placeholder="Enter Username" required></asp:TextBox>
                                </div>
                            </div>

                            <!-- Password -->
                            <div class="col-12">
                                <div class="form-group">
                                    <label class="form-label">Password</label>
                                    <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Enter Password" required></asp:TextBox>
                                </div>
                            </div>

                            <!-- User Type (Role) -->
                            <div class="col-12">
                                <div class="form-group">
                                    <div class="row align-items-center">
                                        <!-- Label -->
                                        <div class="col-md-2 col-sm-5">
                                            <label class="form-label mb-0">User Type</label>
                                        </div>
                                        <!-- Dropdown -->
                                        <div class="col-md-4 col-sm-7">
                                            <asp:DropDownList ID="ddlLoginType" runat="server" CssClass="form-control w-100">
                                                <asp:ListItem Value="0">Select User Type</asp:ListItem>
                                                <asp:ListItem>Job Seeker</asp:ListItem>
                                                <asp:ListItem>Job Provider</asp:ListItem>
                                            </asp:DropDownList>

                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                                ErrorMessage="User Type is required."
                                                ControlToValidate="ddlLoginType"
                                                InitialValue="0"
                                                CssClass="text-danger small"
                                                Display="Dynamic" />
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Submit Button -->
                            <div class="col-12 text-center mt-4">
                                <asp:Button ID="btnLogin" runat="server" Text="Login"
                                    CssClass="btn btn-primary px-5 py-4"
                                    OnClick="btnLogin_Click" />
                                <span class="clickLink d-block mt-3">
                                    <asp:Literal ID="litRegisterLink" runat="server" />
                                </span>

                            </div>

                        </div>
                    </div>

                </div>
            </div>
        </div>
    </section>
</asp:Content>
