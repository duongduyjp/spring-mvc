package vn.hoidanit.laptopshop.domain.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class RegisterDTO {
    private String firstName;
    private String lastName;
    private String password;
    private String email;
    private String confirmPassword;
}