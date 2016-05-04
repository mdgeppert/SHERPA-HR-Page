using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;


public partial class Default3 : System.Web.UI.Page
{
    public string pcName = "'sallya'";

    string sqlConnString = @"Data Source=Dev-Intranet;Initial Catalog=DevData;User ID=IntranetUser;Password=IntranetUser";
    private object ClientName;
    private object input;

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
 WHERE [Status] = 1 AND  [UserId] =  " + pcName +"";
            connection.Open();
            SqlCommand myCommand = new SqlCommand();
            myCommand.Connection = connection;
            myCommand.CommandText = sqlQuery;
            myCommand.CommandType = CommandType.Text;
            infoGridView.DataSource = myCommand.ExecuteReader();
            infoGridView.DataBind();
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

            ddlCategoryDescription.Items.Insert(0, new ListItem("Please select"));
        }
    }
}

protected void saveButton_Click(object sender, EventArgs e)
{
    string query = "";

    for (int i = 0; i < infoGridView.Rows.Count; i++)
    {

        GridViewRow row = infoGridView.Rows[i];



        DropDownList clientId = ((DropDownList)(row.Cells[6].FindControl("ddlClientNameText")));
        string clientIdDdl = clientId.SelectedValue.ToString();



        DropDownList categoryId = ((DropDownList)(row.Cells[7].FindControl("ddlCategoryDescriptionText")));
        string categoryIdDdl = categoryId.SelectedValue.ToString();

        TextBox billableText = (TextBox)row.Cells[8].FindControl("tbxBillable");
        string billableTextTbx = billableText.Text;

        HiddenField hiddenId = (HiddenField)row.Cells[6].FindControl("HiddenId");
        string hiddenIdText = hiddenId.Value;

        TextBox description2Text = (TextBox)row.Cells[4].FindControl("description2Text");
        string description2 = description2Text.Text;


        using (SqlConnection connection = new SqlConnection(sqlConnString))
        {

            string queryUpdate = query + "UPDATE [Expense].[Transactions] SET [Description2] = '" + description2 + "' , [ClientId] = '" + clientIdDdl + "', [CategoryId] = '" + categoryIdDdl + "',   [Billable]= '" + billableTextTbx + "', [Status] = '2'  WHERE  [Id] = '" + hiddenIdText + "' ;\n";

            connection.Open();
            SqlCommand myCommand = new SqlCommand();
            myCommand.Connection = connection;
            myCommand.CommandText = queryUpdate;
            myCommand.CommandTimeout = 60;
            myCommand.ExecuteNonQuery();
        }

    }

}
}













