package vn.hoidanit.laptopshop.service;

import org.springframework.stereotype.Service;
import vn.hoidanit.laptopshop.repository.ProductRepository;
import vn.hoidanit.laptopshop.domain.Product;
import java.util.List;
import java.util.Optional;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import vn.hoidanit.laptopshop.repository.CartItemRepository;
import vn.hoidanit.laptopshop.repository.CartRepository;
import vn.hoidanit.laptopshop.domain.CartItem;
import vn.hoidanit.laptopshop.domain.User;

@Service
public class ProductService {
    private final ProductRepository productRepository;
    private final UploadService uploadService;
    private final CartItemRepository cartItemRepository;
    private final CartRepository cartRepository;

    public ProductService(ProductRepository productRepository, UploadService uploadService,
            CartItemRepository cartItemRepository, CartRepository cartRepository) {
        this.productRepository = productRepository;
        this.uploadService = uploadService;
        this.cartItemRepository = cartItemRepository;
        this.cartRepository = cartRepository;
    }

    public List<Product> getAllProducts() {
        return productRepository.findAll();
    }

    public Optional<Product> getProductById(long id) {
        return productRepository.findById(id);
    }

    public Product createProduct(Product product) {
        return productRepository.save(product);
    }

    public void deleteProduct(long id) {
        Product product = this.productRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Product not found"));
        this.productRepository.delete(product);
        if (product.getImage() != null && !product.getImage().trim().isEmpty()) {
            try {
                this.uploadService.deleteUploadFile(product.getImage(), "products");
            } catch (Exception e) {
                System.err.println("Error deleting product image: " + e.getMessage());
            }
        }
    }

    public Page<Product> getAllProducts(Pageable pageable) {
        return this.productRepository.findAll(pageable);
    }

}