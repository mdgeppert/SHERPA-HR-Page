﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Page2.aspx.cs" Inherits="Page2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" type="text/css" href="StyleSheet1.css" />
    <style type="text/css">
        .row {
            height: 661px;
            width: 1824px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="col-md-12">
            <div class="row">
                <form id="display" runat="server">
                    <asp:Button ID="saveButton" runat="server" OnClick="saveButton_Click" Text="Save" AutoPostBack="true" />
                    <asp:Label ID="doneMessage"  runat="server"  />
                    <asp:GridView ID="infoGridView" runat="server" Height="50px" AutoGenerateColumns="False" OnRowDataBound="ddlClientNameTbx" BackColor="White" BorderColor="#CCCCCC" Style="margin-left: 3px; margin-top: 85px; margin-bottom: 0px;" Width="97%" BorderStyle="None" CellPadding="10" BorderWidth="1px" GridLines="None">
                        <AlternatingRowStyle BackColor="#CCD9FF" />
                        <Columns>

                            <asp:BoundField DataField="EmployeeName" HeaderText="Employee Name" ReadOnly="True"><%--Employee Name--%>
                                <ControlStyle Font-Names="Arial" Font-Bold />
                                <HeaderStyle Font-Names="Arial Black" Wrap="False" CssClass="margin-left: 0;" HorizontalAlign="Left" />
                                <ItemStyle Wrap="False" Font-Names="Arial" Font-Bold />
                            </asp:BoundField>
                            <asp:BoundField DataField="CloseDate" HeaderText="Close Date" ReadOnly="True"><%--Close Date--%>
                                <ControlStyle Font-Names="Arial" Font-Bold />
                                <HeaderStyle Font-Names="Arial Black" Wrap="False" HorizontalAlign="Left" />
                                <ItemStyle Wrap="False" Font-Names="Arial" Font-Bold />
                            </asp:BoundField>
                            <asp:BoundField DataField="ChargeDate" HeaderText="Charge Date" ReadOnly="True"><%--Charge Date--%>
                                <HeaderStyle Font-Names="Arial Black" Wrap="False" HorizontalAlign="Left" />
                                <ItemStyle Font-Names="Arial" Font-Bold Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Description" HeaderText="Description"><%--Description--%>
                                <HeaderStyle Font-Names="Arial Black" Wrap="False" HorizontalAlign="Left" />
                                <ItemStyle Font-Names="Arial" Font-Bold Width="200px" Wrap="False" />
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="Description 2">
                                <ItemTemplate>
                                    <asp:HiddenField ID="HiddenId" runat="server" Value='<%# Bind("Id") %>' />
                                    <asp:TextBox runat="server" ID="description2Text" AutoPostBack="true" Text='<%# Bind("Description2") %>' />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="description2Text" ErrorMessage="*" ForeColor="Red" Font-Size="XX-Large"></asp:RequiredFieldValidator>
                                </ItemTemplate>
                                <ControlStyle Font-Bold="True" Font-Names="Arial" />
                                <HeaderStyle Font-Names="Arial Black" Wrap="False" HorizontalAlign="Left" />
                                <ItemStyle Font-Bold="True" Font-Names="Arial" Wrap="False" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Client Name"><%--ClientName--%>
                                <ItemTemplate>
                                    <asp:DropDownList ID="ddlClientNameText" runat="server" OnSelectedIndexChanged="clientIdText" AutoPostBack="true"></asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="ddlClientNameText" ErrorMessage="*" ForeColor="Red" InitialValue="Please select" Font-Size="XX-Large"></asp:RequiredFieldValidator>
                                </ItemTemplate>
                                <ControlStyle Font-Bold="True" Font-Names="Arial" />
                                <HeaderStyle Font-Names="Arial Black" Wrap="False" HorizontalAlign="Left" />
                                <ItemStyle Font-Names="Arial" Font-Bold Wrap="False" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Category Description"><%--Category Description--%>
                                <ItemTemplate>
                                    <asp:DropDownList ID="ddlCategoryDescriptionText" runat="server"></asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="ddlCategoryDescriptionText" ErrorMessage="*" ForeColor="Red" InitialValue="Please select" Font-Size="XX-Large"></asp:RequiredFieldValidator>
                                </ItemTemplate>
                                <ControlStyle Font-Bold="True" Font-Names="Arial" />
                                <HeaderStyle Font-Names="Arial Black" Wrap="False" HorizontalAlign="Left" />
                                <ItemStyle Font-Names="Arial" Font-Bold Wrap="False" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Billable"><%--Billable--%>
                                <ItemTemplate>
                                    <asp:TextBox runat="server" ID="tbxBillable" OnSelectedIndexChanged="clientIdText" AutoPostBack="true" />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="tbxBillable" ErrorMessage="*" ForeColor="Red" Font-Size="XX-Large"></asp:RequiredFieldValidator>
                                </ItemTemplate>
                                <ControlStyle Font-Bold="True" Font-Names="Arial" />
                                <HeaderStyle Font-Names="Arial Black" Wrap="False" Font-Bold="False" HorizontalAlign="Left" />
                                <ItemStyle Font-Names="Arial" Font-Bold Wrap="False" />

                            </asp:TemplateField>

                            <asp:BoundField DataField="Amount" HeaderText="Amount" ReadOnly="True" HtmlEncode="false" DataFormatString="$ {0:###,###,###.00}"><%--Amount--%>
                                <HeaderStyle Font-Names="Arial Black" Wrap="False" HorizontalAlign="Right" />
                                <ItemStyle Font-Names="Arial" Font-Bold HorizontalAlign="Right" Wrap="False" />
                            </asp:BoundField>

                        </Columns>
                        <FooterStyle BackColor="White" ForeColor="#000066" />
                        <HeaderStyle BackColor="#668CFF" Font-Bold="False" ForeColor="Black" Font-Names="Arial Black" Height="60px" />
                        <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                        <RowStyle ForeColor="Black" BackColor="#E6EEFF" />
                        <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                        <SortedAscendingCellStyle BackColor="#F1F1F1" />
                        <SortedAscendingHeaderStyle BackColor="#007DBB" />
                        <SortedDescendingCellStyle BackColor="#CAC9C9" />
                        <SortedDescendingHeaderStyle BackColor="#00547E" />
                    </asp:GridView>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
