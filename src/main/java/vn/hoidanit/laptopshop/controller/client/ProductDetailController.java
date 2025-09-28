package vn.hoidanit.laptopshop.controller.client;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.ui.Model;
import vn.hoidanit.laptopshop.service.ProductService;
import vn.hoidanit.laptopshop.service.CartService;
import vn.hoidanit.laptopshop.domain.Product;
import java.util.Optional;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class ProductDetailController {
    private final ProductService productService;
    private final CartService cartService;

    public ProductDetailController(ProductService productService, CartService cartService) {
        this.productService = productService;
        this.cartService = cartService;
    }

    @GetMapping("/product/{id}")
    public String getProductDetail(@PathVariable long id, Model model) {
        Optional<Product> productOpt = productService.getProductById(id);
        if (productOpt.isPresent()) {
            model.addAttribute("product", productOpt.get());
            return "client/product/detail";
        }
        return "redirect:/";
    }

    @PostMapping("/cart/add/{productId}")
    public String addToCart(@PathVariable long productId,
            @RequestParam(defaultValue = "1") int quantity) {
        try {
            cartService.addToCart(productId, quantity);
            return "redirect:/";
        } catch (Exception e) {
            return "redirect:/?error=" + e.getMessage();
        }
    }
}