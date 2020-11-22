package Dao;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
public class DBHelper {
	/* 定义driver,url,user,pwd等 */
	private static String driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
	private static String url = "jdbc:sqlserver://47.101.150.10;DatabaseName=Hotel";
	private static String user = "sa", pwd = "Tjh123456789";
	private static Connection con;
    /*加载驱动程序*/
	static {
		try {
			Class.forName(driver);
		} catch (Exception ex) {
ex.printStackTrace();
		}
	}
    /*执行增删改操作*/
	public static int executeUpdateByParams(String sql,Object...params) {
		int r=0;
		try {
			con = DriverManager.getConnection(url, user, pwd);
			 PreparedStatement pcmd=con.prepareStatement(sql,
				        ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
			 for(int i=0;i<params.length;i++)
			 {
				 Object param=params[i];
				 if(param instanceof Integer)
					 pcmd.setInt(i+1, new Integer(param.toString()));
				 else if(param instanceof Double)
					 pcmd.setDouble(i+1, new Double(param.toString()));
				 else if(param instanceof Float)
					 pcmd.setFloat(i+1, new Float(param.toString()));
				 else if(param instanceof String)
					 pcmd.setString(i+1, new String(param.toString()));
				 else
				 {
					 pcmd.setObject(i+1,param);
				 }
			 }
			r=pcmd.executeUpdate();
			con.close();
} catch (Exception ex) {
 ex.printStackTrace();

		}
		return r;
	}
	public static Object execute_pro_count_cost(String sql,int cno,String rno,String checkout_date) {//这里的i对于output输出参数位置
        Object obj = null;
		CallableStatement cs;
		try {
			con = DriverManager.getConnection(url,user,pwd);
			cs=con.prepareCall(sql);
			cs.registerOutParameter(4,Types.INTEGER);
			cs.setInt(1,cno);
			cs.setString(2,rno);
			cs.setString(3,checkout_date);
			cs.executeUpdate();
			obj=cs.getObject(4);
			con.close();
			}catch(Exception ex) {
				ex.printStackTrace();
			}
		return obj;
	}
	//执行存储过程--不带参数
		public static ResultSet execute_pro(String sql) {
			ResultSet rs=null;
			CallableStatement cs;
			try {
				con = DriverManager.getConnection(url,user,pwd);
				//PreparedStatement ff=con.prepareStatement(sql);
				//ff.setString(1, sql);
				Statement cmd=con.createStatement();
				cs=con.prepareCall(sql);
				rs=cs.executeQuery();
				}catch(Exception ex) {
					ex.printStackTrace();
				}
			return rs;
		}
		//执行存储过程不带参数，升级版
		public static List<Object[]> execute_pro1(String sql) {
			ResultSet rs=null;
			CallableStatement cs;
			List<Object[]> list=new ArrayList<Object[]>();
			try {
				con = DriverManager.getConnection(url,user,pwd);
				Statement cmd=con.createStatement();
				cs=con.prepareCall(sql);
				rs=cs.executeQuery();
				int cols=rs.getMetaData().getColumnCount();
				while(rs.next()) {
					Object[] arr=new Object[cols];
					for(int i=0;i<arr.length;i++) {
						arr[i]=rs.getObject(i+1);
					}
					list.add(arr);
				}con.close();
			}catch(Exception ex) {
					ex.printStackTrace();
			}
			return list;
		}


/*执行查询操作*/
	public static List<Object[]> executeQueryAsList(String sql)
	{
		ResultSet rs=null;
		List<Object[]> list=new ArrayList<Object[]>();
		try {
			con=DriverManager.getConnection(url,user,pwd);
			Statement cmd=con.createStatement();
			rs=cmd.executeQuery(sql);
			int cols=rs.getMetaData().getColumnCount();
			while(rs.next())
			{
				Object[] arr=new Object[cols];
				for(int i=0;i<arr.length;i++)
					arr[i]=rs.getObject(i+1);
				list.add(arr);
			}
			con.close();
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return list;
	}
	public static Object executeQueryAsSingle(String sql)
	{
		Object obj=null;
		try {
			con=DriverManager.getConnection(url,user,pwd);
			Statement cmd=con.createStatement();
			ResultSet rs=cmd.executeQuery(sql);
			if(rs.next())
			{
				obj=rs.getObject(1);
			}
			con.close();
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return obj;
	}
	public static ResultSet executeQuery(String sql) {
		ResultSet rs = null;
		try {
			con = DriverManager.getConnection(url, user, pwd);
			 PreparedStatement pcmd=con.prepareStatement(sql,
				        ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
			rs = pcmd.executeQuery();
		} catch (Exception ex) { 
ex.printStackTrace();
		}
		return rs;
	}
   /*执行关闭数据库连接操作*/
public static void closeConnection() {
		try {
           if(!con.isClosed())
			con.close();
		  } catch (Exception ex) {
		}
	}
}
