using System;
using System.Collections.Generic;
using System.Linq;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class EditEvent : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Page.Request.QueryString["id"] != null)
        {
            string eventid = Page.Request.QueryString["id"];
            txtEID.Value = @eventid;
            //idMsg.Text = "Event Selected: " + @eventid;

            if (!IsPostBack)
            {

                string stmt = "select * from events where eventid = @eventID";

                using (SqlConnection thisConnection = new SqlConnection("Data Source=AUSQL;Initial Catalog=EventAttend;Persist Security Info=True;User ID=web_user;Password=w3b_us3r2010;"))
                {
                    using (SqlCommand cmd = new SqlCommand(stmt, thisConnection))
                    {
                        // Create the parameter objects as specific as possible.
                        cmd.Parameters.Add("@eventID", System.Data.SqlDbType.Int);

                        // Add the parameter values.  Validation should have already happened.
                        cmd.Parameters["@eventID"].Value = eventid;

                        thisConnection.Open();
                        SqlDataReader reader = cmd.ExecuteReader();
                        if (reader.Read())
                        {
                            txtTitle.Text = reader["eventTitle"].ToString();
                            txtEventLoc.Text = reader["eventLoc"].ToString();
                            txtDesc.Text = reader["eventDesc"].ToString();
                            txtStartDateTime.Text = reader["startdatetime"].ToString();
                            txtEndDateTime.Text = reader["enddatetime"].ToString();
                            txtHost.SelectedValue = reader["hostid"].ToString();
                            txtPresenter.Text = reader["eventpresenter"].ToString();
                            txtRequestedBy.Text = reader["requestedby"].ToString();
                        }


                        // Call Close when done reading.
                        reader.Close();
                        thisConnection.Close();
                    }
                }
            }
            else
            {
                //idMsg.Text = "No Event Selected";
            }

        }
    }
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
                    dateMsg.Text = "";
                    string stmt = "select count(*) from events where eventid = @eventID";

                    using (SqlConnection conn = new SqlConnection("Data Source=AUSQL;Initial Catalog=EventAttend;Persist Security Info=True;User ID=web_user;Password=w3b_us3r2010"))
                    {
                        string eventid = Page.Request.QueryString["id"];
                        //idMsg.Text = "Event Updating Selected: " + eventid;
                        using (SqlCommand cmd = new SqlCommand(stmt, conn))
                        {
                            // Create the parameter objects as specific as possible.
                            cmd.Parameters.Add("@eventID", System.Data.SqlDbType.Int);

                            // Add the parameter values.  Validation should have already happened.
                            cmd.Parameters["@eventID"].Value = eventid;

                            conn.Open();
                            SqlDataReader reader = cmd.ExecuteReader();
                            if (reader.HasRows == true)
                            {
                                reader.Close();
                                conn.Close();
                                string eventid2 = Page.Request.QueryString["id"];
                                //idMsg.Text = "Now update " + eventid2; 
                                //Build the query statement using parameterized query.
                                string sql2 = "UPDATE [EventAttend].[dbo].[events] set [eventTitle] = @txtEventTitle,[eventDesc] = @txtEventDesc,[eventLoc] = @txtEventLoc,[startDateTime] = @txtStartDateTime,[endDateTime] = @txtEndDateTime,[hostID] = @txtHost,[eventPresenter] = @txtPresenter,[requestedBy] = @txtRequestedBy,[revisedById] = '1',[revisionDateTime] = getDate() where [eventid] = @eventID";
                                conn.Open();
                                using (SqlCommand cmd2 = new SqlCommand(sql2, conn))
                                {
                                    // cmd2.Parameters.Add has been depreciated. I updated it to addwithvalues.
                                    cmd2.Parameters.AddWithValue("@eventID", txtEID.Value);
                                    cmd2.Parameters.AddWithValue("@txtEventTitle", txtTitle.Text);
                                    cmd2.Parameters.AddWithValue("@txtEventDesc", txtDesc.Text);
                                    cmd2.Parameters.AddWithValue("@txtEventLoc", txtEventLoc.Text);
                                    cmd2.Parameters.AddWithValue("@txtStartDateTime", txtStartDateTime.Text);
                                    cmd2.Parameters.AddWithValue("@txtEndDateTime", txtEndDateTime.Text);
                                    cmd2.Parameters.AddWithValue("@txtHost", txtHost.Text);
                                    cmd2.Parameters.AddWithValue("@txtPresenter", txtPresenter.Text);
                                    cmd2.Parameters.AddWithValue("@txtRequestedBy", txtRequestedBy.Text);
                                    cmd2.Parameters.AddWithValue("@txtCreditType", txtCreditType.Text);
                                    cmd2.Parameters.AddWithValue("@txtEventCredits", txtEventCredits.Text);


                                    // Create the parameter objects as specific as possible.
                                    //cmd2.Parameters.Add("@eventID", System.Data.SqlDbType.VarChar, 25);
                                    //cmd2.Parameters.Add("@txtEventTitle", System.Data.SqlDbType.VarChar, 255);
                                    //cmd2.Parameters.Add("@txtEventDesc", System.Data.SqlDbType.Text);
                                    //cmd2.Parameters.Add("@txtEventLoc", System.Data.SqlDbType.VarChar, 255);
                                    //cmd2.Parameters.Add("@txtStartDateTime", System.Data.SqlDbType.DateTime);
                                    //cmd2.Parameters.Add("@txtEndDateTime", System.Data.SqlDbType.DateTime);
                                    //cmd2.Parameters.Add("@txtHost", System.Data.SqlDbType.Int, 3);
                                    //cmd2.Parameters.Add("@txtPresenter", System.Data.SqlDbType.VarChar, 255);
                                    //cmd2.Parameters.Add("@txtRequestedBy", System.Data.SqlDbType.VarChar, 100);
                                    //cmd2.Parameters.Add("@txtCreditType", System.Data.SqlDbType.Int, 2);
                                    //cmd2.Parameters.Add("@txtEventCredits", System.Data.SqlDbType.Int, 3);

                                    // Add the parameter values.  Validation should have already happened.
                                    //cmd2.Parameters["@eventID"].Value = txtEID.Value;
                                    //cmd2.Parameters["@txtEventTitle"].Value = txtTitle.Text;
                                    //cmd2.Parameters["@txtEventDesc"].Value = txtDesc.Text;
                                    //cmd2.Parameters["@txtEventLoc"].Value = txtEventLoc.Text;
                                    //cmd2.Parameters["@txtStartDateTime"].Value = txtStartDateTime.Text;
                                    //cmd2.Parameters["@txtEndDateTime"].Value = txtEndDateTime.Text;
                                    //cmd2.Parameters["@txtHost"].Value = txtHost.Text;
                                    //cmd2.Parameters["@txtPresenter"].Value = txtPresenter.Text;
                                    //cmd2.Parameters["@txtRequestedBy"].Value = txtRequestedBy.Text;
                                    //cmd2.Parameters["@txtCreditType"].Value = txtCreditType.Text;
                                    //cmd2.Parameters["@txtEventCredits"].Value = txtEventCredits.Text;

                                                                       
                                    try
                                    {
                                        //successMsg.Text = "Found. Now update me.";
                                        int inserter = cmd2.ExecuteNonQuery();

                                        //successMsg.Text = "Found. Past NonQuery.";
                                        if (inserter != 0)
                                        {
                                            successMsg.Text = "Event updated: " + txtTitle.Text + " (" + DateTime.Now.ToString("MM-dd-yyyy h:mm:ss tt") + ")";
                                            //ClearTextBoxes(this);
                                        }
                                        else
                                        {
                                            successMsg.Text = "Did not update.";
                                        }

                                    }
                                    catch (SqlException sx)
                                    {
                                        // Handle exceptions before moving on.
                                    }
                                    finally
                                    {
                                        conn.Close();
                                    }
                                }
                                
                            }
                            else
                            {
                                idMsg.Text = "Event " + eventid + " not found.";
                            }
                        }
                    }
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
}



