using System;
using System.Collections.Generic;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Contact : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string ADID = (string)Session["empID"];
        txtLastName.Text = ADID;
        txtLoggedInID.Text = "test";
    }


    protected void btnSend_Click(object sender, EventArgs e)
    {

        string ADID = (string)Session["empID"];
        MailMessage mm = new MailMessage("rjasonritchie@gmail.com", "jritchie@andersonuniversity.edu");

        mm.Subject = "EventAttendance Contact Form";

        mm.Body = "First Name: " + txtFirstName.Text + "<br />" +
            "Last Name: " + txtLastName.Text + "<br />" +
            "Username: " + Server.HtmlEncode(User.Identity.Name) + "<br/>" +
            "<br />Student ID: " + txtMyID.Text + "<br />" +
            "Logged-In ID: " + ADID + "<br />" + 
            "<br />" + txtBody.Text;

        //if (FileUpload1.HasFile)
        //{

        //    string FileName = System.IO.Path.GetFileName(FileUpload1.PostedFile.FileName);

        //    mm.Attachments.Add(new Attachment(FileUpload1.PostedFile.InputStream, FileName));

        //}

        mm.IsBodyHtml = true;

        SmtpClient smtp = new SmtpClient();

        smtp.Host = "smtp.gmail.com";

        smtp.EnableSsl = true;

        System.Net.NetworkCredential NetworkCred = new System.Net.NetworkCredential();

        NetworkCred.UserName = "rjasonritchie@gmail.com";

        NetworkCred.Password = "JesusChristIsMyLordAndSavior";

        smtp.UseDefaultCredentials = true;

        smtp.Credentials = NetworkCred;

        smtp.Port = 587;

        smtp.Send(mm);

        lblMessage.Text = "Email Sent SucessFully.";

    }


    protected void logoutButton_Click(object sender, EventArgs e)
    {
        FormsAuthentication.SignOut();
        Response.Redirect(FormsAuthentication.LoginUrl, false);
    }
}