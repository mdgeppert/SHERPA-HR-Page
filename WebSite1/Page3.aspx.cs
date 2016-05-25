using System;
using System.Data;
using System.Data.SqlClient;
using System.Net.Mail;
using System.Text;
using System.Web.UI.WebControls;


public partial class Page3 : System.Web.UI.Page
{
    string sqlConnString = @"Data Source=Dev-Intranet;Initial Catalog=DevData;User ID=IntranetUser;Password=IntranetUser";
    private object ClientName;
    private object input;

    public void Page_Load(object sender, EventArgs e)
    {
        using (SqlConnection connection = new SqlConnection(sqlConnString))

            if (!IsPostBack)
            {
                populateView();
            }
    }
    public void populateView()
    {
        using (SqlConnection connection = new SqlConnection(sqlConnString))
        {
            string sqlQuery = @"SELECT   
[Id],
[EmployeeName],
[UserId],   
[CloseDate], 
[ChargeDate], 
[Description], 
[Description2],
[Amount], 
[ClientId],
[CategoryId],
(SELECT [ClientName] 
 FROM [Expense].[Clients] e 
 WHERE t.ClientId = e.ClientId ) AS ClientName 
 FROM [DevData].[Expense].[Transactions] t 
 WHERE [Status] = 2";
            connection.Open();
            SqlCommand myCommand = new SqlCommand();
            myCommand.Connection = connection;
            myCommand.CommandText = sqlQuery;
            myCommand.CommandType = CommandType.Text;
            myCommand.CommandTimeout = 60;
            infoGridView.DataSource = myCommand.ExecuteReader();
            infoGridView.DataBind();
            connection.Close();
        }
    }

