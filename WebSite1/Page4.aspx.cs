using System;
using System.Data;
using System.Data.SqlClient;
using System.Net.Mail;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Page4 : Page
{
    public string pcName = "'rogerb'";

    string sqlConnString = @"Data Source=Dev-Intranet;Initial Catalog=DevData;User ID=IntranetUser;Password=IntranetUser";

    public void Page_Load(object sender, EventArgs e)
    {
        using (SqlConnection connection = new SqlConnection(sqlConnString))
            //pcName = System.Security.Principal.WindowsIdentity.GetCurrent().Name;
            pcName = pcName.Substring(pcName.IndexOf(@"\") + 1).ToLower();
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
[UserId],
[EmployeeName],   
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
WHERE [UserId] = " + pcName + "AND  [Status] = 1 OR [Status] = 2";
            connection.Open();
            SqlCommand myCommand = new SqlCommand();
            myCommand.Connection = connection;
            myCommand.CommandText = sqlQuery;
            myCommand.CommandType = CommandType.Text;
            myCommand.CommandTimeout = 60;
            infoGridView.DataSource = myCommand.ExecuteReader();
            infoGridView.DataBind();
            connection.Close(); string sqlQuery2 = @"SELECT   

[EmployeeName]   
FROM [DevData].[Expense].[Transactions] 
WHERE  [UserId] =  " + pcName + "";
            connection.Open();
            SqlCommand myCommand2 = new SqlCommand();
            myCommand2.Connection = connection;
            myCommand2.CommandText = sqlQuery2;
            myCommand2.CommandType = CommandType.Text;
            myCommand2.CommandTimeout = 60;
            myCommand2.ExecuteScalar().ToString();

            transactionUserName.Text = myCommand2.ExecuteScalar().ToString();

        }
    }
    public void ddlClientNameTbx(object sender, GridViewRowEventArgs e)
    {


        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DropDownList ddlClientName = (e.Row.FindControl("ddlClientNameText") as DropDownList);




            using (SqlConnection connection = new SqlConnection(sqlConnString))
            {
                string sqlQuery1 = @"SELECT [ClientName], [ClientId]  FROM [Expense].[Clients]";
                connection.Open();
                SqlCommand myCommand = new SqlCommand();
                myCommand.Connection = connection;
                myCommand.CommandText = sqlQuery1;
                myCommand.CommandType = CommandType.Text;
                myCommand.CommandTimeout = 60;
                SqlDataReader myReader = myCommand.ExecuteReader();
                ddlClientName.DataSource = myReader;
                ddlClientName.DataTextField = "ClientName";
                ddlClientName.DataValueField = "ClientId";
                ddlClientName.DataBind();
                myReader.Close();
                ddlClientName.Items.Insert(0, new ListItem("Please select"));

                HiddenField ddlClientNameTextHidden = e.Row.FindControl("ddlClientNameTextHidden") as HiddenField;
                DropDownList ddlClientNameText = e.Row.FindControl("ddlClientNameText") as DropDownList;
                if (ddlClientNameText != null)
                {
                    ddlClientNameText.SelectedValue = ddlClientNameTextHidden.Value;
                }


                DropDownList ddlCategoryDescription = (e.Row.FindControl("ddlCategoryDescriptionText") as DropDownList);

                string sqlQuery2 = @"SELECT [CategoryDescription], [CategoryId] FROM [Expense].[Category]";
                myCommand = new SqlCommand();
                myCommand.Connection = connection;
                myCommand.CommandText = sqlQuery2;
                myCommand.CommandType = CommandType.Text;
                myCommand.CommandTimeout = 60;
                myReader = myCommand.ExecuteReader();
                ddlCategoryDescription.DataSource = myReader;

                ddlCategoryDescription.DataTextField = "CategoryDescription";
                ddlCategoryDescription.DataValueField = "CategoryId";
                ddlCategoryDescription.DataBind();

                HiddenField ddlCategoryDescriptionHidden = e.Row.FindControl("ddlCategoryDescriptionHidden") as HiddenField;
                DropDownList ddlCategoryDescriptonText = e.Row.FindControl("ddlCategoryDescriptionText") as DropDownList;
                if (ddlCategoryDescriptonText != null)
                {
                    ddlCategoryDescriptonText.SelectedValue = ddlCategoryDescriptionHidden.Value;
                }

                ddlCategoryDescriptonText.Items.Insert(0, new ListItem("Please select"));
            }
        }
    }


    protected void continueSaveButton_Click(object sender, EventArgs e)
    {
        try
        {
            string query = "";

            for (int i = 0; i < infoGridView.Rows.Count; i++)
            {

                GridViewRow row = infoGridView.Rows[i];



                DropDownList clientId = ((DropDownList)(row.Cells[6].FindControl("ddlClientNameText")));
                string clientIdDdl = clientId.SelectedValue.ToString();



                DropDownList categoryId = ((DropDownList)(row.Cells[7].FindControl("ddlCategoryDescriptionText")));
                string categoryIdDdl = categoryId.SelectedValue.ToString();


                HiddenField hiddenId = (HiddenField)row.Cells[6].FindControl("HiddenId");
                string hiddenIdText = hiddenId.Value;

                TextBox description2Text = (TextBox)row.Cells[4].FindControl("description2Text");
                string description2 = description2Text.Text;


                using (SqlConnection connection = new SqlConnection(sqlConnString))
                {

                    string queryUpdate = query + "UPDATE [Expense].[Transactions] SET [Description2] = '" + description2 + "' , [ClientId] = '" + clientIdDdl + "', [CategoryId] = '" + categoryIdDdl + "', [Status] = '1'  WHERE  [Id] = '" + hiddenIdText + "' ;\n";

                    connection.Open();
                    SqlCommand myCommand = new SqlCommand();
                    myCommand.Connection = connection;
                    myCommand.CommandText = queryUpdate;
                    myCommand.CommandTimeout = 60;
                    myCommand.ExecuteNonQuery();
                }

                doneMessage2.Text = "Save complete.";
            }
        }
        catch (Exception)
        {
            doneMessage2.Text = "Saved, but batch not complete!";
        }
    }
    public static void SendErrorEmail1(string bodyText, string emailSubject, string userId)
    {

        string to = "mgeppert@ssgstl.com";
        string from = "emailnoreply@summitstrategies.com";
        try
        {
            MailMessage message = new MailMessage(from, to);

            message.Subject = "Error in 'AMEX Card Holder Save = " + emailSubject;
            message.Body = "<strong>User:</strong><br />" + userId + "<br /><br />" + bodyText;
            message.IsBodyHtml = true;
            SmtpClient client = new SmtpClient();
            client.Send(message);

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void continuedSubmitButton_Click(object sender, EventArgs e)
    {
        try
        {
            string query = "";

            for (int i = 0; i < infoGridView.Rows.Count; i++)
            {

                GridViewRow row = infoGridView.Rows[i];

                DropDownList clientId = ((DropDownList)(row.Cells[6].FindControl("ddlClientNameText")));
                string clientIdDdl = clientId.SelectedValue.ToString();



                DropDownList categoryId = ((DropDownList)(row.Cells[7].FindControl("ddlCategoryDescriptionText")));
                string categoryIdDdl = categoryId.SelectedValue.ToString();


                HiddenField hiddenId = (HiddenField)row.Cells[6].FindControl("HiddenId");
                string hiddenIdText = hiddenId.Value;

                TextBox description2Text = (TextBox)row.Cells[4].FindControl("description2Text");
                string description2 = description2Text.Text;



                using (SqlConnection connection = new SqlConnection(sqlConnString))
                {

                    string queryUpdate = query + "UPDATE [Expense].[Transactions] SET [Description2] = '" + description2 + "' , [ClientId] = '" + clientIdDdl + "', [CategoryId] = '" + categoryIdDdl + "',  [Status] = '2'  WHERE  [Id] = '" + hiddenIdText + "' ;\n";

                    connection.Open();
                    SqlCommand myCommand = new SqlCommand();
                    myCommand.Connection = connection;
                    myCommand.CommandText = queryUpdate;
                    myCommand.CommandTimeout = 60;
                    myCommand.ExecuteNonQuery();
                }
                {
                    doneMessage2.Text = "Submission complete.";
                }
            }
        }
        catch (Exception)
        {

            doneMessage2.Text = " All items must be complete in order to submit!";
        }
    }
    public static void SendErrorEmail(string bodyText, string emailSubject, string userId)
    {

        string to = "mgeppert@ssgstl.com";
        string from = "emailnoreply@summitstrategies.com";
        try
        {
            MailMessage message = new MailMessage(from, to);

            message.Subject = "Error in 'AMEX Card Holder Submit = " + emailSubject;
            message.Body = "<strong>User:</strong><br />" + userId + "<br /><br />" + bodyText;
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