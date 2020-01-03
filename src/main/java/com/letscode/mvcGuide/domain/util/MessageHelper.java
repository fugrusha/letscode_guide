package com.letscode.mvcGuide.domain.util;

import com.letscode.mvcGuide.domain.User;

public abstract class MessageHelper {
    public static String getAuthorName(User author) {
        return author != null ? author.getUsername() : "unknown";
    }
}
