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
		  
		  //����һ���µĹ�������fileName �������ļ����Լ�·����
		  WritableWorkbook wwb = null;
		  WritableSheet ws = null;
		  try {
		   wwb = Workbook.createWorkbook(fileName);
		    ws = wwb.createSheet("sheettest", 0);//�����������һ������������Ϊ sheettest.
		  } catch (IOException e) {
		   // TODO Auto-generated catch block
		   e.printStackTrace();
		  }
		  int i = 0;
		  int j = 0;
		  //����forѭ�������rs.getMetaData().GetColumnCount() ��ȡ���ݿ���ĳ�����������
		  for (int k = 0; k < rs.getMetaData().getColumnCount(); k++) 
		  {
		   //rs.getMetaData().getColumnName()��ȡ�������������ӵ� excel��Label��,Label(i,j,s)��ʾi��j�����s,s������String
		   ws.addCell(new Label(k, 0, rs.getMetaData().getColumnName(k + 1)));
		  }
		  while (rs.next()) {
		   //�㷨������������ݿ������з��ϵ����ݵ�excel��
		   for (int k = 0; k < rs.getMetaData().getColumnCount(); k++) {
		    ws.addCell(new Label(k, j + i + 1, rs.getString(k + 1)));
		   }
		   i++;
		  }
		  wwb.write();//д�빤����
		  wwb.close();//�رչ�����
		  rs.close();//�رս����
		}
	   public  boolean checkin_Excel(String filepath,String hname) throws UnsupportedEncodingException
	   {
		   boolean flag=false;
		   try {
		   String sql="select * from customer_checkin_info where hname='"+hname+"'";
		   ResultSet rs=DBHelper.executeQuery(sql);
		   File newFile = new File(filepath);
		   //Runtime.getRuntime().exec("chmod 777 "+filepath); 
		   newFile.setExecutable(true,false);//���ÿ�ִ��Ȩ��
		   newFile.setReadable(true,false);//���ÿɶ�Ȩ�� 
		   newFile.setWritable(true,false);//���ÿ�дȨ�� 
		   WriteExcel(newFile,rs);
		   flag=true;
		   }catch(Exception e)
		   {
			   e.printStackTrace();
		   }
		   return flag;
	   }
}
