<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@include file="../includes/header.jsp"%>

<script type="text/javascript">
$(document).ready(function (){

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
                    <button type="submit" data-oper="modify" class="btn btn-default">modify</button>
                    <button type="button" data-oper="remove" class="btn btn-danger">remove</button>
                    <button type="button" data-oper="list" class="btn btn-info">List</button>
                </form>
            </div>
        </div>
    </div>
</div>

<%@include file="../includes/footer.jsp"%>