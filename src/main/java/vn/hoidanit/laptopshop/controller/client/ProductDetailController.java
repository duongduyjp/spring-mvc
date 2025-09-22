package vn.hoidanit.laptopshop.controller.client;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.ui.Model;
import vn.hoidanit.laptopshop.service.ProductService;
import vn.hoidanit.laptopshop.domain.Product;
import java.util.Optional;

@Controller
public class ProductDetailController {
    private final ProductService productService;

    public ProductDetailController(ProductService productService) {
        this.productService = productService;
    }

    @GetMapping("/product/{id}")
    public String getProductDetail(@PathVariable long id, Model model) {
        // Optional<Product> productOpt = productService.getProductById(id);
        // if (productOpt.isPresent()) {
        // model.addAttribute("product", productOpt.get());
        // return "client/product/detail";
        // }
        // return "redirect:/"; // Redirect về homepage nếu không tìm thấy
        return "client/product/detail";
    }
}