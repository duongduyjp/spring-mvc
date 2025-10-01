package vn.hoidanit.laptopshop.controller.client;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.ui.Model;
import vn.hoidanit.laptopshop.service.ProductService;
import vn.hoidanit.laptopshop.domain.Product;
import java.util.List;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.data.domain.Page;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import vn.hoidanit.laptopshop.domain.User;
import vn.hoidanit.laptopshop.repository.UserRepository;
import vn.hoidanit.laptopshop.util.PaginationHelper;

@Controller
public class HomePageController {
    private final ProductService productService;
    private final UserRepository userRepository;
    private final PaginationHelper paginationHelper;

    public HomePageController(ProductService productService, UserRepository userRepository,
            PaginationHelper paginationHelper) {
        this.productService = productService;
        this.userRepository = userRepository;
        this.paginationHelper = paginationHelper;
    }

    @GetMapping("/")
    public String getHomePage(Model model,
            @RequestParam(name = "page", defaultValue = "0") int page) {
        // Cố định mỗi trang hiển thị 8 sản phẩm
        int pageSize = 8;

        // Lấy danh sách sản phẩm có phân trang
        Page<Product> productPage = productService.getAllProducts(page, pageSize);
        model.addAttribute("products", productPage.getContent());
        PaginationHelper.addPaginationAttributes(model, productPage, page, pageSize);

        // Lấy một vài sản phẩm đặc biệt cho banner carousel
        List<Product> allProducts = productService.getAllProducts();
        if (!allProducts.isEmpty()) {
            List<Product> featuredProducts = allProducts.size() >= 3 ? allProducts.subList(0, 3) : allProducts;
            model.addAttribute("featuredProducts", featuredProducts);
        }

        // Lấy user hiện tại để hiển thị trên navbar
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null && auth.isAuthenticated() && !(auth.getPrincipal() instanceof String)) {
            org.springframework.security.core.userdetails.User securityUser = (org.springframework.security.core.userdetails.User) auth
                    .getPrincipal();

            // Lấy Domain User từ database bằng email
            String userEmail = securityUser.getUsername();
            User domainUser = userRepository.findByEmail(userEmail);
            if (domainUser != null) {
                model.addAttribute("currentUser", domainUser);
            }
        }
        return "client/homepage/index";
    }

}