<%@ page language="java" import="java.sql.*,java.util.*,Dao.*,Util.*" 
    pageEncoding="gbk"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>²éÑ¯¿ÍÈËÀúÊ·Èë×¡ÐÅÏ¢</title>
 <link rel="stylesheet" type="text/css" href="css/table.css"/>  
 <link rel="stylesheet" type="text/css" href="css/button.css"/> 
</head>
<body>
<form action="search_checkin.jsp" method="post" autocomplete="off">
Éí·ÝÖ¤ºÅÂë:<input type="text" name="cid" placeholder="ÇëÊäÈë15»òÕß18Î»µÄÉí·ÝÖ¤ºÅ" pattern="([0-9]{17}[0-9|Xx]|([0-9]{14}[0-9|Xx]))" value="<%=request.getParameter("cid")==null?"":request.getParameter("cid")%>">
<input type="submit" class="button" value="²éÑ¯">
</form>
<%
String hname=session.getAttribute("hname").toString();
String cid=request.getParameter("cid");
CheckinDao cd=new CheckinDao(hname);
if(cid!=null)
{
	Object[][] in=cd.search_ByCid(cid);
	%>
	<table id="table" width ="100%" border=2>
		<tr>
		<td>ÒÑ½ÉÄÉÑº½ðÊý¶î</td>
		<td>Êµ¼ÊÈë×¡ÌìÊý</td>
		<td>¿Í·¿¼Û¸ñ</td>
		<td>Êµ¼Ê×¡ËÞ·Ñ</td>
		<td>×¡ËÞ·Ñ²î¶î</td>
		</tr>
	<% 
	for(int i=0;i<in.length;i++)
	{
	out.println("<tr>");
	out.println("<td>"+in[i][0].toString()+"</td>");
	out.println("<td>"+in[i][1].toString()+"</td>");
	out.println("<td>"+in[i][2].toString()+"</td>");
	out.println("<td>"+in[i][3].toString()+"</td>");
	out.println("<td>"+in[i][4].toString()+"</td>");
	out.println("</tr>");
	}
	}
	%>
</body>
</html>