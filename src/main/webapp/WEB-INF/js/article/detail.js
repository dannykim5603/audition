
function Article__writeReply(form) {
    form.body.value = form.body.value.trim();
    
    if ( form.body.value.length == 0 ) {
        form.body.focus();
        
        alert('내용을 입력해주세요.');
        return;
    }
    
    var $form = $(form);
    
    $form.find('input[type="submit"]').val('작성중..');
    $form.find('input[type="submit"]').prop('disabled', true);
    $form.find('input[type="reset"]').prop('disabled', true);
    
    /*
    $.post(
        './doWriteReply',
        {
            articleId:articleId,
            body:body
        },
        function(data) {
            if ( data.resultCode.substr(0, 2) == 'F-1' ) {
                alert(data.msg);
            }
            else {
                $form.find('input[type="submit"]').val('작성');
                $form.find('input[type="submit"]').prop('disabled', false);
                $form.find('input[type="reset"]').prop('disabled', false);
            }
        }
    );
    */
}

function Article__modifyReply(form) {
    form.body.value = form.body.value.trim();
    
    if ( form.body.value.length == 0 ) {
        form.body.focus();
        
        alert('내용을 입력해주세요.');
        return;
    }
    
    var $tr = $(form).closest('tr');
    
    $tr.attr('data-modify-mode', 'N');
    
    var newBody = form.body.value;
    var id = form.id.value;
    
    // 임시 테스트용
    $tr.find(' > .reply-body-td > .modify-mode-invisible').empty().append(newBody);
    
    // 실제 서버에서 실행
    /*
    $tr.find(' > .reply-body-td > .modify-mode-invisible').empty().append('변경중..');
    
    $.post('./doModifyReply', {
        id:id,
        body: newBody
    }, function(data) {
        if ( data.resultCode.substr(0, 2) == 'S-' ) {
            $tr.find(' > .reply-body-td > .modify-mode-invisible').empty().append(newBody);
        }
        else {
            alert(data.msg);
        }
    }, 'json');
    */
}

function Article__deleteReply(el, id) {
    if ( confirm(id + '번 댓글을 삭제하시겠습니까?') == false ) {
        return;
    }
    
    var $tr = $(el).closest('tr');
    
    /*
    $.post(
        './doDeleteReply',
        {
            id:id
        },
        function(data) {
            if ( data.resultCode.substr(0, 2) == 'S-' ) {
                $tr.remove();
            }
            else {
                alert(data.msg);
            }
        }
    );
    */
}

function Article__turnOnModifyMode(el) {
    var $tr = $(el).closest('tr');
    
    var body = $tr.find(' > .reply-body-td > .modify-mode-invisible').html().trim();
    
    $tr.find(' > .reply-body-td > .modify-mode-visible > form > textarea').val(body);
    
    $tr.attr('data-modify-mode', 'Y');
    $tr.siblings('[data-modify-mode="Y"]').attr('data-modify-mode', 'N');
}

function Article__turnOffModifyMode(el) {
    var $tr = $(el).closest('tr');
    
    $tr.attr('data-modify-mode', 'N');
}