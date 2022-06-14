package xbw.service;

import xbw.pojo.CarInfor;
import xbw.pojo.PriceMode;

import java.util.List;

public interface CarInforService {

    List<CarInfor> getCarInfor(String carNumber, Integer priceMode, Integer currentPageNo, Integer pageSize);

    CarInfor getCarInforById(Integer id);

    int getCarInforCount(String carNumber,Integer priceMode);

    int insertCarInfor(CarInfor carInfor);

    boolean updateCarInfor(CarInfor carInfor);

    boolean deleteCarInforByid(Integer id);

    List<PriceMode> getModes();

    List<CarInfor> getCarNumbers();
}
