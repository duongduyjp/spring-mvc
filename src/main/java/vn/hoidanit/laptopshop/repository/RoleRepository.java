package vn.hoidanit.laptopshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import vn.hoidanit.laptopshop.domain.Role;
import org.springframework.stereotype.Repository;

/**
 * Tìm Role theo tên.
 * 
 * @param name tên role (ADMIN, USER, MANAGER)
 * @return Role object hoặc null
 */
@Repository
public interface RoleRepository extends JpaRepository<Role, Long> {
    Role findByName(String name);
}
