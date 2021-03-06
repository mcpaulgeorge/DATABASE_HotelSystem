<%@ page language="java" import="java.sql.*,java.util.*,Dao.*,Util.*" 
    pageEncoding="gbk"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>查询客人历史入住信息</title>
 <link rel="stylesheet" type="text/css" href="css/table.css"/>  
 <link rel="stylesheet" type="text/css" href="css/button.css"/> 
</head>
<body>
<form action="search_checkin.jsp" method="post" autocomplete="off">
身份证号码:<input type="text" name="cid" placeholder="请输入15或者18位的身份证号" pattern="([0-9]{17}[0-9|Xx]|([0-9]{14}[0-9|Xx]))" value="<%=request.getParameter("cid")==null?"":request.getParameter("cid")%>">
<input type="submit" class="button" value="查询">
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
		<td>已缴纳押金数额</td>
		<td>实际入住天数</td>
		<td>客房价格</td>
		<td>实际住宿费</td>
		<td>住宿费差额</td>
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