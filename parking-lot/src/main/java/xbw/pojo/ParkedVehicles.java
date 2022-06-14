package xbw.pojo;

import lombok.Data;

import java.util.Date;

@Data
public class ParkedVehicles {
    private Integer id;
    private Integer carId;
    private Date entryTime;
    private Integer parkingState;
    private CarInfor carInfor;
    private String photo;


    public ParkedVehicles() {
    }

    public ParkedVehicles(Integer id, Integer carId, Date entryTime, Integer parkingState,String photo) {
        this.id = id;
        this.entryTime = entryTime;
        this.carId = carId;
        this.parkingState = parkingState;
        this.photo = photo;
    }
}
