package xbw.controller;

import com.alibaba.fastjson.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import xbw.pojo.ParkedVehicles;
import xbw.pojo.ParkingRecord;
import xbw.service.ParkedVehiclesService;
import xbw.service.ParkingRecordService;
import xbw.utils.ResultPrice;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.Date;

@Controller
@RequestMapping("/pay")
public class PayInforControllerComp {
    @Resource
    private ParkedVehiclesService parkedVehiclesService;

    @Resource
    private ParkingRecordService parkingRecordService;

    @Autowired
    private HttpServletRequest request;

    @RequestMapping(value = "/getCar",produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public Object getVehiclesByState(){
        JSONObject jsonObject = new JSONObject();
        Date thisTime = new Date();
        jsonObject.put("thisTime",thisTime);
        ParkedVehicles parkedVehicles = new ParkedVehicles();
        double price = 0;
        Integer setResult = 0;
        ParkingRecord parkingRecord = new ParkingRecord();
        try{
            parkedVehicles = parkedVehiclesService.getParkedVehicleByState();
            jsonObject.put("vehicleId",parkedVehicles.getId());
            jsonObject.put("thisCar",parkedVehicles);
            price = ResultPrice.getPayPrice(parkedVehicles.getEntryTime(),thisTime);
            jsonObject.put("price",price);
            parkingRecord.setCarId(parkedVehicles.getCarId());
            parkingRecord.setEntryTime(parkedVehicles.getEntryTime());
            parkingRecord.setDepartureTime(thisTime);
            parkingRecord.setPrice(price);
            setResult = parkingRecordService.insertParkingRecord(parkingRecord);
            jsonObject.put("setResult",setResult);
        } catch (Exception ex){
            jsonObject.put("error",ex);
        }
        return jsonObject;
    }

    @RequestMapping(value = "/delCar",produces = "application/json; charset=utf-8")
    @ResponseBody
    public Object deleteParkedVehicleById(@RequestParam("id") Integer id){
        JSONObject jsonObject = new JSONObject();
        boolean temp = false;
        try {
            temp = parkedVehiclesService.deleteParkedVehicleById(id);
            jsonObject.put("temp", temp);
        } catch (Exception ex){
            jsonObject.put("error", ex);
        }

        return jsonObject;
    }

}
