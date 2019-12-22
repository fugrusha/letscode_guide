<#macro logout>
<div class="form-group">
    <form action="/logout" method="post">
        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
        <button type="submit" class="btn btn-danger">Log Out</button>
    </form>
</div>
</#macro>

<#macro login path isRegisterForm>
<form action="${path}" method="post">
    <div class="form-group">
        <label class="col-sm-2 col-form-label">Username:</label>
        <input type="text" class="col-sm-4 form-control" name="username" placeholder="Username"/>
    </div>
    <div class="form-group">
        <label class="col-sm-2 col-form-label">Password:</label>
        <input type="password" class="col-sm-4 form-control" name="password" placeholder="Password"/>
    </div>
    <#if isRegisterForm>
    <div class="form-group">
        <label class="col-sm-2 col-form-label">Email:</label>
        <input type="email" class="col-sm-4 form-control" name="email" placeholder="Email"/>
    </div>
    </#if>
    <input type="hidden" name="_csrf" value="${_csrf.token}"/>

    <button type="submit" class="btn btn-primary">
        <#if !isRegisterForm>
            Sign In
        <#else>
            Register
        </#if>
    </button>

    <#if !isRegisterForm><p><a href="/register">Or you can register new account</a></p></#if>
</form>
</#macro>
