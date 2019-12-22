package com.letscode.mvcGuide.controller;

import com.letscode.mvcGuide.domain.User;
import com.letscode.mvcGuide.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import java.util.Map;

@Controller
public class RegistrationController {
    @Autowired
    private UserService userService;

    @GetMapping("/register")
    public String registration() {
        return "register";
    }

    @PostMapping("/register")
    public String addUser(User user, Map<String, Object> model) {
        // if user exists return message
        if (!userService.addUser(user)) {
            model.put("message", "User exists!");
            return "register";
        }
        // if it is new user return login page
        return "redirect:/login";
    }

    @GetMapping("/activate/{code}")
    public String activate(Model model, @PathVariable String code) {
        boolean isActivated = userService.activateUser(code);

        if (isActivated) {
            model.addAttribute("message", "Congrats! \n Your account is activated successfully!");
        } else {
            model.addAttribute("message", "Ooops! \n It seems wrong activation code/");
        }

        return "login";
    }
}
