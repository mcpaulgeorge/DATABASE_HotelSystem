<%@ page language="java" import="java.sql.*,java.util.*,Dao.*" 
    pageEncoding="gbk"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>¸ù¾Ý¿ÍÈË²¿·ÖÐÅÏ¢²é¿ÍÈËÈ«²¿ÐÅÏ¢</title>
 <link rel="stylesheet" type="text/css" href="css/table.css"/>  
 <link rel="stylesheet" type="text/css" href="css/button.css"/> 
</head>
<body>
<form action="part_all.jsp" method="post" autocomplete="off">
<%
request.setCharacterEncoding("gb2312");
		response.setCharacterEncoding("gb2312");
%>
Éí·ÝÖ¤£º<input type="text" name="cid" pattern="([0-9]{17}[0-9|Xx]|([0-9]{14}[0-9|Xx])" placeholder="ÇëÊäÈëÒª²éÑ¯µÄÉí·ÝÖ¤ºÅ" required value="<%=request.getParameter("cid")==null?"":request.getParameter("cid")%>">
ÐÕÃû£º<input type="text" name="cname" placeholder="ÇëÊäÈëÒª²éÑ¯µÄÐÕÃû" required value="<%=request.getParameter("cname")==null?"":request.getParameter("cname")%>">
<input type="submit" class="button" value="²éÑ¯">
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
		<td>¿ÍÈËÉí·ÝÖ¤ºÅ</td>
		<td>¿ÍÈËÐÕÃû</td>
		<td>¿ÍÈËÐÔ±ð</td>
		<td>¿ÍÈËÄêÁä</td>
		<td>¿ÍÈË¼ÒÍ¥×¡Ö·</td>
		<td>¿ÍÈË¹¤×÷µ¥Î»</td>
		<td>¿ÍÈËÉúÔ´µØ</td>
		<td>¿ÍÈËÀàÐÍ</td>
		<td>¿ÍÈËËù×¡·¿¼ä</td>
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
	out.println("<script>alert('ÇëÊäÈëÊ®ÎåÎ»»òÕßÊ®°ËÎ»µÄÉí·ÝÖ¤') </script>");
}
%>
	</table>
</body>
</html>