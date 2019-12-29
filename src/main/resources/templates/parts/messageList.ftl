
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