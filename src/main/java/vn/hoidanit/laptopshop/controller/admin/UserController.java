package vn.hoidanit.laptopshop.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;

import vn.hoidanit.laptopshop.service.UserService;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.GetMapping;
import vn.hoidanit.laptopshop.domain.User;
import org.springframework.web.bind.annotation.ModelAttribute;

import java.util.List;
import vn.hoidanit.laptopshop.domain.Role;
import vn.hoidanit.laptopshop.service.RoleService;
import vn.hoidanit.laptopshop.service.UploadService;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import jakarta.validation.Valid;

@Controller
@RequestMapping("/admin")
public class UserController {
    private UserService userService;
    private RoleService roleService;
    private UploadService uploadService;

    public UserController(UserService userService, RoleService roleService, UploadService uploadService) {
        this.userService = userService;
        this.roleService = roleService;
        this.uploadService = uploadService;
    }

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        // Ignore avatar field để tránh conflict với file upload
        binder.setDisallowedFields("avatar");
    }

    // localhost:8080/
    @RequestMapping("/")
    public String getHomePage(Model model) {
        List<User> users = this.userService.getAllUsers();
        model.addAttribute("users", users);
        System.out.println(users);
        return "hello";
    }

    // show user list
    @GetMapping("/user")
    public String getUserPage(Model model) {
        List<User> users = this.userService.getAllUsers();
        model.addAttribute("users", users);
        return "admin/user/index";
    }

    // show create user form
    @GetMapping("/user/create")
    public String showCreateUserForm(Model model) {
        model.addAttribute("user", new User());
        List<Role> roles = this.roleService.getAllRoles();

        // Nếu không có roles, tạo default roles
        if (roles.isEmpty()) {
            Role adminRole = new Role();
            adminRole.setName("ADMIN");
            this.roleService.createRole(adminRole);

            Role userRole = new Role();
            userRole.setName("USER");
            this.roleService.createRole(userRole);

            roles = this.roleService.getAllRoles();
        }

        model.addAttribute("roles", roles);
        return "admin/user/create";
    }

    // show edit user form
    @GetMapping("/user/edit/{id}")
    public String getEditUserPage(Model model, @PathVariable long id) {
        User user = this.userService.getUserById(id).orElse(null);
        if (user == null) {
            return "redirect:/admin/user?error=true&message=User not found";
        }

        List<Role> roles = this.roleService.getAllRoles();
        model.addAttribute("user", user);
        model.addAttribute("roles", roles);
        return "admin/user/edit";
    }

    // show detail user
    @GetMapping("/user/{id}")
    public String getDetailUserPage(Model model, @PathVariable long id) {
        User user = this.userService.getUserById(id).orElse(null);
        model.addAttribute("user", user);
        return "admin/user/detail";
    }

    // create user
    @PostMapping("/user/create")
    public String createUser(Model model,
            @Valid @ModelAttribute("user") User user,
            BindingResult bindingResult,
            @RequestParam("roleName") String roleName,
            @RequestParam(value = "avatarFile", required = false) MultipartFile avatarFile) {

        // Kiểm tra validation errors
        if (bindingResult.hasErrors()) {
            List<Role> roles = this.roleService.getAllRoles();
            model.addAttribute("roles", roles);
            return "admin/user/create";
        }
        try {
            this.userService.handleCreateUser(user, roleName, avatarFile);
            return "redirect:/admin/user?success=true&message=User created successfully";
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
            List<Role> roles = this.roleService.getAllRoles();
            model.addAttribute("roles", roles);
            return "admin/user/create";
        }

    }

    // update user
    @PostMapping("/user/edit/{id}")
    public String updateUser(Model model,
            @PathVariable long id,
            @Valid @ModelAttribute("user") User user,
            BindingResult bindingResult,
            @RequestParam(value = "roleName", required = false) String roleName,
            @RequestParam(value = "avatarFile", required = false) MultipartFile avatarFile) {

        // Kiểm tra user có tồn tại không
        User existingUser = this.userService.getUserById(id).orElse(null);
        if (existingUser == null) {
            return "redirect:/admin/user?error=true&message=User not found";
        }

        // Kiểm tra validation errors
        if (bindingResult.hasErrors()) {
            List<Role> roles = this.roleService.getAllRoles();
            // Preserve the avatar from existing user to avoid losing it
            user.setAvatar(existingUser.getAvatar());
            model.addAttribute("roles", roles);
            model.addAttribute("user", user);
            return "admin/user/edit";
        }

        try {
            user.setId(id);
            this.userService.handleUpdateUser(user, avatarFile, roleName);
            return "redirect:/admin/user?success=true&message=User updated successfully";
        } catch (Exception e) {
            List<Role> roles = this.roleService.getAllRoles();
            // Preserve the avatar from existing user to avoid losing it
            user.setAvatar(existingUser.getAvatar());
            model.addAttribute("user", user);
            model.addAttribute("roles", roles);
            model.addAttribute("error", e.getMessage());
            return "admin/user/edit";
        }
    }

    // delete user
    @PostMapping("/user/delete/{id}")
    public String deleteUser(@PathVariable long id, Model model) {
        try {
            this.userService.handleDeleteUser(id);
            return "redirect:/admin/user?success=true&message=User deleted successfully";
        } catch (Exception e) {
            return "redirect:/admin/user?error=true&message=" + e.getMessage();
        }
    }

}
