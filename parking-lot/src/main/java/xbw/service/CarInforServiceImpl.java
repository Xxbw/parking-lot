package xbw.service;

import com.github.pagehelper.PageHelper;
import org.springframework.stereotype.Service;
import xbw.dao.CarInforMapper;
import xbw.pojo.CarInfor;
import xbw.pojo.PriceMode;

import javax.annotation.Resource;
import java.util.List;

@Service
public class CarInforServiceImpl implements CarInforService {

    @Resource
    private CarInforMapper carInforMapper;


    @Override
    public List<CarInfor> getCarInfor(String carNumber, Integer priceMode, Integer currentPageNo, Integer pageSize) {
        PageHelper.startPage(currentPageNo,pageSize);
        return carInforMapper.getCarInfor(carNumber, priceMode);
    }

    @Override
    public CarInfor getCarInforById(Integer id) {
        return carInforMapper.getCarInforById(id);
    }

    @Override
    public int getCarInforCount(String carNumber,Integer priceMode) {
        return carInforMapper.getCarInforCount(carNumber,priceMode);
    }

    @Override
    public int insertCarInfor(CarInfor carInfor) {
        return carInforMapper.insertCarInfor(carInfor);
    }

    @Override
    public boolean updateCarInfor(CarInfor carInfor) {
        return carInforMapper.updateCarInfor(carInfor);
    }

    @Override
    public boolean deleteCarInforByid(Integer id) {
        return carInforMapper.deleteCarInforByid(id);
    }

    @Override
    public List<PriceMode> getModes() {
        return carInforMapper.getModes();
    }

    @Override
    public List<CarInfor> getCarNumbers() {
        return carInforMapper.getCarNumbers();
    }
}
