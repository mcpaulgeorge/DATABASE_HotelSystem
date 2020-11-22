<%@ page language="java" import="java.sql.*,java.util.*,Dao.*" 
    pageEncoding="gbk"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
    <link rel="stylesheet" type="text/css" href="css/table.css"/> 
    <link rel="stylesheet" type="text/css" href="css/button.css"/>  
</head>
<body>
<form action="rno_customer_info.jsp" method="post" autocomplete="off">
·¿¼äºÅ:<input type="text" list="rnolist" name="rno" required value="<%=request.getParameter("rno")==null?"":request.getParameter("rno")%>">
   		<datalist id="rnolist">
   		<%
	String hname=session.getAttribute("hname").toString();
	CheckinDao cd=new CheckinDao(hname);
	String[] rno_list=cd.get_uncheckout_rno();
	for(int i=0;i<rno_list.length;i++){
	%>
	<option value="<%=rno_list[i]%>"><%=rno_list[i]%></option>
	<%} %>
	</datalist>
<input type="submit" class="button" value="²éÑ¯">
</form>
<%
String rno=request.getParameter("rno");
Object[][] list=cd.rno_customer_info(rno);
		if(rno!=null)
		{
		%>
		<table id="table" width ="100%" border=2>
		<tr>
		<td>¿ÍÈËÉí·ÝÖ¤ºÅÂë</td>
		<td>¿ÍÈËÐÕÃû</td>
		<td>¿ÍÈËÐÔ±ð</td>
		<td>¿ÍÈËÄêÁä</td>
		<td>¿ÍÈË¼ÒÍ¥×¡Ö·</td>
		<td>¿ÍÈË¹¤×÷µ¥Î»</td>
		<td>¿ÍÈËÉúÔ´µØ</td>
		<td>¿ÍÈËÀàÐÍ</td>
		</tr>

		<% 
			for(Object[] obj:list)
			{
				out.println("<tr>");
				out.println("<td>"+obj[0]+"</td>");
				out.println("<td>"+obj[1]+"</td>");
				out.println("<td>"+obj[2]+"</td>");
				out.println("<td>"+obj[3]+"</td>");
				out.println("<td>"+obj[4]+"</td>");
				out.println("<td>"+obj[5]+"</td>");
				out.println("<td>"+obj[6]+"</td>");
				out.println("<td>"+obj[7]+"</td>");
				out.println("</tr>");
			}
		}
		%>
</table>
</body>
</html>