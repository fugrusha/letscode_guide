package com.letscode.mvcGuide.service;

import com.letscode.mvcGuide.domain.Role;
import com.letscode.mvcGuide.domain.User;
import com.letscode.mvcGuide.repos.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.*;
import java.util.stream.Collectors;

@Service
public class UserService implements UserDetailsService {
    @Autowired
    private UserRepo userRepo;

    @Autowired
    private MailSenderService mailSenderService;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        return userRepo.findByUsername(username);
    }

    public boolean addUser(User user) {
        User userFromDB = userRepo.findByUsername(user.getUsername());
        // if user exists return false
        if (userFromDB != null) {
            return false;
        }

        user.setActive((true));
        user.setRoles(Collections.singleton(Role.USER));
        user.setActivationCode(UUID.randomUUID().toString()); // generate UUID to confirm email
        userRepo.save(user);

        sendMessageToUser(user);

        return true;
    }

    private void sendMessageToUser(User user) {
        // check if user has email
        if (StringUtils.isEmpty(user.getEmail())) {
            String messageText = String.format(
                    "Hello, %s! \n" +
                            "Welcome to Sweeter. To confirm your email please go to: http://localhost:9090/activate/%s",
                    user.getUsername(),
                    user.getActivationCode()
            );

            mailSenderService.send(user.getEmail(), "Email Confirmation", messageText);
        }
    }

    public boolean activateUser(String code) {
        User user = userRepo.findByActivationCode(code);

        if (user == null) {
            return false; // if user is not found return false
        }

        user.setActivationCode(null); //user verified email
        userRepo.save(user);

        // if user is found TRUE
        return true;
    }

    public List<User> findAll() {
        return userRepo.findAll();
    }

    public void saveUser(User user, String username, Map<String, String> form) {

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
    }

    public void updateProfile(User user, String password, String email) {
        String userEmail = user.getEmail();

        boolean isEmailChanged = (email != null && !email.equals(userEmail) ||
                userEmail != null && !userEmail.equals(email));

        if (isEmailChanged) {
            user.setEmail(email);

            if (!StringUtils.isEmpty(email)) {
                user.setActivationCode(UUID.randomUUID().toString());
            }
        }

        if (!StringUtils.isEmpty(password)) {
            user.setPassword(password);
        }

        userRepo.save(user);

        if (isEmailChanged) {
            sendMessageToUser(user);
        }

    }
}