//string stmt = "SELECT * FROM dbo.events where eventid = @txtEventID";
////int count = 0;

//using (SqlConnection thisConnection = new SqlConnection("Data Source=AUSQL;Initial Catalog=EventAttend;Persist Security Info=True;User ID=web_user;Password=w3b_us3r2010"))
//{
//    using (SqlCommand cmdCount = new SqlCommand(stmt, thisConnection))
//    {
//        // Create the parameter objects as specific as possible.
//        cmdCount.Parameters.Add("@txtEventID", System.Data.SqlDbType.Int);

//        // Add the parameter values.  Validation should have already happened.
//        cmdCount.Parameters["@txtEventID"].Value = txtEID.Value;

//        thisConnection.Open();
//        using (SqlDataReader c = cmdCount.ExecuteReader())
//        if (c.HasRows)
//        {
//            existsMsg.Text = "Failed to update. No event with that ID exists in the database.";
//        }
//        else
//        {
//            existsMsg.Text = "";
//            successMsg.Text = "Event added to the database successfully.";

//            //Build the query statement using parameterized query.
//            string sql2 = "UPDATE [EventAttend].[dbo].[events] set [eventTitle] = @txtEventTitle,[eventDesc] = @txtEventDesc,[eventLoc] = @txtEventLoc,[startDateTime] = @txtStartDateTime,[endDateTime] = @txtEndDateTime,[hostID] = @txtHost,[eventPresenter] = @txtPresenter,[requestedBy] = @txtRequestedBy,[revisedById] = '1',[revisionDateTime] = getDate() where [eventid] = @txtEventID or eventid = 99999";

