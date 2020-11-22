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
		<span>客户信息录入</span>
		</h1>
		
       	 <label>
       	 <span>身份证号码:</span><input type="text" name="cid" placeholder="请输入15或者18位的身份证号" pattern="([0-9]{17}[0-9|Xx]|([0-9]{14}[0-9|Xx]))" value="<%=request.getParameter("cid")==null?"":request.getParameter("cid")%>">
   		</label>
   		<label>
       	 <span>客户姓名:</span><input type="text" name="cname" required placeholder="请输入客人的姓名"value="<%=request.getParameter("cname")==null?"":request.getParameter("cname")%>">
   		</label>
   		<label>
   		<span>性别:</span>
   		<input name="csex" type="text" list="sexlist" style="padding:0.5em;border-radius:10px;">
            <datalist id="sexlist">
                <option value="男">男</option>
				<option value="女">女</option>
            </datalist>
         </label>
         <label>
   		</label>
   		<label>
   		<span>地址:</span><input type="text" name="caddress" required placeholder="请输入客人的现居地址"value="<%=request.getParameter("caddress")==null?"":request.getParameter("caddress")%>">
   		</label>工作单位:<input type="text" name="cwork" required placeholder="请输入客人的工作单位"value="<%=request.getParameter("cwork")==null?"":request.getParameter("cwork")%>">
   		<label>
   		<span>生源地:</span>
   		<input type="text" name="chome" required placeholder="请输入客人的生源地"value="<%=request.getParameter("chome")==null?"":request.getParameter("chome")%>">
   		</label><br/><br/><br/>
   		<h1>
   		<span>客人入住信息录入</span>
   		</h1>
   		<label>
   		<span>房间号:</span>
   		<input type="text" name="rno" required placeholder="请输入客人想住的房间号(1001-6005)" pattern="([1-6][0][0][1-5])" value="<%=request.getParameter("rno")==null?"":request.getParameter("rno")%>">
   		
   		</label>
   		<label>
   		<span>入住时间:</span>
   		<input type="date" value="2020-11-18" min="2020-11-18" name="checkin_date"value="<%=request.getParameter("checkin_date")==null?"":request.getParameter("checkin_date")%>">
   		</label>
   		<label>
   		<span>预计离开时间:</span>
   		<input type="date" value="2020-11-19" min="2020-11-19" name="support_date"value="<%=request.getParameter("support_date")==null?"":request.getParameter("support_date")%>">
  	 	</label>
  	 	<input type="reset" class="button" value="清空">
  	 	<input type="submit" class="button" value="登记" onClick="return window.confirm('确认要登记嘛？')">
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
			 out.println("<script language='javascript'>alert('当前房间人数已达上限')</script>");
		else if(age<18)
		{
			 out.println("<script language='javascript'>alert('未成年人无法入住')</script>");
		}
		else if(!csex.equals("男")&&!csex.equals("女"))
		{
			out.println("<script language='javascript'>alert('请输入正确的性别')</script>");
		}
		else if(sdf.parse(checkin_date).getTime()>sdf.parse(support_date).getTime())
		{
			out.println("<script language='javascript'>alert('预计离开时间应该大于入住时间')</script>");
		}
		else{
		out.println("<script language='javascript'>alert('您需要缴纳的押金为:"+cd.plege(checkin_date, support_date)+"')</script>");
	    Customer c=new Customer(cid,cname,csex,cage,caddress,cwork,chome,"普通客户",cd.max_cno()+1,rno,hname,checkin_date,support_date,cd.plege(checkin_date, support_date));
	    cd.login(c);
	    out.println("<script language='javascript'>alert('插入成功')</script>");
		}
	}
	else
	{
		out.println("<script language='javascript'>alert('身份证必须为15/18位请重新输入')</script>");
	}
}
%>

</body>
</html>