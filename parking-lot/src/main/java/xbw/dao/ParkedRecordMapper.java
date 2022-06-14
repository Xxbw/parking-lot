package xbw.dao;

import org.apache.ibatis.annotations.Param;
import xbw.pojo.ParkingRecord;

import java.util.Date;
import java.util.List;

public interface ParkedRecordMapper {

    List<ParkingRecord> getParkingRecord(@Param("carNumber") String carNumber);

    ParkingRecord getParkingRecordById(@Param("id") Integer id);

    int getParkingRecordCount(@Param(value = "carNumber") String carNumber);

    int insertParkingRecord(ParkingRecord parkingRecord);

    boolean deleteParkingRecordById(@Param("id") Integer id);

    boolean updateParkingRecord(ParkingRecord parkingRecord);

    ParkingRecord getByParkingRecord(ParkingRecord parkingRecord);

    List<ParkingRecord> getRecordByDeparture(@Param("departureTime")String departureTime);

    List<ParkingRecord> getAllPrice();

    List<ParkingRecord> getPriceByCarId(@Param("carId") Integer carId);
}
