<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Page1.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Page 1</title>
    <link rel="stylesheet" type="text/css" href="StyleSheet1.css" />
</head>
<body>
    <div class="container">
        <div class="col-md-12">
            <div class="row">
                <form id="browse" runat="server">
                    <asp:FileUpload ID="openFileDialog1" runat="server" Style="margin-left: 38.5%" Width="250px" button="40px" />
                    <asp:Button ID="upload" runat="server" Text="Upload and Split" OnClick="uploadButton_Click" Height="40px" margin-left="47%" Width="124px" Style="margin-top: 0px" />
                    <%--<asp:Button ID="split" runat="server" Text="Split" OnClick="splitButton_Click" Height="40px" margin-left="50%" Width="100px" Style="margin-left: 33px" />--%>
                    <asp:GridView ID="infoGridView" runat="server" Width="70%" Height="277px" Style="margin-left: 15%; margin-top: 25px;" BackColor="#F0F0F0" GridLines="None"  AutoGenerateColumns="False" overflow="vertical" >
                        <AlternatingRowStyle ForeColor="Black" BackColor="#CCD9FF" />
                        <Columns>
                             <asp:ImageField>
                                 <ItemStyle Width="1%" />
                             </asp:ImageField>
                             <asp:BoundField DataField="UserId" HeaderText="User Id">
                                <ItemStyle Width="4%" />
                            </asp:BoundField>
                             <asp:BoundField DataField="CloseDate" HeaderText="Close Date" ConvertEmptyStringToNull="False" DataFormatString="{0:MM/dd/yyyy}">
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle Width="8%" HorizontalAlign="Center" />
                            </asp:BoundField>
                             <asp:BoundField DataField="ChargeDate" HeaderText="Charge Date" ConvertEmptyStringToNull="False" DataFormatString="{0:MM/dd/yyyy}">
                                <HeaderStyle Font-Names="Arial" HorizontalAlign="Center" />
                                <ItemStyle Width="10%" HorizontalAlign="Center" />
                            </asp:BoundField>
                             <asp:BoundField DataField="Description" HeaderText="Description">
                                <ItemStyle Width="25%" />
                            </asp:BoundField>
                             <asp:BoundField DataField="Description2" HeaderText="Description 2">
                                <ItemStyle Width="25%" />
                            </asp:BoundField>
                             <asp:BoundField DataField="Amount" HeaderText="Amount" DataFormatString="{0: $ #.00}">
                                <HeaderStyle HorizontalAlign="Right" />
                                <ItemStyle Width="6%" HorizontalAlign="Right" />
                            </asp:BoundField>
                             <asp:ImageField>
                                 <ItemStyle Width="1%" />
                             </asp:ImageField>
                        </Columns>
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
