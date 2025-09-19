package vn.hoidanit.laptopshop.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.ui.Model;
import vn.hoidanit.laptopshop.service.UserService;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.GetMapping;
import vn.hoidanit.laptopshop.domain.User;
import org.springframework.web.bind.annotation.ModelAttribute;
import java.util.List;

@Controller
public class UserController {
    private UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
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
    @GetMapping("/admin/user")
    public String getUserPage(Model model) {
        List<User> users = this.userService.getAllUsers();
        model.addAttribute("users", users);
        return "admin/user/index";
    }

    // show create user form
    @GetMapping("/admin/user/create")
    public String showCreateUserForm(Model model) {
        model.addAttribute("user", new User());
        return "admin/user/create";
    }

    // show edit user form
    @GetMapping("/admin/user/edit/{id}")
    public String getEditUserPage(Model model, @PathVariable long id) {
        User user = this.userService.getUserById(id);
        model.addAttribute("user", user);
        return "admin/user/edit";
    }

    // show detail user
    @GetMapping("/admin/user/{id}")
    public String getDetailUserPage(Model model, @PathVariable long id) {
        User user = this.userService.getUserById(id);
        model.addAttribute("user", user);
        return "admin/user/detail";
    }

    // create user
    @PostMapping("/admin/user/create")
    public String createUser(Model model, @ModelAttribute("user") User user) {
        System.out.println(user);
        this.userService.handleCreateUser(user);
        return "redirect:/admin/user";
    }

    // update user
    @PostMapping("/admin/user/edit/{id}")
    public String updateUser(Model model, @PathVariable long id, @ModelAttribute("user") User user) {
        user.setId(id);
        this.userService.handleUpdateUser(user);
        return "redirect:/admin/user";
    }

    // delete user
    @PostMapping("/admin/user/delete/{id}")
    public String deleteUser(@PathVariable long id, Model model) {
        try {
            this.userService.handleDeleteUser(id);
            return "redirect:/admin/user?success=true&message=User deleted successfully";
        } catch (Exception e) {
            return "redirect:/admin/user?error=true&message=" + e.getMessage();
        }
    }

}
