<%@ page language="java" import="java.sql.*,java.util.*,Dao.*,java.text.*,Util.*" 
    pageEncoding="gbk"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="gb2312">
<title>check_in</title>

<style type="text/css">

@media screen and (max-width: 600px) {
  input {
    width: 100%;
  }
  }
</style>
<link rel="stylesheet" type="text/css" href="css/checkin_info_form.css"/>  
</head>
<body>
		<form name="this_form" action="checkin.jsp" method="post" autocomplete="off" class="smart-green">
		<% request.setCharacterEncoding("gb2312");
		response.setCharacterEncoding("gb2312");
		Age a=new Age();
		%>
		<h1>
		<span>�ͻ���Ϣ¼��</span>
		</h1>
		
       	 <label>
       	 <span>���֤����:</span><input type="text" name="cid" placeholder="������15����18λ�����֤��" pattern="([0-9]{17}[0-9|Xx]|([0-9]{14}[0-9|Xx]))" value="<%=request.getParameter("cid")==null?"":request.getParameter("cid")%>">
   		</label>
   		<label>
       	 <span>�ͻ�����:</span><input type="text" name="cname" required placeholder="��������˵�����"value="<%=request.getParameter("cname")==null?"":request.getParameter("cname")%>">
   		</label>
   		<label>
   		<span>�Ա�:</span>
   		<input name="csex" type="text" list="sexlist" style="padding:0.5em;border-radius:10px;">
            <datalist id="sexlist">
                <option value="��">��</option>
				<option value="Ů">Ů</option>
            </datalist>
         </label>
         <label>
   		</label>
   		<label>
   		<span>��ַ:</span><input type="text" name="caddress" required placeholder="��������˵��־ӵ�ַ"value="<%=request.getParameter("caddress")==null?"":request.getParameter("caddress")%>">
   		</label>������λ:<input type="text" name="cwork" required placeholder="��������˵Ĺ�����λ"value="<%=request.getParameter("cwork")==null?"":request.getParameter("cwork")%>">
   		<label>
   		<span>��Դ��:</span>
   		<input type="text" name="chome" required placeholder="��������˵���Դ��"value="<%=request.getParameter("chome")==null?"":request.getParameter("chome")%>">
   		</label><br/><br/><br/>
   		<h1>
   		<span>������ס��Ϣ¼��</span>
   		</h1>
   		<label>
   		<span>�����:</span>
   		<input type="text" name="rno" required placeholder="�����������ס�ķ����(1001-6005)" pattern="([1-6][0][0][1-5])" value="<%=request.getParameter("rno")==null?"":request.getParameter("rno")%>">
   		
   		</label>
   		<label>
   		<span>��סʱ��:</span>
   		<input type="date" value="2020-11-18" min="2020-11-18" name="checkin_date"value="<%=request.getParameter("checkin_date")==null?"":request.getParameter("checkin_date")%>">
   		</label>
   		<label>
   		<span>Ԥ���뿪ʱ��:</span>
   		<input type="date" value="2020-11-19" min="2020-11-19" name="support_date"value="<%=request.getParameter("support_date")==null?"":request.getParameter("support_date")%>">
  	 	</label>
  	 	<input type="reset" class="button" value="���">
  	 	<input type="submit" class="button" value="�Ǽ�" onClick="return window.confirm('ȷ��Ҫ�Ǽ��')">
		</form>
<%
String cid=request.getParameter("cid");
if(cid!=null)
{
String hname=session.getAttribute("hname").toString();
CheckinDao cd=new CheckinDao(hname);
	if(cid.length()==15||cid.length()==18)
	{
		int age=a.IdNOToAge(cid);
		String csex=request.getParameter("csex");
		String cname=request.getParameter("cname");
		String cage=Integer.toString(age);
		String caddress=request.getParameter("caddress");
		String cwork=request.getParameter("cwork");
		String chome=request.getParameter("chome");
		String rno=request.getParameter("rno");
		String checkin_date=request.getParameter("checkin_date");
		String support_date=request.getParameter("support_date");
		DateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		if(cd.cur_num(rno)==cd.max_num(rno))
			 out.println("<script language='javascript'>alert('��ǰ���������Ѵ�����')</script>");
		else if(age<18)
		{
			 out.println("<script language='javascript'>alert('δ�������޷���ס')</script>");
		}
		else if(!csex.equals("��")&&!csex.equals("Ů"))
		{
			out.println("<script language='javascript'>alert('��������ȷ���Ա�')</script>");
		}
		else if(sdf.parse(checkin_date).getTime()>sdf.parse(support_date).getTime())
		{
			out.println("<script language='javascript'>alert('Ԥ���뿪ʱ��Ӧ�ô�����סʱ��')</script>");
		}
		else{
		out.println("<script language='javascript'>alert('����Ҫ���ɵ�Ѻ��Ϊ:"+cd.plege(checkin_date, support_date)+"')</script>");
	    Customer c=new Customer(cid,cname,csex,cage,caddress,cwork,chome,"��ͨ�ͻ�",cd.max_cno()+1,rno,hname,checkin_date,support_date,cd.plege(checkin_date, support_date));
	    cd.login(c);
	    out.println("<script language='javascript'>alert('����ɹ�')</script>");
		}
	}
	else
	{
		out.println("<script language='javascript'>alert('���֤����Ϊ15/18λ����������')</script>");
	}
}
%>

</body>
</html>