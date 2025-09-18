package vn.hoidanit.laptopshop.service;

import org.springframework.stereotype.Service;
import vn.hoidanit.laptopshop.repository.UserRepository;
import vn.hoidanit.laptopshop.domain.User;
import java.util.List;

@Service
public class UserService {
    private UserRepository userRepository;

    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public User handleCreateUser(User user) {
        return this.userRepository.save(user);
    }

    public User handleUpdateUser(User updatedUser) {
        User existingUser = this.userRepository.findById(updatedUser.getId())
                .orElseThrow(() -> new RuntimeException("User not found"));

        String newPassword = updatedUser.getPassword();
        if (newPassword != null && !newPassword.trim().isEmpty()) {
            existingUser.setPassword(newPassword);
        }
        // Nếu password null hoặc rỗng thì không cần set lại, giữ nguyên

        existingUser.setPhoneNumber(updatedUser.getPhoneNumber());
        existingUser.setFullName(updatedUser.getFullName());
        existingUser.setAddress(updatedUser.getAddress());

        return this.userRepository.save(existingUser);
    }

    public List<User> getAllUsers() {
        return this.userRepository.findAll();
    }

    public List<User> getUserByEmail(String email) {
        return this.userRepository.findAll();
    }

    public User getUserById(long id) {
        return this.userRepository.findById(id).orElse(null);
    }

    public void handleDeleteUser(long id) {
        User user = this.userRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("User not found"));

        this.userRepository.delete(user);
    }

}
