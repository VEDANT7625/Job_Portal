<%@ Page Title="" Language="C#" MasterPageFile="~/JobSeeker/JobSeeker.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="Job_Portal.JobSeeker.Contact" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="contact-section">
        <script>
            // Detect back button press
            window.history.pushState(null, "", window.location.href);
            window.onpopstate = function () {
                window.location.href = '/Index.aspx'; // Change to your homepage route
            };
        </script>

        <div class="container">
            <iframe
                src="https://www.google.com/maps/embed?pb=!1m14!1m12!1m3!1d20942778.616787035!2d0!3d0!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!5e0!3m2!1sen!2sin!4v1712834514815!5m2!1sen!2sin"
                width="100%"
                height="480"
                style="border: 0;"
                allowfullscreen=""
                loading="lazy"
                referrerpolicy="no-referrer-when-downgrade"></iframe>


            <div class="row">
                <div class="col-12 pb-3">
                    <asp:Label ID="lblMsg" runat="server" Visible="false" CssClass="text-success font-weight-bold"></asp:Label>
                </div>

                <div class="col-12">
                    <h2 class="contact-title">Get in Touch</h2>
                </div>

                <div class="col-lg-8">
                    <div class="form-contact contact_form" id="contactForm">
                        <div class="row">
                            <div class="col-12">
                                <div class="form-group">
                                    <asp:TextBox ID="txtMessage" runat="server" CssClass="form-control w-100" TextMode="MultiLine" Rows="5" MaxLength="1000" placeholder="Enter Message"></asp:TextBox>

                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <asp:TextBox ID="txtName" runat="server" CssClass="form-control valid" placeholder="Enter your name"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control valid" TextMode="Email" placeholder="Enter email address"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-12">
                                <div class="form-group">
                                    <asp:TextBox ID="txtSubject" runat="server" CssClass="form-control" placeholder="Enter Subject"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="form-group mt-3">
                            <asp:Button ID="btnsend" runat="server" Text="Send" CssClass="button button-contactForm boxed-btn" OnClick="btnsend_Click" />
                        </div>
                    </div>
                </div>

                <div class="col-lg-3 offset-lg-1">
                    <!-- Static contact info -->
                </div>
            </div>
        </div>
    </section>
</asp:Content>
