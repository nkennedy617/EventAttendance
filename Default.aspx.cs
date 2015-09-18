using System;
using System.Collections.Generic;
//using System.Linq;
using System.Data.SqlClient;
using System.Web;
using System.Web.Security;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (String.IsNullOrEmpty(Page.Request.QueryString["id"]))
        {
            MultiView1.SetActiveView(View1);
        }
        else
        {
            gvData.DataBind(); 
            MultiView1.SetActiveView(View2);
        }
        if (System.Web.HttpContext.Current.User != null && System.Web.HttpContext.Current.User.Identity is FormsIdentity)
        {
            //Response.Write("Username: " + Server.HtmlEncode(User.Identity.Name));

            FormsIdentity id = (FormsIdentity)User.Identity;
            FormsAuthenticationTicket ticket = id.Ticket;

            //string count = "";
            string connstring1 = "Data Source=AUSQL;Initial Catalog=EventAttend;Persist Security Info=True;User ID=web_user;Password=w3b_us3r2010";
            using (SqlConnection con1 = new SqlConnection(connstring1))
            {
                string query = "select	top 1 p.people_id, p.last_name, p.first_name, p.middle_name, coalesce(p.nickname,'') as nickname, m.manLevelID, cm.mlTitle as ManageLevel from	aupcstor.campus6_train.dbo.personuser pu  inner join aupcstor.campus6_train.dbo.people as p  on p.personid = pu.personid  inner join ausql.eventattend.dbo.management as m on m.peopleid = p.people_id and m.status = 'a' and m.manLevelID IN (1,2,3) inner join ausql.eventattend.dbo.code_managementlevel as cm on cm.manLevelID = m.manLevelID where	pu.username = @username";
                using (SqlCommand cmd1 = new SqlCommand(query, con1))
                {
                    cmd1.Parameters.AddWithValue("@username", ticket.Name);
                    con1.Open();

                    SqlDataReader reader = cmd1.ExecuteReader();
                    if (reader != null && reader.HasRows)
                    {   
                        while (reader.Read())
                        {
                            string fullname = reader["last_name"] + ", " + reader["first_name"] + " " + reader["middle_name"];
                            string nname = "";
                            string pid = (string)reader["People_ID"];
                            Session["pid"] = pid;
                            Session["fname"] = reader["first_name"];
                            Session["lname"] = reader["last_name"];
                            Session["mname"] = reader["middle_name"];
                            if (reader["nickname"] != null && (string)reader["nickname"] != "")
                            {
                                nname = " [" + (string)reader["nickname"] + "]";
                            }
                            userPID.Text = pid;
                            userFullName.Text = fullname + nname;
                            userManageLevel.Text = "(" + reader["ManageLevel"] + ")";
                            if ((int)reader["manLevelID"] != 2)
                            {
                                if (Page.Request.QueryString["id"] != null)
                                {} else {
                                    MultiView1.SetActiveView(View3);
                                }
                            }
                        }
                    }
                    else
                    {
                        Server.Transfer("StudentView.aspx");
                    }
                }
            }
        }
        else
        {
            Response.Write("<p/>Not Authenticated");
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




    protected void logoutButton_Click(object sender, EventArgs e)
    {
        FormsAuthentication.SignOut();
        Response.Redirect(FormsAuthentication.LoginUrl, false);
    }
}