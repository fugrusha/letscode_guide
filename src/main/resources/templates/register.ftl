<#import "parts/common.ftl" as c>
<#import "parts/login.ftl" as l>

<@c.page>
Add new user
<!--Show msg about existing user-->
<#if message??>
    ${message}
</#if>

<@l.login "/register" />
</@c.page>