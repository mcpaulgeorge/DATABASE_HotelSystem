<%@ page language="java" import="java.sql.*,java.util.*,Dao.*" 
    pageEncoding="gbk"%>
<!DOCTYPE html>  
<html lang="en">  
<head>  
<link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">  
<script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
<script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<link rel="stylesheet" type="text/css" href="css/login.css"/>  
    <meta charset="UTF-8">  
    <title>Login</title>  
    <style>
    body{   
    width: 100%;   
    height: 100%;   
    font-family: 'Open Sans',sans-serif;   
    margin: 0;   
    background:url(image/background.jpg);
    background-size: 100% 100%;
    background-repeat: no-repeat;
    background-attachment:fixed;
}   
    </style>
</head>  
<body>  
	<div id="carousel-example-generic" class="carousel slide" data-ride="carousel" data-interval="2000">
  <!-- Indicators -->
  <ol class="carousel-indicators">
    <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
    <li data-target="#carousel-example-generic" data-slide-to="1"></li>
    <li data-target="#carousel-example-generic" data-slide-to="2"></li>
    <li data-target="#carousel-example-generic" data-slide-to="3"></li>
    <li data-target="#carousel-example-generic" data-slide-to="4"></li>
    <li data-target="#carousel-example-generic" data-slide-to="5"></li>
  </ol>

  <!-- Wrapper for slides -->
  <div class="carousel-inner" role="listbox">
    <div class="item active" style="width:500px;height:270px">
      <img src="image/普通标间.jpg"  alt="">
      <div class="carousel-caption">
        <h3>普通标间</h3>
      </div>
    </div>
    <div class="item"style="width:500px;height:270px">
      <img src="image/普通大床.jpg"  alt="">
      <div class="carousel-caption" >
        <h3>普通大床</h3>
      </div>
    </div>
    <div class="item" style="width:500px;height:270px">
      <img src="image/商务标间.jpg"   alt="">
      <div class="carousel-caption" >
        <h3>商务标间</h3>
      </div>
    </div>
    <div class="item" style="width:500px;height:270px">
      <img src="image/商务大床.jpg" alt="">
      <div class="carousel-caption"  >
        <h3>商务大床</h3>
      </div>
    </div>
    <div class="item" style="width:500px;height:270px">
      <img src="image/套房.jpg" class="room" alt="">
      <div class="carousel-caption" >
        <h3>套房</h3>
      </div>
    </div>
    <div class="item" style="width:500px;height:270px">
      <img src="image/总统套房.jpg" class="room"  alt="">
      <div class="carousel-caption">
        <h3 style="float:bottom">总统套房</h3>
      </div>
    </div>
  </div>

  <!-- Controls -->
  <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
    <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
    <span class="sr-only">Previous</span>
  </a>
  <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
    <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
    <span class="sr-only">Next</span>
  </a>
</div>
    <div id="login">  
        <h1>Login</h1>  
        <form action="login.jsp" method="post">  
          <span class="glyphicon glyphicon-user"></span> <strong>用户名:</strong><input type="text" required="required" placeholder="用户名" name="u"></input><br>  
        <span class="glyphicon glyphicon-lock"></span> <strong>密码:</strong><input type="password" required="required" placeholder="密码" name="p"></input><br>
                    <strong>验证码:</strong><br>
                    <input type="text" style="width: 170px;height: 40px;margin-bottom: 20px;outline: none;    padding: 10px;    font-size: 13px;   color: #fff; " name="validationCode" id="validationCode" required pattern="[0-9]{4}"/>  
              <!--<img id="validationCode_img"  src="validate.jsp"><br>-->
              <img src="validate.jsp"  id="picture" onClick="change()" id="picture" >
                <!--点击验证码可以进行动态刷新  --> 
                <script src="js/Change.js">
                </script>
                <button class="but" type="submit">登录</button>  
        </form>  
    </div>  
    <%
    request.setCharacterEncoding("gb2312");
	response.setCharacterEncoding("gb2312");
	ResultSet rs=null;
	CheckinDao cd=new CheckinDao();
	rs=cd.username_password();
    String username=request.getParameter("u");
    String password=request.getParameter("p");
    String checkcode=request.getParameter("validationCode");
    String hname=null;
    boolean flag=true;
    if(username!=null&&password!=null&&checkcode!=null)
    {
    	if(checkcode.equals(session.getAttribute("randomCode")))
    	{
  		 	if(username.equals("wanhua"))
   		 	{
    			hname="万华";
  			 }
   	 		else if(username.equals("wanhuafen1"))
   			 {
    			hname="万华分1";	
    		}
  			while(rs.next())
  			{
  				int i=rs.getRow();
   				if(username.equals(rs.getString(1))&&password.equals(rs.getString(2))&&i==1)
    			{
   					flag=false;
    				session.setAttribute("hname","万华");
    				out.println("<script language='javascript'>alert('欢迎您登陆万华')</script>");
    				response.setHeader("Refresh","1;URL=main.html");
	  		  	}
   			 	if(username.equals(rs.getString(2))&&password.equals(rs.getString(2))&&i==2)
    			{
   					flag=false;
    				session.setAttribute("hname","万华分1");
    				out.println("<script language='javascript'>alert('欢迎您登陆万华分1')</script>");
    				response.setHeader("Refresh","1;URL=main.html");
    			}
   			
  			}
  				if(flag)
  				out.println("<script language='javascript'>alert('您输入的用户名或者密码有误')</script>");
    	}
    	else
    	{
    		out.println("<script language='javascript'>alert('验证码有误')</script>");
    	}
    }
    %>
</body>  
</html>  