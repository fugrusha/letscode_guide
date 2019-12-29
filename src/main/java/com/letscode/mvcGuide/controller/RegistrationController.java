package com.letscode.mvcGuide.controller;

import com.letscode.mvcGuide.domain.User;
import com.letscode.mvcGuide.domain.dto.CaptchaResponseDTO;
import com.letscode.mvcGuide.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

import javax.validation.Valid;
import java.util.Collections;
import java.util.Map;

@Controller
public class RegistrationController {
    private final static String CAPTCHA_URL = "https://www.google.com/recaptcha/api/siteverify?secret=%s&response=%s";

    @Autowired
    private UserService userService;

    @Autowired
    private RestTemplate restTemplate;

    @Value("${recaptcha.secret}")
    private String secretCode;

    @GetMapping("/register")
    public String registration() {
        return "register";
    }

    @PostMapping("/register")
    public String addUser(
            @RequestParam("password2") String passwordConfirmaion,
            @RequestParam("g-recaptcha-response") String captchaResponse,
            @Valid User user,
            BindingResult bindingResult,
            Model model) {
        // send captcha to google
        String url = String.format(CAPTCHA_URL, secretCode, captchaResponse);
        CaptchaResponseDTO response = restTemplate.postForObject(url, Collections.emptyList(), CaptchaResponseDTO.class);
        // if captcha doest match put to model massage
        if (!response.isSuccess()) {
            model.addAttribute("captchaError", "Incorrect CAPTCHA");
        }

        boolean isConfirmEmpty = StringUtils.isEmpty(passwordConfirmaion);

        if (isConfirmEmpty) {
            model.addAttribute("password2Error", "Password confirmation cant be empty");
        }

        // check two passwords
        if (user.getPassword() != null && !user.getPassword().equals(passwordConfirmaion)) {
            model.addAttribute("passwordError", "Passwords are different");
        }
        // check validation
        if (isConfirmEmpty || bindingResult.hasErrors() || !response.isSuccess()) {
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
            model.addAttribute("messageType", "success");
            model.addAttribute("message", "Congrats! \n Your account is activated successfully!");
        } else {
            model.addAttribute("messageType", "danger");
            model.addAttribute("message", "Ooops! \n It seems wrong activation code/");
        }

        return "login";
    }
}
