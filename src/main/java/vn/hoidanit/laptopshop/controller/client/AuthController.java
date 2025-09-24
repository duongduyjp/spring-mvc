package vn.hoidanit.laptopshop.controller.client;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import vn.hoidanit.laptopshop.service.AuthService;
import org.springframework.ui.Model;
import vn.hoidanit.laptopshop.domain.User;
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

    @GetMapping("/register")
    public String showRegisterPage(Model model) {
        model.addAttribute("user", new User());
        return "client/auth/register";
    }

    @PostMapping("/register")
    public String registerUser(Model model, @Valid @ModelAttribute("user") User user, BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            return "client/auth/register";
        }
        try {
            this.authService.registerUser(user);
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
            return "client/auth/register";
        }
        return "redirect:/login";
    }

}