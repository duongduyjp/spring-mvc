package vn.hoidanit.laptopshop.controller.client;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.ui.Model;
import vn.hoidanit.laptopshop.service.CartService;
import vn.hoidanit.laptopshop.service.AuthService;
import vn.hoidanit.laptopshop.domain.Cart;
import vn.hoidanit.laptopshop.domain.User;
import java.math.BigDecimal;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import vn.hoidanit.laptopshop.service.OrderService;
import vn.hoidanit.laptopshop.domain.Order;

@Controller
public class CheckoutController {
    private final CartService cartService;
    private final AuthService authService;
    private final OrderService orderService;

    public CheckoutController(CartService cartService, AuthService authService, OrderService orderService) {
        this.cartService = cartService;
        this.authService = authService;
        this.orderService = orderService;
    }

    @GetMapping("/checkout")
    public String showCheckoutPage(Model model) {
        User user = authService.getCurrentUser();
        if (user == null) {
            return "redirect:/login";
        }

        Cart cart = cartService.getCartByUser(user);

        // Kiểm tra cart có rỗng không
        if (cart == null || cart.getCartItems() == null || cart.getCartItems().isEmpty()) {
            return "redirect:/cart/detail";
        }

        // Tính tổng tiền
        BigDecimal totalAmount = BigDecimal.ZERO;
        for (var item : cart.getCartItems()) {
            totalAmount = totalAmount.add(
                    item.getUnitPrice().multiply(BigDecimal.valueOf(item.getQuantity())));
        }

        model.addAttribute("cart", cart);
        model.addAttribute("totalAmount", totalAmount);
        model.addAttribute("user", user);

        return "client/checkout/checkout";
    }

    // Process checkout
    @PostMapping("/checkout/process")
    public String processCheckout(@RequestParam("customerName") String customerName,
            @RequestParam("shippingAddress") String shippingAddress,
            @RequestParam("customerPhone") String customerPhone,
            RedirectAttributes redirectAttributes) {
        try {
            User user = authService.getCurrentUser();
            if (user == null) {
                return "redirect:/login";
            }
            // Tạo đơn hàng
            Order order = orderService.createOrderFromCart(user, customerName.trim(),
                    shippingAddress.trim(), customerPhone.trim());

            // Thông báo thành công
            redirectAttributes.addFlashAttribute("success",
                    "Đặt hàng thành công! Mã đơn hàng: #" + order.getId());

            return "redirect:/";

        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Lỗi đặt hàng: " + e.getMessage());
            return "redirect:/checkout";
        }
    }

}