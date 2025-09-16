package vn.hoidanit.laptopshop.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import vn.hoidanit.laptopshop.service.UserService;

@Controller
public class UserController {
    private UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    // localhost:8080/
    @RequestMapping("/")
    public String getHomePage() {
        String test = this.userService.getHelloWorld();
        return "eric.html";
    }
}