//            using (SqlCommand cmd2 = new SqlCommand(sql2, thisConnection))
//            {
//                // Create the parameter objects as specific as possible.
//                cmd2.Parameters.Add("@txtEventID", System.Data.SqlDbType.Int);
//                cmd2.Parameters.Add("@txtEventTitle", System.Data.SqlDbType.VarChar, 255);
//                cmd2.Parameters.Add("@txtEventDesc", System.Data.SqlDbType.Text);
//                cmd2.Parameters.Add("@txtEventLoc", System.Data.SqlDbType.VarChar, 255);
//                cmd2.Parameters.Add("@txtStartDateTime", System.Data.SqlDbType.DateTime);
//                cmd2.Parameters.Add("@txtEndDateTime", System.Data.SqlDbType.DateTime);
//                cmd2.Parameters.Add("@txtHost", System.Data.SqlDbType.Int, 3);
//                cmd2.Parameters.Add("@txtPresenter", System.Data.SqlDbType.VarChar, 255);
//                cmd2.Parameters.Add("@txtRequestedBy", System.Data.SqlDbType.VarChar, 100);
//                cmd2.Parameters.Add("@txtCreditType", System.Data.SqlDbType.Int, 2);
//                cmd2.Parameters.Add("@txtEventCredits", System.Data.SqlDbType.Int, 3);

//                // Add the parameter values.  Validation should have already happened.
//                cmd2.Parameters["@txtEventID"].Value = txtEID.Value;
//                cmd2.Parameters["@txtEventTitle"].Value = txtTitle.Text;
//                cmd2.Parameters["@txtEventDesc"].Value = txtDesc.Text;
//                cmd2.Parameters["@txtEventLoc"].Value = txtEventLoc.Text;
//                cmd2.Parameters["@txtStartDateTime"].Value = txtStartDateTime.Text;
//                cmd2.Parameters["@txtEndDateTime"].Value = txtEndDateTime.Text;
//                cmd2.Parameters["@txtHost"].Value = txtHost.Text;
//                cmd2.Parameters["@txtPresenter"].Value = txtPresenter.Text;
//                cmd2.Parameters["@txtRequestedBy"].Value = txtRequestedBy.Text;
//                cmd2.Parameters["@txtCreditType"].Value = txtCreditType.Text;
//                cmd2.Parameters["@txtEventCredits"].Value = txtEventCredits.Text;
//                //cmd2.Connection = con;

//                try
//                {
//                    int inserter = cmd2.ExecuteNonQuery();

//                    if (inserter == 1)
//                    {
//                        retMessage = "true";
//                        ClearTextBoxes(this);
//                    }
//                    else
//                    {
//                        retMessage = "false";
//                    }

//                }
//                catch (SqlException sx)
//                {
//                    // Handle exceptions before moving on.
//                }
//                finally
//                {
//                    //con.Close();
//                }
//            }
//        }

//    }
//}
////Console.WriteLine(count);