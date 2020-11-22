package Util;
import java.text.SimpleDateFormat;
import java.util.Calendar;

public class Cal {
	 public static String getFirstDayOfMonth(int year,int month){
	        Calendar cal = Calendar.getInstance();
	        cal.set(Calendar.YEAR,year); //�������
	        cal.set(Calendar.MONTH, month-1);  //�����·�
	        int firstDay = cal.getActualMinimum(Calendar.DAY_OF_MONTH); //��ȡĳ����С����
	        cal.set(Calendar.DAY_OF_MONTH, firstDay);    //�����������·ݵ���С����
	        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); //��ʽ������
	        String firstDayOfMonth = sdf.format(cal.getTime());
	        return firstDayOfMonth;
	    }

	    /**
	     * @param year
	     * @param month
	     * @return ��ø������һ��
	     */
	    public static String getLastDayOfMonth(int year,int month){
	        Calendar cal = Calendar.getInstance();
	        cal.set(Calendar.YEAR,year); //�������
	        cal.set(Calendar.MONTH, month-1); //�����·�
	        int lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);    //��ȡĳ���������
	        cal.set(Calendar.DAY_OF_MONTH, lastDay);   //�����������·ݵ��������
	        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");  //��ʽ������
	        String lastDayOfMonth = sdf.format(cal.getTime());
	        return lastDayOfMonth;
	    }
	 public static void main(String[] args) {
		 Integer time[] = {1,2,3,4,5,6,7,8,9,10,11,12}; 
		 for (Integer integer : time) {
		 System.out.println(Cal.getFirstDayOfMonth(2020,integer+1));
		 }
		}

}
