<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@include file="../includes/header.jsp"%>

<script type="text/javascript">
$(document).ready(function (){
    let formObj = $("form");
    console.log(formObj);

    $('button').on('click', function(e){

        e.preventDefault();

        let operation = $(this).data("oper");
        console.log(operation);

        if(operation === 'remove') {
            formObj.attr("action", "/board/remove");
        }

        if(operation === 'list') {
            formObj.attr("action", "/board/list").attr("method", "get");
            formObj.empty();
        }

        formObj.submit();
    })
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
                    <button type="submit" data-oper="modify" class="btn btn-default">modify</button>
                    <button type="submit" data-oper="remove" class="btn btn-danger">remove</button>
                    <button type="submit" data-oper="list" class="btn btn-info">List</button>
                </form>
            </div>
        </div>
    </div>
</div>

<%@include file="../includes/footer.jsp"%>