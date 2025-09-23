package vn.hoidanit.laptopshop.controller.client;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.ui.Model;
import vn.hoidanit.laptopshop.service.ProductService;
import vn.hoidanit.laptopshop.domain.Product;
import java.util.List;

@Controller
public class HomePageController {
    private final ProductService productService;

    public HomePageController(ProductService productService) {
        this.productService = productService;
    }

    @GetMapping("/")
    public String getHomePage(Model model) {
        List<Product> products = productService.getAllProducts();
        model.addAttribute("products", products);

        // Lấy một vài sản phẩm đặc biệt cho banner carousel
        if (!products.isEmpty()) {
            // Lấy 3 sản phẩm đầu tiên để hiển thị trong banner
            List<Product> featuredProducts = products.size() >= 3 ? products.subList(0, 3) : products;
            model.addAttribute("featuredProducts", featuredProducts);
        }

        return "client/homepage/index";
    }
}