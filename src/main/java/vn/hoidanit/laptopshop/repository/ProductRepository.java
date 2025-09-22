package vn.hoidanit.laptopshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import vn.hoidanit.laptopshop.domain.Product;
import java.util.List;

@Repository
public interface ProductRepository extends JpaRepository<Product, Long> {
    // Có thể thêm các method tùy chỉnh nếu cần
    List<Product> findByTarget(String target);

    List<Product> findByFactory(String factory);
}