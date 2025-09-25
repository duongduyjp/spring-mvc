package vn.hoidanit.laptopshop.validation;

import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import vn.hoidanit.laptopshop.domain.dto.RegisterDTO;
import vn.hoidanit.laptopshop.repository.UserRepository;
import vn.hoidanit.laptopshop.domain.User;
import java.util.Optional;

@Component
public class RegisterValidator implements ConstraintValidator<RegisterValidation, RegisterDTO> {

    @Autowired
    private UserRepository userRepository;

    @Override
    public void initialize(RegisterValidation constraintAnnotation) {
        // Khởi tạo validator nếu cần
    }

    @Override
    // Phương thức này được framework gọi để kiểm tra tính hợp lệ của đối tượng
    // RegisterDTO.
    // Tham số 'registerDTO' là một đối tượng kiểu RegisterDTO (DTO = Data Transfer
    // Object), chứa dữ liệu đăng ký người dùng (họ tên, email, mật khẩu...).
    // Tham số 'context' là một đối tượng kiểu ConstraintValidatorContext, cho phép
    // thêm thông báo lỗi tuỳ chỉnh vào quá trình kiểm tra ràng buộc.
    public boolean isValid(RegisterDTO registerDTO, ConstraintValidatorContext context) {
        boolean isValid = true;

        // Kiểm tra email đã tồn tại chưa
        if (registerDTO.getEmail() != null && !registerDTO.getEmail().trim().isEmpty()) {
            User existingUser = userRepository.findByEmail(registerDTO.getEmail());
            if (existingUser != null) {
                context.disableDefaultConstraintViolation();
                context.buildConstraintViolationWithTemplate("Email này đã được sử dụng")
                        .addPropertyNode("email")
                        .addConstraintViolation();
                isValid = false;
            }
        }

        // Kiểm tra email có đúng định dạng không
        if (registerDTO.getEmail() != null && !registerDTO.getEmail().trim().isEmpty()) {
            if (!registerDTO.getEmail().matches("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$")) {
                context.disableDefaultConstraintViolation();
                context.buildConstraintViolationWithTemplate("Email không đúng định dạng")
                        .addPropertyNode("email")
                        .addConstraintViolation();
                isValid = false;
            }
        }

        // Kiểm tra password và confirmPassword có khớp không
        if (registerDTO.getPassword() != null && registerDTO.getConfirmPassword() != null) {
            if (!registerDTO.getPassword().equals(registerDTO.getConfirmPassword())) {
                context.disableDefaultConstraintViolation();
                context.buildConstraintViolationWithTemplate("Mật khẩu xác nhận không khớp")
                        .addPropertyNode("confirmPassword")
                        .addConstraintViolation();
                isValid = false;
            }
        }

        // Kiểm tra password có đủ mạnh không
        if (registerDTO.getPassword() != null && !registerDTO.getPassword().trim().isEmpty()) {
            if (!registerDTO.getPassword()
                    .matches("^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$")) {
                context.disableDefaultConstraintViolation();
                context.buildConstraintViolationWithTemplate(
                        "Mật khẩu phải có ít nhất 8 ký tự, bao gồm chữ cái viết hoa, chữ cái viết thường, số và ký tự đặc biệt")
                        .addPropertyNode("password")
                        .addConstraintViolation();
                isValid = false;
            }
        }

        return isValid;
    }
}