package com.letscode.mvcGuide.controller;

import com.letscode.mvcGuide.domain.Role;
import com.letscode.mvcGuide.domain.User;
import com.letscode.mvcGuide.repos.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

// controller to control userRoles
@Controller
@RequestMapping("/user")
@PreAuthorize("hasAuthority('ADMIN')")  // to check authorization as ADMIN
public class UserController {
    @Autowired
    private UserRepo userRepo;

    @GetMapping
    public String userList(Model model) {
        model.addAttribute("users", userRepo.findAll());
        return "userList";
    }

    // for user editing
    @GetMapping("{user}")
    public String userEditForm(@PathVariable User user, Model model) {
        model.addAttribute("user", user);
        model.addAttribute("roles", Role.values());
        return "userEdit";
    }

    @PostMapping
    public String userSave(
            @RequestParam String username,
            @RequestParam Map<String, String> form,
            @RequestParam("userId") User user
    ) {
        user.setUsername(username); // change username

        Set<String> roles = Arrays.stream(Role.values())
                .map(Role::name)
                .collect(Collectors.toSet());  // Roles to array
        // clean user roles
        user.getRoles().clear();

        // iter throw form to check values of checkbox. Work if role is added
        for (String key : form.keySet()) {
            if (roles.contains(key)) {
                user.getRoles().add(Role.valueOf(key));
            }
        }


        userRepo.save(user);
        return "redirect:/user";
    }

}
