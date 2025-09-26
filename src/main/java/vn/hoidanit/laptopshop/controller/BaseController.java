package vn.hoidanit.laptopshop.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.ModelAttribute;
import vn.hoidanit.laptopshop.repository.UserRepository;
import vn.hoidanit.laptopshop.domain.User;

public abstract class BaseController {

    @Autowired
    private UserRepository userRepository;

    // Get current user and add to model
    @ModelAttribute("currentUser")
    public User getCurrentUser() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null && auth.isAuthenticated() && !(auth.getPrincipal() instanceof String)) {
            org.springframework.security.core.userdetails.User securityUser = (org.springframework.security.core.userdetails.User) auth
                    .getPrincipal();

            String userEmail = securityUser.getUsername();
            return userRepository.findByEmail(userEmail);
        }
        return null;
    }
}