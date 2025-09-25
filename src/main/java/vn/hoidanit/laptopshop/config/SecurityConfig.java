package vn.hoidanit.laptopshop.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import jakarta.servlet.DispatcherType;

import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.core.userdetails.UserDetailsService;
import vn.hoidanit.laptopshop.service.CustomUserDetailsService;
import vn.hoidanit.laptopshop.service.UserService;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;

@Configuration
@EnableMethodSecurity(prePostEnabled = true)
public class SecurityConfig {

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder(12);
    }

    @Bean
    public UserDetailsService userDetailsService(UserService userService) {
        return new CustomUserDetailsService(userService);
    }

    @Bean
    public DaoAuthenticationProvider authProvider(
            PasswordEncoder passwordEncoder,
            UserDetailsService userDetailsService) {

        DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();
        authProvider.setUserDetailsService(userDetailsService);
        authProvider.setPasswordEncoder(passwordEncoder);
        // authProvider.setHideUserNotFoundExceptions(false);

        return authProvider;
    }

    /*
     * Đoạn code dưới đây định nghĩa một bean SecurityFilterChain để cấu hình bảo
     * mật cho ứng dụng Spring Security.
     * 
     * 1. @Bean: Đánh dấu phương thức này là một bean để Spring quản lý.
     * 2. SecurityFilterChain filterChain(HttpSecurity http): Phương thức nhận vào
     * đối tượng HttpSecurity để cấu hình các rule bảo mật.
     * 
     * Chi tiết các cấu hình:
     * 
     * - http.authorizeHttpRequests(...): Cấu hình quyền truy cập cho các request.
     * + dispatcherTypeMatchers(DispatcherType.FORWARD,
     * DispatcherType.INCLUDE).permitAll():
     * Cho phép tất cả các request có dispatcher type là FORWARD hoặc INCLUDE
     * (thường dùng khi forward/ include giữa các servlet/JSP).
     * + requestMatchers("/", "/login", "/client/**", "/css/**", "/js/**",
     * "/images/**").permitAll():
     * Cho phép truy cập không cần đăng nhập vào các đường dẫn: trang chủ, trang
     * login, các tài nguyên tĩnh (css, js, images), và các trang client.
     * + anyRequest().authenticated():
     * Các request còn lại đều yêu cầu phải đăng nhập (authenticated).
     * 
     * - .formLogin(...): Cấu hình đăng nhập bằng form.
     * + loginPage("/login"): Chỉ định trang login custom tại đường dẫn "/login".
     * + failureUrl("/login?error"): Nếu đăng nhập thất bại sẽ redirect về
     * "/login?error".
     * + permitAll(): Cho phép tất cả mọi người truy cập trang login.
     * 
     * - return http.build(): Trả về đối tượng SecurityFilterChain đã cấu hình.
     */
    @Bean
    SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
                .authorizeHttpRequests(authorize -> authorize
                        .dispatcherTypeMatchers(DispatcherType.FORWARD, DispatcherType.INCLUDE).permitAll()
                        .requestMatchers("/", "/login", "/client/**", "/css/**", "/js/**", "/images/**").permitAll()
                        .anyRequest().authenticated())
                .formLogin(formLogin -> formLogin
                        .loginPage("/login")
                        .failureUrl("/login?error")
                        .permitAll());

        return http.build();
    }

}