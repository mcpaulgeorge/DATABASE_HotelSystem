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
房间号:<input type="text" list="rnolist" name="rno" required value="<%=request.getParameter("rno")==null?"":request.getParameter("rno")%>">
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
<input type="submit" class="button" value="查询">
</form>
<%
String rno=request.getParameter("rno");
Object[][] list=cd.rno_customer_info(rno);
		if(rno!=null)
		{
		%>
		<table id="table" width ="100%" border=2>
		<tr>
		<td>客人身份证号码</td>
		<td>客人姓名</td>
		<td>客人性别</td>
		<td>客人年龄</td>
		<td>客人家庭住址</td>
		<td>客人工作单位</td>
		<td>客人生源地</td>
		<td>客人类型</td>
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