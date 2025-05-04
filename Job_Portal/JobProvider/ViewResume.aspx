<%@ Page Title="" Language="C#" MasterPageFile="~/JobProvider/JobProvider.Master" AutoEventWireup="true" CodeBehind="ViewResume.aspx.cs" Inherits="Job_Portal.JobProvider.ViewResume" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div style="background-image: url('../Images/bg.jpg'); width: 100%; height: auto; background-repeat: no-repeat; background-size: cover; background-attachment: fixed;">
        <div class="container py-4">

            <asp:Label ID="lblMsg" runat="server" CssClass="text-danger font-weight-bold"></asp:Label>

            <h3 class="text-center mb-4 text-white">View Resume/Download</h3>
            <div class="row mb-3 pt-sm-3">
                <div class="col-md-12">
                    <asp:GridView ID="GridView1" runat="server" CssClass="table table-hover table-bordered"
                        EmptyDataText="No record to display." AutoGenerateColumns="false" AllowPaging="true" PageSize="5"
                        DataKeyNames="ApplicationId"
                        OnPageIndexChanging="GridView1_PageIndexChanging"
                        OnRowDeleting="GridView1_RowDeleting"
                        OnRowDataBound="GridView1_RowDataBound">

                        <Columns>
                            <asp:BoundField DataField="Sr.No" HeaderText="Sr.No" ReadOnly="true">
                                <ItemStyle Width="5%" />
                            </asp:BoundField>

                            <asp:TemplateField HeaderText="Company Name">
                                <ItemTemplate><%# Eval("CompanyName") %></ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtCompanyName" runat="server" Text='<%# Bind("CompanyName") %>' CssClass="form-control" />
                                </EditItemTemplate>
                                <ItemStyle Width="12%" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Job Title">
                                <ItemTemplate><%# Eval("Title") %></ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtTitle" runat="server" Text='<%# Bind("Title") %>' CssClass="form-control" />
                                </EditItemTemplate>
                                <ItemStyle Width="12%" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="User Name">
                                <ItemTemplate><%# Eval("Name") %></ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtName" runat="server" Text='<%# Bind("Name") %>' CssClass="form-control" />
                                </EditItemTemplate>
                                <ItemStyle Width="8%" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="User Email">
                                <ItemTemplate><%# Eval("Email") %></ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtEmail" runat="server" Text='<%# Bind("Email") %>' CssClass="form-control" />
                                </EditItemTemplate>
                                <ItemStyle Width="10%" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Mobile No.">
                                <ItemTemplate><%# Eval("Mobile") %></ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtMobile" runat="server" Text='<%# Bind("Mobile") %>' CssClass="form-control" />
                                </EditItemTemplate>
                                <ItemStyle Width="10%" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Applied Date">
                                <ItemTemplate><%# Eval("ApplyDate", "{0:dd-MMMM-yyyy}") %></ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtApplyDate" runat="server" Text='<%# Bind("ApplyDate", "{0:dd-MMMM-yyyy}") %>' CssClass="form-control" TextMode="Date" />
                                </EditItemTemplate>
                                <ItemStyle Width="10%" />
                            </asp:TemplateField>


                            <asp:TemplateField HeaderText="Resume">
                                <ItemTemplate>
                                    <%-- The View link or "No Resume" will be injected from RowDataBound in code-behind --%>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>





                            <asp:CommandField HeaderText="Action" ShowEditButton="true" ShowDeleteButton="true" />
                        </Columns>

                        <HeaderStyle BackColor="#7200cf" ForeColor="White" />
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

