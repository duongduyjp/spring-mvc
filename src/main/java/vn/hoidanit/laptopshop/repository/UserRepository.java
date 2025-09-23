package vn.hoidanit.laptopshop.repository;

import org.springframework.stereotype.Repository;
import org.springframework.data.jpa.repository.JpaRepository;
import vn.hoidanit.laptopshop.domain.User;
import java.util.List;
import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    // Không cần thiết override lại phương thức save(User user) vì JpaRepository đã
    // cung cấp sẵn.

    List<User> findByEmailAndAddress(String email, String address);

    List<User> findByEmail(String email);
}
