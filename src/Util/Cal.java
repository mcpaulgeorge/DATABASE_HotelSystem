package Util;
import java.text.SimpleDateFormat;
import java.util.Calendar;

public class Cal {
	 public static String getFirstDayOfMonth(int year,int month){
	        Calendar cal = Calendar.getInstance();
	        cal.set(Calendar.YEAR,year); //设置年份
	        cal.set(Calendar.MONTH, month-1);  //设置月份
	        int firstDay = cal.getActualMinimum(Calendar.DAY_OF_MONTH); //获取某月最小天数
	        cal.set(Calendar.DAY_OF_MONTH, firstDay);    //设置日历中月份的最小天数
	        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); //格式化日期
	        String firstDayOfMonth = sdf.format(cal.getTime());
	        return firstDayOfMonth;
	    }

	    /**
	     * @param year
	     * @param month
	     * @return 获得该月最后一天
	     */
	    public static String getLastDayOfMonth(int year,int month){
	        Calendar cal = Calendar.getInstance();
	        cal.set(Calendar.YEAR,year); //设置年份
	        cal.set(Calendar.MONTH, month-1); //设置月份
	        int lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);    //获取某月最大天数
	        cal.set(Calendar.DAY_OF_MONTH, lastDay);   //设置日历中月份的最大天数
	        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");  //格式化日期
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
