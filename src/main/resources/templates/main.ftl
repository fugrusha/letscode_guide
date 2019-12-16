<#import "parts/common.ftl" as c>
<#import "parts/login.ftl" as l>

<@c.page>
    <div>
        <h1 inline="text">Welcome, Username!</h1>
        <@l.logout />
        <span><a href="/user">User List</a> </span>
    </div>

    <div>
        <form method="post" enctype="multipart/form-data">
            <input type="hidden" name="_csrf" value="${_csrf.token}"/>
            <input type="text" name="text" placeholder="What's new?">
            <input type="text" name="tag" placeholder="tags">
            <input type="file" name="file">
            <button type="submit">Public post</button>
        </form>
    </div>

    <div> List of messages </div>
    <form method="get" action="main">
        <input type="text" name="filter" placeholder="Find by tag" value="${filter?ifExists}">
        <button type="submit">Search</button>
    </form>

    <#list messages as message>
        <div>
            <b>${message.id}</b>
            <span>${message.text}</span>
            <i>${message.tag}</i>
            <span>by ${message.authorName}</span>
            <div>
                <#if message.filename??>
                <img src="/img/${message.filename}">
                </#if>
            </div>
        </div>
    <#else> No messages
    </#list>

</@c.page>