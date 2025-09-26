package vn.hoidanit.laptopshop.controller.client;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import vn.hoidanit.laptopshop.service.AuthService;
import org.springframework.ui.Model;
import vn.hoidanit.laptopshop.domain.User;
import vn.hoidanit.laptopshop.domain.dto.RegisterDTO;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.validation.BindingResult;
import jakarta.validation.Valid;
import org.springframework.web.bind.annotation.ModelAttribute;

@Controller
public class AuthController {
    private AuthService authService;

    public AuthController(AuthService authService) {
        this.authService = authService;
    }

    // Show register page
    @GetMapping("/register")
    public String showRegisterPage(Model model) {
        model.addAttribute("registerDTO", new RegisterDTO());
        return "client/auth/register";
    }

    // Execute register user
    @PostMapping("/register")
    public String registerUser(Model model, @Valid @ModelAttribute("registerDTO") RegisterDTO registerDTO,
            BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            return "client/auth/register";
        }
        try {
            // Call service to convert RegisterDTO to User
            User user = this.authService.convertRegisterDTOToUser(registerDTO);

            this.authService.registerUser(user);
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
            return "client/auth/register";
        }
        return "redirect:/login";
    }

    // Show login page
    @GetMapping("/login")
    public String showLoginPage(Model model) {
        model.addAttribute("user", new User());
        return "client/auth/login";
    }

    // Show access denied page
    @GetMapping("/access-denied")
    public String showAccessDeniedPage() {
        return "client/auth/access-denied";
    }

}