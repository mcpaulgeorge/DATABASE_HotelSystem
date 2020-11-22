package Util;
import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import jxl.Workbook;
import jxl.write.Label;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import Dao.*;
public class Sql_Excel {
	public Sql_Excel()
	{
		
	}
	public  void WriteExcel(File fileName,ResultSet rs) throws Exception{
		  
		  //创建一个新的工作薄，fileName 包含了文件名以及路径。
		  WritableWorkbook wwb = null;
		  WritableSheet ws = null;
		  try {
		   wwb = Workbook.createWorkbook(fileName);
		    ws = wwb.createSheet("sheettest", 0);//给工作薄添加一个工作表，命名为 sheettest.
		  } catch (IOException e) {
		   // TODO Auto-generated catch block
		   e.printStackTrace();
		  }
		  int i = 0;
		  int j = 0;
		  //下面for循环里面的rs.getMetaData().GetColumnCount() 获取数据库中某个表的列总数
		  for (int k = 0; k < rs.getMetaData().getColumnCount(); k++) 
		  {
		   //rs.getMetaData().getColumnName()获取表的列名。并添加到 excel表Label里,Label(i,j,s)表示i列j行添加s,s必须是String
		   ws.addCell(new Label(k, 0, rs.getMetaData().getColumnName(k + 1)));
		  }
		  while (rs.next()) {
		   //算法，依次添加数据库中所有符合的数据到excel中
		   for (int k = 0; k < rs.getMetaData().getColumnCount(); k++) {
		    ws.addCell(new Label(k, j + i + 1, rs.getString(k + 1)));
		   }
		   i++;
		  }
		  wwb.write();//写入工作薄
		  wwb.close();//关闭工作薄
		  rs.close();//关闭结果集
		}
	   public  boolean checkin_Excel(String filepath,String hname) throws UnsupportedEncodingException
	   {
		   boolean flag=false;
		   try {
		   String sql="select * from customer_checkin_info where hname='"+hname+"'";
		   ResultSet rs=DBHelper.executeQuery(sql);
		   File newFile = new File(filepath);
		   //Runtime.getRuntime().exec("chmod 777 "+filepath); 
		   newFile.setExecutable(true,false);//设置可执行权限
		   newFile.setReadable(true,false);//设置可读权限 
		   newFile.setWritable(true,false);//设置可写权限 
		   WriteExcel(newFile,rs);
		   flag=true;
		   }catch(Exception e)
		   {
			   e.printStackTrace();
		   }
		   return flag;
	   }
}
