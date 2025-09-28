package vn.hoidanit.laptopshop.controller.client;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.ui.Model;
import vn.hoidanit.laptopshop.service.CartService;
import vn.hoidanit.laptopshop.service.AuthService;
import vn.hoidanit.laptopshop.domain.Cart;
import vn.hoidanit.laptopshop.domain.User;
import java.math.BigDecimal;

@Controller
public class CartController {
    private final CartService cartService;
    private final AuthService authService;

    public CartController(CartService cartService, AuthService authService) {
        this.cartService = cartService;
        this.authService = authService;
    }

    @GetMapping("/cart/detail")
    public String viewCart(Model model) {
        User user = authService.getCurrentUser();
        if (user == null) {
            return "redirect:/login";
        }

        Cart cart = cartService.getCartByUser(user);

        // Tính tổng tiền
        BigDecimal totalAmount = BigDecimal.ZERO;
        if (cart != null && cart.getCartItems() != null) {
            for (var item : cart.getCartItems()) {
                totalAmount = totalAmount.add(
                        item.getUnitPrice().multiply(BigDecimal.valueOf(item.getQuantity())));
            }
        }

        model.addAttribute("cart", cart);
        model.addAttribute("totalAmount", totalAmount);
        return "client/cart/detail";
    }

    @PostMapping("/cart/update/{itemId}")
    public String updateCartItem(@PathVariable Long itemId, @RequestParam int quantity) {
        try {
            cartService.updateCartItemQuantity(itemId, quantity);
            return "redirect:/cart/detail";
        } catch (Exception e) {
            return "redirect:/cart/detail?error=" + e.getMessage();
        }
    }

    @PostMapping("/cart/remove/{itemId}")
    public String removeCartItem(@PathVariable Long itemId) {
        try {
            cartService.removeCartItem(itemId);
            return "redirect:/cart/detail";
        } catch (Exception e) {
            return "redirect:/cart/detail?error=" + e.getMessage();
        }
    }
}