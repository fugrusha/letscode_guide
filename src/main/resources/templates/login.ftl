<#import "parts/common.ftl" as c>
<#import "parts/login.ftl" as l>

<@c.page>
<h3>Login page</h3>
${message?ifExists}
<@l.login "/login" false/>

</@c.page>