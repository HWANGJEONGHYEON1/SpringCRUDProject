<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%@include file="../includes/header.jsp"%>
<script type="text/javascript">
$(document).ready(function(){
    let formObj = $("form[role='form']");

    $("button[type='submit']").on("click", function(e){

        e.preventDefault();

        let str = [];
        $(".uploadResult ul li").each(function(i, obj){
            let jobj = $(obj);
            console.dir(jobj);
            console.log("# "+ jobj.data("path"));
            console.log("# "+ jobj.data("uuid"));
            console.log("# "+ jobj.data("filename"));
            console.log("# "+ jobj.data("type"));
            str.push("<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>");
            str.push("<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>");
            str.push("<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>");
            str.push("<input type='hidden' name='attachList["+i+"].fileType' value='"+jobj.data("type")+"'>");
            console.log($("hidden[name='attachList0']").val());
        });

        formObj.append(str).submit();
    })

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
    })

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

    $(".uploadResult").on("click", "button", function (e){
        console.log("delete file");

        let targetFile = $(this).data("file");

        let type = $(this).data("type");

        let targetLi = $(this).closest("li");

        $.ajax({
            url: '/deleteFile',
            data: {fileName: targetFile, type: type},
            beforeSend: function(xhr){
                xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
            },
            dataType: 'text',
            type: 'POST',
            success: function (result){
                alert(result);
                targetLi.remove();
            }


        })
    })

});
</script>
<div class="row">
    <div class="col-lg-12">
        <h1 class="page-header">Board Register</h1>
    </div>
    <!-- /.col-lg-12 -->
</div>
<!-- /.row -->
<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading">
                DataTables Advanced Tables
            </div>
            <!-- /.panel-heading -->
            <div class="panel-body">
               <form role="form" action="/board/register" method="post">

                   <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                   <div class="form-group">
                       <label>Title</label> <input class="form-control" name="title">
                   </div>
                   <div class="form-group">
                       <label>Text Area</label> <input rows="3" class="form-control" name="content">
                   </div>
                   <div class="form-group">
                       <label>writer</label> <input class="form-control" name="writer" value='<sec:authentication property="principal.username" />' readonly="readonly">
                   </div>
                   <button type="submit" class="btn btn-default">Submit</button>
                   <button type="reset" class="btn btn-default">Reset Button</button>
               </form>
            </div>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">

            <div class="panel-heading">File Attach</div>
            <div class="panel-body">
                <div class="form-group uploadDiv">
                    <input type="file" name="uploadFile" multiple>
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