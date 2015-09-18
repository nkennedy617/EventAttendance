using System;
using System.Data;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.Security;

public partial class Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (System.Web.HttpContext.Current.User != null && System.Web.HttpContext.Current.User.Identity is FormsIdentity)
        {
            //Response.Write("Hello, " + Server.HtmlEncode(User.Identity.Name));

            //FormsIdentity id = (FormsIdentity)User.Identity;
            //FormsAuthenticationTicket ticket = id.Ticket;

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
            Authenticated.Text = "Not Authenticated";
        }
    }
}