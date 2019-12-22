<#import "parts/common.ftl" as c>
<#import "parts/login.ftl" as l>

<@c.page>
<h3>Add new user</h3>
<!--Show msg about existing user-->
    ${message?ifExists}

<@l.login "/register" true/>
</@c.page>