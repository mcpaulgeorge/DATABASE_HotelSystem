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
<script src="js/getdate.js">
</script>
<form name="this_form"action="checkout.jsp" method="post" autocomplete="off">
	�����:<input type="text" list="rno_list"  name="rno" required value="<%=request.getParameter("rno")==null?"":request.getParameter("rno")%>">
	<datalist id="rno_list">
	<%
	String hname=session.getAttribute("hname").toString();
	CheckinDao cd=new CheckinDao(hname);
	String[] rno_list=cd.get_uncheckout_rno();
	for(int i=0;i<rno_list.length;i++){
	%>
	<option value="<%=rno_list[i]%>"><%=rno_list[i]%></option>
	<%} %>
	</datalist>
	�˷�ʱ��:<input type="text" name="checkout_date" required placeholder="�����Աߵİ�ť��ȡ��ǰʱ��">
	<input type="button" class="button" onClick=getdate() value="��ȡ��ǰʱ��">
	<input type="submit" class="button" id="checkout" value="�˷�" onClick="return window.confirm('ȷ��Ҫ�˷���');">
</form>
<%
String rno=request.getParameter("rno");
if(rno!=null)
{
String checkin_date=cd.get_checkin_date(rno);
String checkout_date=request.getParameter("checkout_date");
String cId=cd.CidBy_rno_checkin_date(rno,checkin_date);
cd.update_checkout_date(rno,checkin_date, checkout_date);
out.println("<script>alert('�˷��ɹ�')</script>");
%>
<table id="table" width ="100%" border=2>
		<tr>
		<td>�ѽ���Ѻ������</td>
		<td>ʵ����ס����</td>
		<td>�ͷ��۸�</td>
		<td>ʵ��ס�޷�</td>
		<td>ס�޷Ѳ��</td>
		</tr>
		<%
		Object[] Cost=cd.search_checkinByCid(cId,checkin_date);
		out.println("<tr>");
		out.println("<td>"+Cost[0]+"</td>");
		out.println("<td>"+Cost[1]+"</td>");
		out.println("<td>"+Cost[2]+"</td>");
		out.println("<td>"+Cost[3]+"</td>");
		out.println("<td>"+Cost[4]+"</td>");
		out.println("</tr>");
		}
		%>
</table>
</body>
</html>