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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.http.ResponseEntity;
import java.util.Map;
import java.util.HashMap;

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

    @GetMapping("/api/cart/test")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> testApi() {
        Map<String, Object> response = new HashMap<>();
        response.put("success", true);
        response.put("message", "API endpoint is working!");
        return ResponseEntity.ok(response);
    }

    @PostMapping("/api/cart/count")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getCartCount() {
        Map<String, Object> response = new HashMap<>();

        try {
            User user = authService.getCurrentUser();
            int totalItems = 0;

            if (user != null) {
                Cart cart = cartService.getCartByUser(user);
                if (cart != null && cart.getCartItems() != null) {
                    totalItems = cart.getCartItems().stream()
                            .mapToInt(item -> item.getQuantity())
                            .sum();
                }
            }

            response.put("success", true);
            response.put("cartItemCount", totalItems);
            return ResponseEntity.ok(response);

        } catch (Exception e) {
            response.put("success", false);
            response.put("error", e.getMessage());
            return ResponseEntity.ok(response);
        }
    }

    @PostMapping("/api/cart/add")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> addToCartAjax(
            @RequestParam Long productId,
            @RequestParam(defaultValue = "1") int quantity) {

        Map<String, Object> response = new HashMap<>();

        try {
            User user = authService.getCurrentUser();
            if (user == null) {
                response.put("success", false);
                response.put("error", "Vui lòng đăng nhập để thêm sản phẩm vào giỏ hàng");
                return ResponseEntity.ok(response);
            }

            cartService.addToCart(productId, quantity);

            // Lấy tổng số items trong cart để cập nhật badge
            Cart cart = cartService.getCartByUser(user);
            int totalItems = 0;
            if (cart != null && cart.getCartItems() != null) {
                totalItems = cart.getCartItems().stream()
                        .mapToInt(item -> item.getQuantity())
                        .sum();
            }

            response.put("success", true);
            response.put("message", "Đã thêm sản phẩm vào giỏ hàng thành công!");
            response.put("cartItemCount", totalItems);

            return ResponseEntity.ok(response);

        } catch (Exception e) {
            response.put("success", false);
            response.put("error", e.getMessage());
            return ResponseEntity.ok(response);
        }
    }

    @PostMapping("/api/cart/update/{itemId}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> updateCartItemAjax(
            @PathVariable Long itemId,
            @RequestParam int quantity) {

        Map<String, Object> response = new HashMap<>();

        try {
            User user = authService.getCurrentUser();
            if (user == null) {
                response.put("success", false);
                response.put("error", "Vui lòng đăng nhập để cập nhật giỏ hàng");
                return ResponseEntity.ok(response);
            }

            cartService.updateCartItemQuantity(itemId, quantity);

            // Lấy thông tin cart đã cập nhật
            Cart cart = cartService.getCartByUser(user);
            int totalItems = 0;
            BigDecimal totalAmount = BigDecimal.ZERO;

            if (cart != null && cart.getCartItems() != null) {
                for (var item : cart.getCartItems()) {
                    totalItems += item.getQuantity();
                    totalAmount = totalAmount.add(
                            item.getUnitPrice().multiply(BigDecimal.valueOf(item.getQuantity())));
                }
            }

            response.put("success", true);
            response.put("message", "Cập nhật giỏ hàng thành công!");
            response.put("cartItemCount", totalItems);
            response.put("totalAmount", totalAmount);

            // Tính itemTotal - nếu quantity = 0 thì item đã bị xóa
            BigDecimal itemTotal = BigDecimal.ZERO;
            if (quantity > 0) {
                try {
                    var cartItem = cartService.getCartItemById(itemId);
                    itemTotal = cartItem.getUnitPrice().multiply(BigDecimal.valueOf(quantity));
                } catch (Exception e) {
                    // Item might be deleted, set to zero
                    itemTotal = BigDecimal.ZERO;
                }
            }
            response.put("itemTotal", itemTotal);

            return ResponseEntity.ok(response);

        } catch (Exception e) {
            response.put("success", false);
            response.put("error", e.getMessage());
            return ResponseEntity.ok(response);
        }
    }

    @PostMapping("/api/cart/remove/{itemId}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> removeCartItemAjax(@PathVariable Long itemId) {
        Map<String, Object> response = new HashMap<>();

        try {
            User user = authService.getCurrentUser();
            if (user == null) {
                response.put("success", false);
                response.put("error", "Vui lòng đăng nhập để xóa sản phẩm");
                return ResponseEntity.ok(response);
            }

            cartService.removeCartItem(itemId);

            // Lấy thông tin cart sau khi xóa
            Cart cart = cartService.getCartByUser(user);
            int totalItems = 0;
            BigDecimal totalAmount = BigDecimal.ZERO;

            if (cart != null && cart.getCartItems() != null) {
                for (var item : cart.getCartItems()) {
                    totalItems += item.getQuantity();
                    totalAmount = totalAmount.add(
                            item.getUnitPrice().multiply(BigDecimal.valueOf(item.getQuantity())));
                }
            }

            response.put("success", true);
            response.put("message", "Đã xóa sản phẩm khỏi giỏ hàng!");
            response.put("cartItemCount", totalItems);
            response.put("totalAmount", totalAmount);

            return ResponseEntity.ok(response);

        } catch (Exception e) {
            response.put("success", false);
            response.put("error", e.getMessage());
            return ResponseEntity.ok(response);
        }
    }
}
