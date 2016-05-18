using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
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
[Billable],
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

    protected void clientIdText(object sender, EventArgs e)
    {
        DropDownList ddl = (DropDownList)sender;
        GridViewRow row = (GridViewRow)ddl.Parent.Parent;
        TextBox tbxBillable = (TextBox)row.Cells[8].FindControl("tbxBillable");



        using (SqlConnection connection = new SqlConnection(sqlConnString))
        {
            connection.Open();
            string sqlQuery3 = @"SELECT [Billable] FROM [Expense].[Clients] WHERE [ClientId] = '" + ddl.SelectedValue + "' ";

            SqlCommand myCommand = new SqlCommand();
            myCommand.Connection = connection;
            myCommand.CommandText = sqlQuery3;
            myCommand.CommandType = CommandType.Text;
            myCommand.CommandTimeout = 60;
            SqlDataReader myReader = myCommand.ExecuteReader();



            if (myReader.HasRows)
            {
                while (myReader.Read())
                {
                    tbxBillable.Text = myReader["Billable"].ToString();
                }
            }
        }
    }




    protected void finalUpdateInfo(object sender, EventArgs e)
    {
        string pcName = "";
        //pcName = System.Security.Principal.WindowsIdentity.GetCurrent().Name;
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

                TextBox billableText = (TextBox)row.Cells[8].FindControl("tbxBillable");
                string billableTextTbx = billableText.Text;

                HiddenField hiddenId = (HiddenField)row.Cells[6].FindControl("HiddenId");
                string hiddenIdText = hiddenId.Value;

                TextBox description2Text = (TextBox)row.Cells[4].FindControl("description2Text");
                string description2 = description2Text.Text;


                using (SqlConnection connection = new SqlConnection(sqlConnString))
                {

                    string queryUpdate = query + "UPDATE [Expense].[Transactions] SET [Description2] = '" + description2 + "' , [ClientId] = '" + clientIdTbx + "', [CategoryId] = '" + CategoryDescriptionTbx + "',   [Billable]= '" + billableTextTbx + "', [Status] = '3'  WHERE  [Id] = '" + hiddenIdText + "' ;\n";

                    connection.Open();
                    SqlCommand myCommand = new SqlCommand();
                    myCommand.Connection = connection;
                    myCommand.CommandText = queryUpdate;
                    myCommand.CommandTimeout = 60;
                    myCommand.ExecuteNonQuery();
                }
                doneMessage2.Text = "Confirmation complete.";


            }
        }
        catch (Exception ex)
        {


            SendErrorEmail(ex.ToString(), "AMEX - saveButton_Click", pcName);


            doneMessage2.Text = "Entries not saved!";
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



protected void createCsv(object sender, EventArgs e)
{
    StringBuilder sb = new StringBuilder();
    //try
    //{
    using (SqlConnection connection = new SqlConnection(sqlConnString))
    {
        string sqlQuery = @"SELECT   
[Id],
[UserId],   
[CloseDate], 
[ChargeDate], 
[Description], 
[Description2],
[Amount], 
[ClientId],
[CategoryId],
[Billable]
FROM [DevData].[Expense].[Transactions]
WHERE [Status] = 3";
        connection.Open();
        SqlCommand myCommand = new SqlCommand();
        myCommand.Connection = connection;
        myCommand.CommandText = sqlQuery;
        myCommand.CommandType = CommandType.Text;
        myCommand.CommandTimeout = 60;
        SqlDataReader reader = myCommand.ExecuteReader();
        if (reader.HasRows)
        {
            while (reader.Read())
            {
                sb.Append(reader["UserId"].ToString() + ",");
                sb.Append(reader["CloseDate"].ToString() + ",");
                sb.Append(reader["ChargeDate"].ToString() + ",");
                sb.Append(reader["Description"].ToString() + ",");
                sb.Append(reader["Description2"].ToString() + ",");
                sb.Append(reader["Amount"].ToString() + ",");
                sb.Append(reader["ClientId"].ToString() + ",");
                sb.Append(reader["CategoryId"].ToString() + ",");
                sb.Append(reader["Billable"].ToString() + ",");
                sb.Append("\r\n");
            }
            Response.Output.Write(sb.ToString());
            Response.Buffer = true;
            Response.AddHeader("content-disposition",
             "attachment;filename=amexExpenseData" + DateTime.Now + ".csv");
            Response.End();
            Response.Flush();
            Response.Charset = "";
            Response.ContentType = "application/text";
        }

    }
}
}