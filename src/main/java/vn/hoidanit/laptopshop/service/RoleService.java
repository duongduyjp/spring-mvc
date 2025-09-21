package vn.hoidanit.laptopshop.service;

import org.springframework.stereotype.Service;
import vn.hoidanit.laptopshop.repository.RoleRepository;
import vn.hoidanit.laptopshop.domain.Role;
import java.util.List;

@Service
public class RoleService {
    private RoleRepository roleRepository;

    public RoleService(RoleRepository roleRepository) {
        this.roleRepository = roleRepository;
    }

    /**
     * Tìm role theo tên.
     * 
     * @param name tên role (ADMIN, USER, MANAGER)
     * @return Role object hoặc null
     */
    public Role getRoleByName(String name) {
        return this.roleRepository.findByName(name);
    }

    /**
     * Lấy tất cả roles.
     * 
     * @return danh sách tất cả roles
     */
    public List<Role> getAllRoles() {
        return this.roleRepository.findAll();
    }

    /**
     * Tạo role mới.
     * 
     * @param role Role object cần tạo
     * @return Role đã được lưu
     */
    public Role createRole(Role role) {
        return this.roleRepository.save(role);
    }
}
