package vn.hoidanit.laptopshop.service;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import java.util.Collections;

@Service
public class CustomUserDetailsService implements UserDetailsService {

    private final UserService userservice;

    public CustomUserDetailsService(UserService userService) {
        this.userservice = userService;
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        vn.hoidanit.laptopshop.domain.User user = userservice.getUserByEmail(username);
        if (user == null) {
            throw new UsernameNotFoundException("User not found");
        }
        return new User(user.getEmail(), user.getPassword(),
                Collections.singletonList(new SimpleGrantedAuthority("ROLE_USER")));
    }

}