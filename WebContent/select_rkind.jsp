<%@ page language="java" import="java.sql.*,java.util.*,Dao.*" 
    pageEncoding="gbk"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>select</title>
<link rel="stylesheet" type="text/css" href="css/button.css"/> 
<style>
#table thead, #table tr {
border-top-width: 1px;
border-top-style: solid;
border-top-color: rgb(235, 242, 224);
}
#table {
border-bottom-width: 1px;
border-bottom-style: solid;
border-bottom-color: rgb(235, 242, 224);
}
 
/* Padding and font style */
#table td, #table th {
padding: 5px 10px;
font-size: 12px;
font-family: Verdana;
color: rgb(149, 170, 109);
}
 
/* Alternating background colors */
#table tr:nth-child(even) {
background: rgb(230, 238, 214)
}
#table tr:nth-child(odd) {
background: #FFF
}
</style>
</head>
<body>
		<form name="this_form" action="select_rkind.jsp" method="post" autocomplete="off">
		<%
		request.setCharacterEncoding("gb2312");
		response.setCharacterEncoding("gb2312");
		%>
			<input type="text" name="select_rkind" list="rkindlist" value="<%=request.getParameter("select_rkind")==null?"":request.getParameter("select_rkind")%>"><br>
			<datalist id="rkindlist">
			<option value="普通标间">普通标间</option>
			<option value="普通大床">普通大床</option>
			<option value="商务标间">商务标间</option>
			<option value="商务大床">商务大床</option>
			<option value="套房">套房</option>
			<option value="总统套房">总统套房</option>
			</datalist>
			<input type="submit" class="button" value="查询所选类型空房间号和价格" >
			
		</form>
		
		<%
		//String hname=session.getAttribute("hname").toString();
		String hname=session.getAttribute("hname").toString();
		String rkind=request.getParameter("select_rkind");
		CheckinDao cd=new CheckinDao(hname);
		List<Object[]>list=cd.empty_rno_price(rkind);
		%>
		<table id="table" width ="100%" border=2>
		<tr>
		<td>房间号</td>
		<td>价格</td>
		<td>最大容纳人数</td>
		</tr>
		<%
		for(Object[] l:list)
		{
			out.println("<tr>");
			out.println("<td>"+l[0]+"</td>");
			out.println("<td>"+l[1]+"</td>");
			out.println("<td>"+l[2]+"</td>");
			out.println("</tr>");
		}
		%>
		</table>
		
</body>
</html>