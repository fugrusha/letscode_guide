<#include "parts/security.ftl">
<#import "parts/common.ftl" as c>

<@c.page>
<h1 class="display-4">Hey, here is ${userChannel.username}'s tweets</h1>

<#if !isCurrentUser>
    <#if isSubscriber>
        <a class="btn btn-danger" href="/user/unsubscribe/${userChannel.id}">Unsubscribe</a>
    <#else>
        <a class="btn btn-success" href="/user/subscribe/${userChannel.id}">Subscribe</a>
    </#if>
</#if>

<div class="container my-3">
    <div class="row">
        <div class="col">
            <div class="card">
                <div class="card-body">
                    <div class="card-title">Subscriptions</div>
                    <h4 class="card-text">
                        <a href="/user/subscriptions/${userChannel.id}/list">${subscriptionsCount}</a>
                    </h4>
                </div>
            </div>
        </div>
        <div class="col">
            <div class="card">
                <div class="card-body">
                    <div class="card-title">Subscribers</div>
                    <h4 class="card-text">
                        <a href="/user/subscribers/${userChannel.id}/list">${subscribersCount}</a>
                    </h4>
                </div>
            </div>
        </div>
    </div>
</div>


<#if isCurrentUser>
    <#include "parts/messageEdit.ftl">
</#if>

<div class="card-columns">
    <#list messages as message>
    <div class="card border-info my-3" style="width: 18rem;">
        <#if message.filename??>
            <img class="card-img-top" src="/img/${message.filename}">
        </#if>
        <div class="m-2">
            <span>${message.text}</span><br>
            <i>#${message.tag}</i>
        </div>
        <div class="card-footer text-muted">
            by <a href="/user-tweets/${message.author.id}">${message.authorName}</a>
            <#if message.author.id == currentUserId>
                <a class="btn btn-primary" href="/user-tweets/${message.author.id}?message=${message.id}">Edit</a>
            </#if>
        </div>
    </div>
    <#else> No messages
    </#list>
</div>

</@c.page>