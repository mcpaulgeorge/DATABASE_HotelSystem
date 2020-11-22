<%@ page language="java" import="java.sql.*,java.util.*,Dao.*" 
    pageEncoding="gbk"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>expire_remind</title>
    <link rel="stylesheet" type="text/css" href="css/table.css"/>  
    <style type="text/css">
		#over_expire{
		padding: 5px 10px;
		font-size: 12px;
		font-family: Verdana;
		color: #CE0000;
		background:#CE0000;
	}
</style>
</head>
<body>
<form action="expire.jsp" method="post" autocomplete="off">
<table id="table" width ="100%" border=2>
		<tr>
		<td>¿ÍÈËÐòºÅ</td>
		<td>Ô¤¼ÆÀë¿ªÊ±¼ä</td>
		<td>ÒÑ×¡ÌìÊý</td>
		<td>ÒÑ½ÉÑº½ð</td>
		<td>·¿¼äºÅ</td>
		<td>»¹Ðè½ÉÄÉÑº½ð</td>
		</tr>
<%
	String hname=session.getAttribute("hname").toString();
	CheckinDao cd=new CheckinDao(hname);
	String[][] on_expire=cd.showon_ExpireCustomer();
	String[][] over_expire=cd.showover_ExpireCustomer();
	for(int i=0;i<on_expire.length;i++)
	{
	out.println("<tr>");
	out.println("<td >"+on_expire[i][0]+"</td>");
	out.println("<td >"+on_expire[i][1]+"</td>");
	out.println("<td >"+on_expire[i][2]+"</td>");
	out.println("<td >"+on_expire[i][3]+"</td>");
	out.println("<td >"+on_expire[i][4]+"</td>");
	out.println("<td >"+on_expire[i][5]+"</td>");
	out.println("</tr>");
	}
	for(int i=0;i<over_expire.length;i++)
	{
	out.println("<tr>");
	out.println("<td id='over_expire'>"+over_expire[i][0]+"</td>");
	out.println("<td id='over_expire'>"+over_expire[i][1]+"</td>");
	out.println("<td id='over_expire'>"+over_expire[i][2]+"</td>");
	out.println("<td id='over_expire'>"+over_expire[i][3]+"</td>");
	out.println("<td id='over_expire'>"+over_expire[i][4]+"</td>");
	out.println("<td id='over_expire'>"+over_expire[i][5]+"</td>");
	out.println("</tr>");
	}
%>
</table>
</form>
</body>
</html>