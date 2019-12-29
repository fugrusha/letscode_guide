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
    <a class="btn btn-primary" data-toggle="collapse" href="#collapseMessage" role="button" aria-expanded="false"
       aria-controls="collapseExample">
        New message
    </a>
<div class="collapse <#if message??>show</#if>" id="collapseMessage">
    <div class="form-group mt-3">
        <form method="post" enctype="multipart/form-data">
            <input type="hidden" name="_csrf" value="${_csrf.token}"/>
            <div class="form-group">
                <input type="text" class="form-control ${(textError??)?string('is-invalid', '')}"
                       value="<#if message??>${message.text}</#if>" name="text" placeholder="What's new?">
                <#if textError??>
                <div class="invalid-feedback">
                    ${textError}
                </div>
            </
            #if>
    </div>
    <div class="form-group">
        <input type="text" class="form-control ${(tagError??)?string('is-invalid', '')}"
               value="<#if message??>${message.tag}</#if>" name="tag" placeholder="tags">
        <#if tagError??>
        <div class="invalid-feedback">
            ${tagError}
        </div>
    </
    #if>
</div>
<div class="form-group">
    <div class="custom-file">
        <input type="file" class="custom-file-input" id="customFie" name="file">
        <label class="custom-file-label" for="customFie">Choose File</label>
    </div>
</div>
                <div class="form-group">
                    <button type="submit" class="btn btn-success">Public post</button>
                </div>
            </form>
        </div>
    </div>


<div class="card-columns">
    <#list messages as message>
        <div class="card border-info my-3" style="width: 18rem;">
            <#if message.filename??>
            <img class="card-img-top" src="/img/${message.filename}">
        </#if>
        <div class="m-2">
            <span>${message.text}</span>
            <i>${message.tag}</i>
        </div>
        <div class="card-footer text-muted">by ${message.authorName}</div>

        </div>
    <#else> No messages
    </#list>
</div>

</@c.page>