<#import "parts/common.ftl" as c>


<@c.page>
<h3>${username}</h3>
${message?ifExists}

<form method="post">
    <div class="form-group">
        <label class="col-sm-2 col-form-label">Password:</label>
        <input type="password" class="col-sm-4 form-control" name="password" placeholder="Password"/>
    </div>
    <div class="form-group">
        <label class="col-sm-2 col-form-label">Email:</label>
        <input type="email" class="col-sm-4 form-control" name="email" placeholder="Email" value="${email!''}"/>
    </div>

    <input type="hidden" name="_csrf" value="${_csrf.token}"/>

    <button type="submit" class="btn btn-primary">Save</button>

</form>

</@c.page>