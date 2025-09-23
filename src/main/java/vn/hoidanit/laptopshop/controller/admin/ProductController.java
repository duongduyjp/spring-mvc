package vn.hoidanit.laptopshop.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;

import vn.hoidanit.laptopshop.domain.Product;
import vn.hoidanit.laptopshop.service.ProductService;
import java.util.List;
import java.util.Optional;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import vn.hoidanit.laptopshop.service.UploadService;
import org.springframework.web.bind.annotation.PathVariable;

@Controller
public class ProductController {
    private ProductService productService;
    private UploadService uploadService;

    public ProductController(ProductService productService, UploadService uploadService) {
        this.productService = productService;
        this.uploadService = uploadService;
    }

    // show product list
    @GetMapping("/admin/product")
    public String showListProduct(Model model) {
        List<Product> products = productService.getAllProducts();
        model.addAttribute("products", products);
        return "admin/product/index";
    }

    // show create form
    @GetMapping("/admin/product/create")
    public String showCreateProduct(Model model) {
        model.addAttribute("product", new Product());
        return "admin/product/create";
    }

    // show detail
    @GetMapping("/admin/product/{id}")
    public String showDetailProduct(Model model, @PathVariable long id) {
        Optional<Product> product = productService.getProductById(id);
        if (product.isPresent()) {
            model.addAttribute("product", product.get());
        } else {
            return "redirect:/admin/product?error=true&message=Product not found";
        }
        return "admin/product/detail";
    }

    // show edit form
    @GetMapping("/admin/product/edit/{id}")
    public String showEditProduct(Model model, @PathVariable long id) {
        Optional<Product> product = productService.getProductById(id);
        if (product.isPresent()) {
            model.addAttribute("product", product.get());
        } else {
            return "redirect:/admin/product?error=true&message=Product not found";
        }
        return "admin/product/edit";
    }

    // create product
    @PostMapping("/admin/product/create")
    public String handleCreateProduct(@ModelAttribute("product") Product product,
            BindingResult bindingResult,
            @RequestParam("imageFile") MultipartFile imageFile,
            Model model,
            RedirectAttributes redirectAttributes) {

        if (bindingResult.hasErrors()) {
            return "admin/product/create";
        }

        try {
            // Handle image upload
            if (!imageFile.isEmpty()) {
                String imageName = uploadService.handleSaveUploadFile(imageFile, "products");
                product.setImage(imageName);
            }

            // Save product
            productService.createProduct(product);
            return "redirect:/admin/product?success=true&message=Product created successfully!";

        } catch (Exception e) {
            model.addAttribute("error", "Error creating product: " + e.getMessage());
            return "admin/product/create";
        }

    }

    // update product
    @PostMapping("/admin/product/edit/{id}")
    public String handleUpdateProduct(@ModelAttribute("product") Product product,
            @PathVariable long id,
            BindingResult bindingResult,
            @RequestParam("imageFile") MultipartFile imageFile,
            Model model,
            RedirectAttributes redirectAttributes) {

        if (bindingResult.hasErrors()) {
            return "admin/product/edit";
        }

        try {
            // Get existing product to preserve current image if no new image uploaded
            Optional<Product> existingProductOpt = productService.getProductById(id);
            if (!existingProductOpt.isPresent()) {
                return "redirect:/admin/product?error=true&message=Product not found";
            }

            Product existingProduct = existingProductOpt.get();

            // Handle image upload
            if (!imageFile.isEmpty()) {
                String imageName = uploadService.handleSaveUploadFile(imageFile, "products");
                product.setImage(imageName);
            } else {
                // Keep existing image if no new image uploaded
                product.setImage(existingProduct.getImage());
            }

            // Set ID to ensure update instead of create
            product.setId(id);

            // Update product
            productService.createProduct(product); // createProduct is actually save/update
            return "redirect:/admin/product?success=true&message=Product updated successfully!";

        } catch (Exception e) {
            model.addAttribute("error", "Error updating product: " + e.getMessage());
            model.addAttribute("product", product);
            return "admin/product/edit";
        }
    }

    // delete product
    @PostMapping("/admin/product/delete/{id}")
    public String deleteProduct(@PathVariable long id, Model model) {
        try {
            productService.deleteProduct(id);
            return "redirect:/admin/product?success=true&message=Product deleted successfully";
        } catch (Exception e) {
            return "redirect:/admin/product?error=true&message=" + e.getMessage();
        }
    }
}
