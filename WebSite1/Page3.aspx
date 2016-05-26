<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Page3.aspx.cs" Inherits="Page3" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" type="text/css" href="/css/StyleSheet1.css" />
    <style type="text/css">
        .auto-style2 {
            height: 41px;
        }
        .auto-style3 {
            margin-top: 0px;
        }
        .auto-style4 {
            height: 22px;
        }
    </style>
</head>
<body style="width: 1727px">
    <div class="container">
        <form id="display" runat="server" class="auto-style6">
                    <table>
                        <tr>
                            <td class="auto-style2">
                                <asp:Button ID="button1" runat="server" OnClick="updateButton_Click" Text="Update" />
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style25">
                                <asp:Button ID="button2" runat="server" OnClick="createCsv" Text="Create CSV" AutoPostBack="true" />
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style25">
                                <div id="invoiceNumberLabel">Invoice Number:</div>
                            </td>
                            <td class="auto-style7">
                                <asp:TextBox ID="invoiceNumber" runat="server" CssClass="auto-style18" Height="22px" Width="160px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style16">
                                <div id="transactionDateLabel" class="auto-style14">Transaction Date:</div>
                            </td>
                            <td class="auto-style17">
                                <asp:TextBox ID="transactionDate" runat="server" CssClass="auto-style18" Height="22px" Width="160px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style21">
                                <div id="dueDateLabel">Due Date:</div>
                            </td>
                            <td class="auto-style22">
                                <asp:TextBox ID="dueDate" runat="server" CssClass="auto-style18" Height="22px" Width="160px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style23">A/P AccountNumber:</td>
                            <td class="auto-style24">
                                <asp:TextBox ID="apAccountNumber" runat="server" CssClass="auto-style12" Height="22px" Width="160px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style4">
                                <asp:Label ID="doneMessage3" runat="server"></asp:Label>
                            </td>   
                        </tr>
                    </table>
            <div class="col-md-12">
                <div>
                    <asp:GridView ID="infoGridView" runat="server" AutoGenerateColumns="False" OnRowDataBound="ddlClientNameTbx" ShowHeaderWhenEmpty="true" Width="1802px" CssClass="auto-style3">
                        <AlternatingRowStyle BackColor="#CCD9FF" />
                        <Columns>
                            <asp:BoundField DataField="EmployeeName" HeaderText="Employee Name" ReadOnly="True"><%--Employee Name--%>
                                <ControlStyle Font-Names="Arial" Font-Bold />
                                <HeaderStyle Font-Names="Arial Black" Wrap="False" CssClass="margin-left: 0;" HorizontalAlign="Left" />
                                <ItemStyle Wrap="False" Font-Names="Arial" Font-Bold Font-Size="11px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="CloseDate" HeaderText="Close Date" ReadOnly="True"><%--Close Date--%>
                                <ControlStyle Font-Names="Arial" Font-Bold />
                                <HeaderStyle Font-Names="Arial Black" Wrap="False" HorizontalAlign="Left" />
                                <ItemStyle Wrap="False" Font-Names="Arial" Font-Bold Font-Size="11px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="ChargeDate" HeaderText="Charge Date" ReadOnly="True"><%--Charge Date--%>
                                <HeaderStyle Font-Names="Arial Black" Wrap="False" HorizontalAlign="Left" />
                                <ItemStyle Font-Names="Arial" Font-Bold Wrap="False" Font-Size="11px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Description" HeaderText="Description"><%--Description--%>
                                <HeaderStyle Font-Names="Arial Black" Wrap="False" HorizontalAlign="Left" />
                                <ItemStyle Font-Names="Arial" Font-Bold Width="200px" Wrap="False" Font-Size="11px" />
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="Description 2">
                                <ItemTemplate>
                                    <asp:HiddenField ID="HiddenId" runat="server" Value='<%# Bind("Id") %>' />
                                    <asp:TextBox runat="server" ID="description2Text" AutoPostBack="true" Text='<%# Bind("Description2") %>' />
                                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="description2Text" ErrorMessage="*" ForeColor="Red" Font-Size="XX-Large"></asp:RequiredFieldValidator>--%>
                                </ItemTemplate>
                                <ControlStyle Font-Bold="True" Font-Names="Arial" Font-Size="11px" Width="300px" />
                                <HeaderStyle Font-Names="Arial Black" Wrap="False" HorizontalAlign="Left" />
                                <ItemStyle Font-Bold="True" Font-Names="Arial" Wrap="False" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Client Name"><%--ClientName--%>
                                <ItemTemplate>
                                    <asp:HiddenField ID="ddlClientNameTextHidden" Value='<%# Bind("ClientId") %>' runat="server"></asp:HiddenField>
                                    <asp:DropDownList ID="ddlClientNameText" runat="server" AutoPostBack="true" AppendDataBoundItems="true"></asp:DropDownList>
                                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="ddlClientNameText" ErrorMessage="*" ForeColor="Red" InitialValue="Please select" Font-Size="XX-Large"></asp:RequiredFieldValidator>--%>
                                </ItemTemplate>
                                <ControlStyle Font-Bold="True" Font-Names="Arial" Font-Size="11px" Width="280px" />
                                <HeaderStyle Font-Names="Arial Black" Wrap="False" HorizontalAlign="Left" />
                                <ItemStyle Font-Names="Arial" Font-Bold Wrap="False" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Category Description"><%--Category Description--%>
                                <ItemTemplate>
                                    <asp:HiddenField ID="ddlCategoryDescriptionHidden" Value='<%# Bind("CategoryId") %>' runat="server"></asp:HiddenField>
                                    <asp:DropDownList ID="ddlCategoryDescriptionText" runat="server" AutoPostBack="true" AppendDataBoundItems="true"></asp:DropDownList>
                                </ItemTemplate>
                                <ControlStyle Font-Bold="True" Font-Names="Arial" Font-Size="11px" Width="280px" />
                                <HeaderStyle Font-Names="Arial Black" Wrap="False" HorizontalAlign="Left" />
                                <ItemStyle Font-Names="Arial" Font-Bold Wrap="False" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="Amount" HeaderText="Amount" ReadOnly="True" HtmlEncode="false" DataFormatString="$ {0:###,###,###.00}"><%--Amount--%>
                                <HeaderStyle Font-Names="Arial Black" Wrap="False" HorizontalAlign="Right" />
                                <ItemStyle Font-Names="Arial" Font-Bold HorizontalAlign="Right" Wrap="False" Font-Size="11px" />
                            </asp:BoundField>

                        </Columns>
                        <EmptyDataTemplate>No Record Available</EmptyDataTemplate>
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
