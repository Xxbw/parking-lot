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
import xbw.pojo.ParkingRecord;
import xbw.service.CarInforService;
import xbw.service.ParkingRecordService;
import xbw.utils.ControllerUtil;
import xbw.utils.EmptyUtils;
import xbw.utils.PageSupport;
import xbw.utils.ResultPrice;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/record")
public class ParkingRecordControllerComp {

    @Resource
    private ParkingRecordService parkingRecordService;
    @Resource
    private CarInforService carInforService;
    @Autowired
    private HttpServletRequest request;

    @RequestMapping(value = "getRecord")
    public Object getRecord(Model model, @RequestParam(value = "carNumber", required = false) String carNumber,
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
            List<ParkingRecord> parkingRecords = parkingRecordService.getParkingRecord(carNumber,currentPageNo,pageSize);
            model.addAttribute("parkingRecords",parkingRecords);
            totalCount = parkingRecordService.getParkingRecordCount(carNumber);
            List<CarInfor> carInforList = carInforService.getCarNumbers();
            model.addAttribute("carInforList",carInforList);

        }catch (Exception ex){
            request.setAttribute("films1",ex);
        }
        PageSupport pages = new PageSupport();
        pages.setCurrentPageNo(currentPageNo);
        pages.setPageSize(pageSize);//
        pages.setTotalCount(totalCount);

        model.addAttribute("pages",pages);

        return "car/Car_Record";
    }

    @RequestMapping(value = "/setNewRecord",produces = "application/json; charset=utf-8")
    @ResponseBody
    public Object setNewRecord(@RequestBody ParkingRecord parkingRecord){
        if (EmptyUtils.isEmpty(request.getSession().getAttribute("user"))) {
            return "index";
        }
        String message = "";
        Date tempDepartureTime = parkingRecord.getDepartureTime();
        CarInfor carMode = carInforService.getCarInforById(parkingRecord.getCarId());
        Integer payMode = carMode.getPriceMode();
        if (payMode != 1){
            if (tempDepartureTime != null && !(tempDepartureTime.equals(""))){
                Double price = ResultPrice.getPayPrice(parkingRecord.getEntryTime(),tempDepartureTime);
                Double zero = -1.0;
                if (price != zero){
                    parkingRecord.setPrice(price);
                }
            }
        }

        try{
            ParkingRecord getResult = parkingRecordService.getByParkingRecord(parkingRecord);
            if (getResult != null && !(getResult.equals(""))){
                message = "该记录已存在";
                return message;
            }
            Integer result = parkingRecordService.insertParkingRecord(parkingRecord);
            if (result > 0){
                message = "添加成功";
                return message;
            } else {
                message = "添加失败";
                return message;
            }
        } catch (Exception ex){
            message = ex.toString();
        }
        return message;
    }

    @RequestMapping(value = "/deleteRecord")
    public Object deleteRecord(@RequestParam("id")Integer id){
        if (EmptyUtils.isEmpty(request.getSession().getAttribute("user"))) {
            return "index";
        }
        try {
            boolean result = parkingRecordService.deleteParkingRecordById(id);
            if(result){
                request.setAttribute("films1","删除成功");
                return "forward:/record/getRecord";
            } else {
                request.setAttribute("films1","删除失败");
                return "forward:/record/getRecord";
            }
        }catch (Exception ex){
            request.setAttribute("films1",ex);
        }
        return "forward:/record/getRecord";
    }

    @RequestMapping(value = "/setRecord",produces = "application/json; charset=utf-8")
    @ResponseBody
    public Object serRecord(@RequestBody ParkingRecord parkingRecord){
        if (EmptyUtils.isEmpty(request.getSession().getAttribute("user"))) {
            return "index";
        }
        String message = "";
        try {
            ParkingRecord getResult = parkingRecordService.getByParkingRecord(parkingRecord);
            if (getResult != null && !(getResult.equals(""))){
                message = "该记录已存在";
                return message;
            }
            boolean resultUpdate =  parkingRecordService.updateParkingRecord(parkingRecord);
            if (resultUpdate){
                message = "修改成功";
                return message;
            } else {
                message = "修改失败";
                return message;
            }
        }catch (Exception ex){
            message = ex.toString();
        }
        return message;
    }
}
