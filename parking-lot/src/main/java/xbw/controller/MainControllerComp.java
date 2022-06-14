package xbw.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/main")
public class MainControllerComp {

    @RequestMapping(value = "home")
    public String mainHome(){
        return "/main";
    }

    @RequestMapping(value = "login")
    public String getIndex(){
        return "/index";
    }

    @RequestMapping(value = "update")
    public String setUpdate(){
        return "/person/updatepwd";
    }

    @RequestMapping(value = "personInfo")
    public String personInfo(){
        return "/person/person_info";
    }

}
