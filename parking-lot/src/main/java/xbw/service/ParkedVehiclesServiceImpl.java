package xbw.service;

import com.github.pagehelper.PageHelper;
import org.springframework.stereotype.Service;
import xbw.dao.ParkedVehiclesMapper;
import xbw.pojo.ParkedVehicles;

import javax.annotation.Resource;
import java.util.List;

@Service
public class ParkedVehiclesServiceImpl implements ParkedVehiclesService {

    @Resource
    private ParkedVehiclesMapper parkedVehiclesMapper;

    @Override
    public List<ParkedVehicles> getParkedVehicles(String carNumber, Integer currentPageNo, Integer pageSize) {
        PageHelper.startPage(currentPageNo,pageSize);
        return parkedVehiclesMapper.getParkedVehicles(carNumber);
    }

    @Override
    public ParkedVehicles getParkedVehicleById(Integer id) {
        return parkedVehiclesMapper.getParkedVehicleById(id);
    }

    @Override
    public int getParkedVehiclesCount(String carNumber) {
        return parkedVehiclesMapper.getParkedVehiclesCount(carNumber);
    }

    @Override
    public boolean deleteParkedVehicleById(Integer id) {
        return parkedVehiclesMapper.deleteParkedVehicleById(id);
    }

    @Override
    public int insterVehicle(ParkedVehicles parkedVehicle) {
        return parkedVehiclesMapper.insterVehicle(parkedVehicle);
    }

    @Override
    public boolean updateVehicle(ParkedVehicles parkedVehicle) {
        return parkedVehiclesMapper.updateVehicle(parkedVehicle);
    }

    @Override
    public ParkedVehicles getParkedVehicleByState() {
        return parkedVehiclesMapper.getParkedVehicleByState();
    }

    @Override
    public int getParkedVehicleByCarId(ParkedVehicles parkedVehicle) {
        return parkedVehiclesMapper.getParkedVehicleByCarId(parkedVehicle);
    }
}
