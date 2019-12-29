<#import "parts/common.ftl" as c>
<#include "parts/security.ftl">

<@c.page>
    <div>
        <h1 inline="text">Welcome, ${name}!</h1>
    </div>

    <div class="form-row">
        <form method="get" action="main" class="form-inline">
            <input type="text" name="filter" class="form-control" placeholder="Find by tag" value="${filter?ifExists}">
            <button type="submit" class="btn btn-primary ml-2">Search</button>
        </form>
    </div>


<#include "parts/messageEdit.ftl">

<#include "parts/messageList.ftl">


</@c.page>