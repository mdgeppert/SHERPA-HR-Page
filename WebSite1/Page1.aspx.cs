using System;
using System.Data;
using Microsoft.VisualBasic.FileIO;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{

    string sqlConnString = @"Data Source=Dev-Intranet;Initial Catalog=DevData;User ID=IntranetUser;Password=IntranetUser";
    public static DataTable processCSVFile(string filePath)
    {
        DataTable csvData = new DataTable();
        using (TextFieldParser csvReader = new TextFieldParser(filePath))
        {
            csvReader.SetDelimiters(new string[] { "," });
            csvReader.HasFieldsEnclosedInQuotes = true;
            string[] colFields = csvReader.ReadFields();
            foreach (string column in colFields)
            {
                DataColumn datecolumn = new DataColumn(column);
                datecolumn.AllowDBNull = true;
                csvData.Columns.Add(datecolumn);
            }

            while (!csvReader.EndOfData)
            {
                string[] fieldData = csvReader.ReadFields();
                //Making empty value as null
                for (int i = 0; i < fieldData.Length; i++)
                {
                    if (fieldData[i] == "")
                    {
                        fieldData[i] = null;
                    }

                }
                csvData.Rows.Add(fieldData);
            }
        }

        return csvData;
    }

    string savePath = "";
    //save csv file to server for processing
    public void uploadButton_Click(object sender, EventArgs e)
    {

        string saveDir = @"/Uploads\";
        string appPath = Request.PhysicalApplicationPath;


        if (openFileDialog1.HasFile)
        {
            savePath = appPath + saveDir +
                 Server.HtmlEncode(openFileDialog1.FileName);
            openFileDialog1.SaveAs(savePath);
            savePathHiddenField1.Value = savePath;
        }
        string cardNumber = "";
        string user = "";
        string closeDate = "";
        string chargeDate = "";
        string description = "";
        string description2 = "";
        string amount = "";
        string indicator = "";
        string airPassenger = "";
        string rocID = "";
        string employeeName = "";



        // int i = 0;


        DataTable csvData = processCSVFile(savePathHiddenField1.Value);

        {
            foreach (DataRow row in csvData.Rows)
            {
                airPassenger = row["AIR_PASSENGER_NAME"].ToString().Trim();
                indicator = row["DB\\CR_INDICATOR"].ToString().Trim();
                closeDate = row["BILLING_DATE"].ToString().Trim();
                chargeDate = row["DATE_OF_CHARGE"].ToString().Trim();
                description = row["CHARGE_DESCRIPTION_LINE1"].ToString().Replace("'", "''").Trim();
                description2 = row["CHARGE_DESCRIPTION_LINE2"].ToString().Replace("'", "''").Trim();
                amount = row["BILLING_AMOUNT"].ToString().Trim();
                cardNumber = row["CARDMEMBER_ACCOUNT_NUMBER"].ToString().Trim();
                rocID = row["ROC_ID"].ToString().Trim();
                employeeName = row["CARDMEMBER_NAME"].ToString().Trim();
                user = GetUserId(cardNumber);

                //if (i == 612) { break; }

                if (indicator == "1")
                {
                    if (airPassenger != "")
                    {
                        description2 = "Passenger: " + airPassenger + "/ ID " + rocID;
                    }

                    using (SqlConnection connection = new SqlConnection(sqlConnString))
                    {
                        string sqlQuery = @"insert into Expense.Transactions (EmployeeName, UserId, CloseDate, ChargeDate, Description, Description2, Amount, Status) Values('" + employeeName + "' , '" + user + "' , '" + closeDate + "' , '" + chargeDate + "' ,'" + description + "' , '" + description2 + "' , '" + amount + "', '1')";
                        connection.Open();
                        SqlCommand myCommand = new SqlCommand();
                        myCommand.Connection = connection;
                        myCommand.CommandText = sqlQuery;
                        myCommand.CommandTimeout = 60;
                        myCommand.ExecuteNonQuery();
                    }
                    // i = i + 1;
                }
            }

        }
        populateView();

    }
    protected void Page_Load(object sender, EventArgs e)
    {
        populateView();

    }
    private void populateView()
    {
        using (SqlConnection connection = new SqlConnection(sqlConnString))
        {
            string sqlQuery = @"SELECT  [EmployeeName], [UserId], [CloseDate], [ChargeDate],  [Description], [Description2], [Amount], [Status]  FROM [DevData].[Expense].[Transactions] WHERE [Status] = '1' ";
            connection.Open();
            SqlCommand myCommand = new SqlCommand();
            myCommand.Connection = connection;
            myCommand.CommandText = sqlQuery;
            myCommand.CommandType = CommandType.Text;
            myCommand.CommandTimeout = 60;
            infoGridView.DataSource = myCommand.ExecuteReader();
            infoGridView.DataBind();

        }
    }


    public string GetUserId(string cardNumber)
    {
        string userId = "";
        using (SqlConnection connection = new SqlConnection(sqlConnString))
        {

            string sqlQuery = @"SELECT UserId FROM [DevData].[Expense].[PeachtreeUser] where Card = '" + cardNumber + "'";
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
                    userId = reader["UserId"].ToString();
                }
            }
        }
        return userId;
    }
}
    //public void splitButton_Click(object sender, EventArgs e)
    //{
        



//    protected void infoGridView_SelectedIndexChanged(object sender, EventArgs e)
//    {

//    }
////}

