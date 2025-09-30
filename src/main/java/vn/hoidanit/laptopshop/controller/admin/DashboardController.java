package vn.hoidanit.laptopshop.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import vn.hoidanit.laptopshop.controller.BaseController;
import vn.hoidanit.laptopshop.service.UserService;
import vn.hoidanit.laptopshop.service.OrderService;
import vn.hoidanit.laptopshop.service.ProductService;
import org.springframework.ui.Model;

@Controller
public class DashboardController extends BaseController {
    private UserService userService;
    private OrderService orderService;
    private ProductService productService;

    public DashboardController(UserService userService, OrderService orderService, ProductService productService) {
        this.userService = userService;
        this.orderService = orderService;
        this.productService = productService;
    }

    @GetMapping("/admin")
    public String showDashboard(Model model) {
        model.addAttribute("userCount", userService.getTotalUserCount());
        model.addAttribute("orderCount", orderService.getTotalOrderCount());
        model.addAttribute("productCount", productService.getTotalProductCount());
        return "admin/dashboard/index";
    }
}
