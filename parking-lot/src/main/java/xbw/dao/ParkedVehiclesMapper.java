package xbw.dao;

import org.apache.ibatis.annotations.Param;
import xbw.pojo.ParkedVehicles;

import java.util.List;

public interface ParkedVehiclesMapper {

    List<ParkedVehicles> getParkedVehicles(@Param("carNumber") String carNumber);

    ParkedVehicles getParkedVehicleById(@Param("id") Integer id);

    int getParkedVehiclesCount(@Param(value = "carNumber") String carNumber);

    boolean deleteParkedVehicleById(@Param("id") Integer id);

    int insterVehicle(ParkedVehicles parkedVehicle);

    boolean updateVehicle(ParkedVehicles parkedVehicle);

    ParkedVehicles getParkedVehicleByState();

    int getParkedVehicleByCarId(ParkedVehicles parkedVehicle);

}
