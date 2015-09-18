<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EntryForm.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <link href="StyleSheet.css" rel="stylesheet" type="text/css" />
    <title>Event Attendance - Entry Form</title>
	<script src="https://code.jquery.com/jquery-latest.js" type="text/javascript"></script>  
	<link rel="stylesheet" type="text/css" href="css/jquery.datetimepicker.css"/>
</head>

<body style="text-align:left;margin:auto;">
    <form id="form1" runat="server" style="text-align:left;margin:auto;"> 
    <%-- Tried adding this to form tag:  defaultfocus="txtStudentID" --%>
        <div id="surround">
            <div id="header">
                <h2>Event Attendance<span style="width:24%;float:right;text-align:right;"><asp:Button ID="logoutButton" runat="server" Text="Log out" OnClick="logoutButton_Click" Height="25px" Width="75px" /></span></h2>
                <div style="clear:both;"></div>
                <div>
                    <div style="width:33%;float:left;"><asp:Label ID="userPID" runat="server"></asp:Label></div>
                    <div style="width:33%;float:left;"><asp:Label ID="userFullName" runat="server"></asp:Label></div>
                    <div style="width:33%;float:left;text-align:right;"><asp:Label ID="userManageLevel" runat="server"></asp:Label></div>
                    <div style="clear:both;"></div>
                </div>
            </div>
            <asp:MultiView ID="MultiView1" runat="server">
                <asp:View ID="View1" runat="server">
					<div style="width:576px;text-align:left;margin:auto;padding:12px;">
                    <asp:Label ID="existsMsg" runat="server" style="color:maroon;font-size:14pt;" />
                    <asp:Label ID="successMsg" runat="server" style="color:darkgreen;font-size:14pt;" />
					<h3 class="vTitle">Event Entry Form</h3>
                    <table style="width:100%">
						<tr>
                            <td class="txtBoxLabel">Event Title:
                                <asp:RequiredFieldValidator id="RequiredFieldValidator2" runat="server"
                                  ControlToValidate="txtTitle"
                                  ErrorMessage="(required field)"
                                  ForeColor="Red">
                                </asp:RequiredFieldValidator></td>
                        </tr>
                        <tr>
                            <td>
                                <asp:TextBox id="txtTitle" style="width: 280px; height: 30px;font-size:13pt;" runat="server" onblur="txtAge_onblur()" class="txtBox"></asp:TextBox>
                            </td>
                        </tr> 
						<tr>
                            <td class="txtBoxLabel">Event Location:
                                <asp:RequiredFieldValidator id="RequiredFieldValidator9" runat="server"
                                  ControlToValidate="txtEventLoc"
                                  ErrorMessage="(required field)"
                                  ForeColor="Red">
                                </asp:RequiredFieldValidator></td>
                        </tr>
                        <tr>
                            <td>
                                <asp:TextBox id="txtEventLoc" style="width: 280px; height: 30px;font-size:13pt;" runat="server" onblur="txtAge_onblur()" class="txtBox"></asp:TextBox>
                            </td>
                        </tr> 
						<tr>
                            <td class="txtBoxLabel">Description: </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:TextBox id="txtDesc" style="width: 450px; height: 150px; vertical-align:top;" runat="server" onblur="txtAge_onblur()" TextMode="MultiLine" Rows="4"></asp:TextBox>
                            </td>
                        </tr>  
						<tr>
                            <td class="txtBoxLabel">Start Date and Time:
                                <asp:RequiredFieldValidator id="RequiredFieldValidator1" runat="server"
                                  ControlToValidate="txtStartDateTime"
                                  ErrorMessage="(required field)"
                                  ForeColor="Red">
                                </asp:RequiredFieldValidator>
                                <asp:Label ID="dateMsg" runat="server" style="color:maroon" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:TextBox id="txtStartDateTime" style="width: 280px; height: 30px;" runat="server" onblur="txtAge_onblur()"></asp:TextBox>
                            </td>
                        </tr>  
						<tr>
                            <td class="txtBoxLabel">End Date and Time:
                                <asp:RequiredFieldValidator id="RequiredFieldValidator3" runat="server"
                                  ControlToValidate="txtEndDateTime"
                                  ErrorMessage="(required field)"
                                  ForeColor="Red">
                                </asp:RequiredFieldValidator></td>
                        </tr>
                        <tr>
                            <td>
                                <asp:TextBox id="txtEndDateTime" style="width: 280px; height: 30px;" runat="server" onblur="txtAge_onblur()"></asp:TextBox>
                            </td>
                        </tr> 
						<tr>
                            <td class="txtBoxLabel">Hosting Department:
                                <asp:RequiredFieldValidator id="RequiredFieldValidator4" runat="server"
                                  ControlToValidate="txtHost"
                                  ErrorMessage="(required field)"
                                  ForeColor="Red">
                                </asp:RequiredFieldValidator></td>
                        </tr>
                        <tr>
                            <td>
								<asp:DropDownList id="txtHost"  style="width: 280px; height: 30px;" runat="server" AppendDataBoundItems="true" DataSourceID="Hosts" DataTextField="hostName" DataValueField="hostID">
								    <asp:ListItem Value="0"> -- Select One -- </asp:ListItem>
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="Hosts" runat="server" ConnectionString="Data Source=ausql;Initial Catalog=EventAttend;Persist Security Info=True;User ID=web_user;Password=w3b_us3r2010" ProviderName="System.Data.SqlClient" SelectCommand="select h.hostid , h.hostname from management as m inner join hosts as h on h.hostid = m.hostid and h.status = 'a' where m.peopleid = @userPID and m.status = 'a' ORDER BY [hostName]">					
									<SelectParameters>  
										<asp:SessionParameter Name="userPID" SessionField="pid" />  
									</SelectParameters> 
								</asp:SqlDataSource>
                            </td>
                        </tr> 
						<tr>
                            <td class="txtBoxLabel">Presenter:
                                <asp:RequiredFieldValidator id="RequiredFieldValidator5" runat="server"
                                  ControlToValidate="txtPresenter"
                                  ErrorMessage="(required field)"
                                  ForeColor="Red">
                                </asp:RequiredFieldValidator></td>
                        </tr>
                        <tr>
                            <td>
                                <asp:TextBox id="txtPresenter" style="width: 350px; height: 30px;" runat="server" onblur="txtAge_onblur()"></asp:TextBox>
                            </td>
                        </tr>  
						<tr>
                            <td class="txtBoxLabel">Requested By:
                                <asp:RequiredFieldValidator id="RequiredFieldValidator6" runat="server"
                                  ControlToValidate="txtRequestedBy"
                                  ErrorMessage="(required field)"
                                  ForeColor="Red">
                                </asp:RequiredFieldValidator></td>
                        </tr>
                        <tr>
                            <td>
                                <asp:TextBox id="txtRequestedBy" style="width: 280px; height: 30px;" runat="server" onblur="txtAge_onblur()"></asp:TextBox>
                            </td>
                        </tr>
						<tr>
                            <td class="txtBoxLabel">Credit Type:
                                <asp:RequiredFieldValidator id="RequiredFieldValidator7" runat="server"
                                  ControlToValidate="txtCreditType"
                                  ErrorMessage="(required field)"
                                  ForeColor="Red">
                                </asp:RequiredFieldValidator></td>
                        </tr>
                        <tr>
                            <td>
								<asp:DropDownList id="txtCreditType"  style="width: 280px; height: 30px;" runat="server" autopostback="false">
									<asp:ListItem value="1">CEP</asp:ListItem>
									<asp:ListItem value="2">Journey</asp:ListItem>
								</asp:DropDownList>
                            </td>
                        </tr>  
						<tr>
                            <td class="txtBoxLabel">Event Credits:
                                <asp:RequiredFieldValidator id="RequiredFieldValidator8" runat="server"
                                  ControlToValidate="txtEventCredits"
                                  ErrorMessage="(required field)"
                                  ForeColor="Red">
                                </asp:RequiredFieldValidator></td>
                        </tr>
                        <tr>
                            <td>
								<asp:DropDownList id="txtEventCredits"  style="width: 280px; height: 30px;" runat="server" autopostback="false">
									<asp:ListItem value="1"></asp:ListItem>
									<asp:ListItem value="2"></asp:ListItem>
									<asp:ListItem value="3"></asp:ListItem>
									<asp:ListItem value="4"></asp:ListItem>
									<asp:ListItem value="5"></asp:ListItem>
								</asp:DropDownList>
                            </td>
                        </tr>     
                        <tr>
                            <td>
                                <asp:Button ID="btnSubmit" runat="server" Text="Save Event" Visible="true" style="width: 200px; height: 60px" OnClick="btnSubmit_Click" />
                                <asp:Button ID="btnClear" runat="server" Text="Clear Form" Visible="true" style="width: 200px; height: 60px; margin-left:100px;" OnClick="btnClear_Click" />
                            </td>
                        </tr>
                    </table>
					</div>
                </asp:View>
                <asp:View ID="View2" runat="server">
                  <div style="width:310px;text-align:left;margin:auto;">
                  
                   
                    
                    
                  </div>
                </asp:View>
            </asp:MultiView> 
        </div>
 </form>


<script src="js/jquery.datetimepicker.js"></script>
<script>/*
window.onerror = function(errorMsg) {
	$('#console').html($('#console').html()+'<br>'+errorMsg)
}*/

$('#txtStartDateTime').datetimepicker({
	formatTime:'h:00a',
	formatDate:'yyyy-MM-dd',
	defaultDate:'01/01/2015',
	defaultTime:'10:00',
	timepickerScrollbar:false
});
$('#txtEndDateTime').datetimepicker({
	formatTime:'h:00a',
	formatDate:'yyyy-MM-dd',
	defaultDate:'01/01/2015',
	defaultTime:'10:00',
	timepickerScrollbar:false
});

$('#close').click(function(){
	$('#datetimepicker4').datetimepicker('hide');
});
$('#reset').click(function(){
	$('#datetimepicker4').datetimepicker('reset');
});
var logic = function( currentDateTime ){
	if( currentDateTime.getDay()==6 ){
		this.setOptions({
			minTime:'11:00'
		});
	}else
		this.setOptions({
			minTime:'8:00'
		});
};
var dateToDisable = new Date();
	dateToDisable.setDate(dateToDisable.getDate() + 2);


</script>
     

</body>
</html>