package vn.hoidanit.laptopshop.service;

import org.springframework.stereotype.Service;
import java.util.Optional;
import org.springframework.security.crypto.password.PasswordEncoder;
import vn.hoidanit.laptopshop.repository.UserRepository;
import vn.hoidanit.laptopshop.domain.User;
import vn.hoidanit.laptopshop.domain.dto.RegisterDTO;
import vn.hoidanit.laptopshop.domain.Role;

@Service
public class AuthService {
    private PasswordEncoder passwordEncoder;
    private UserRepository userRepository;
    private RoleService roleService;

    public AuthService(PasswordEncoder passwordEncoder, UserRepository userRepository, RoleService roleService) {
        this.passwordEncoder = passwordEncoder;
        this.userRepository = userRepository;
        this.roleService = roleService;
    }

    public User registerUser(User user) {
        // 1. Kiểm tra email đã tồn tại chưa
        User existingUser = this.userRepository.findByEmail(user.getEmail());
        if (existingUser != null) {
            throw new RuntimeException("Email đã tồn tại trong hệ thống");
        }

        // 2. Mã hóa password
        String encodedPassword = passwordEncoder.encode(user.getPassword());
        user.setPassword(encodedPassword);

        // 3. Set role USER mặc định
        Role userRole = this.roleService.getRoleByName("USER");
        if (userRole == null) {
            throw new RuntimeException("Role USER không tồn tại trong hệ thống");
        }
        user.setRole(userRole);

        // 4. Lưu user vào database
        return this.userRepository.save(user);
    }

    public User convertRegisterDTOToUser(RegisterDTO registerDTO) {
        User user = new User();
        user.setFullName(registerDTO.getFirstName() + " " + registerDTO.getLastName());
        user.setEmail(registerDTO.getEmail());
        user.setPassword(registerDTO.getPassword());
        return user;
    }

    public User authenticateUser(String email, String password) {
        // Tìm user theo email
        User user = this.userRepository.findByEmail(email);
        if (user == null) {
            throw new RuntimeException("Email không tồn tại trong hệ thống");
        }
        // Kiểm tra password
        if (!passwordEncoder.matches(password, user.getPassword())) {
            throw new RuntimeException("Mật khẩu không đúng");
        }

        return user;
    }

}