<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Page1.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Page 1</title>
    <link rel="stylesheet" type="text/css" href="/css/StyleSheet1.css" />
    <style type="text/css">
        .auto-style1 {
            margin-left: 42px;
        }

        .auto-style2 {
            margin-left: 0px;
        }

        .auto-style3 {
            width: 500px;
            margin-left: 0px;
        }
        .auto-style4 {
            height: 2px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="col-md-12">
            <div class="row">
                <form id="browse" runat="server">
                    <table id="page1Table">
                        <tr>
                            <td>
                                <asp:FileUpload ID="openFileDialog1" runat="server" CssClass="auto-style3" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Button ID="uploadButton" runat="server" Text="Upload and Split" OnClick="uploadButton_Click" CssClass="auto-style2" />
                            </td>
                            <td>
                                <p id="rawData" class="auto-style4">Raw Data</p>

                            </td>
                        </tr>
                    </table>
                    <%--<asp:Button ID="split" runat="server" Text="Split" OnClick="splitButton_Click" Height="40px" margin-left="50%" Width="100px" Style="margin-left: 33px" />--%>
                    <asp:GridView ID="infoGridView" runat="server" ShowHeaderWhenEmpty="true" GridLines="None" AutoGenerateColumns="False" CssClass="auto-style1" Width="1796px">
                        <AlternatingRowStyle BackColor="#CCD9FF" />
                        <Columns>
                            <asp:ImageField>
                                <ItemStyle Width="1%" />
                            </asp:ImageField>
                            <asp:BoundField DataField="UserId" HeaderText="User Id">
                                <ControlStyle Height="15px" />
                                <HeaderStyle Font-Names="Arial Black" />
                                <ItemStyle Width="4%" Font-Names="Arial" Font-Size="11px" Height="15px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="CloseDate" HeaderText="Close Date" ConvertEmptyStringToNull="False" DataFormatString="{0:MM/dd/yyyy}">
                                <HeaderStyle HorizontalAlign="Center" Font-Names="Arial Black" />
                                <ItemStyle Width="8%" HorizontalAlign="Center" Font-Names="Arial" Font-Size="11px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="ChargeDate" HeaderText="Charge Date" ConvertEmptyStringToNull="False" DataFormatString="{0:MM/dd/yyyy}">
                                <HeaderStyle Font-Names="Arial Black" HorizontalAlign="Center" />
                                <ItemStyle Width="10%" HorizontalAlign="Center" Font-Names="Arial" Font-Size="11px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Description" HeaderText="Description">
                                <HeaderStyle Font-Names="Arial Black" />
                                <ItemStyle Width="25%" Font-Names="Arial" Font-Size="11px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Description2" HeaderText="Description 2">
                                <HeaderStyle Font-Names="Arial Black" />
                                <ItemStyle Width="25%" Font-Names="Arial" Font-Size="11px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Amount" HeaderText="Amount" DataFormatString="{0: $ #.00}">
                                <HeaderStyle HorizontalAlign="Right" Font-Names="Arial Black" />
                                <ItemStyle Width="6%" HorizontalAlign="Right" Font-Names="Arial" Font-Size="11px" />
                            </asp:BoundField>
                            <asp:ImageField>
                                <ItemStyle Width="1%" />
                            </asp:ImageField>
                        </Columns>
                        <EmptyDataTemplate>No Record Available</EmptyDataTemplate>
                        <HeaderStyle BackColor="#668CFF" Height="50px" Font-Names="Arial Black" HorizontalAlign="Left" />
                        <RowStyle Height="30px" BackColor="#E6EEFF" Font-Bold="True" Font-Names="Arial" />
                    </asp:GridView>
                    <alternatingrowstyle backcolor="White" />
                    <asp:HiddenField ID="savePathHiddenField1" runat="server" />
                    <asp:HiddenField ID="seNumberHiddenField" runat="server" />
                    </asp:GridView>
                </form>
            </div>
        </div>
</body>

</html>
