package xbw.service;

import xbw.pojo.ParkingRecord;

import java.util.Date;
import java.util.List;

public interface ParkingRecordService {

    List<ParkingRecord> getParkingRecord(String carNumber, Integer currentPageNo, Integer pageSize);

    ParkingRecord getParkingRecordById(Integer id);

    int getParkingRecordCount(String carNumber);

    int insertParkingRecord(ParkingRecord parkingRecord);

    boolean deleteParkingRecordById(Integer id);

    boolean updateParkingRecord(ParkingRecord parkingRecord);

    ParkingRecord getByParkingRecord(ParkingRecord parkingRecord);

    List<ParkingRecord> getRecordByDeparture(String departureTime);

    List<ParkingRecord> getAllPrice();

    List<ParkingRecord> getPriceByCarId(Integer carId);
}
