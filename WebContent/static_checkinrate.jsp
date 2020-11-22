<%@ page language="java" import="java.sql.*,java.util.*,Dao.*" 
    pageEncoding="gbk"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Í³¼ÆÈë×¡ÂÊ</title>
<link rel="stylesheet" type="text/css" href="css/button.css"/> 
</head>
<body>
<% 
request.setCharacterEncoding("gb2312");
response.setCharacterEncoding("gb2312");
%>
<form action="static_checkinrate.jsp" method="post" autocomplete="off">
´Ó<input type="date" name="start_time" required value="<%=request.getParameter("start_time")==null?"":request.getParameter("start_time")%>">
µ½<input type="date" name="end_time" required value="<%=request.getParameter("end_time")==null?"":request.getParameter("end_time")%>">
·¿¼äÀàÐÍ£º<input type="text" name="rkind" list="rkindlist" required value="<%=request.getParameter("rkind")==null?"":request.getParameter("rkind")%>">
<datalist id="rkindlist">
<option value="ÆÕÍ¨±ê¼ä">ÆÕÍ¨±ê¼ä</option>
			<option value="ÆÕÍ¨´ó´²">ÆÕÍ¨´ó´²</option>
			<option value="ÉÌÎñ±ê¼ä">ÉÌÎñ±ê¼ä</option>
			<option value="ÉÌÎñ´ó´²">ÉÌÎñ´ó´²</option>
			<option value="Ì×·¿">Ì×·¿</option>
			<option value="×ÜÍ³Ì×·¿">×ÜÍ³Ì×·¿</option>
</datalist>
<input type="submit" class="button" value="Í³¼Æ">
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
out.println("<h1>¸ÃÀà·¿¼äÔÚ¸Ã¶ÎÊ±¼ä¶ÎÄÚµÄÈë×¡ÂÊÎª"+rate+"</h1>");
}
%>
</body>
</html>