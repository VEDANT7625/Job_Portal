<%@ Page Title="" Language="C#" MasterPageFile="~/JobProvider/JobProvider.Master" AutoEventWireup="true" CodeBehind="ContactList.aspx.cs" Inherits="Job_Portal.JobProvider.ContactList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">



    <div style="background-image: url('../Images/bg.jpg'); width: 100%; height: auto; background-repeat: no-repeat; background-size: cover; background-attachment: fixed;">
    <div class="container py-4">

        <asp:Label ID="lblMsg" runat="server" CssClass="text-danger font-weight-bold"></asp:Label>

        <h3 class="text-center mb-4 text-white">Contact List/Details</h3>
        <div class="row mb-3 pt-sm-3">
            <div class="col-md-12">
                <asp:GridView ID="GridView1" runat="server" CssClass="table table-hover table-bordered"
                    EmptyDataText="No record to display." AutoGenerateColumns="false" AllowPaging="true" PageSize="5"
                    DataKeyNames="ContactId"
                    OnPageIndexChanging="GridView1_PageIndexChanging"
                    OnRowDeleting="GridView1_RowDeleting">

                    <Columns>
                        <asp:BoundField DataField="Sr.No" HeaderText="Sr.No" ReadOnly="true">
                            <ItemStyle Width="5%" />
                        </asp:BoundField>

                        <asp:TemplateField HeaderText="User Name">
                            <ItemTemplate><%# Eval("Name") %></ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtTitle" runat="server" Text='<%# Bind("Name") %>' CssClass="form-control" />
                            </EditItemTemplate>
                            <ItemStyle Width="12%" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Email">
                            <ItemTemplate><%# Eval("Email") %></ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtNoOfPost" runat="server" Text='<%# Bind("Email") %>' CssClass="form-control" />
                            </EditItemTemplate>
                            <ItemStyle Width="8%" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Subject">
                            <ItemTemplate><%# Eval("Subject") %></ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtQualification" runat="server" Text='<%# Bind("Subject") %>' CssClass="form-control" />
                            </EditItemTemplate>
                            <ItemStyle Width="10%" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Message">
                            <ItemTemplate><%# Eval("Message") %></ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtExperience" runat="server" Text='<%# Bind("Message") %>' CssClass="form-control" />
                            </EditItemTemplate>
                            <ItemStyle Width="10%" />
                        </asp:TemplateField>
 
                        <asp:CommandField HeaderText="Action" ShowDeleteButton="true" />
                    </Columns>

                    <HeaderStyle BackColor="#7200cf" ForeColor="White" />
                </asp:GridView>
            </div>
        </div>
    </div>
</div>
</asp:Content>
