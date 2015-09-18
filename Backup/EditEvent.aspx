<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EditEvent.aspx.cs" Inherits="EditEvent" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <link href="StyleSheet.css" rel="stylesheet" type="text/css" />
    <title>Event Attendance - Event Editing Form</title>
	<script src="http://code.jquery.com/jquery-latest.js" type="text/javascript"></script>  
	<link rel="stylesheet" type="text/css" href="css/jquery.datetimepicker.css"/>
</head>

<body style="margin:auto;">
    <form id="form1" runat="server" style="margin:auto; border:1px none red;"> 
        <asp:SqlDataSource ID="eventInfo" runat="server" ConnectionString="<%$ ConnectionStrings:EventAttendConnectionString %>" SelectCommand="SELECT [eventID], [eventTitle], [eventDesc], [eventPresenter], [eventLoc], [startDateTime], [endDateTime], [hostID], [requestedBy] FROM [events] WHERE ([eventID] = @eventID)">
            <SelectParameters>
                <asp:QueryStringParameter Name="eventID" QueryStringField="id" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
					<div style="width:800px;margin:auto;">
                    <asp:Label ID="idMsg" runat="server" style="color:orange;font-size:14pt;" />
                    <asp:Label ID="existsMsg" runat="server" style="color:maroon;font-size:14pt;" />
                    <asp:Label ID="successMsg" runat="server" style="color:darkgreen;font-size:14pt;" />
                    <asp:HiddenField ID="txtEID" runat="server" />
					<h2 class="vTitle">Event Editing Form
                        </h2>
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
                                <asp:TextBox id="txtTitle" style="width: 280px; height: 30px;font-size:13pt;" runat="server" Text='<%# Eval("eventTitle") %>'></asp:TextBox>
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
                                <asp:TextBox id="txtEventLoc" style="width: 280px; height: 30px;font-size:13pt;" runat="server"></asp:TextBox>
                            </td>
                        </tr> 
						<tr>
                            <td class="txtBoxLabel">Description: </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:TextBox id="txtDesc" style="width: 350px; height: 150px; vertical-align:top;" runat="server" TextMode="MultiLine" Rows="4"></asp:TextBox>
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
                                <asp:TextBox id="txtStartDateTime" style="width: 280px; height: 30px;" runat="server"></asp:TextBox>
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
                                <asp:TextBox id="txtEndDateTime" style="width: 280px; height: 30px;" runat="server"></asp:TextBox>
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
                                <asp:SqlDataSource ID="Hosts" runat="server" ConnectionString="Data Source=ausql;Initial Catalog=EventAttend;Persist Security Info=True;User ID=web_user;Password=w3b_us3r2010" ProviderName="System.Data.SqlClient" SelectCommand="SELECT [hostID], [hostName] FROM [hosts] ORDER BY [hostName]"></asp:SqlDataSource>
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
                                <asp:TextBox id="txtPresenter" style="width: 350px; height: 30px;" runat="server"></asp:TextBox>
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
                                <asp:TextBox id="txtRequestedBy" style="width: 280px; height: 30px;" runat="server"></asp:TextBox>
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
                                <asp:Button ID="btnSubmit" runat="server" Text="Save Event" Visible="true" style="width: 290px; height: 60px" OnClick="btnSubmit_Click" />
                            </td>
                        </tr>
                    </table>
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