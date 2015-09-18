<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Contact.aspx.cs" Inherits="Contact" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="StyleSheet.css" rel="stylesheet" type="text/css" />
    <title>Event Attendance Tracking - Contact Form</title>
   <script src="https://code.jquery.com/jquery-latest.js"   
        type="text/javascript"></script> 
</head>
<body>
    <form id="form1" runat="server">
        <div>
        <div id="surroundStudent">
            <div id="header">
                <div>
                    <div class="logo-img"><img src="images/anderson-university.png" alt="Anderson University" id="logo" /></div>
                    <span style="width:24%;float:right;text-align:right;">
                        <asp:Button ID="logoutButton" runat="server" Text="Log out" OnClick="logoutButton_Click" Height="25px" Width="75px" />
                    </span>
                </div>
                <div class="cb"></div>
                <h2 style="text-align:center;margin:5px">Check Your CEP Credits</h2>
                <div>
                    <div style="width:33%;float:left;text-align:right;"><asp:Label ID="userManageLevel" runat="server" Visible="false"></asp:Label></div>
                    <div style="clear:both;"></div>
                </div>
            </div>
            <div id="content">
                <div style="padding:12px;">
                    Logged in as: <asp:Label ID="txtLoggedInID" runat="server"></asp:Label><br />
                    Logged in Name:
                    <table border = "0" style="width: 409px">
                        <tr>
                            <td>
                                <asp:Label ID="lblLastName" runat="server" Text="Last Name*"></asp:Label><br />
                            </td>
                            <td>
                                <asp:TextBox ID="txtLastName" runat="server"></asp:TextBox><br />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*" ControlToValidate = "txtLastName"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblFirstName" runat="server" Text="First Name*"></asp:Label><br />
                            </td>
                            <td>
                                <asp:TextBox ID="txtFirstName" runat="server"></asp:TextBox><br />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="*" ControlToValidate = "txtFirstName"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label3" runat="server" Text="Student ID*"></asp:Label><br />
                            </td>
                            <td>
                                <asp:TextBox ID="txtMyID" runat="server"></asp:TextBox><br />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="*" ControlToValidate = "txtMyID"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td style="vertical-align:top;">
                                <asp:Label ID="Label4" runat="server" Text="Questions/Comments*"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtBody" runat="server" TextMode = "MultiLine" Height="100" Width="300" ></asp:TextBox><br />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="*"  ControlToValidate = "txtBody"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                            <%--<tr>
                            <td></td>
                            <td>
                                <asp:FileUpload ID="FileUpload1" runat="server" />
                            </td>
                        </tr>--%>
                        <tr>
                            <td></td>
                            <td>
                                <asp:Button ID="btnSend" runat="server" Text="Send" OnClick="btnSend_Click" />
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>
                                <asp:Label ID="lblMessage" runat="server" Text="" ForeColor = "Green"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
