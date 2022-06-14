package xbw.dao;

import org.apache.ibatis.annotations.Param;
import xbw.pojo.CarInfor;
import xbw.pojo.PriceMode;

import java.util.List;

public interface CarInforMapper {

    List<CarInfor> getCarInfor(@Param("carNumber") String carNumber, @Param("priceMode") Integer priceMode);

    CarInfor getCarInforById(@Param("id") Integer id);

    int getCarInforCount(@Param(value = "carNumber") String carNumber,@Param("priceMode") Integer priceMode);

    int insertCarInfor(CarInfor carInfor);

    boolean updateCarInfor(CarInfor carInfor);

    boolean deleteCarInforByid(@Param("id") Integer id);

    List<PriceMode> getModes();

    List<CarInfor> getCarNumbers();

}
