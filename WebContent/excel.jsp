<%@ page language="java" import="java.sql.*,java.util.*,Dao.*,Util.Sql_Excel" 
    pageEncoding="gbk"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>µ¼³öÈë×¡ÐÅÏ¢µ½excel</title>
<link rel="stylesheet" type="text/css" href="css/button.css"/> 
</head>
<body>
<form action="excel.jsp" method="post">
<input type="text" name="filepath" placeholder="ÇëÊäÈëÄãÏë´æ·ÅµÄÂ·¾¶" >
<input type="submit" class="button" value="µ¼Èëexcel" onClick="return window.confirm('È·ÈÏÒªµ¼ÈëÂï');">
</form>
<%
String file=request.getParameter("filepath");
Sql_Excel se=new Sql_Excel();
String hname=session.getAttribute("hname").toString();
if(file!=null)
{
	boolean flag=se.checkin_Excel(file,hname);
	if(flag){
	out.println("<script language='javascript'>alert('µ¼Èë³É¹¦')</script>");
	}
	else{
	out.println("<script language='javascript'>alert('µ¼ÈëÊ§°Ü')</script>");
	}
}
%>
</body>
</html>