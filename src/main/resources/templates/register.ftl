<#import "parts/common.ftl" as c>
<#import "parts/login.ftl" as l>

<@c.page>
Add new user

<!--Show msg about existing user-->
${message}

<@l.login "/register" />
</#c.page>