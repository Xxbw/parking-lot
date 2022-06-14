package xbw.service;

import xbw.pojo.ParkedVehicles;

import java.util.List;

public interface ParkedVehiclesService {

    List<ParkedVehicles> getParkedVehicles(String carNumber, Integer currentPageNo, Integer pageSize);

    ParkedVehicles getParkedVehicleById(Integer id);

    int getParkedVehiclesCount(String carNumber);

    boolean deleteParkedVehicleById(Integer id);

    int insterVehicle(ParkedVehicles parkedVehicle);

    boolean updateVehicle(ParkedVehicles parkedVehicle);

    ParkedVehicles getParkedVehicleByState();

    int getParkedVehicleByCarId(ParkedVehicles parkedVehicle);

}
