<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CancelEvent.aspx.cs" Inherits="admin_CancelEvent" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellSpacing="2" DataKeyNames="eventID" DataSourceID="EventAttendance">
            <AlternatingRowStyle BackColor="#FFFFDD" />
            <Columns>
                <asp:BoundField DataField="eventID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="eventID" Visible="False" />
                <asp:BoundField DataField="eventTitle" HeaderText="Title" SortExpression="eventTitle" />
                <asp:BoundField DataField="cancelled" HeaderText="Cancelled" SortExpression="cancelled" Visible="False" />
                <asp:BoundField DataField="eventLoc" HeaderText="Location" SortExpression="eventLoc" />
                <asp:BoundField DataField="eventPresenter" HeaderText="Presenter" SortExpression="eventPresenter" />
                <asp:BoundField DataField="startDateTime" HeaderText="Start" SortExpression="startDateTime" />
                <asp:BoundField DataField="endDateTime" HeaderText="End" SortExpression="endDateTime" />
                <asp:BoundField DataField="status" HeaderText="Status" SortExpression="status" Visible="False" />
                <asp:BoundField DataField="Cancel" HeaderText="Cancel" ReadOnly="True" SortExpression="Cancel" >
                <HeaderStyle HorizontalAlign="Center" />
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="Reactivate" HeaderText="Reactivate" ReadOnly="True" SortExpression="Reactivate">
                <HeaderStyle HorizontalAlign="Center" />
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="cancelledBy" HeaderText="Cancelled By" ReadOnly="True" SortExpression="cancelledBy" />
                <asp:BoundField DataField="cancelledDateTime" HeaderText="Cancelled Date" SortExpression="cancelledDateTime" />
            </Columns>
            <EditRowStyle BackColor="#FFFFCC" />
            <HeaderStyle BackColor="#DADADA" />
        </asp:GridView>
        <asp:SqlDataSource ID="EventAttendance" runat="server" ConnectionString="<%$ ConnectionStrings:EventAttendConnectionString %>" SelectCommand="SELECT	e.[eventID]
		, e.[eventTitle]
		, e.[cancelled]
		, e.[eventLoc]
		, e.[eventPresenter]
		, e.[startDateTime]
		, e.[endDateTime]
		, e.[status] 
		, case when e.cancelled = 'y' then '' else 'cancel' end as Cancel
		, case when e.cancelled = 'y' then 'reactivate' else '' end as Reactivate
		, p.last_name + ', ' + p.first_name + ' ' + left(p.middle_name,1) as cancelledBy
		, e.cancelledDateTime
		

FROM	ausql.eventattend.dbo.[events] as e
		left outer join ausql.eventattend.dbo.management as m
			on m.id = e.cancelledBy
		left outer join aupcstor.campus6.dbo.people as p
			on p.people_id = m.peopleid
		

where	startdatetime &gt; dateadd(&quot;d&quot;,-3,getdate()) 

ORDER BY	[startDateTime] DESC
			, [eventTitle]
			, [createDateTime]"></asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
