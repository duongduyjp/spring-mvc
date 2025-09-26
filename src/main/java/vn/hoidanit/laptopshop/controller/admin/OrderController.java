package vn.hoidanit.laptopshop.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import vn.hoidanit.laptopshop.controller.BaseController;

@Controller
public class OrderController extends BaseController {
    @GetMapping("/admin/order")
    public String showOrder() {
        return "admin/order/index";
    }
}
