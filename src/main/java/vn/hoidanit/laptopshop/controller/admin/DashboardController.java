package vn.hoidanit.laptopshop.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import vn.hoidanit.laptopshop.controller.BaseController;

@Controller
public class DashboardController extends BaseController {
    @GetMapping("/admin")
    public String showDashboard() {
        return "admin/dashboard/index";
    }
}
