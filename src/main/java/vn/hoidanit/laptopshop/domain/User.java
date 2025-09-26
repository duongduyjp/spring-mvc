package vn.hoidanit.laptopshop.domain;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import jakarta.persistence.OneToMany;
import java.util.List;
import jakarta.persistence.FetchType;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.CascadeType;
import java.util.ArrayList;
import jakarta.persistence.ManyToOne;
import lombok.Getter;
import lombok.Setter;

// Validation imports
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.Size;
import jakarta.persistence.OneToOne;

@Entity
@Table(name = "users")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor

public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @NotBlank(message = "Email không được để trống")
    @Email(message = "Email không đúng định dạng")
    @Size(max = 100, message = "Email không được quá 100 ký tự")
    private String email;

    @NotBlank(message = "Mật khẩu không được để trống")
    @Size(min = 6, max = 100, message = "Mật khẩu phải từ 6-100 ký tự")
    private String password;

    private String phoneNumber;

    @NotBlank(message = "Họ tên không được để trống")
    private String fullName;

    private String address;

    private String avatar;

    // Một user có một role
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "role_id")
    private Role role;

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Order> orders = new ArrayList<>();

    @OneToOne(mappedBy = "user", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private Cart cart;

    @Override
    public String toString() {
        return String.format(
                "User{id=%d, email='%s', fullName='%s', phoneNumber='%s', address='%s', avatar='%s', role=%s}",
                id, email, fullName, phoneNumber, address, avatar,
                (role != null ? role.getName() : "null"));
    }
}