package vn.hoidanit.laptopshop.domain.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import vn.hoidanit.laptopshop.validation.RegisterValidation;
import jakarta.validation.constraints.NotBlank;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@RegisterValidation
public class RegisterDTO {

    @NotBlank(message = "Họ tên không được để trống")
    private String firstName;

    @NotBlank(message = "Họ tên không được để trống")
    private String lastName;

    @NotBlank(message = "Mật khẩu không được để trống")
    private String password;

    @NotBlank(message = "Email không được để trống")
    private String email;

    @NotBlank(message = "Mật khẩu xác nhận không được để trống")
    private String confirmPassword;
}