package vn.hoidanit.laptopshop.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import vn.hoidanit.laptopshop.domain.Product;
import java.util.List;
import org.springframework.data.domain.Pageable;

@Repository
public interface ProductRepository extends JpaRepository<Product, Long> {
    // Có thể thêm các method tùy chỉnh nếu cần
    List<Product> findByTarget(String target);

    List<Product> findByFactory(String factory);

    Page<Product> findAll(Pageable page);
}