package xbw.utils;

import xbw.pojo.ParkingRecord;

import java.util.Date;
import java.util.List;

public class ResultPrice {

    private static final Integer hourPay = 3;

    public static double getPayPrice(Date entryTime,Date departureTime){

        long nd = 1000 * 24 * 60 * 60;// 一天的毫秒数
        long nh = 1000 * 60 * 60;// 一小时的毫秒数
        long day = 0;
        long hour = 0;
        long result = 0;
        long price = 0;
        if (departureTime.getTime() < entryTime.getTime()) {
            return -1.0;
        }
        Long diff = departureTime.getTime() - entryTime.getTime();

        day = diff / nd;// 计算差多少天
        hour = diff % nd / nh + day * 24;// 计算差多少小时

        price = hour * hourPay;
        return price;
    }

    public static double getPrice(List<ParkingRecord> parkingRecords){

        double result = 0.0;
        for (ParkingRecord r : parkingRecords) {
            result += r.getPrice();
        }
        return result;
    }

}
