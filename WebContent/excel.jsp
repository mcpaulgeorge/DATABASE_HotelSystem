<%@ page language="java" import="java.sql.*,java.util.*,Dao.*,Util.Sql_Excel" 
    pageEncoding="gbk"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>������ס��Ϣ��excel</title>
<link rel="stylesheet" type="text/css" href="css/button.css"/> 
</head>
<body>
<form action="excel.jsp" method="post">
<input type="text" name="filepath" placeholder="�����������ŵ�·��" >
<input type="submit" class="button" value="����excel" onClick="return window.confirm('ȷ��Ҫ������');">
</form>
<%
String file=request.getParameter("filepath");
Sql_Excel se=new Sql_Excel();
String hname=session.getAttribute("hname").toString();
if(file!=null)
{
	boolean flag=se.checkin_Excel(file,hname);
	if(flag){
	out.println("<script language='javascript'>alert('����ɹ�')</script>");
	}
	else{
	out.println("<script language='javascript'>alert('����ʧ��')</script>");
	}
}
%>
</body>
</html>