package xbw.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import xbw.pojo.ParkingRecord;
import xbw.pojo.PayPrice;
import xbw.service.CarInforService;
import xbw.service.ParkingRecordService;
import xbw.utils.EmptyUtils;
import xbw.utils.GetDateFormat;
import xbw.utils.ResultPrice;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/revenue")
public class RevenueControllerComp {

    @Resource
    private ParkingRecordService parkingRecordService;
    @Resource
    private CarInforService carInforService;
    @Autowired
    private HttpServletRequest request;

    @RequestMapping(value = "/getRevenue")
    public  Object getRevenue(Model model, @RequestParam(value = "departureTime", required = false) Date departureTime) {
        if (EmptyUtils.isEmpty(request.getSession().getAttribute("user"))) {
            return "index";
        }
        Date thisDate = new Date();
        String tempStringDate[] = new String[3];
        String allYearM[] = new String[12];
        double tempPrice[] = new double[4];
        PayPrice payPrice = new PayPrice();
        List allYearPrice = new ArrayList();

        if (departureTime != null && !(departureTime.equals(""))){
            thisDate = departureTime;
        }
        tempStringDate[0] = GetDateFormat.getYear(thisDate);
        tempStringDate[1] = GetDateFormat.getMonth(thisDate);
        tempStringDate[2] = GetDateFormat.getDay(thisDate);
        allYearM = GetDateFormat.getAllYear(thisDate);

        try {
            List<ParkingRecord> parkingRecordsY = parkingRecordService.getRecordByDeparture(tempStringDate[0]);
            List<ParkingRecord> parkingRecordsM = parkingRecordService.getRecordByDeparture(tempStringDate[1]);
            List<ParkingRecord> parkingRecordsD = parkingRecordService.getRecordByDeparture(tempStringDate[2]);
            List<ParkingRecord> parkingRecordsA = parkingRecordService.getAllPrice();
            tempPrice[0] = ResultPrice.getPrice(parkingRecordsY);
            tempPrice[1] = ResultPrice.getPrice(parkingRecordsM);
            tempPrice[2] = ResultPrice.getPrice(parkingRecordsD);
            tempPrice[3] = ResultPrice.getPrice(parkingRecordsA);

            payPrice.setPriceY(tempPrice[0]);
            payPrice.setPriceM(tempPrice[1]);
            payPrice.setPriceD(tempPrice[2]);
            payPrice.setPriceA(tempPrice[3]);
            model.addAttribute("payPrice",payPrice);

            for (int i = 0; i < 12; i++) {
                List<ParkingRecord> parkingRecordsTemp = parkingRecordService.getRecordByDeparture(allYearM[i]);
                allYearPrice.add(ResultPrice.getPrice(parkingRecordsTemp));
            }
            model.addAttribute("allYearPrice",allYearPrice);
        }catch (Exception ex){
            request.setAttribute("films1",ex);
        }
        return "price/revenue_info";
    }
}
