<%@ Page Language="C#" AutoEventWireup="true" CodeFile="StudentView.aspx.cs" Inherits="StudentView" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="StyleSheet.css" rel="stylesheet" />
    <title>Event Attendance - Student Attendance View</title>
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
                <h2>Name: <asp:Label ID="userFullName" runat="server"></asp:Label> (<asp:Label ID="userPID" runat="server"></asp:Label>)</h2>
                <asp:Label runat="server" ID="DateTimeNow"></asp:Label>

                <div class="box">
                    <div class="cb"><div class="ctBox"><span class="ctBoxLbl">Number Events Scanned: </span><span class="ctBoxTxt"><asp:Label runat="server" ID="totalScanned"></asp:Label></span></div></div>
                    <div class="cb"><div class="ctBox"><span class="ctBoxLbl">Transfer Credits or Archived Events: </span><span class="ctBoxTxt"><asp:Label runat="server" ID="totalArchive"></asp:Label></span></div></div>
                    <div class="cb"><div class="ctBox"><span class="ctBoxTotLbl">Total Events Attended: </span><span class="ctBoxTotTxt"><asp:Label runat="server" ID="totalAttended"></asp:Label></span><span style="display:block;float:left;font-size:0.7em;font-style:italic;color:#777;font-weight:normal;margin:10px 0 0 14px;">You must have a minimum of 24 CEP credits to graduate.</span></div></div>
                </div>
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="8" DataKeyNames="eventid" DataSourceID="EventsAttended" EnableModelValidation="True" ForeColor="#333333" GridLines="None" BorderStyle="Solid" BorderWidth="1px" Width="776px">
                    <AlternatingRowStyle BackColor="White" />
                    <Columns>
                        <asp:BoundField DataField="eventTitle" HeaderText="Event Title" SortExpression="eventTitle" />
                        <asp:BoundField DataField="startdatetime" HeaderText="Start Date and Time" SortExpression="startdatetime" >
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="enddatetime" HeaderText="End Date and Time" SortExpression="enddatetime" >
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                    </Columns>
                    <EditRowStyle BackColor="#7C6F57" />
                    <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#ffcc00" Font-Bold="True" ForeColor="black" /> 
                    <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="#f5f5f5" />
                    <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
                </asp:GridView>
                    <p style="font-style:italic;">Note: You should see three rows of numbers at the top, one displaying the total count of CEP events during which your ID was scanned, one for the total number of Transfer and pre-Spring 2015 events (combined) you are known to have attended, and an overall total of the two previous rows.  Please contact the Student Development Office at 864-231-2075 if you have questions or feel that the total above is incorrect.</p>
                </div>
                <asp:SqlDataSource ID="EventsAttended" runat="server" ConnectionString="<%$ ConnectionStrings:EventAttendConnectionString %>" SelectCommand="select	distinct e.eventid
		, e.eventTitle
		, e.startdatetime
		, e.enddatetime
		, (select	convert(varchar(10),count(distinct a.eventid)) as totct
			from	attendance as a
					inner join [events] as e
						on e.eventid = a.eventid
						and e.[status] = 'a'
						and e.cancelled = 'N'
			where	a.scannedid = @pid) as ct

from	[events] as e
		inner join attendance as a
			on a.eventid = e.eventid
			and a.scannedid = @pid

where	e.status = 'a'
		and cancelled = 'N'
">
                    <SelectParameters>
                        <asp:SessionParameter DefaultValue="0" Name="pid" SessionField="pid" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </div>
    </div>
        </div>
    </form>
</body>
</html>
