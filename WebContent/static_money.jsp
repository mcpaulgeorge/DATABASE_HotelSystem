<%@ page language="java" import="java.sql.*,java.util.*,Dao.*,Util.*" 
    pageEncoding="gbk"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="css/button.css"/> 
</head>
<body>
<form action="static_money.jsp" method="post" autocomplete="off">
ÔÂ·Ý:<input type="number" required name="month" min="1" step="1" max="12" value="<%=request.getParameter("month")==null?"":request.getParameter("month")%>">

<input type="submit" class="button" value="Í³¼Æ">
</form>
<%
String hname=session.getAttribute("hname").toString();
if(request.getParameter("month")!=null)
{
int month=Integer.parseInt(request.getParameter("month"));
CheckinDao cd=new CheckinDao(hname);
Cal c=new Cal();
String start_time=c.getFirstDayOfMonth(2020,month);
String end_time=c.getFirstDayOfMonth(2020,month+1);
	int money=cd.static_money(start_time, end_time);
	out.println("<p>"+month+"·ÝµÄ¿Í·¿×ÜÊÕÈëÎª"+money+"</p>");
}
%>
</body>
</html>