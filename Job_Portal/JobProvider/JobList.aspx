<%@ Page Title="" Language="C#" MasterPageFile="~/JobProvider/JobProvider.Master" AutoEventWireup="true" CodeBehind="JobList.aspx.cs" Inherits="Job_Portal.JobProvider.JobList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div style="background-image: url('../Images/bg.jpg'); width: 100%; height: auto; background-repeat: no-repeat; background-size: cover; background-attachment: fixed;">
        <div class="container py-4">

            <asp:Label ID="lblMsg" runat="server" CssClass="text-danger font-weight-bold"></asp:Label>

            <h3 class="text-center mb-4 text-white">Job List/Details</h3>
            <div class="row mb-3 pt-sm-3">
                <div class="col-md-12">
                    <asp:GridView ID="GridView1" runat="server" CssClass="table table-hover table-bordered"
                        EmptyDataText="No record to display." AutoGenerateColumns="false" AllowPaging="true" PageSize="5"
                        DataKeyNames="JobId"
                        OnPageIndexChanging="GridView1_PageIndexChanging"
                        OnRowEditing="GridView1_RowEditing"
                        OnRowCancelingEdit="GridView1_RowCancelingEdit"
                        OnRowUpdating="GridView1_RowUpdating"
                        OnRowDeleting="GridView1_RowDeleting">

                        <Columns>
                            <asp:BoundField DataField="Sr.No" HeaderText="Sr.No" ReadOnly="true">
                                <ItemStyle Width="5%" />
                            </asp:BoundField>

                            <asp:TemplateField HeaderText="Job Title">
                                <ItemTemplate><%# Eval("Title") %></ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtTitle" runat="server" Text='<%# Bind("Title") %>' CssClass="form-control" />
                                </EditItemTemplate>
                                <ItemStyle Width="12%" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="No. of Post">
                                <ItemTemplate><%# Eval("NoOfPost") %></ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtNoOfPost" runat="server" Text='<%# Bind("NoOfPost") %>' CssClass="form-control" />
                                </EditItemTemplate>
                                <ItemStyle Width="8%" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Qualification">
                                <ItemTemplate><%# Eval("Qualification") %></ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtQualification" runat="server" Text='<%# Bind("Qualification") %>' CssClass="form-control" />
                                </EditItemTemplate>
                                <ItemStyle Width="10%" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Experience">
                                <ItemTemplate><%# Eval("Experience") %></ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtExperience" runat="server" Text='<%# Bind("Experience") %>' CssClass="form-control" />
                                </EditItemTemplate>
                                <ItemStyle Width="10%" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Valid Till">
                                <ItemTemplate><%# Eval("LastDateToApply", "{0:dd-MMMM-yyyy}") %></ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtLastDate" runat="server" Text='<%# Bind("LastDateToApply", "{0:dd-MMMM-yyyy}") %>' CssClass="form-control" TextMode="Date" />
                                </EditItemTemplate>
                                <ItemStyle Width="10%" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Company">
                                <ItemTemplate><%# Eval("CompanyName") %></ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtCompanyName" runat="server" Text='<%# Bind("CompanyName") %>' CssClass="form-control" />
                                </EditItemTemplate>
                                <ItemStyle Width="10%" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Country">
                                <ItemTemplate><%# Eval("Country") %></ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtCountry" runat="server" Text='<%# Bind("Country") %>' CssClass="form-control" />
                                </EditItemTemplate>
                                <ItemStyle Width="8%" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="State">
                                <ItemTemplate><%# Eval("State") %></ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtState" runat="server" Text='<%# Bind("State") %>' CssClass="form-control" />
                                </EditItemTemplate>
                                <ItemStyle Width="7%" />
                            </asp:TemplateField>

                            <asp:BoundField DataField="CreateDate" HeaderText="Posted Date" DataFormatString="{0:dd-MMMM-yyyy}" ReadOnly="true">
                                <ItemStyle Width="10%" />
                            </asp:BoundField>

                            <asp:CommandField HeaderText="Action" ShowEditButton="true" ShowDeleteButton="true" />
                        </Columns>

                        <HeaderStyle BackColor="#7200cf" ForeColor="White" />
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
