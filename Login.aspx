<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Event Attendance - Login</title>
    <link href="StyleSheet.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div><asp:Label ID="Authenticated" runat="server" Visible="false"></asp:Label></div>
    <div id="loginBox">
        <asp:Login ID="Login1" runat="server" DisplayRememberMe="False" UserNameLabelText="Username" Font-Bold="True" PasswordLabelText="Password" TitleText="CEP Credits - Log In">
            <LabelStyle Height="40px" HorizontalAlign="Left" VerticalAlign="Middle" Width="75px" ForeColor="Gray" />
            <LoginButtonStyle BackColor="Gray" BorderColor="#666666" BorderStyle="Solid" BorderWidth="1px" Font-Size="Smaller" ForeColor="White" Height="25px" Width="60px" />
            <TextBoxStyle BackColor="#ffcc00" BorderColor="#999999" BorderWidth="1px" Height="20px" Width="170px" />
            <TitleTextStyle Font-Bold="True" Font-Size="Larger" ForeColor="#000" Height="40px" VerticalAlign="Top" />
            <ValidatorTextStyle Height="25px" />
        </asp:Login>
    </div>
    </form>
</body>
</html>
