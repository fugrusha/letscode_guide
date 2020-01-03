<#include "security.ftl">
<#import "pager.ftl" as p>

<div class="card-columns">
        <#list page.content as message>
        <div class="card border-info my-3" style="width: 18rem;">
            <#if message.filename??>
                <img class="card-img-top" src="/img/${message.filename}">
            </#if>
            <div class="m-2">
                <span>${message.text}</span><br>
                <i>#${message.tag}</i>
            </div>
            <div class="card-footer text-muted container">
                <div class="row">
                    <a class="col align-self-center" href="/user-tweets/${message.author.id}">by ${message.authorName}</a>
                    <a style="text-decoration: none" class="col align-self-center" href="/messages/${message.id}/like">
                        <#if message.meLiked>
                            <i class="fas fa-heart"></i>
                        <#else>
                            <i class="far fa-heart"></i>
                        </#if>
                        ${message.likes}
                        </a>
                    <#if message.author.id == currentUserId>
                        <a class="col btn btn-primary" href="/user-tweets/${message.author.id}?message=${message.id}">Edit</a>
                    </#if>
                </div>
            </div>
        </div>
        <#else> No messages
        </#list>
</div>

<@p.pager url page />