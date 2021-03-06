package com.letscode.mvcGuide.service;

import com.letscode.mvcGuide.domain.User;
import com.letscode.mvcGuide.domain.dto.MessageDTO;
import com.letscode.mvcGuide.repos.MessageRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

@Service
public class MessageService {
    @Autowired
    private MessageRepo messageRepo;

    public Page<MessageDTO> messageList(Pageable pageable, String filter, User user) {
        if (filter != null && !filter.isEmpty()) {
            return messageRepo.findByTag(filter, pageable, user);
        } else {
            return messageRepo.findAll(pageable, user);
        }
    }

    public Page<MessageDTO> getMessageListForUser(Pageable pageable, User currentUser , User author) {
        return messageRepo.findMessageByUser(pageable, currentUser, author);
    }
}
