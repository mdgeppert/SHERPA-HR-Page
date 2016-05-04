<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Page3.aspx.cs" Inherits="Page3" %>

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
                    <asp:Button ID="submitButton" runat="server" Text="Submit" />
                    <asp:GridView ID="infoGridView" runat="server"  Height="50px"  AutoGenerateColumns="False" BackColor="White" BorderColor="#CCCCCC" style="margin-left: 67px; margin-top: 85px; margin-bottom: 0px;" Width="95%" BorderStyle="None" CellPadding="10" BorderWidth="1px" GridLines="None">
                        <AlternatingRowStyle BackColor="#CCD9FF" />
                        <Columns>

                            <asp:BoundField DataField="UserId" HeaderText="User Id" ReadOnly="True"><%--Employee Name--%>
                                <ControlStyle Font-Names="Arial" Font-Bold />
                                <HeaderStyle Font-Names="Arial Black" Wrap="False" />
                                <ItemStyle Wrap="False" Font-Names="Arial" Font-Bold />
                            </asp:BoundField>
                            <asp:BoundField DataField="CloseDate" HeaderText="Close Date" ReadOnly="True" DataFormatString="{0:MM/dd/yyyy}"><%--Close Date--%>
                                <ControlStyle Font-Names="Arial" Font-Bold />
                                <HeaderStyle Font-Names="Arial Black" Wrap="False" />
                                <ItemStyle Wrap="False" Font-Names="Arial" Font-Bold />
                            </asp:BoundField>
                            <asp:BoundField DataField="ChargeDate" HeaderText="Charge Date" ReadOnly="True" DataFormatString="{0:MM/dd/yyyy}"><%--Charge Date--%>
                                <HeaderStyle Font-Names="Arial Black" Wrap="False" />
                                <ItemStyle Font-Names="Arial" Font-Bold Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Description" HeaderText="Description"><%--Description--%>
                                <HeaderStyle Font-Names="Arial Black" Wrap="False" />
                                <ItemStyle Font-Names="Arial" Font-Bold Width="200px" Wrap="False" />
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="Description 2">
                                <ItemTemplate>
                                    <asp:HiddenField ID="HiddenId" runat="server" Value='<%# Bind("Id") %>' />
                                    <asp:TextBox runat="server" ID="description2Text" AutoPostBack="true" Text='<%# Bind("Description2") %>' />
                                </ItemTemplate>
                                <ControlStyle Font-Bold="True" Font-Names="Arial" />
                                <HeaderStyle Font-Names="Arial Black" Wrap="False" />
                                <ItemStyle Font-Bold="True" Font-Names="Arial" Wrap="False" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="Amount" HeaderText="Amount" ReadOnly="True" HtmlEncode="false" DataFormatString="$ {0:###,###,###.00}"><%--Amount--%>
                                <HeaderStyle Font-Names="Arial Black" Wrap="False" />
                                <ItemStyle Font-Names="Arial" Font-Bold HorizontalAlign="Right" Wrap="False" />
                            </asp:BoundField>

                            <asp:TemplateField HeaderText="Client Id"><%--ClientName--%>
                                <ItemTemplate>
                                    <asp:TextBox runat="server" ID="ClientNameTbx" AutoPostBack="true" Text='<%# Bind("ClientId") %>' />
                                </ItemTemplate>
                                <ControlStyle Font-Bold="True" Font-Names="Arial" />
                                <HeaderStyle Font-Names="Arial Black" Wrap="False" />
                                <ItemStyle Font-Names="Arial" Font-Bold Wrap="False" />
                            </asp:TemplateField>

                            <asp:CheckBoxField />

                            <asp:TemplateField HeaderText="Category Id"><%--Category Description--%>
                                <ItemTemplate>
                                    <asp:TextBox runat="server" ID="CategoryDescriptionTbx" AutoPostBack="true" Text='<%# Bind("CategoryId") %>' />
                                </ItemTemplate>
                                <ControlStyle Font-Bold="True" Font-Names="Arial" />
                                <HeaderStyle Font-Names="Arial Black" Wrap="False" />
                                <ItemStyle Font-Names="Arial" Font-Bold Wrap="False" />
                            </asp:TemplateField>

                            <asp:CheckBoxField />

                            <asp:TemplateField HeaderText="Billable"><%--Billable--%>
                                <ItemTemplate>
                                    <asp:TextBox runat="server" ID="tbxBillable" OnSelectedIndexChanged="clientIdText" AutoPostBack="true" Text='<%# Bind("Billable") %>' />
                                </ItemTemplate>
                                <ControlStyle Font-Bold="True" Font-Names="Arial" />
                                <HeaderStyle Font-Names="Arial Black" Wrap="False" Font-Bold="False" />
                                <ItemStyle Font-Names="Arial" Font-Bold Wrap="False" />

                            </asp:TemplateField>
                            <asp:CheckBoxField />
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
