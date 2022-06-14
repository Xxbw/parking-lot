package xbw.controller;

import com.alibaba.fastjson.JSONObject;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.math.NumberUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import xbw.pojo.CarInfor;
import xbw.pojo.PriceMode;
import xbw.service.CarInforService;
import xbw.utils.ControllerUtil;
import xbw.utils.EmptyUtils;
import xbw.utils.PageSupport;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("/carInfor")
public class CarInforControllerComp {

    @Resource
    private CarInforService carInforService;

    @Autowired
    private HttpServletRequest request;

    @RequestMapping(value = "/getCar")
    public Object getCar(Model model, @RequestParam(value = "carNumber", required = false) String carNumber,
                         @RequestParam(value = "type", required = false) Integer priceMode,
                         @RequestParam(value = "pageIndex", required = false) String pageIndex){
        if (EmptyUtils.isEmpty(request.getSession().getAttribute("user"))) {
            return "index";
        }
        CarInfor serchInfo = new CarInfor();
        carNumber = StringUtils.defaultString(carNumber);
        carNumber = carNumber.trim();
        serchInfo.setCarNumber(carNumber);
        serchInfo.setPriceMode(priceMode);
        request.getSession().setAttribute("search",serchInfo);

        int pageSize = ControllerUtil.pageSize;
        int currentPageNo = NumberUtils.toInt(pageIndex,1);
        List<CarInfor> carInfors = carInforService.getCarInfor(carNumber,priceMode,currentPageNo,pageSize);
        List<PriceMode> priceModes = carInforService.getModes();

        int totalCount = 0;
        try {
            totalCount = carInforService.getCarInforCount(carNumber,priceMode);
        } catch (Exception e1) {
            e1.printStackTrace();
        }

        PageSupport pages = new PageSupport();
        pages.setCurrentPageNo(currentPageNo);
        pages.setPageSize(pageSize);//
        pages.setTotalCount(totalCount);

        model.addAttribute("carInfors",carInfors);
        model.addAttribute("pages",pages);
        model.addAttribute("modes",priceModes);
        return "car/Car_info";
    }

    @RequestMapping(value = "/setNewCar",produces = "application/json; charset=utf-8")
    @ResponseBody
    public Object setNewCar(@RequestBody CarInfor newCar){
        if (EmptyUtils.isEmpty(request.getSession().getAttribute("user"))) {
            return "index";
        }
        String message = "";
        try{
            CarInfor result = carInforService.getCarInforById(newCar.getId());
            if (result != null && !(result.equals(""))) {
                message = "用户编号已存在";
                return message;
            }
            Integer resultCount = carInforService.getCarInforCount(newCar.getCarNumber(),null);
            if (resultCount > 0){
                message = "车牌号已存在";
                return message;
            }
            Integer setResult = carInforService.insertCarInfor(newCar);
            if (setResult > 0){
                message = "添加成功";
                return message;
            } else {
                message = "添加失败";
            }
        }catch (Exception ex){
            message = ex.toString();
        }
        return message;
    }

    @RequestMapping(value = "/deleteCar")
    public Object deleteCar(@RequestParam("id") Integer id){
        if (EmptyUtils.isEmpty(request.getSession().getAttribute("user"))) {
            return "index";
        }

        try {
            boolean result = carInforService.deleteCarInforByid(id);
            if(result){
                request.setAttribute("films1","删除成功");
                return "forward:/carInfor/getCar";
            } else {
                request.setAttribute("films1","删除失败");
                return "forward:/carInfor/getCar";
            }
        }catch (Exception ex){
            ex.printStackTrace();
        }
        return "forward:/carInfor/getCar";
    }

    @RequestMapping(value = "/setCar",produces = "application/json; charset=utf-8")
    @ResponseBody
    public Object setCar(@RequestBody List<CarInfor> newCars){
        if (EmptyUtils.isEmpty(request.getSession().getAttribute("user"))) {
            return "index";
        }
        CarInfor oldCar = newCars.get(0);
        CarInfor setCar = newCars.get(1);
        String message = "";
        try {
            if (!(oldCar.getCarNumber().equals(setCar.getCarNumber()))){
                Integer result = carInforService.getCarInforCount(setCar.getCarNumber(),null);
                if (result > 0){
                    message = "车牌号码已存在";
                    return message;
                }
            }
            boolean setResult = carInforService.updateCarInfor(setCar);
            if (setResult){
                message = "修改成功";
            } else {
                message = "修改失败";
            }
        } catch (Exception ex){
            message = ex.toString();
        }

        return message;
    }




}
