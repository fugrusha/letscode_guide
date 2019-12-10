<#import "parts/common.ftl" as c>
<#import "part/login.ftl" as l>

<@c.page>
    <div>
        <h1 inline="text">Welcome, Username!</h1>
        <@l.logout />
    </div>

    <div>
        <form method="post">
            <input type="hidden" name="_csrf" value="${_csrf.token}"/>
            <input type="text" name="text" placeholder="What's new?">
            <input type="text" name="tag" placeholder="tags">
            <button type="submit">Public post</button>
        </form>
    </div>

    <div> List of messages </div>
    <form method="get" action="/main">
        <input type="text" name="filter" placeholder="Find by tag" value="${filter}">
        <button type="submit">Search</button>
    </form>

    <#list messages as message>
    <div>
        <b>#{message.id}</b>
        <span>#{message.text}</span>
        <i>#{message.tag}</i>
        <span>by #{message.getAuthorName}</span>
    </div>
    <#else>
    Oops, no messages
    </#list>

</@c.page>