package vn.hoidanit.laptopshop.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;

import vn.hoidanit.laptopshop.controller.BaseController;
import vn.hoidanit.laptopshop.domain.Order;
import vn.hoidanit.laptopshop.service.OrderService;
import java.util.List;
import org.springframework.ui.Model;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import vn.hoidanit.laptopshop.service.AuthService;

@Controller
public class OrderController extends BaseController {
    private OrderService orderService;
    private AuthService authService;

    public OrderController(OrderService orderService, AuthService authService) {
        this.authService = authService;
        this.orderService = orderService;
    }

    @GetMapping("/admin/order")
    public String showOrderPage(Model model) {
        List<Order> orders = orderService.getAllOrders();
        model.addAttribute("orders", orders);
        return "admin/order/index";
    }

    @GetMapping("/admin/order/{id}")
    public String showOrderDetailPage(Model model, @PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            Order order = orderService.getOrderById(id);
            if (order == null) {
                redirectAttributes.addFlashAttribute("error", "Order not found with ID: " + id);
                return "redirect:/admin/order";
            }
            model.addAttribute("order", order);
            model.addAttribute("orderDetails", order.getOrderDetails());
            return "admin/order/detail";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error loading order: " + e.getMessage());
            return "redirect:/admin/order";
        }
    }

    @GetMapping("/admin/order/edit/{id}")
    public String showEditOrderPage(Model model, @PathVariable Long id) {
        Order order = orderService.getOrderById(id);
        model.addAttribute("order", order);
        return "admin/order/edit";
    }

    @PostMapping("/admin/order/edit/{id}")
    public String handleUpdateOrder(Model model, @PathVariable Long id, @ModelAttribute Order order,
            RedirectAttributes redirectAttributes) {
        try {
            orderService.updateOrder(id, order);
            redirectAttributes.addFlashAttribute("success", "Order updated successfully!");
            return "redirect:/admin/order";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error updating order: " + e.getMessage());
            return "redirect:/admin/order";
        }
    }

    // delete order
    @PostMapping("/admin/order/delete/{id}")
    public String handleDeleteOrder(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            orderService.deleteOrder(id);
            redirectAttributes.addFlashAttribute("success", "Order deleted successfully!");
            return "redirect:/admin/order";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error deleting order: " + e.getMessage());
            return "redirect:/admin/order";
        }
    }

    @GetMapping("/orders-history")
    public String showOrdersHistory(Model model) {
        List<Order> orders = orderService.getOrdersByUser(authService.getCurrentUser());
        model.addAttribute("orders", orders);
        return "client/order/history";
    }

    @GetMapping("/order-history/{id}")
    public String showOrderHistoryPage(Model model, @PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            Order order = orderService.getOrderById(id);
            if (order == null) {
                redirectAttributes.addFlashAttribute("error", "Không tìm thấy đơn hàng với ID: " + id);
                return "redirect:/orders-history";
            }
            model.addAttribute("order", order);
            model.addAttribute("orderDetails", order.getOrderDetails());
            return "client/order/detail";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Lỗi khi tải đơn hàng: " + e.getMessage());
            return "redirect:/orders-history";
        }
    }
}
