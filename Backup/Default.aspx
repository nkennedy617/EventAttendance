<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <link href="StyleSheet.css" rel="stylesheet" type="text/css" />
    <title>Event Attendance Tracking</title>
   <script src="http://code.jquery.com/jquery-latest.js"   
        type="text/javascript"></script>  
</head>

<body style="margin:auto;">
    <form id="form1" runat="server" style="margin:auto;"> 
    <%-- Tried adding this to form tag:  defaultfocus="txtStudentID" --%>
            <asp:MultiView ID="MultiView1" runat="server">
                <asp:View ID="View1" runat="server">
                    <asp:GridView ID="GridView1" runat="server" DataSourceID="SqlGetAllEvents" 
                        AllowPaging="True" AllowSorting="True" CellPadding="15" ForeColor="#333333" 
                        GridLines="None" AutoGenerateColumns="False" DataKeyNames="eventid" PageSize="100">
                        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                        <Columns>
                            <asp:HyperLinkField DataNavigateUrlFields="eventID" 
                                DataNavigateUrlFormatString="default.aspx?id={0}" DataTextField="eventTitle" 
                                HeaderText="Event Title" />
                            <asp:BoundField DataField="EventTimes" HeaderText="Event Times" ReadOnly="True" 
                                SortExpression="EventTimes" />
                            <asp:BoundField DataField="eventPresenter" HeaderText="Presenter" 
                                ReadOnly="True" SortExpression="eventPresenter" />
                            <asp:BoundField DataField="eventLoc" HeaderText="Location" ReadOnly="True" 
                                SortExpression="eventLoc" />
                            <asp:BoundField DataField="hostName" HeaderText="Hosted By" 
                                SortExpression="hostName" />
                        </Columns>
                        <EditRowStyle BackColor="#999999" />
                        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                        <SortedAscendingCellStyle BackColor="#E9E7E2" />
                        <SortedAscendingHeaderStyle BackColor="#506C8C" />
                        <SortedDescendingCellStyle BackColor="#FFFDF8" />
                        <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                    </asp:GridView>
                </asp:View>
                <asp:View ID="View2" runat="server">
                  <div style="width:310px;margin:auto;" runat="server">
                        <table>
                            <tr>
                                <td>
                                    <asp:ListView ID="ListView1" runat="server" DataSourceID="SqlSelectedEvent" ItemPlaceholderID="itemPlaceholder"
                                        DataMember="DefaultView">
                                        <LayoutTemplate>
                                            <asp:PlaceHolder ID="itemPlaceholder" runat="server"></asp:PlaceHolder>
                                        </LayoutTemplate>
                                        <ItemTemplate>
                                            <span style="float:right; font-size:8pt;"><a href="/EventAttendance/">Events List</a></span>
                                            <h3><asp:Label ID="Id" runat="server" Text='<%# Eval("eventTitle") %>'></asp:Label></span></h3>
                                            <asp:Label ID="DatesTimes" runat="server" Text='<%# Eval("eventTimes") %>'></asp:Label></span>
                                            <asp:HiddenField ID="txtEventId" runat="server" Value='<%# Eval("eventid") %>' />  
                                        </ItemTemplate>
                                    </asp:ListView>
                                </td>
                            </tr>
                            <tr>
                                <td>Student ID: </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:TextBox id="txtStudentID" ontextchanged="txtStudentID_TextChanged" style="width: 280px; height: 220px;" runat="server" BackColor="#D9EBF9"></asp:TextBox>
                                </td>
                            </tr>               
                            <tr>
                                <td>
                                    <asp:Button ID="btnSubmit" runat="server" Text="Submit" Visible="true" style="width: 290px; height: 60px" />
                                    <asp:label runat="server" id="lblmsg" style="color:green" />
                                </td>
                            </tr>
                        </table>
                    <asp:GridView ID="gvData" runat="server" DataSourceID="SqlDailyAttendCount" 
                        AutoGenerateColumns="False" BorderStyle="None">
                        <Columns>
                            <asp:BoundField DataField="Event_Attendance" HeaderText="Attendance" 
                                ReadOnly="True" SortExpression="Event_Attendance" />
                        </Columns>
                        <HeaderStyle BackColor="#EAF2FB" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDailyAttendCount" runat="server"  
						ConnectionString="<%$ ConnectionStrings:EventAttendConnectionString %>" 
						SelectCommand="select count(distinct scannedid) as Event_Attendance  from attendance where eventID = @eventID">
                        <SelectParameters>  
                            <asp:QueryStringParameter Name="eventID" QueryStringField="id" />  
                        </SelectParameters> 
					</asp:SqlDataSource>
                    <asp:SqlDataSource ID="SqlSelectedEvent" runat="server" ConnectionString="<%$ ConnectionStrings:EventAttendConnectionString %>" SelectCommand="select	eventid
                        , eventTitle
		                , coalesce(eventDesc,'') as eventDesc, coalesce(eventPresenter,'') as eventPresenter, coalesce(eventLoc,'') as eventLoc
		                , case when convert(varchar(9),startdatetime,110) = convert(varchar(9),enddatetime,110) then 
			                convert(varchar(20),startdatetime,100) + '-' + right(convert(varchar(20),enddatetime,100),7)
				                else convert(varchar(20),startdatetime,100) + '-' + convert(varchar(20),enddatetime,100)
				                end as EventTimes
		                , h.hostName, case when e.approvedby > '0' then 'Y' else 'N' end as Approved
	
                        from	events as e
		                        left outer join hosts as h
			                        on h.hostid = e.hostid
		                        left outer join management as m
			                        on m.id = e.approvedBy

                        where	e.eventid = @eventID
		                        and e.status = 'a'
		                        and e.cancelled = 'n'
                                and e.approvedBy > 0">
          <%--OnSelecting="SqlSelectedEvent_Selecting"--%>
                        <SelectParameters>  
                            <asp:QueryStringParameter Name="eventID" QueryStringField="id" />  
                        </SelectParameters>  
                    </asp:SqlDataSource>
                  </div>
                </asp:View>
            </asp:MultiView> 
            


    <asp:SqlDataSource ID="SqlGetAllEvents" runat="server"  ConnectionString="<%$ ConnectionStrings:EventAttendConnectionString %>" SelectCommand="select	eventid
                        , eventTitle
		                , coalesce(eventDesc,'') as eventDesc, coalesce(eventPresenter,'') as eventPresenter, coalesce(eventLoc,'') as eventLoc
		                , case when convert(varchar(9),startdatetime,110) = convert(varchar(9),enddatetime,110) then 
			                convert(varchar(20),startdatetime,100) + '-' + right(convert(varchar(20),enddatetime,100),7)
				                else convert(varchar(20),startdatetime,100) + '-' + convert(varchar(20),enddatetime,100)
				                end as EventTimes
		                , h.hostName
	
                from	events as e
		                left outer join hosts as h
			                on h.hostid = e.hostid
		                left outer join management as m
			                on m.id = e.approvedBy

                where	e.status = 'a'
		                and e.cancelled = 'n'
                        and e.endDateTime > dateAdd(d,-15,getdate())
                order by    startdatetime"></asp:SqlDataSource>


    </form>


     

</body>
</html>