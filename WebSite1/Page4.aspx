<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Page4.aspx.cs" Inherits="Page4" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" type="text/css" href="/css/StyleSheet1.css" />
    <style type="text/css">
        .row {
            height: 661px;
            width: 1824px;
        }

        .auto-style1 {
            margin-left: 0px;
            margin-top: 19px;
        }

        #display {
            margin-left: -26px;
        }

        .auto-style5 {
            width: 99px;
        }
    </style>
</head>
<body style="width: 1727px">
    <div class="container">
        <div class="col-md-12">
            <div>
                <form id="display" runat="server">
                    <table>
                        <tr>
                            <td class="auto-style5">
                                <asp:Button ID="button1" runat="server" Text="Save" OnClick="continueSaveButton_Click" AutoPostBack="true" />
                            </td>
                            <td>
                                <div id="currentTransactionsFor">
                                    Current Transactions for:  
                                    <asp:Label ID="transactionUserName" runat="server"></asp:Label><div class="revisited">revisited</div>
                                </div>
                            </td>
                         <%--   <td>
                                <div id="revisited">revisited</div>
                            </td>--%>
                        </tr>
                        <tr>
                            <td class="auto-style5">
                                <asp:Button ID="button2" runat="server" OnClick="continuedSubmitButton_Click" Text="Submit" AutoPostBack="true" />
                        </tr>
                    </table>
                    <asp:Label ID="doneMessage2" runat="server" />
                    <asp:Label ID="incompleteMessage1" runat="server" />
                    <asp:GridView ID="infoGridView" runat="server" AutoGenerateColumns="False" OnRowDataBound="ddlClientNameTbx" ShowHeaderWhenEmpty="true">
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
                                <ItemStyle Font-Names="Arial" Font-Bold Width="300px" Wrap="False" Font-Size="11px" />
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
