<%@ page language="java" import="java.sql.*,java.util.*,Dao.*" 
    pageEncoding="gbk"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>统计入住率</title>
<link rel="stylesheet" type="text/css" href="css/button.css"/> 
</head>
<body>
<% 
request.setCharacterEncoding("gb2312");
response.setCharacterEncoding("gb2312");
%>
<form action="static_checkinrate.jsp" method="post" autocomplete="off">
从<input type="date" name="start_time" required value="<%=request.getParameter("start_time")==null?"":request.getParameter("start_time")%>">
到<input type="date" name="end_time" required value="<%=request.getParameter("end_time")==null?"":request.getParameter("end_time")%>">
房间类型：<input type="text" name="rkind" list="rkindlist" required value="<%=request.getParameter("rkind")==null?"":request.getParameter("rkind")%>">
<datalist id="rkindlist">
<option value="普通标间">普通标间</option>
			<option value="普通大床">普通大床</option>
			<option value="商务标间">商务标间</option>
			<option value="商务大床">商务大床</option>
			<option value="套房">套房</option>
			<option value="总统套房">总统套房</option>
</datalist>
<input type="submit" class="button" value="统计">
</form>
<%
String hname=session.getAttribute("hname").toString();
CheckinDao cd=new CheckinDao(hname);
String rkind=request.getParameter("rkind");
String start_time=request.getParameter("start_time");
String end_time=request.getParameter("end_time");
if(rkind!=null&&start_time!=null&&end_time!=null)
{
String rate=cd.static_checkin_rate(rkind, start_time, end_time);
out.println("<h1>该类房间在该段时间段内的入住率为"+rate+"</h1>");
}
%>
</body>
</html>