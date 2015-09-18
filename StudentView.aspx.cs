using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

public partial class StudentView : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string DateNow = DateTime.Now.ToString();
        DateTimeNow.Text = DateNow;
        if (System.Web.HttpContext.Current.User != null && System.Web.HttpContext.Current.User.Identity is FormsIdentity)
        {
            //Response.Write("Username: " + Server.HtmlEncode(User.Identity.Name));

            FormsIdentity id = (FormsIdentity)User.Identity;
            FormsAuthenticationTicket ticket = id.Ticket;

            //string count = "";
            string connstring1 = "Data Source=AUSQL;Initial Catalog=EventAttend;Persist Security Info=True;User ID=web_user;Password=w3b_us3r2010";
            using (SqlConnection con1 = new SqlConnection(connstring1))
            {
                string query = "select	top 1 p.people_id, p.last_name, p.first_name, p.middle_name, coalesce(p.nickname,'') as nickname, coalesce(convert(varchar(5),m.manLevelID),'') as mLevelID, coalesce(cm.mlTitle,'') as ManageLevel from	aupcstor.campus6_train.dbo.personuser pu  inner join aupcstor.campus6_train.dbo.people as p  on p.personid = pu.personid  left outer join ausql.eventattend.dbo.management as m on m.peopleid = p.people_id and m.status = 'a' and m.manLevelID IN (1,3) left outer join ausql.eventattend.dbo.code_managementlevel as cm on cm.manLevelID = m.manLevelID where	pu.username = @username";
                using (SqlCommand cmd1 = new SqlCommand(query, con1))
                {
                    cmd1.Parameters.AddWithValue("@username", ticket.Name);
                    con1.Open();

                    SqlDataReader reader = cmd1.ExecuteReader();
                    if (reader != null && reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            Session["pid"] = (string)reader["people_id"];
                            string fullname = (string)reader["last_name"] + ", " + (string)reader["first_name"] + " " + (string)reader["middle_name"];
                            string nname = "";
                            string mlevel = (string)reader["ManageLevel"];
                            string mlevelid = (string)reader["mLevelID"];
                            if (reader["nickname"] != null && (string)reader["nickname"] != "")
                            {
                                nname = " [" + (string)reader["nickname"] + "]";
                            }
                            userPID.Text = (String)Session["pid"];
                            userFullName.Text = fullname + nname;
                            userManageLevel.Text = "(" + mlevel + ")"; 
                        }
                    }
                    else
                    {
                        Server.Transfer("Errorpage.aspx");
                    }
                    reader.Close();
                }
                string queryAttendance = " " +
                        "select	distinct e.eventid   " + 
						"		, e.eventTitle   " + 
						"		, e.startdatetime   " + 
						"		, e.enddatetime   " + 
						"		, coalesce((select	convert(varchar(10),count(distinct a.eventid)) as totct   " + 
						"				 from	ausql.eventattend.dbo.attendance as a   " + 
						"						inner join [events] as e   " + 
						"							on e.eventid = a.eventid   " + 
						"       					and e.[status] = 'a'   " + 
						"							and e.cancelled = 'N'   " + 
						"				 where	a.scannedid = @pid),'') as ct " +   
						"		, coalesce((select convert(varchar(10),ar.eventsAttended) from ausql.eventattend.dbo.archiveRecords as ar where ar.peopleid = @pid),'0') as ArchiveCt  " + 
						"		, convert(varchar(10),coalesce((select	count(distinct a.eventid) as totct   " + 
						"				from	ausql.eventattend.dbo.attendance as a   " + 
						"						inner join ausql.eventattend.dbo.[events] as e   " + 
						"						on e.eventid = a.eventid   " + 
						"							and e.[status] = 'a'   " + 
						"							and e.cancelled = 'N'   " + 
						"               where	a.scannedid = @pid),'') +   " + 
						"						coalesce((select convert(varchar(10),ar.eventsAttended) from ausql.eventattend.dbo.archiveRecords as ar where ar.peopleid = @pid),'0')) as TotalCount   " + 
						"from	ausql.eventattend.dbo.[events] as e   " + 
						"		left outer join ausql.eventattend.dbo.attendance as a   " + 
						"			on a.eventid = e.eventid   " + 
						"			and a.scannedid = @pid " + 
						"where	e.status = 'a'  " + 
						"		and cancelled = 'N'";
                using (SqlCommand cmdAttendance = new SqlCommand(queryAttendance, con1))
                {
                    cmdAttendance.Parameters.AddWithValue("@pid", Session["pid"]);
                    SqlDataReader readerAttendance = cmdAttendance.ExecuteReader();
                    if (readerAttendance != null && readerAttendance.HasRows)
                    {
                        while (readerAttendance.Read())
                        {
                            string numScanned = (string)readerAttendance["ct"];
                            totalScanned.Text = numScanned;
                            string numArchived = (string)readerAttendance["ArchiveCt"];
                            totalArchive.Text = numArchived;
                            string numTotAttended = (string)readerAttendance["TotalCount"];
                            totalAttended.Text = numTotAttended;
                        }
                    }
                }
                con1.Close();
            }
        }
        else
        {
            Response.Write("<p/>Not Authenticated");
        }
    }


    protected void logoutButton_Click(object sender, EventArgs e)
    {
        FormsAuthentication.SignOut();
        Response.Redirect(FormsAuthentication.LoginUrl, false);
    }
}