    protected void saveChanges_Click(object sender, EventArgs e)
    {
        string pcName = "";
        pcName = System.Security.Principal.WindowsIdentity.GetCurrent().Name;
        pcName = pcName.Substring(pcName.IndexOf(@"\") + 1).ToLower();
        try
        {
            string query = "";
            for (int i = 0; i < infoGridView.Rows.Count; i++)
            {
                GridViewRow row = infoGridView.Rows[i];
                TextBox clientId = ((TextBox)(row.Cells[6].FindControl("ClientNameTbx")));
                string clientIdTbx = clientId.Text.ToString();
                TextBox categoryId = ((TextBox)(row.Cells[7].FindControl("CategoryDescriptionTbx")));
                string CategoryDescriptionTbx = categoryId.Text.ToString();
                HiddenField hiddenId = (HiddenField)row.Cells[6].FindControl("HiddenId");
                string hiddenIdText = hiddenId.Value;
                TextBox description2Text = (TextBox)row.Cells[4].FindControl("description2Text");
                string description2 = description2Text.Text;

                using (SqlConnection connection = new SqlConnection(sqlConnString))
                {
                    string queryUpdate = query + "UPDATE [Expense].[Transactions] SET [Description2] = '" + description2 + "' , [ClientId] = '" + clientIdTbx + "', [CategoryId] = '" + CategoryDescriptionTbx + "' , [Status] =  3  WHERE  [Id] = '" + hiddenIdText + "' ;\n";
                    connection.Open();
                    SqlCommand myCommand = new SqlCommand();
                    myCommand.Connection = connection;
                    myCommand.CommandText = queryUpdate;
                    myCommand.CommandTimeout = 60;
                    myCommand.ExecuteNonQuery();
                }
                doneMessage3.Text = "Save complete.";
            }
        }
        catch (Exception ex)
        {
            SendErrorEmail(ex.ToString(), "AMEX - saveButton_Click", pcName);
            doneMessage3.Text = "Entries not saved!";
        }
    }

    protected void createCsv(object sender, EventArgs e)
    {
        StringBuilder sb = new StringBuilder();

        using (SqlConnection connection = new SqlConnection(sqlConnString))
        {
            string sqlQuery = @"SELECT   
[Id],
[EmployeeName],
[UserId],   
[CloseDate], 
[ChargeDate], [Description], [Description2],
[Amount], 
[ClientId],
[CategoryId],
(SELECT Distinct Count(UserId) FROM [Expense].[Transactions] WHERE [UserId] = t.[UserId] AND [Status] = 3) as NumberOfTransactions,
(SELECT [ClientName] 
 FROM [Expense].[Clients] e 
 WHERE t.ClientId = e.ClientId ) AS ClientName,
(SELECT COALESCE(CAST(p.Peachtree AS varchar(100)), '') FROM [Expense].[PeachtreeUser] p WHERE t.UserId = p.UserId FOR XML PATH('')) AS EmployeeId
 FROM [DevData].[Expense].[Transactions] t 
 WHERE [Status] = 3 Order By [UserId]";
            connection.Open();
            SqlCommand myCommand = new SqlCommand();
            myCommand.Connection = connection;
            myCommand.CommandText = sqlQuery;
            myCommand.CommandType = CommandType.Text;
            myCommand.CommandTimeout = 60;
            SqlDataReader reader = myCommand.ExecuteReader();
            if (reader.HasRows)
            {
                sb.Append("Employee ID" + ",");
                sb.Append("Invoice Number" + ",");
                sb.Append("Transaction_Date" + ",");
                sb.Append("Due Date" + ",");
                sb.Append("A/P Account Number" + ",");
                sb.Append("Number of Entries for Vendor" + ",");
                sb.Append("Description" + ",");
                sb.Append("G/L Account Number" + ",");
                sb.Append("Approved Entry Amount" + ",");
                sb.Append("Client Code" + ",");
                sb.Append("\r\n");

                while (reader.Read())
                {
                    sb.Append(reader["EmployeeId"].ToString() + ",");
                    sb.Append(invoiceNumber.Text + ",");
                    sb.Append(transactionDate + ",");
                    sb.Append(dueDate.Text + ",");
                    sb.Append(apAccountNumber.Text + ",");
                    sb.Append(reader["NumberOfTransactions"].ToString() + ",");

                    sb.Append(reader["ChargeDate"].ToString() + "-");
                    sb.Append(reader["ClientName"].ToString() + "-");
                    sb.Append(reader["Description"].ToString() + ";");
                    sb.Append(reader["Description2"].ToString() + ";");
                    sb.Append(reader["EmployeeId"].ToString() + ",");

                    sb.Append(reader["CategoryId"].ToString() + ",");
                    sb.Append(reader["Amount"].ToString() + ",");
                    sb.Append(reader["ClientId"].ToString() + ",");
                    sb.Append("\r\n");
                }
                Response.Output.Write(sb.ToString());
                Response.Buffer = true;
                Response.AddHeader("content-disposition",
                 "attachment;filename=amexExpenseData" + DateTime.Now + ".csv");
                Response.Charset = "";
                Response.ContentType = "application/text";
                string pcName = "";
                pcName = System.Security.Principal.WindowsIdentity.GetCurrent().Name;
                pcName = pcName.Substring(pcName.IndexOf(@"\") + 1).ToLower();

                try
                {
                    string query = "";
                    using (SqlConnection connection2 = new SqlConnection(sqlConnString))
                    {
                        string queryUpdate = query + "UPDATE [Expense].[Transactions] SET [Status] = '4'  WHERE  [Status] = 3";
                        connection2.Open();
                        SqlCommand myCommand2 = new SqlCommand();
                        myCommand2.Connection = connection2;
                        myCommand2.CommandText = queryUpdate;
                        myCommand2.CommandTimeout = 60;
                        myCommand2.ExecuteNonQuery();
                    }
                    doneMessage3.Text = "Process complete.";

                }

                catch (Exception ex)
                {
                    SendErrorEmail(ex.ToString(), "AMEX - saveButton_Click", pcName);
                    doneMessage3.Text = "Entries not saved!";
                }
                Response.End();
                Response.Flush();
            }
        }
    }

    public static void SendErrorEmail(string bodyText, string emailSubject, string pcName)
    {
        string to = "mgeppert@ssgstl.com";
        string from = "emailnoreply@summitstrategies.com";
        try
        {
            MailMessage message = new MailMessage(from, to);
            message.Subject = "Error in 'AMEX = " + emailSubject;
            message.Body = "<strong>User:</strong><br />" + pcName + "<br /><br />" + bodyText;
            message.IsBodyHtml = true;
            SmtpClient client = new SmtpClient();
            client.Send(message);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
}