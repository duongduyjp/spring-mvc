package vn.hoidanit.laptopshop.service;

import org.springframework.stereotype.Service;
import vn.hoidanit.laptopshop.repository.UserRepository;
import vn.hoidanit.laptopshop.domain.User;
import java.util.List;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.multipart.MultipartFile;
import vn.hoidanit.laptopshop.domain.Role;
import java.util.Optional;

@Service
public class UserService {
    private UserRepository userRepository;
    private PasswordEncoder passwordEncoder;
    private UploadService uploadService;
    private RoleService roleService;

    public UserService(UserRepository userRepository, PasswordEncoder passwordEncoder, UploadService uploadService,
            RoleService roleService) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
        this.uploadService = uploadService;
        this.roleService = roleService;
    }

    public User handleCreateUser(User user, String roleName, MultipartFile avatarFile) {
        // 1. Upload avatar
        if (avatarFile != null && !avatarFile.isEmpty()) {
            try {
                String avatarFileName = this.uploadService.handleSaveAvatarFile(avatarFile);
                if (avatarFileName != null) {
                    user.setAvatar(avatarFileName);
                }
            } catch (RuntimeException e) {
                throw new RuntimeException("Lỗi upload avatar: " + e.getMessage());
            }
        }

        // 2. Tìm và set Role
        if (roleName != null && !roleName.trim().isEmpty()) {
            Role role = this.roleService.getRoleByName(roleName);
            if (role == null) {
                throw new RuntimeException("Role không tồn tại: " + roleName);
            }
            user.setRole(role);
        }

        // 3. Mã hóa password
        String encodedPassword = passwordEncoder.encode(user.getPassword());
        user.setPassword(encodedPassword);
        return this.userRepository.save(user);
    }

    public User handleUpdateUser(User updatedUser, MultipartFile avatarFile, String roleName) {
        User existingUser = this.userRepository.findById(updatedUser.getId())
                .orElseThrow(() -> new RuntimeException("User not found"));

        String newPassword = updatedUser.getPassword();
        if (newPassword != null && !newPassword.trim().isEmpty()) {
            String encodedPassword = passwordEncoder.encode(newPassword);
            existingUser.setPassword(encodedPassword);
        }

        // 2. Upload avatar
        if (avatarFile != null && !avatarFile.isEmpty()) {
            try {
                String avatarFileName = this.uploadService.handleSaveAvatarFile(avatarFile);
                if (avatarFileName != null) {
                    existingUser.setAvatar(avatarFileName);
                }
            } catch (RuntimeException e) {
                throw new RuntimeException("Lỗi upload avatar: " + e.getMessage());
            }
        }

        // 3. Tìm và set Role
        if (roleName != null && !roleName.trim().isEmpty()) {
            Role role = this.roleService.getRoleByName(roleName);
            if (role == null) {
                throw new RuntimeException("Role không tồn tại: " + roleName);
            }
            existingUser.setRole(role);
        }

        // 4. Cập nhật thông tin khác
        existingUser.setPhoneNumber(updatedUser.getPhoneNumber());
        existingUser.setFullName(updatedUser.getFullName());
        existingUser.setAddress(updatedUser.getAddress());
        existingUser.setEmail(updatedUser.getEmail());

        return this.userRepository.save(existingUser);
    }

    public List<User> getAllUsers() {
        return this.userRepository.findAll();
    }

    public Optional<User> getUserById(long id) {
        return this.userRepository.findById(id);
    }

    public void handleDeleteUser(long id) {
        User user = this.userRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("User not found"));
        if (user.getAvatar() != null && !user.getAvatar().trim().isEmpty()) {
            try {
                this.uploadService.deleteAvatarFile(user.getAvatar());
                System.out.println("Avatar file deleted successfully: " + user.getAvatar());
            } catch (Exception e) {
                System.err.println("Error deleting avatar file: " + e.getMessage());
                // Không throw exception để không block việc xóa user
            }
        }

        this.userRepository.delete(user);
    }

    public User getUserByEmail(String email) {
        return this.userRepository.findByEmail(email);
    }
}
