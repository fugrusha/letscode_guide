<a class="btn btn-primary" data-toggle="collapse" href="#collapseMessage" role="button" aria-expanded="false"
   aria-controls="collapseExample">
    Message Editor
</a>

<div class="collapse <#if message??>show</#if>" id="collapseMessage">
    <div class="form-group mt-3">
        <form method="post" enctype="multipart/form-data">
            <div class="form-group">
                <input type="text" class="form-control ${(textError??)?string('is-invalid', '')}"
                       value="<#if message??>${message.text}</#if>" name="text" placeholder="What's new?">
                <#if textError??>
                    <div class="invalid-feedback">
                        ${textError}
                    </div>
                </#if>
            </div>
        <div class="form-group">
        <input type="text" class="form-control ${(tagError??)?string('is-invalid', '')}"
               value="<#if message??>${message.tag}</#if>" name="tag" placeholder="tags">
            <#if tagError??>
                <div class="invalid-feedback">
                    ${tagError}
                </div>
            </#if>
        </div>
        <div class="form-group">
            <div class="custom-file">
                <input type="file" class="custom-file-input" id="customFile" name="file">
                <label class="custom-file-label" for="customFile">Choose File</label>
            </div>
        </div>

            <input type="hidden" name="_csrf" value="${_csrf.token}" />
            <input type="hidden" name="id" value="<#if message??>${message.id}</#if>" />


        <div class="form-group">
            <button type="submit" class="btn btn-success">Public post</button>
        </div>
        </form>
    </div>
</div>