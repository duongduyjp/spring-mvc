package vn.hoidanit.laptopshop.controller.client;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.ui.Model;
import vn.hoidanit.laptopshop.service.CartService;
import vn.hoidanit.laptopshop.service.AuthService;
import vn.hoidanit.laptopshop.domain.Cart;
import vn.hoidanit.laptopshop.domain.User;
import java.math.BigDecimal;

@Controller
public class CheckoutController {
    private final CartService cartService;
    private final AuthService authService;

    public CheckoutController(CartService cartService, AuthService authService) {
        this.cartService = cartService;
        this.authService = authService;
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
}