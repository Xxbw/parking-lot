package xbw.utils;

import java.util.Calendar;
import java.util.Date;

public class GetDateFormat {

    public static String getYear(Date date){
        Calendar now = Calendar.getInstance();
        now.setTime(date);
        Integer temp = now.get(Calendar.YEAR);
        String result = temp.toString();

        return result;
    }

    public static String getMonth(Date date){
        Calendar now = Calendar.getInstance();
        now.setTime(date);
        Integer tempY = now.get(Calendar.YEAR);
        Integer tempM = now.get(Calendar.MONTH) + 1;
        String tempStrM = "";
        if (tempM < 10){
            tempStrM = "0" + tempM;
        } else {
            tempStrM = ""+ tempM;
        }
        String result = tempY + "-" + tempStrM;
        return result;
    }

    public static String getDay(Date date){
        Calendar now = Calendar.getInstance();
        now.setTime(date);
        Integer tempY = now.get(Calendar.YEAR);
        Integer tempM = now.get(Calendar.MONTH) + 1;
        Integer tempD = now.get(Calendar.DAY_OF_MONTH);
        String tempStrM = "";
        String tempStrD = "";
        if (tempM < 10){
            tempStrM = "0" + tempM;
        } else {
            tempStrM = ""+ tempM;
        }
        if (tempD < 10){
            tempStrD = "0" + tempD;
        } else{
            tempStrD = "" + tempD;
        }
        String result = tempY + "-" + tempStrM + "-" + tempStrD;
        return result;
    }

    public static String[] getAllYear(Date date){
        Calendar now = Calendar.getInstance();
        now.setTime(date);
        Integer tempY = now.get(Calendar.YEAR);
        String result[] = new String[12];
        for (int i = 0; i < 12; i++) {
            int temp = i + 1;
            if (temp < 10){
                result[i] = tempY.toString() + "-0" + temp;
            } else {
                result[i] = tempY.toString() + "-" + temp;
            }
        }
        return result;
    }
}
