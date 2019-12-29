<#import "parts/common.ftl" as c>

<@c.page>
<h3 class="display-4">${userChannel}'s ${type}</h3>

<ul class="list-group">
    <#list users as user>
        <li class="list-group-item">
            <a href="/user-tweets/${user.id}">${user.getUsername()}</a>
        </li>
    </#list>
</ul>


</@c.page>