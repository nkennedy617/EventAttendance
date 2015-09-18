using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;
using System.Net.Mail;


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
                string query = "select	top 1 p.people_id, p.last_name, p.first_name, p.middle_name, coalesce(p.nickname,'') as nickname, cm.mlTitle as ManageLevel from	aupcstor.campus6_train.dbo.personuser pu  inner join aupcstor.campus6_train.dbo.people as p  on p.personid = pu.personid  inner join ausql.eventattend.dbo.management as m on m.peopleid = p.people_id and m.status = 'a' and m.manLevelID IN (1,3) inner join ausql.eventattend.dbo.code_managementlevel as cm on cm.manLevelID = m.manLevelID where	pu.username = @username";
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
                            if (reader["nickname"] != null && (string)reader["nickname"] != "")
                            {
                                nname = " [" + (string)reader["nickname"] + "]";
                            }
                            userPID.Text = (string)reader["People_ID"];
                            userFullName.Text = fullname + nname;
                            userManageLevel.Text = "(" + reader["ManageLevel"] + ")";
                        }
                    }
                    else
                    {
                        Server.Transfer("Errorpage.aspx");
                    }
                }
            }

            //Response.Write("<p/>TicketName: " + ticket.Name);
            //Response.Write("<br/>Cookie Path: " + ticket.CookiePath);
            //Response.Write("<br/>Ticket Expiration: " +
            //                ticket.Expiration.ToString());
            //Response.Write("<br/>Expired: " + ticket.Expired.ToString());
            //Response.Write("<br/>Persistent: " + ticket.IsPersistent.ToString());
            //Response.Write("<br/>IssueDate: " + ticket.IssueDate.ToString());
            //Response.Write("<br/>UserData: " + ticket.UserData);
            //Response.Write("<br/>Version: " + ticket.Version.ToString());
        }
        else
        {
            Response.Write("<p/>Not Authenticated");
        }
    }


    protected void txtTitle_TextChanged(object sender, EventArgs e)
    {
        //InsertData(txtStudentID.Text, Page.Request.QueryString["id"]);

        //lblmsg.Text = "Data Inserted Successfully!";

        //this.txtStudentID.Text = "";

        //this.txtStudentID.Focus();

    }

    [WebMethod]    

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        DateTime dateTime1;
        DateTime dateTime2;
        string retMessage = string.Empty;
        if (DateTime.TryParse(txtStartDateTime.Text, out dateTime1) && DateTime.TryParse(txtEndDateTime.Text, out dateTime2))
        {
            if (dateTime1 < dateTime2)
            {
                {

                    string stmt = "SELECT COUNT(*) FROM dbo.events where eventtitle = @txtEventTitle and eventLoc = @txtEventLoc and startDateTime = @txtStartDateTime and endDateTime = @txtEndDateTime";
                    int count = 0;

                    using (SqlConnection thisConnection = new SqlConnection("Data Source=AUSQL;Initial Catalog=EventAttend;Persist Security Info=True;User ID=web_user;Password=w3b_us3r2010"))
                    {
                        using (SqlCommand cmdCount = new SqlCommand(stmt, thisConnection))
                        {
                            // Create the parameter objects as specific as possible.
                            cmdCount.Parameters.Add("@txtEventTitle", System.Data.SqlDbType.VarChar, 255);
                            cmdCount.Parameters.Add("@txtEventLoc", System.Data.SqlDbType.VarChar, 255);
                            cmdCount.Parameters.Add("@txtStartDateTime", System.Data.SqlDbType.DateTime);
                            cmdCount.Parameters.Add("@txtEndDateTime", System.Data.SqlDbType.DateTime);

                            // Add the parameter values.  Validation should have already happened.
                            cmdCount.Parameters["@txtEventTitle"].Value = txtTitle.Text;
                            cmdCount.Parameters["@txtEventLoc"].Value = txtEventLoc.Text;
                            cmdCount.Parameters["@txtStartDateTime"].Value = txtStartDateTime.Text;
                            cmdCount.Parameters["@txtEndDateTime"].Value = txtEndDateTime.Text;

                            thisConnection.Open();
                            count = (int)cmdCount.ExecuteScalar();
                            if (count > 0)
                            {
                                existsMsg.Text = "Failed to add. Event already exists in the database."; 
                            }
                            else
                            {
                                existsMsg.Text = "";
                                successMsg.Text = "Event added to the database successfully.";
                                
                                //Build the query statement using parameterized query.
                                string sql2 = "INSERT INTO [EventAttend].[dbo].[events] ([eventTitle],[eventDesc],[eventLoc],[startDateTime],[endDateTime],[hostID],[eventPresenter],[requestedBy],[status],[createdByID],[createDateTime],[revisedById],[revisionDateTime],[approvedBy]) VALUES(@txtEventTitle,@txtEventDesc,@txtEventLoc,@txtStartDateTime,@txtEndDateTime,@txtHost,@txtPresenter,@txtRequestedBy,'A','1',getDate(),'1',getDate(),7)";

                                using (SqlCommand cmd2 = new SqlCommand(sql2, thisConnection))
                                {
                                    // Create the parameter objects as specific as possible.
                                    cmd2.Parameters.Add("@txtEventTitle", System.Data.SqlDbType.VarChar, 255);
                                    cmd2.Parameters.Add("@txtEventDesc", System.Data.SqlDbType.Text);
                                    cmd2.Parameters.Add("@txtEventLoc", System.Data.SqlDbType.VarChar, 255);
                                    cmd2.Parameters.Add("@txtStartDateTime", System.Data.SqlDbType.DateTime);
                                    cmd2.Parameters.Add("@txtEndDateTime", System.Data.SqlDbType.DateTime);
                                    cmd2.Parameters.Add("@txtHost", System.Data.SqlDbType.Int, 3);
                                    cmd2.Parameters.Add("@txtPresenter", System.Data.SqlDbType.VarChar, 255);
                                    cmd2.Parameters.Add("@txtRequestedBy", System.Data.SqlDbType.VarChar, 100);
                                    cmd2.Parameters.Add("@txtCreditType", System.Data.SqlDbType.Int, 2);
                                    cmd2.Parameters.Add("@txtEventCredits", System.Data.SqlDbType.Int, 3);

                                    // Add the parameter values.  Validation should have already happened.
                                    cmd2.Parameters["@txtEventTitle"].Value = txtTitle.Text;
                                    cmd2.Parameters["@txtEventDesc"].Value = txtDesc.Text;
                                    cmd2.Parameters["@txtEventLoc"].Value = txtEventLoc.Text;
                                    cmd2.Parameters["@txtStartDateTime"].Value = txtStartDateTime.Text;
                                    cmd2.Parameters["@txtEndDateTime"].Value = txtEndDateTime.Text;
                                    cmd2.Parameters["@txtHost"].Value = txtHost.Text;
                                    cmd2.Parameters["@txtPresenter"].Value = txtPresenter.Text;
                                    cmd2.Parameters["@txtRequestedBy"].Value = txtRequestedBy.Text;
                                    cmd2.Parameters["@txtCreditType"].Value = txtCreditType.Text;
                                    cmd2.Parameters["@txtEventCredits"].Value = txtEventCredits.Text;
                                    //cmd2.Connection = con;

                                    try
                                    {
                                        int inserter = cmd2.ExecuteNonQuery();

                                        if (inserter == 1)
                                        {
                                            retMessage = "true";
                                            ClearTextBoxes(this);
                                        }
                                        else
                                        {
                                            retMessage = "false";
                                        }
                                        
                                    }
                                    catch (SqlException sx)
                                    {
                                        // Handle exceptions before moving on.
                                    }
                                    finally
                                    {
                                        //con.Close();
                                    }
                                }
                            }

                        }
                    }
                    Console.WriteLine(count);                    
                }  
            }
            else
            {
                dateMsg.Text = "Abort.  Start Date Time can not be after or the same as End Date Time.";
            } 
        }
        else
        {
            dateMsg.Text = "Date and Time formats are Invalid";
        }
       //Send Email on button click
       System.Net.Mail.SmtpClient client = new System.Net.Mail.SmtpClient("mail.andersonuniversity.edu");
       MailMessage Message = new MailMessage();
       Message.From = new MailAddress("mcoco103@andersonuniversity.edu");
       Message.To.Add("mcoco@andersonuniversity.edu");
       Message.Subject ="Event approval needed";
       Message.Body = "<h2><b>An event has been created that needs attention</b></h2> <hr><h3>The event</h3>" + txtTitle.Text + "<h3>Has been created by</h3>" + txtRequestedBy.Text;
       Message.IsBodyHtml = true;
       client.Credentials = new System.Net.NetworkCredential("mcoco103@andersonuniversity.edu", "MYdog7!");
       client.Port = System.Convert.ToInt32(25);
       
       client.Send(Message);
     
    }
    protected void btnClear_Click(object sender, EventArgs e)
    {
        ClearTextBoxes(this);
    }
    public void ClearTextBoxes(Control parent)
    {
        foreach (Control x in parent.Controls)
        {
            if ((x.GetType() == typeof(TextBox)))
            {
                ((TextBox)(x)).Text = "";
            }

            if (x.HasControls())
            {
                ClearTextBoxes(x);
            }
        }
    }



    protected void logoutButton_Click(object sender, EventArgs e)
    {
        FormsAuthentication.SignOut();
        Response.Redirect(FormsAuthentication.LoginUrl, false);
    }
}