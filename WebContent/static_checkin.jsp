<%@ page language="java" import="java.sql.*,java.util.*,Dao.*,Util.*" 
    pageEncoding="gbk"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>ͳ����ס���</title>
<link rel="stylesheet" type="text/css" href="css/button.css"/> 
</head>
<body>
<% 
request.setCharacterEncoding("gb2312");
response.setCharacterEncoding("gb2312");
%>
<form action="static_checkin.jsp" method="post" autocomplete="off">
��<input type="date" name="start_time" required value="<%=request.getParameter("start_time")==null?"":request.getParameter("start_time")%>">
��<input type="date" name="end_time" required value="<%=request.getParameter("end_time")==null?"":request.getParameter("end_time")%>">
�������ͣ�<input type="text" name="rkind" list="rkindlist" required value="<%=request.getParameter("rkind")==null?"":request.getParameter("rkind")%>">
<datalist id="rkindlist">
<option value="��ͨ���">��ͨ���</option>
			<option value="��ͨ��">��ͨ��</option>
			<option value="������">������</option>
			<option value="�����">�����</option>
			<option value="�׷�">�׷�</option>
			<option value="��ͳ�׷�">��ͳ�׷�</option>
</datalist>
<input type="submit" value="ͳ��" class="button">
</form>
<%
String hname=session.getAttribute("hname").toString();
CheckinDao cd=new CheckinDao(hname);
String rkind=request.getParameter("rkind");
String start_time=request.getParameter("start_time");
String end_time=request.getParameter("end_time");
if(rkind!=null&&start_time!=null&&end_time!=null)
{
Object[] obj=cd.static_checkin(rkind, start_time, end_time);
out.println("<h1>���෿���ڸö�ʱ����ڵ���ס��������Ϊ"+obj[0]+",��ס��������Ϊ"+obj[1]+"</h1>");
}
%>
</body>
</html>