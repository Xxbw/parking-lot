package xbw.pojo;

import lombok.Data;

import java.util.Date;

@Data
public class ParkingRecord {

    private Integer id;
    private Integer carId;
    private Date entryTime;
    private Date departureTime;
    private CarInfor carInfor;
    private double price;

    public ParkingRecord() {
    }

    public ParkingRecord(Integer id, Integer carId, Date entryTime, Date departureTime) {
        this.id = id;
        this.carId = carId;
        this.entryTime = entryTime;
        this.departureTime = departureTime;
    }
}
