<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%@include file="../includes/header.jsp"%>

<style>
    .uploadResult {
        width: 100%;
        background-color: gray;
    }

    .uploadResult ul {
        display: flex;
        flex-flow: row;
        justify-content: center;
        align-items: center;
    }

    .uploadResult ul li {
        list-style : none;
        padding: 10px;
        align-content: center;
        text-align: center;
    }

    .uploadResult ul li img {
        width: 100px
    }

    .uploadResult ul li span{
        color: white;
    }

    .bigPictureWrapper {
        position: absolute;
        display: none;
        justify-content: center;
        align-content: center;
        align-items: center;
        top: 0%;
        width: 100%;
        height: 100%;
        background-color: gray;
        z-index: 100;
        background: rgba(255, 255, 255, 0.5);
    }

    .bigPicture {
        position: relative;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .bigPicture img {
        width: 600px;
    }

</style>

<script type="text/javascript">
$(document).ready(function (){

    (function (){
        let bno = '<c:out value="${board.bno}" />';
        $.getJSON("/board/getAttachList", {bno: bno}, function(arr){
            console.log(arr);

            let str = "";

            $(arr).each(function(i, attach){
                if(attach.fileType) {
                    let fileCallPath = encodeURIComponent(attach.uploadPath + "/s_" + attach.uuid + "_" + attach.fileName);
                    str += "<li " +
                        "data-path = '" +
                        attach.uploadPath + "' " +
                        "data-uuid='" + attach.uuid + "' " +
                        "data-filename='"+attach.fileName+"' " +
                        "data-type='"+attach.fileType+"'><div>";
                    str += "<span>" + attach.fileName + "</span>";
                    str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' ";
                    str += "class='btn btn-warning btn-circle'> <i class='fa fa-times'></i></button><br>";
                    str += "<img src='/display?fileName=" + fileCallPath + "'>";
                    str += "</div></li>";
                } else {
                    str += "<li data-path = '" + attach.uploadPath + "' data-uuid='" + attach.uuid + "' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"'><div>";
                    str += "<span> " + attach.fileName + "</span><br />";
                    str += "<span>" + attach.fileName + "</span>";
                    str += "<button type='button' data-file=\'"+fileCallPath+"\'";
                    str += " class='btn btn-warning btn-circle'> <i class='fa fa-times'></i></button><br>";
                    str += "<img src='/resources/img/undraw_rocket.svg'>";
                    str += "</div></li>";
                }
            });
            $(".uploadResult ul").html(str);
        })
    })();

    let formObj = $("form");

    $('button').on('click', function(e){

        e.preventDefault();

        let operation = $(this).data("oper");
        console.log(operation);

        if(operation === 'remove') {
            formObj.attr("action", "/board/remove");
            console.log(formObj);
        }

        if(operation === 'list') {
            formObj.attr("action", "/board/list").attr("method", "get");

            let pageNumTag = $("input[name='pageNum']").clone();
            let amountTag = $("input[name='amount']").clone();
            let keywordTag = $("input[name='keyword']").clone();
            let typeTag = $("input[name='type']").clone();

            console.log(pageNumTag.val());
            console.log(amountTag.val());
            console.log(keywordTag.val());
            console.log(typeTag.val());
            formObj.empty();
            formObj.append(pageNumTag);
            formObj.append(amountTag);
            formObj.append(keywordTag);
            formObj.append(typeTag);

        } else if(operation == 'modify'){
            console.log("submit check");

            let str = '';

            $(".uploadResult ul li").each(function(i, obj){
                let jobj = $(obj);
                console.log(jobj);

                str += "<input type='hidden' name='attachList["+ i + "].fileName' value='" + jobj.data("filename") + "'>";
                str += "<input type='hidden' name='attachList["+ i + "].uuid' value='" + jobj.data("uuid") + "'>";
                str += "<input type='hidden' name='attachList["+ i + "].uploadPath' value='" + jobj.data("path") + "'>";
                str += "<input type='hidden' name='attachList["+ i + "].fileType' value='" + jobj.data("type") + "'>";

            });

            formObj.append(str).submit();
        }

        formObj.submit();
    });

    $(".uploadResult").on("click", "button", function (){
        console.log("delete file");

        if(confirm("Remove this file ? ")){
            let targetLi = $("this").closest("li");
            console.log(targetLi);
            targetLi.remove();

        }
    });

    let regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
    let maxSize = 5242880;

    function checkExtension(fileName, fileSize) {
        if(fileSize >= maxSize) {
            alert("[경고] 파일 사이즈 초과");
            return false;
        }

        if(regex.test(fileName)){
            alert("[경고] 해당 종류의 파일은 업로드 불가할 수 없습니다.");
            return false;
        }
        return true;
    }

    let csrfHeaderName = "${_csrf.headerName}";
    let csrfTokenValue = "${_csrf.token}";

    $("input[type='file']").change(function(e){

        let formData = new FormData();

        let inputFile = $("input[name='uploadFile']");

        let files = inputFile[0].files;

        for(let i = 0 ; i < files.length; i++){
            if(!checkExtension(files[i].name, files[i].size)){
                return false;
            }
            formData.append("uploadFile", files[i]);
        }

        $.ajax({
            url: '/uploadAjaxAction',
            processData: false,
            contentType: false,
            beforeSend: function(xhr){
                xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
            },
            data: formData,
            type: 'POST',
            dataType: 'json',
            success: function(result){
                console.log(result);
                showUploadResult(result);
            }
        })
    });

    let showUploadResult = (uploadResultArr) => {
        if(!uploadResultArr || uploadResultArr.length == 0) return false;

        let uploadUL = $(".uploadResult ul");

        let str = "";

        $(uploadResultArr).each(function(i, obj){
            if(obj.image) {
                let fileCallPath = encodeURIComponent( obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
                str += "<li data-path='"+obj.uploadPath+"' "
                    + " data-uuid='"+obj.uuid+"' data-filename='"
                    + obj.fileName+"' data-type='"+obj.image+"'><div>";
                str += "<span> " + obj.fileName + "</span>";
                str += "<button type='button' data-file=\'" + fileCallPath + "\' data-type='image' class='btn btn-warning btn-circle'>" +
                    "<i class=fa fa-times'></i></button><br>";
                str += "<img src='/display?fileName="+fileCallPath+ "'>";
                str += "</div></li>";

            } else {
                let fileCallPath = encodeURIComponent( obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
                let fileLink = fileCallPath.replace(new RegExp(/\\/g), "/");
                str += "<li data-path='"+obj.uploadPath+"' "
                    + " data-uuid='"+obj.uuid+"' data-filename='"
                    + obj.fileName+"' data-type='"+obj.image+"'><div>";
                str += "<span> " + obj.fileName + "</span>";
                str += "<button type='button' data-file=\'" + fileCallPath + "\' data-type='image' class='btn btn-warning btn-circle'>" +
                    "<i class=fa fa-times'></i></button><br>";
                str += "<a><img src='/resources/img/undraw_profile_1.svg' style='width: 30px; height: 30px'></a>";
                str += "</div></li>";
            }
        });

        uploadUL.append(str);
    }


});

</script>
<div class="row">
    <div class="col-lg-12">
        <h1 class="page-header">Board Modify</h1>
    </div>
    <!-- /.col-lg-12 -->
</div>
<!-- /.row -->
<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading">
                Board modify Page
            </div>
            <!-- /.panel-heading -->
            <div class="panel-body">
                <form role="form" action="/board/modify" method="post">
                    <input typ="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                    <input type="hidden" name="pageNum" value="<c:out value='${cri.pageNum}'/>">
                    <input type="hidden" name="amount" value="<c:out value='${cri.amount}'/>">
                    <input type="hidden" name="keyword" value="<c:out value='${cri.keyword}'/>">
                    <input type="hidden" name="type" value="<c:out value='${cri.type}'/>">
                    <div class="form-group">
                        <label>Bno</label> <input class="form-control" name="bno" value="<c:out value='${board.bno}' />" readonly="readonly">
                    </div>
                    <div class="form-group">
                        <label>Title</label> <input class="form-control" name="title" value="<c:out value='${board.title}' />" >
                    </div>
                    <div class="form-group">
                        <label>Text Area</label> <textarea rows="3" class="form-control" name="content"><c:out value='${board.content}' /></textarea>
                    </div>
                    <div class="form-group">
                        <label>writer</label> <input class="form-control" name="writer" value="<c:out value='${board.writer}' />" readonly="readonly">
                    </div>
                    <sec:authentication property="principal" var="pinfo" />
                    <sec:authorize access="isAuthenticated()">
                        <c:if test="${pinfo.username eq board.writer}">
                            <button type="submit" data-oper="modify" class="btn btn-default">modify</button>
                            <button type="button" data-oper="remove" class="btn btn-danger">remove</button>
                        </c:if>
                    </sec:authorize>
                    <button type="button" data-oper="list" class="btn btn-info">List</button>
                </form>
            </div>
        </div>
    </div>
</div>


<div class="bigPictureWrapper">
    <div class="bigPicture"></div>
</div>
<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading">Files</div>
            <div class="panel-body">
                <div class="form-group uploadDiv">
                    <input type="file" name="uploadFile" multiple="multiple">
                </div>
                <div class="uploadResult">
                    <ul>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>

<%@include file="../includes/footer.jsp"%>