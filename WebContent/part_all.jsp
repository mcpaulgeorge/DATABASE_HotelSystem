<%@ page language="java" import="java.sql.*,java.util.*,Dao.*" 
    pageEncoding="gbk"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>���ݿ��˲�����Ϣ�����ȫ����Ϣ</title>
 <link rel="stylesheet" type="text/css" href="css/table.css"/>  
 <link rel="stylesheet" type="text/css" href="css/button.css"/> 
</head>
<body>
<form action="part_all.jsp" method="post" autocomplete="off">
<%
request.setCharacterEncoding("gb2312");
		response.setCharacterEncoding("gb2312");
%>
���֤��<input type="text" name="cid" pattern="([0-9]{17}[0-9|Xx]|([0-9]{14}[0-9|Xx])" placeholder="������Ҫ��ѯ�����֤��" required value="<%=request.getParameter("cid")==null?"":request.getParameter("cid")%>">
������<input type="text" name="cname" placeholder="������Ҫ��ѯ������" required value="<%=request.getParameter("cname")==null?"":request.getParameter("cname")%>">
<input type="submit" class="button" value="��ѯ">
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
		<td>�������֤��</td>
		<td>��������</td>
		<td>�����Ա�</td>
		<td>��������</td>
		<td>���˼�ͥסַ</td>
		<td>���˹�����λ</td>
		<td>������Դ��</td>
		<td>��������</td>
		<td>������ס����</td>
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
	out.println("<script>alert('������ʮ��λ����ʮ��λ�����֤') </script>");
}
%>
	</table>
</body>
</html>