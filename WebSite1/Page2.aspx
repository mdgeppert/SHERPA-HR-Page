<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Page2.aspx.cs" Inherits="Page2" %>

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
        .auto-style1 {
            margin-left: 0px;
        }
        .auto-style3 {
            height: 420px;
            width: 1824px;
        }
        .auto-style4 {
            margin-left: 25px;
        }
        .auto-style5 {
            margin-left: 750px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="col-md-12">
            <div class="auto-style3">
                <form id="display" runat="server" style="margin-left: -20px;">
                    <asp:Button ID="saveButton1" runat="server" Text="Save" OnClick="saveButton_Click" AutoPostBack="true" Height="30px" Width="98px" CssClass="auto-style5" />
                    <asp:Button ID="submitButton1" runat="server" OnClick="submitButton_Click" Text="Submit" AutoPostBack="true" Height="30px" Width="98px" CssClass="auto-style4" />
                    <asp:Label ID="doneMessage"  runat="server" Font-Size="X-Large"  />
                    <asp:GridView ID="infoGridView" runat="server" Height="50px" AutoGenerateColumns="False" OnRowDataBound="ddlClientNameTbx" BackColor="White" BorderColor="#CCCCCC" Style="margin-top: 85px; margin-bottom: 0px;" Width="97%" BorderStyle="None" CellPadding="10" BorderWidth="1px" GridLines="None" CssClass="auto-style1">
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
                                    <%--<asp:CustomValidator runat="server" Id="description2Valid" ValidationGroup="Descriptions"  OnServerValidate="descriptionCustomValidator_ServerValidate" ErrorMessage="*"></asp:CustomValidator>--%>
                                </ItemTemplate>
                                <ControlStyle Font-Bold="True" Font-Names="Arial" />
                                <HeaderStyle Font-Names="Arial Black" Wrap="False" HorizontalAlign="Left" />
                                <ItemStyle Font-Bold="True" Font-Names="Arial" Wrap="False" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Client Name"><%--ClientName--%>
                                <ItemTemplate>
                                    <asp:DropDownList ID="ddlClientNameText" runat="server" AutoPostBack="true"></asp:DropDownList>
                                      <%--<asp:CustomValidator runat="server" Id="customerNameValid" ValidationGroup="CustName" OnServerValidate="customerNameCustomValidator_ServerValidate" ErrorMessage="*"></asp:CustomValidator>--%>
                                </ItemTemplate>
                                <ControlStyle Font-Bold="True" Font-Names="Arial" />
                                <HeaderStyle Font-Names="Arial Black" Wrap="False" HorizontalAlign="Left" />
                                <ItemStyle Font-Names="Arial" Font-Bold Wrap="False" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Category Description"><%--Category Description--%>
                                <ItemTemplate>
                                    <asp:DropDownList ID="ddlCategoryDescriptionText" runat="server"></asp:DropDownList>
                                </ItemTemplate>
                                <ControlStyle Font-Bold="True" Font-Names="Arial" />
                                <HeaderStyle Font-Names="Arial Black" Wrap="False" HorizontalAlign="Left" />
                                <ItemStyle Font-Names="Arial" Font-Bold Wrap="False" />
                            </asp:TemplateField>
                            <%--<asp:CustomValidator runat="server" Id="categoryValid" ValidationGroup="Category" OnServerValidate="categoryCustomValidator_ServerValidate" ErrorMessage="*"></asp:CustomValidator>--%>
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
