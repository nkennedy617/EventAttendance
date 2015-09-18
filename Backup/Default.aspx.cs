using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //attempt 1
        //this.txtStudentID.Focus();

        //attempt2
        //string jsCode = "<script language=javascript>document.getElementById('<%= txtStudentID.ClientID%>').focus();</script>";

        //ClientScript.RegisterClientScriptBlock(GetType(), "txtStudentID", jsCode, false);

        //attempt3
        //Page.SetFocus(txtStudentID);


        if (String.IsNullOrEmpty(Page.Request.QueryString["id"]))
        {
            MultiView1.SetActiveView(View1);
        }
        else
        {
            gvData.DataBind(); 
            MultiView1.SetActiveView(View2);
        }
    }


    protected void txtStudentID_TextChanged(object sender, EventArgs e)
    {
        if (Page.Request.QueryString["id"] != null)
        {

            InsertData(txtStudentID.Text, Page.Request.QueryString["id"]);

            lblmsg.Text = "Data Inserted Successfully!";

            this.txtStudentID.Text = "";

            this.txtStudentID.Focus();
        } 
        else 
        {

        }

    }

    [WebMethod]
    public static string InsertData(string studentID, string eventID)
    {
        string retMessage = string.Empty;
        string connectionString = "Data Source=AUSQL;Initial Catalog=EventAttend;Persist Security Info=True;User ID=web_user;Password=w3b_us3r2010";
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            string query = "insert into attendance(eventId,scannedID,scanDateTime) values(@EventID,left(right(@StudentID,10),9),getdate())";
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                con.Open();
                cmd.Parameters.Add("@EventID", eventID);
                cmd.Parameters.Add("@StudentID", studentID);

                int affectedRow = cmd.ExecuteNonQuery();
                if (affectedRow == 1)
                {
                    retMessage = "true";
                }
                else
                {
                    retMessage = "false";
                }
            }
            return retMessage;
        }
    }


}