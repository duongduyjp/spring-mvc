package vn.hoidanit.laptopshop.exception;

import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.validation.FieldError;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.context.request.WebRequest;
import org.springframework.beans.factory.annotation.Autowired;
import vn.hoidanit.laptopshop.service.ProductService;
import vn.hoidanit.laptopshop.domain.Product;
import java.util.Optional;

@ControllerAdvice
public class GlobalExceptionHandler {

    @Autowired
    private ProductService productService;

    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ModelAndView handleValidationException(MethodArgumentNotValidException ex,
            WebRequest request) {

        // Get the request URI to determine which form we're handling
        String requestURI = request.getDescription(false).replace("uri=", "");

        ModelAndView modelAndView = new ModelAndView();

        // Check if this is an edit request
        if (requestURI.contains("/admin/product/edit/")) {
            // For edit requests, stay on the edit page with validation errors
            modelAndView.setViewName("admin/product/edit");

            // Extract product ID from URI and get existing product data
            String[] pathSegments = requestURI.split("/");
            String productIdStr = pathSegments[pathSegments.length - 1];

            try {
                long productId = Long.parseLong(productIdStr);
                Optional<Product> existingProduct = productService.getProductById(productId);
                if (existingProduct.isPresent()) {
                    modelAndView.addObject("product", existingProduct.get());
                }
            } catch (NumberFormatException e) {
                // Handle invalid product ID
            }

        } else if (requestURI.contains("/admin/product/create")) {
            // For create requests, stay on the create page with validation errors
            modelAndView.setViewName("admin/product/create");

        } else {
            // For other requests, redirect to product list
            StringBuilder errorMessage = new StringBuilder("Validation errors: ");
            for (FieldError error : ex.getBindingResult().getFieldErrors()) {
                errorMessage.append(error.getDefaultMessage()).append("; ");
            }

            modelAndView.setViewName("redirect:/admin/product?error=true&message=" + errorMessage.toString());
        }

        return modelAndView;
    }
}