<%@ page language="java" import="java.sql.*,java.util.*,Dao.*,Util.Sql_Excel" 
    pageEncoding="gbk"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>导出入住信息到excel</title>
<link rel="stylesheet" type="text/css" href="css/button.css"/> 
</head>
<body>
<form action="excel.jsp" method="post">
<input type="text" name="filepath" placeholder="请输入你想存放的路径" >
<input type="submit" class="button" value="导入excel" onClick="return window.confirm('确认要导入嘛');">
</form>
<%
String file=request.getParameter("filepath");
Sql_Excel se=new Sql_Excel();
String hname=session.getAttribute("hname").toString();
if(file!=null)
{
	boolean flag=se.checkin_Excel(file,hname);
	if(flag){
	out.println("<script language='javascript'>alert('导入成功')</script>");
	}
	else{
	out.println("<script language='javascript'>alert('导入失败')</script>");
	}
}
%>
</body>
</html>