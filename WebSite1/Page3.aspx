<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Page3.aspx.cs" Inherits="Page3" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" type="text/css" href="StyleSheet1.css" />
    <style type="text/css">
        .row {
            height: 115px;
            width: 1824px;
        }
    </style>
</head>
<body>
    <div class="container">

        <div class="col-md-12">
            <div class="row">
                <form id="display" runat="server">
                    <div class="row">
                        <div class="col-md-2" display="inline">
                            <table>
                                <tr>
                                    <td>
                                        <div id="invoiceNumberLabel">Invoice Number:</div>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="invoiceNumber" runat="server"></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td>
                                        <div id="transactionDateLabel">Transaction Date:</div>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="transactionDate" runat="server"></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td>
                                        <div id="dueDateLabel">Due Date:</div>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="dueDate" runat="server"></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td>
                                        <div id="apAccountNumberLabel">A/P Account Number:</div>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="apAccountNumber" runat="server"></asp:TextBox></td>
                                </tr>
                            </table>
                            <table>
                                <tr>
                                    <div ID="transactionCountLabel">Transaction Count:</div>
                                    <asp:Label ID="transactionCountDisplay" OnDataBinding="countTransactions" runat="server"></asp:Label>
                                    </tr>
                                <tr>
                                    <asp:Label ID="doneMessage2" runat="server" />
                                </tr>
                            </table>
                        </div>
                    </div>
                    
                    <asp:Button ID="finalSaveButton" runat="server" OnClick="finalUpdateInfo" Text="Confirm" Style="margin-left: 769px" Width="76px" />
                    <asp:Button ID="transactionCount" runat="server" OnClick="countTransactions" style="margin-left: 36px" Text="Tx Count" Width="96px" />
                    <asp:Button ID="toCsv" runat="server" OnClick="createCsv" Text="Create CSV" Height="24px" Style="margin-left: 39px" Width="85px" />

                    <asp:GridView ID="infoGridView" runat="server" Height="50px" AutoGenerateColumns="False" BackColor="White" BorderColor="#CCCCCC" Style="margin-left: 26px; margin-top: 21px; margin-bottom: 0px;" Width="95%" BorderStyle="None" CellPadding="10" BorderWidth="1px" GridLines="None">
                        <AlternatingRowStyle BackColor="#CCD9FF" />
                        <Columns>

                            <asp:BoundField DataField="UserId" HeaderText="User Id" ReadOnly="True"><%--Employee Name--%>
                                <ControlStyle Font-Names="Arial" Font-Bold />
                                <HeaderStyle Font-Names="Arial Black" Wrap="False" CssClass="color: orange;" HorizontalAlign="Left" />
                                <ItemStyle Wrap="False" Font-Names="Arial" Font-Bold />
                            </asp:BoundField>
                            <asp:BoundField DataField="CloseDate" HeaderText="Close Date" ReadOnly="True" DataFormatString="{0:MM/dd/yyyy}"><%--Close Date--%>
                                <ControlStyle Font-Names="Arial" Font-Bold />
                                <HeaderStyle Font-Names="Arial Black" Wrap="False" HorizontalAlign="Left" />
                                <ItemStyle Wrap="False" Font-Names="Arial" Font-Bold />
                            </asp:BoundField>
                            <asp:BoundField DataField="ChargeDate" HeaderText="Charge Date" ReadOnly="True" DataFormatString="{0:MM/dd/yyyy}"><%--Charge Date--%>
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
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="description2Text" ErrorMessage="*" ForeColor="Red" Font-Size="XX-Large"></asp:RequiredFieldValidator>
                                </ItemTemplate>
                                <ControlStyle Font-Bold="True" Font-Names="Arial" />
                                <HeaderStyle Font-Names="Arial Black" Wrap="False" HorizontalAlign="Left" />
                                <ItemStyle Font-Bold="True" Font-Names="Arial" Wrap="False" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Client Code"><%--ClientName--%>
                                <ItemTemplate>
                                    <asp:TextBox runat="server" ID="ClientNameTbx" AutoPostBack="true" Text='<%# Bind("ClientId") %>' />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="ClientNameTbx" ErrorMessage="*" ForeColor="Red" Font-Size="XX-Large"></asp:RequiredFieldValidator>
                                </ItemTemplate>
                                <ControlStyle Font-Bold="True" Font-Names="Arial" />
                                <HeaderStyle Font-Names="Arial Black" Wrap="False" HorizontalAlign="Left" />
                                <ItemStyle Font-Names="Arial" Font-Bold Wrap="False" />
                            </asp:TemplateField>

                            <asp:CheckBoxField>

                                <HeaderStyle HorizontalAlign="Left" />
                            </asp:CheckBoxField>

                            <asp:TemplateField HeaderText="Category Id"><%--Category Description--%>
                                <ItemTemplate>
                                    <asp:TextBox runat="server" ID="CategoryDescriptionTbx" AutoPostBack="true" Text='<%# Bind("CategoryId") %>' />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="CategoryDescriptionTbx" ErrorMessage="*" ForeColor="Red" Font-Size="XX-Large"></asp:RequiredFieldValidator>
                                </ItemTemplate>
                                <ControlStyle Font-Bold="True" Font-Names="Arial" />
                                <HeaderStyle Font-Names="Arial Black" Wrap="False" HorizontalAlign="Left" />
                                <ItemStyle Font-Names="Arial" Font-Bold Wrap="False" />
                            </asp:TemplateField>

                            <asp:CheckBoxField>

                                <HeaderStyle HorizontalAlign="Left" />
                            </asp:CheckBoxField>                       
                            <asp:BoundField DataField="Amount" HeaderText="Amount" ReadOnly="True" HtmlEncode="false" DataFormatString="$ {0:###,###,###.00}"><%--Amount--%>
                                <HeaderStyle Font-Names="Arial Black" Wrap="False" HorizontalAlign="Right" />
                                <ItemStyle Font-Names="Arial" Font-Bold HorizontalAlign="Right" Wrap="False" />
                            </asp:BoundField>

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
                    <asp:HiddenField ID="saveHiddenCsv" runat="server"></asp:HiddenField>
                    <asp:HiddenField ID="HiddenField1" runat="server"></asp:HiddenField>
                    <asp:HiddenField ID="invoiceNumberHidden" runat="server"></asp:HiddenField>
                    <asp:HiddenField ID="transactionDateHidden" runat="server"></asp:HiddenField>
                    <asp:HiddenField ID="dueDateHidden" runat="server"></asp:HiddenField>
                    <asp:HiddenField ID="apAccountNumberHidden" runat="server"></asp:HiddenField>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
