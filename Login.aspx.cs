using System;
using System.Data;
using System.DirectoryServices;
using System.DirectoryServices.AccountManagement;
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
            Session["fullName"] = "N/A";
            Session["empID"] = "N/A";

        

            //using (PrincipalContext context = new PrincipalContext(ContextType.Domain))
            //{
            //    using (UserPrincipal user
            //            = UserPrincipal.FindByIdentity(context,
            //                                            User.Identity.Name))
            //    {
            //        if (user != null)
            //        {
            //            Session["fullName"] = user.DisplayName;
            //            Session["empID"] = user.EmployeeId;
            //        }
            //    }
            //}
            
            //Response.Write("Hello, " + Server.HtmlEncode(User.Identity.Name));

            FormsIdentity id = (FormsIdentity)User.Identity;
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
            //string Session["empid"] = (FormsIdentity)User.Identity.;

          

        }
        else
        {
            Authenticated.Text = "Not Authenticated";
        }

        

}private string GetUserIdFromDisplayName(string displayName)
{
    // set up domain context
    using(PrincipalContext ctx = new PrincipalContext(ContextType.Domain))
    {
        // find user by display name
        UserPrincipal user = UserPrincipal.FindByIdentity(ctx, displayName);

        // 
        if (user != null)
        {
             return user.SamAccountName;
             // or maybe you need user.UserPrincipalName;
        }
        else
        {
             return string.Empty;
        }
   }
    }
}