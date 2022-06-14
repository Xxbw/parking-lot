package xbw.service;

import com.github.pagehelper.PageHelper;
import org.springframework.stereotype.Service;
import xbw.dao.ParkedRecordMapper;
import xbw.pojo.ParkingRecord;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

@Service
public class ParkingRecordServiceImpl implements ParkingRecordService {

    @Resource
    private ParkedRecordMapper parkedRecordMapper;

    @Override
    public List<ParkingRecord> getParkingRecord(String carNumber, Integer currentPageNo, Integer pageSize) {
        PageHelper.startPage(currentPageNo,pageSize);
        return parkedRecordMapper.getParkingRecord(carNumber);
    }

    @Override
    public ParkingRecord getParkingRecordById(Integer id) {
        return parkedRecordMapper.getParkingRecordById(id);
    }

    @Override
    public int getParkingRecordCount(String carNumber) {
        return parkedRecordMapper.getParkingRecordCount(carNumber);
    }

    @Override
    public int insertParkingRecord(ParkingRecord parkingRecord) {
        return parkedRecordMapper.insertParkingRecord(parkingRecord);
    }

    @Override
    public boolean deleteParkingRecordById(Integer id) {
        return parkedRecordMapper.deleteParkingRecordById(id);
    }

    @Override
    public boolean updateParkingRecord(ParkingRecord parkingRecord) {
        return parkedRecordMapper.updateParkingRecord(parkingRecord);
    }

    @Override
    public ParkingRecord getByParkingRecord(ParkingRecord parkingRecord) {
        return parkedRecordMapper.getByParkingRecord(parkingRecord);
    }

    @Override
    public List<ParkingRecord> getRecordByDeparture(String departureTime) {
        return parkedRecordMapper.getRecordByDeparture(departureTime);
    }

    @Override
    public List<ParkingRecord> getAllPrice() {
        return parkedRecordMapper.getAllPrice();
    }

    @Override
    public List<ParkingRecord> getPriceByCarId(Integer carId) {
        return parkedRecordMapper.getPriceByCarId(carId);
    }
}
