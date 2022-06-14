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
import xbw.pojo.ParkedVehicles;
import xbw.service.CarInforService;
import xbw.service.ParkedVehiclesService;
import xbw.utils.ControllerUtil;
import xbw.utils.EmptyUtils;
import xbw.utils.PageSupport;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/parked")
public class ParkedVehiclesControllerComp {

    @Resource
    private ParkedVehiclesService parkedVehiclesService;
    @Resource
    private CarInforService carInforService;

    @Autowired
    private HttpServletRequest request;

    @RequestMapping(value = "/getVehicles")
    public Object getVehicles(Model model, @RequestParam(value = "carNumber", required = false) String carNumber,
                              @RequestParam(value = "pageIndex", required = false) String pageIndex){
        if (EmptyUtils.isEmpty(request.getSession().getAttribute("user"))) {
            return "index";
        }
        CarInfor serchInfo = new CarInfor();
        carNumber = StringUtils.defaultString(carNumber);
        carNumber = carNumber.trim();
        serchInfo.setCarNumber(carNumber);
        request.getSession().setAttribute("search",serchInfo);

        int pageSize = ControllerUtil.pageSize;

        int currentPageNo = NumberUtils.toInt(pageIndex,1);
        int totalCount = 0;

        try {
            List<ParkedVehicles> parkedVehicles = parkedVehiclesService.getParkedVehicles(carNumber,currentPageNo,pageSize);
            model.addAttribute("vehicles",parkedVehicles);
            totalCount = parkedVehiclesService.getParkedVehiclesCount(carNumber);
            List<CarInfor> carInforList = carInforService.getCarNumbers();
            model.addAttribute("carInforList",carInforList);
        } catch (Exception ex){
            request.setAttribute("films1",ex);
        }
        PageSupport pages = new PageSupport();
        pages.setCurrentPageNo(currentPageNo);
        pages.setPageSize(pageSize);//
        pages.setTotalCount(totalCount);
        model.addAttribute("pages",pages);

        return "car/Car_Vehicles";
    }

    @RequestMapping(value = "/setNewVehicles",produces = "application/json; charset=utf-8")
    @ResponseBody
    public Object setNewVehicles(@RequestBody ParkedVehicles parkedVehicles){
        if (EmptyUtils.isEmpty(request.getSession().getAttribute("user"))) {
            return "index";
        }
        String message = "";
        try{
            int isHasCar = parkedVehiclesService.getParkedVehicleByCarId(parkedVehicles);
            if (isHasCar > 0) {
                message = "车辆已在车库";
                return message;
            } else {
                ParkedVehicles tempVehicle = parkedVehiclesService.getParkedVehicleByState();
                Integer flagState = parkedVehicles.getParkingState();
                if (flagState == 1 && tempVehicle != null){
                    message = "其他车辆即将离开";
                    return message;
                }
                Integer flag  = parkedVehiclesService.insterVehicle(parkedVehicles);
                if (flag > 0){
                    message = "添加成功";
                    return message;
                } else {
                    message = "添加失败";
                    return message;
                }
            }
        }catch (Exception ex){
            message = ex.toString();
        }
        return message;
    }

    @RequestMapping(value = "/deleteVehicle")
    public Object deleteVehicle(@RequestParam("id") Integer id){
        if (EmptyUtils.isEmpty(request.getSession().getAttribute("user"))) {
            return "index";
        }
        boolean result = false;
        try {
            result = parkedVehiclesService.deleteParkedVehicleById(id);
            if (result){
                request.setAttribute("films1","删除成功");
                return "forward:/parked/getVehicles";
            } else {
                request.setAttribute("films1","删除失败");
                return "forward:/parked/getVehicles";
            }
        }catch (Exception ex){
            request.setAttribute("films1",ex);
        }
        return "forward:/parked/getVehicles";
    }

    @RequestMapping(value = "/setVehicle",produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public Object setCar(@RequestParam("id")Integer id, @RequestParam("carNumber")String carNumber,
                         @RequestParam("parkingState")Integer parkingState, @RequestParam(value = "entryTime",required = false)Date entryTime){

        ParkedVehicles parkedVehicles = new ParkedVehicles(id, null, entryTime, parkingState,null);
        JSONObject jsonObject = new JSONObject();
        try {
            jsonObject.put("result",parkedVehiclesService.updateVehicle(parkedVehicles));
        }catch (Exception ex){
            jsonObject.put("error",ex);
        }
        return jsonObject;
    }

}
