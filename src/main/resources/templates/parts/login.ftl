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
        <div class="col-sm-4">
            <input type="text" class="form-control ${(usernameError??)?string('is-invalid', '')}"
                   name="username" placeholder="Username"
                   value="<#if user??>${user.username}</#if>"/>
            <#if usernameError??>
            <div class="invalid-feedback">
                ${usernameError}
            </div>
        </
        #if>
    </div>

    </div>
    <div class="form-group">
        <label class="col-sm-2 col-form-label">Password:</label>
        <div class="col-sm-4">
            <input type="password" class="form-control ${(passwordError??)?string('is-invalid', '')}"
                   name="password" placeholder="Password"/>
            <#if passwordError??>
            <div class="invalid-feedback">
                ${passwordError}
            </div>
        </
        #if>
    </div>
    </div>
    <#if isRegisterForm>
    <div class="form-group">
        <label class="col-sm-2 col-form-label">Password:</label>
        <div class="col-sm-4">
            <input type="password" class="form-control ${(password2Error??)?string('is-invalid', '')}"
                   name="password2" placeholder="Confirm password"/>
            <#if password2Error??>
            <div class="invalid-feedback">${password2Error}</div>
        </
        #if>
    </div>
    </div>

    <div class="form-group">
        <label class="col-sm-2 col-form-label">Email:</label>
        <div class="col-sm-4">
            <input type="email" class="form-control ${(emailError??)?string('is-invalid', '')}"
                   name="email" placeholder="Email"
                   value="<#if user??>${user.email}</#if>"/>
            <#if emailError??>
            <div class="invalid-feedback">${emailError}</div>
        </
        #if>
    </div>
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
