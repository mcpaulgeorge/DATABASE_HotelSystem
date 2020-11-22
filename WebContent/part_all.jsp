<%@ page language="java" import="java.sql.*,java.util.*,Dao.*" 
    pageEncoding="gbk"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>根据客人部分信息查客人全部信息</title>
 <link rel="stylesheet" type="text/css" href="css/table.css"/>  
 <link rel="stylesheet" type="text/css" href="css/button.css"/> 
</head>
<body>
<form action="part_all.jsp" method="post" autocomplete="off">
<%
request.setCharacterEncoding("gb2312");
		response.setCharacterEncoding("gb2312");
%>
身份证：<input type="text" name="cid" pattern="([0-9]{17}[0-9|Xx]|([0-9]{14}[0-9|Xx])" placeholder="请输入要查询的身份证号" required value="<%=request.getParameter("cid")==null?"":request.getParameter("cid")%>">
姓名：<input type="text" name="cname" placeholder="请输入要查询的姓名" required value="<%=request.getParameter("cname")==null?"":request.getParameter("cname")%>">
<input type="submit" class="button" value="查询">
</form>
<%
String hname=session.getAttribute("hname").toString();
CheckinDao cd=new CheckinDao(hname);
String cid=request.getParameter("cid");
String cname=request.getParameter("cname");
if(cid!=null&&cname!=null&&(cid.length()==15||cid.length()==18))
{
	String[] all=cd.part_all_rno(cid, cname);
	%>
	<table id="table" width ="100%" border=2>
		<tr>
		<td>客人身份证号</td>
		<td>客人姓名</td>
		<td>客人性别</td>
		<td>客人年龄</td>
		<td>客人家庭住址</td>
		<td>客人工作单位</td>
		<td>客人生源地</td>
		<td>客人类型</td>
		<td>客人所住房间</td>
		</tr>
<% 
out.println("<tr>");
	for(String a:all)
	{
	out.println("<td>"+a+"</td>");
	}
	out.println("</tr>");
}
else if(cid!=null&&cname!=null)
{
	out.println("<script>alert('请输入十五位或者十八位的身份证') </script>");
}
%>
	</table>
</body>
</html>