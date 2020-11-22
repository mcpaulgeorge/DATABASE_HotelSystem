package Util;

import java.text.SimpleDateFormat;
import java.util.Date;

public class Age {
	 public static int IdNOToAge(String IdNO){
	        int leh = IdNO.length();
	        String dates="";
	        if (leh == 18) {
	            dates = IdNO.substring(6, 10);
	            SimpleDateFormat df = new SimpleDateFormat("yyyy");
	            String year=df.format(new Date());
	            int u=Integer.parseInt(year)-Integer.parseInt(dates);
	            return u;
	        }else{//十五位身份证
	            String date = IdNO.substring(6, 8);
	            dates="19"+date;
	            SimpleDateFormat df = new SimpleDateFormat("yyyy");
	            String year=df.format(new Date());
	            int u=Integer.parseInt(year)-Integer.parseInt(dates);
	            return u;
	        }

	    }
	 public static void main(String[] args) {
	        System.out.println(IdNOToAge("35042487050620x")); //320621198804303
	    }
}
