package vn.hoidanit.laptopshop.controller.client;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.ui.Model;
import vn.hoidanit.laptopshop.service.ProductService;
import vn.hoidanit.laptopshop.domain.Product;
import java.util.List;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;

@Controller
public class HomePageController {
    private final ProductService productService;

    public HomePageController(ProductService productService) {
        this.productService = productService;
    }

    @GetMapping("/")
    public String getHomePage(Model model,
            @RequestParam(name = "page", defaultValue = "0") int page) {
        // Cố định mỗi trang hiển thị 8 sản phẩm
        int pageSize = 8;

        // Lấy danh sách sản phẩm có phân trang
        Page<Product> productPage = productService.getAllProducts(PageRequest.of(page, pageSize));
        model.addAttribute("products", productPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", productPage.getTotalPages());
        model.addAttribute("totalElements", productPage.getTotalElements());
        model.addAttribute("pageSize", pageSize);

        // Lấy một vài sản phẩm đặc biệt cho banner carousel
        List<Product> allProducts = productService.getAllProducts();
        if (!allProducts.isEmpty()) {
            List<Product> featuredProducts = allProducts.size() >= 3 ? allProducts.subList(0, 3) : allProducts;
            model.addAttribute("featuredProducts", featuredProducts);
        }

        return "client/homepage/index";
    }
}