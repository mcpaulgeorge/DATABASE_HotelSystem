package Dao;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
public class CheckinDao {
	public static String hname;
	public CheckinDao(String hname)
	{
		this.hname=hname;
	}
	public CheckinDao()
	{
		
	}
	//--------------入住系统：---------------------------------------------
	public List<Object[]> empty_rno_price(String rkind)//获取该类房间的空房间的房间号和对应价格（入住的第一个界面）
	{
		List<Object[]> list=new ArrayList<Object[]>();
		try {
			list=DBHelper.execute_pro1("{call checkin_empty_price('"+rkind+"','"+hname+"')}");
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return list;
	}
	public void login(Customer c)//信息录入
	{
		if(!isExistCid(c.getCid()))
		{
		String sql_info="insert into customer_info values(?,?,?,?,?,?,?,?)";
		String sql_checkin="insert into customer_checkin_info values(?,?,?,?,?,?,?,?,?)";
		DBHelper.executeUpdateByParams(sql_info,c.getCid(),c.getCname(),c.getCsex(),c.getCage(),c.getCaddress(),c.getCwork(),c.getChome(),c.getCkind());
		DBHelper.executeUpdateByParams(sql_checkin,c.getCno(),c.getRno(),c.getHname(),c.getCid(),c.getCheckin_date(),c.getSupport_date(),c.getCheckout_date(),c.getPlege(),c.getCost());
		}
		else
		{
			String sql_checkin="insert into customer_checkin_info values(?,?,?,?,?,?,?,?,?)";
			DBHelper.executeUpdateByParams(sql_checkin,c.getCno(),c.getRno(),c.getHname(),c.getCid(),c.getCheckin_date(),c.getSupport_date(),c.getCheckout_date(),c.getPlege(),c.getCost());
		}
			
		}
	public int max_cno()//检索现在客户序号的最大值
	{
		int max=0;
		try {
			String sql="select max(cno) from customer_checkin_info";
			ResultSet rs=DBHelper.executeQuery(sql);
			if(rs.next())
				max=rs.getInt(1);
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return max;
	}
	//--------------------登录界面-------------------------------------
	public ResultSet username_password()//获取数据库内用户密码信息
	{
		ResultSet rs=null;
		try
		{
			String sql="select username,password from user_info";
			rs=DBHelper.executeQuery(sql);
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return rs;
	}
	//-----------------退房系统---------------------------------
	public String[] get_uncheckout_rno()//获取未退房的房间号
	{
		String[] rno=null;
		try {
			String sql="select distinct(rno) from uncheckout where hname='"+hname+"'";
			ResultSet rs=DBHelper.executeQuery(sql);
			rs.last();
			int count=rs.getRow();
			rno=new String[count];
			rs.absolute(0);
			int i=0;
			while(rs.next())
			{
			 rno[i]=rs.getString(1);
			 i++;
			}
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return rno;
	}
	
	public String get_cost(String rno,String checkin_date)
	{
		String cost=null;
		try {
			String sql="select cost from customer_checkin_info where hname='"+hname+"' and rno='"+rno+"' and checkin_date='"+checkin_date+"'";
			cost=DBHelper.executeQueryAsSingle(sql).toString();
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return cost;
	}
	public String get_checkin_date(String rno)//获取房间号的入住时间
	{
		String checkin_date=null;
		try {
			String sql="select checkin_date from uncheckout where  rno='"+rno+"' and hname='"+hname+"'";
			checkin_date=DBHelper.executeQueryAsSingle(sql).toString();
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return checkin_date;
	}
	public void update_checkout_date(String rno,String checkin_date,String checkout_date)//更新退房时间
	{
		try {
			String sql="update customer_checkin_info set checkout_date=? where hname=? and checkin_date=? and rno=?";
			DBHelper.executeUpdateByParams(sql,checkout_date,hname,checkin_date,rno);
		}catch(Exception e)
		{
			e.printStackTrace();
		}
	}
	//-----------------------------查询系统------------------------------------------
	
	public String CidBy_rno_checkin_date(String rno,String checkin_date)//通过入住时间和房间号查到身份证号码
	{
		String cid=null;
		try {
			String sql="select cid from uncheckout where rno='"+rno+"' and hname='"+hname+"' and checkin_date='"+checkin_date+"'";
			ResultSet rs=DBHelper.executeQuery(sql);
			if(rs.next())
			{
			cid=rs.getString(1);
			}
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return cid;
	}
	
	
	public boolean isExistCid(String cid)
	{
		boolean flag=false;
		String sql="select cid from customer_info";
		List<Object[]> list=DBHelper.executeQueryAsList(sql);
		for(int i=0;i<list.size();i++)
		{
			if(cid.equals(list.get(i)[0].toString()))
			{
			flag=true;
			}
		}
		return flag;
	}
	public String[] part_all_rno(String cid,String cname)//根据客人的身份证号码和姓名查客人全部信息和所在房间号(没退房)
	{
		String[] c=new String[9];
		try {
			String sql="{call search_customer('"+cid+"','"+cname+"','"+hname+"')}";
			ResultSet rs=DBHelper.execute_pro(sql);
			if(rs.next())
			{
				c[0]=rs.getString(1);
				c[1]=rs.getString(2);
				c[2]=rs.getString(3);
				c[3]=rs.getString(4);
				c[4]=rs.getString(5);
				c[5]=rs.getString(6);
				c[6]=rs.getString(7);
				c[7]=rs.getString(8);
				c[8]=rs.getString(9);
			}
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return c;
	}
	public Object[][] rno_customer_info(String rno)//通过房间号查询入住客人信息(i行9列)
	{
		Object[][] obj=null;
		try{
			String sql="select c.cid,cname,csex,cage,caddress,cwork,chome,ckind from customer_checkin_info ci,customer_info c where ci.cid=c.cid and rno='"+rno+"' and hname='"+hname+"' and checkout_date is null";
			ResultSet rs=DBHelper.executeQuery(sql);
			rs.last();
			int count=rs.getRow();
			obj=new Object[count][8];
			rs.absolute(0);
			int i=0;
			while(rs.next())
			{
			obj[i][0]=rs.getString(1);
			obj[i][1]=rs.getString(2);
			obj[i][2]=rs.getString(3);
			obj[i][3]=rs.getString(4);
			obj[i][4]=rs.getString(5);
			obj[i][5]=rs.getString(6);
			obj[i][6]=rs.getString(7);
			obj[i][7]=rs.getString(8);
			i++;	
			}
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return obj;
	}
	public String[][] showon_ExpireCustomer()//查询已经到了预计离开时间的顾客
	{
		String[][] s = null;
		try {
			String sql="select cno,support_date,check_day,plege,rno,additional from expire_remind where additional=0 and hname='"+hname+"'";
		ResultSet rs=DBHelper.executeQuery(sql);
		rs.last();
		int count=rs.getRow();
		rs.absolute(0);
		s=new String[count][6];
		int i=0;
		while(rs.next())
		{
		s[i][0]=rs.getString(1)+" ";
		s[i][1]=rs.getString(2)+" ";
		s[i][2]=rs.getString(3)+" ";
		s[i][3]=rs.getString(4)+" ";
		s[i][4]=rs.getString(5)+" ";
		s[i][5]=rs.getString(6)+" ";
		i++;
		}
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return s;
	}
	public String[][] showover_ExpireCustomer()//查询超过了预计离开时间的顾客
	{
		String[][] s = null;
		try {
			String sql="select cno,support_date,check_day,plege,rno,additional from expire_remind where additional>0 and hname='"+hname+"'";
		ResultSet rs=DBHelper.executeQuery(sql);
		rs.last();
		int count=rs.getRow();
		rs.absolute(0);
		s=new String[count][6];
		int i=0;
		while(rs.next())
		{
		s[i][0]=rs.getString(1)+" ";
		s[i][1]=rs.getString(2)+" ";
		s[i][2]=rs.getString(3)+" ";
		s[i][3]=rs.getString(4)+" ";
		s[i][4]=rs.getString(5)+" ";
		s[i][5]=rs.getString(6)+" ";
		i++;
		}
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return s;
	}
	public Object[] search_checkinByCid(String cid,String checkin_date)//通过身份证号码查询未退房住宿信息
	{
		Object[] s=null;
		try
		{
			String sql="select plege,real_day,rprice,cost,margin from checkin_inf where cid='"+cid+"' and checkin_date='"+checkin_date+"' and hname='"+hname+"'";
		ResultSet rs=DBHelper.executeQuery(sql);
		s=new String[5];
		if(rs.next())
		{
			s[0]=rs.getString(1);
			s[1]=rs.getString(2);
			s[2]=rs.getString(3);
			s[3]=rs.getString(4);
			s[4]=rs.getString(5);
		}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return s;
	}
	public Object[][] search_ByCid(String cid)//通过身份证号码查询历史住宿信息
	{
		Object[][] s=null;
		try
		{
			String sql="select plege,real_day,rprice,cost,margin from checkin_inf where cid='"+cid+"' and hname='"+hname+"'";
		ResultSet rs=DBHelper.executeQuery(sql);
		rs.last();
		int count=rs.getRow();
		rs.absolute(0);
		s=new String[count][5];
		int i=0;
		while(rs.next())
		{
			s[i][0]=rs.getString(1);
			s[i][1]=rs.getString(2);
			s[i][2]=rs.getString(3);
			s[i][3]=rs.getString(4);
			s[i][4]=rs.getString(5);
			i++;
		}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return s;
	}
	
	
	//---------------------------------统计系统----------------------------------------------
	public Object[] static_checkin(String rkind,String start_time,String end_time)//一个房间总数一个入住人总数
	{
		Object[] obj=new Object[2];
		try {
		String sql="select count(distinct checkin_date),count(*) from main_view where hname='"+hname+"' and rkind='"+rkind+"' and checkin_date<='"+end_time+"' and checkout_date>='"+start_time+"'";
		ResultSet rs=DBHelper.executeQuery(sql);
		if(rs.next())
		{
			obj[0]=rs.getString(1);
			obj[1]=rs.getString(2);
		}
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return obj;
	}
	public int static_money(String start_time,String end_time)//统计月度收入
	{
		int sum=0;
		try {
		String sql="{call static_money('"+hname+"','"+start_time+"','"+end_time+"')}";
		ResultSet rs=DBHelper.execute_pro(sql);
		if(rs.next())
		{
			sum=rs.getInt(1);
		}
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return sum;
	}
	public String static_checkin_rate(String rkind,String start_time,String end_time)
	{
		String cr=null;
		double rate=0;
		try {
			String sql="{call static_checkin_rate('"+rkind+"','"+hname+"','"+start_time+"','"+end_time+"')}";
			ResultSet rs=DBHelper.execute_pro(sql);
           if(rs.next())
           {
            rate=rs.getDouble(1);
           }
           rate=rate*100;
           cr=rate+"%";
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return cr;
	}
	/*public Object[] empty_room(String rkind)//根据需要的房间种类与酒店名称显示目前空房的数目与客房号以及对应的价格
	{
		    String sql_empty_count="select count(*) from room_info where rkind='"+rkind+"' and cur_num=0 and hname='"+hname+"'";
		    System.out.println(sql_empty_count);
			int count_empty=Integer.parseInt((DBHelper.executeQueryAsSingle(sql_empty_count)).toString());
			Object[] empty =new Object[count_empty+1];
			empty[0]=count_empty;//empty第一个存数目，后面都是客房号
			//String sql_empty_price="select rprice from room_price rp,room_info ri where rp.rkind=ri.rkind and rp.hname=ri.hname and rp.rkind="+rkind+" and ri.cur_num=0 and ri.hname="+hname;
			//empty[1]=DBHelper.executeQueryAsSingle(sql_empty_price);
		try {
			String sql_empty_rno="select rno from room_info where rkind='"+rkind+"' and cur_num=0 and hname='"+hname+"'";
			ResultSet rs=DBHelper.executeQuery(sql_empty_rno);
			int i=1;
			while(rs.next())
			{
				empty[i]=rs.getString(1);
				i++;
			}	
		}catch(Exception e)
		{
			e.printStackTrace();
		}
	return empty;
	}*/
	/*public Object[] unempty_room(String rkind)//根据需要的房间种类显示目前入住房间的数目与客房号以及对应的价格
	{
		    String sql_unempty_count="select count(*) from room_info where rkind ='"+rkind+"' and cur_num!=0 and hname='"+hname+"'";
		    int count_unempty=Integer.parseInt((DBHelper.executeQueryAsSingle(sql_unempty_count)).toString());
			Object[] unempty =new Object[(count_unempty)*2+1];
			unempty[0]=count_unempty;//empty第一个存数目，后面都是客房号与目前的房间人数的一对一对
			//String sql_unempty_price="select rprice from room_price rp,room_info ri where rp.rkind=ri.rkind and rp.hname=ri.hname and rp.rkind="+rkind+" and ri.rstate=1 and ri.hname="+hname;
			//unempty[1]=DBHelper.executeQueryAsSingle(sql_unempty_price);
		try {
			String sql_unempty_rno="select rno,cur_num from room_info where rkind='"+rkind+"' and cur_num>0 and hname='"+hname+"'";
			ResultSet rs=DBHelper.executeQuery(sql_unempty_rno);
			int i=1;
			while(rs.next())
			{
				unempty[i]=rs.getString(1);
				i++;
				unempty[i]=rs.getInt(2);
				i++;
			}	
		}catch(Exception e)
		{
			e.printStackTrace();
		}
	return unempty;
	}*/
	//界面容错：
	public int plege(String checkin_date,String support_date)//计算出押金
	{
		int plege = 0;
		try {
			String sql="select datediff(day,'"+checkin_date+"','"+support_date+"')";
			System.out.println(sql);
		ResultSet rs=DBHelper.executeQuery(sql);
		if(rs.next())
			plege=rs.getInt(1);
		plege=plege*1000;
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return plege;
	}
	public int max_num(String rno)//房间允许容纳最大人数
	{
		String sql="select max_num from room_info where rno='"+rno+"'and hname='"+hname+"'";
		int max=Integer.parseInt(DBHelper.executeQueryAsSingle(sql).toString());
        return max;
	}
	public int cur_num(String rno)//房价目前容纳人数
	{
		String sql="select cur_num from room_info where rno='"+rno+"' and hname='"+hname+"'";
		int cur=Integer.parseInt(DBHelper.executeQueryAsSingle(sql).toString());
        return cur;
	}
	
	/*public boolean checkout_checkin(String rno,String checkout_date)//判断退房时输入的退房时间是否大于入住时间，大于返回true，不大于返回false
	{
		boolean flag=false;
		try
		{
			String sql="select datediff(day,checkin_date,'"+checkout_date+"') from uncheckout where rno="+rno;
			int datediff=Integer.parseInt(DBHelper.executeQueryAsSingle(sql).toString());
			System.out.println(datediff);
			if(datediff>0)
				flag=true;
			
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return flag;
	}*/
	

	
	/*public int count_cost(int cno,String rno,String checkout_date)
	{
		
			int cost1=Integer.parseInt((DBHelper.execute_pro_count_cost("{call count_cost(?,?,?,?)}",cno,rno,checkout_date)).toString());
			System.out.println(cost1);
			return cost1;
	}*/
	
	public static void main(String []args) throws ParseException
	{
		CheckinDao cd=new CheckinDao("万华");
		/*
		Object[] o=cd.unempty_room("普通标间");
		System.out.println("目前的非空房总数");
		System.out.println(o[0]);
		System.out.print("房间号  ");
		System.out.println("目前入住人数");
		for(int i=1;i<o.length;i++)
		{
			System.out.print(o[i]+" ");
			System.out.println(o[i+1]);
			i++;
		}*/
		/*
		Object[] o=cd.empty_room("普通标间");
		System.out.println("目前的空房总数");
		System.out.println(o[0]);
		System.out.println("价格为:");
		System.out.println(o[1]);
		System.out.print("房间号  ");
		for(int i=2;i<o.length;i++)
		{
			System.out.print(o[i]+" ");
		}*/
		//System.out.println(cd.plege("2020-09-01","2020-09-05"));
		//cd.count_cost(2,"6001","2020-10-20");
		/*String [][] s=cd.showExpireCustomer();
		for(int i=0;i<s.length;i++)
		{
			for(int j=0;j<6;j++)
			System.out.print(s[i][j]+" ");
			System.out.println();
		}*/
	/*	List<Object[]> list=cd.empty_rno_price("总统套房");
		for(int i=0;i<list.size();i++)
		{
			System.out.print(list.get(i)[0]+"  ");	
			System.out.println(list.get(i)[1]);
		}*/
		/*Object[] obj=cd.static_checkin("套房","2020-01-01","2020-10-31");
		System.out.println("已住房间总数  已住房客总数");
		System.out.println(obj[0]+"      	 "+obj[1]);*/
				//System.out.println(cd.static_money("2020-10-25","2020-10-31"));
		
		/*Object[][] obj=cd.rno_customer_info("2001");
		for(int i=0;i<obj.length;i++)
		{
			for(int j=0;j<8;j++)
				{System.out.print(obj[i][j]+" ");
				}System.out.println();
		}*/
		/*Customer c=new Customer("310230200006142915","傻逼","男","21","上海","生全部","上海","普通客户",cd.max_cno()+1,"5001","万华","2020-05-06","2020-05-07",null,1000);
		cd.login(c);*/
		
		/*Object[][] s=cd.search_ByCid("310230200006142914");
		for(int i=0;i<s.length;i++)
		{
			for(int j=0;j<5;j++)
				System.out.print(s[i][j]+" ");
			
		}*/
		/*boolean test=cd.checkout_checkin("3001","2020-07-09");
		System.out.println(test);*/
		/*String[] rno=cd.get_uncheckout_rno();
		for(int i=0;i<rno.length;i++)
		System.out.println(rno[i]);*/
		//System.out.println(cd.get_checkin_date("1001"));
		//System.out.println(cd.get_cost("1001",cd.get_checkin_date("1001")));
		/*String[][] expire=cd.showover_ExpireCustomer();
		for(int i=0;i<expire.length;i++)
		{
			for(int j=0;j<6;j++)
			System.out.print(expire[i][j]+" ");
			System.out.println();
		}*/
		//System.out.println(cd.static_checkin_rate("套房","2020-10-25","2020-10-27"));
		/*Object[] obj=cd.search_checkinByCid("310230200006142914","2020-10-26");
		for(int i=0;i<obj.length;i++)
		{
			System.out.print(obj[i]+" ");
		}*/
		//System.out.println(cd.CidBy_rno_checkin_date("2001",cd.get_checkin_date("2001")));
		String[] s=cd.part_all_rno("130123199906097516","泽泽");
		for(int i=0;i<s.length;i++)
		{
			System.out.print(s[i]+"  ");
		}
	}
}
