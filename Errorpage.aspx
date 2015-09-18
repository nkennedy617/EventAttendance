<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Errorpage.aspx.cs" Inherits="Errorpage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">



<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <link href="StyleSheet.css" rel="stylesheet" type="text/css" />
    <title>Event Attendance Tracking</title>
   <script src="http://code.jquery.com/jquery-latest.js"   
        type="text/javascript"></script>  
</head>

<body style="text-align:auto;margin:auto;">
<form id="form1" runat="server">
    <div>
        <h2>We've Encountered An Error</h2>
        <div class="module_content">
            <p>
                <b>I'm sorry, but it appears the page you were using has caused an error. Please go back to the home page to try again. <a href="Default.aspx">Return To Homepage</a> </b>
            </p>
            <p>&nbsp;</p>
            <asp:Button ID="LogoutButton" runat="server" Text="Log out" OnClick="LogoutButton_Click" />
        </div>
    </div>
</form>
</body>
</html>
