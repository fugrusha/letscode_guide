package com.letscode.mvcGuide.controller;

import com.letscode.mvcGuide.domain.User;
import com.letscode.mvcGuide.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import javax.validation.Valid;
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
    public String addUser(@Valid User user, BindingResult bindingResult, Model model) {
        // check two passwords
        if (user.getPassword() != null && !user.getPassword().equals(user.getPassword2())) {
            model.addAttribute("passwordError", "Passwords are different");
        }
        // check validation
        if (bindingResult.hasErrors()) {
            Map<String, String> errors = ControllerUtils.getErrors(bindingResult);
            model.mergeAttributes(errors);
            return "register";
        }

        // if user exists return message
        if (!userService.addUser(user)) {
            model.addAttribute("usernameError", "User already exists!");
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
