<%@ Page Title="" Language="C#" MasterPageFile="~/JobSeeker/JobSeeker.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="Job_Portal.JobSeeker.Register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .form-label {
            font-weight: 600;
            font-size: 1rem;
            margin-bottom: 0.3rem;
        }

        .form-title {
            font-size: 1.75rem;
            font-weight: 700;
            margin-bottom: 1.5rem;
        }

        .section-padding {
            padding: 60px 0;
        }

        .form-group {
            margin-bottom: 1.2rem;
        }

        .clickLink a {
            font-size: 0.95rem;
            margin-left: 15px;
        }

        .alert {
            font-size: 1rem;
            padding: 1rem 1.5rem;
            border-radius: 6px;
            width: 100%;
            text-align: center;
        }
    </style>
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

                    <h2 class="form-title text-center">Sign Up</h2>

                    <div class="form-contact contact_form">
                        <div class="row">
                            <div class="col-12">
                                <h5 class="mb-3">Login Information</h5>
                            </div>

                            <div class="col-12">
                                <div class="form-group">
                                    <label class="form-label">Username</label>
                                    <asp:TextBox ID="txtUserName" runat="server" CssClass="form-control" placeholder="Enter Unique Username" required></asp:TextBox>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="form-label">Password</label>
                                    <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" placeholder="Enter Password" TextMode="Password" required></asp:TextBox>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="form-label">Confirm Password</label>
                                    <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control" placeholder="Confirm Password" TextMode="Password" required></asp:TextBox>
                                    <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="Passwords must match."
                                        ControlToCompare="txtPassword" ControlToValidate="txtConfirmPassword"
                                        CssClass="text-danger small" Display="Dynamic" SetFocusOnError="true" />
                                </div>
                            </div>

                            <div class="col-12 mt-4">
                                <h5 class="mb-3">Personal Information</h5>
                            </div>

                            <div class="col-12">
                                <div class="form-group">
                                    <label class="form-label">Full Name</label>
                                    <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" placeholder="Enter Full Name" required></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Name must be alphabetic."
                                        ControlToValidate="txtFullName" CssClass="text-danger small"
                                        ValidationExpression="^[a-zA-Z\s]+$" Display="Dynamic" SetFocusOnError="true" />
                                </div>
                            </div>

                            <div class="col-12">
                                <div class="form-group">
                                    <label class="form-label">Address</label>
                                    <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" placeholder="Enter Address" required></asp:TextBox>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="form-label">Mobile Number</label>
                                    <asp:TextBox ID="txtMobile" runat="server" CssClass="form-control" placeholder="Enter Mobile Number" required></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="Mobile must be 10 digits."
                                        ControlToValidate="txtMobile" CssClass="text-danger small"
                                        ValidationExpression="^[0-9]{10}$" Display="Dynamic" SetFocusOnError="true" />
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="form-label">Email</label>
                                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Enter Email Address" TextMode="Email" required></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail"
                                        ErrorMessage="Invalid email format." CssClass="text-danger small"
                                        ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$" Display="Dynamic" SetFocusOnError="true" />
                                </div>
                            </div>

                            <!-- User Type -->
                            <div class="col-md-6">
                                <div class="form-group">
                                    <div class="row align-items-center">
                                        <!-- Label on the left -->
                                        <div class="col-md-4 col-sm-5">
                                            <label class="form-label mb-0">User Type</label>
                                        </div>

                                        <!-- Dropdown on the right -->
                                        <div class="col-md-8 col-sm-7">
                                            <asp:DropDownList ID="ddlUserType" runat="server" CssClass="form-control">
                                                <asp:ListItem Text="Select User Type" Value="" />
                                                <asp:ListItem Text="Job Provider" Value="Job Provider" />
                                                <asp:ListItem Text="Job Seeker" Value="Job Seeker" />
                                            </asp:DropDownList>

                                            <!-- Validation Message -->
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidatorRole" runat="server"
                                                ControlToValidate="ddlUserType"
                                                InitialValue=""
                                                ErrorMessage="Please select a user type."
                                                CssClass="text-danger small"
                                                Display="Dynamic"
                                                SetFocusOnError="true" />
                                        </div>
                                    </div>
                                </div>
                            </div>


                            <!-- Country Dropdown -->
                            <div class="form-group row mb-3 align-items-center">
                                <label for="ddlCountry" class="col-sm-3 col-form-label form-label">Country</label>
                                <div class="col-sm-9">
                                    <asp:DropDownList ID="ddlCountry" runat="server"
                                        CssClass="form-control form-control-lg"
                                        DataSourceID="SqlDataSource1"
                                        DataTextField="CountryName"
                                        DataValueField="CountryName"
                                        AutoPostBack="true"
                                        AppendDataBoundItems="true"
                                        OnSelectedIndexChanged="ddlCountry_SelectedIndexChanged2">
                                        <asp:ListItem Text="Select Country" Value="" />
                                    </asp:DropDownList>
                                </div>

                                <asp:SqlDataSource ID="SqlDataSource1" runat="server"
                                    ConnectionString="<%$ ConnectionStrings:cs %>"
                                    ProviderName="MySql.Data.MySqlClient"
                                    SelectCommand="SELECT CountryName FROM Country" />
                            </div>

                            <!-- Submit -->
                            <div class="col-12 text-center mt-4">
                                <asp:Button ID="btnRegister" runat="server" Text="Register" CssClass="btn btn-primary px-7 py-3"
                                    OnClick="btnRegister_Click" />
                                <span class="clickLink d-block mt-3">
                                    <a href="../JobSeeker/Login.aspx">Already Registered? Click Here..</a>
                                </span>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

</asp:Content>
