<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@include file="../includes/header.jsp"%>

<script type="text/javascript">
$(document).ready(function(){
   let operForm = $("#openForm");

   $("button[data-oper='modify']").on("click", function (e){
       operForm.attr("action", "/board/modify").submit();

   })
});
</script>
<div class="row">
    <div class="col-lg-12">
        <h1 class="page-header">Board Read</h1>
    </div>
    <!-- /.col-lg-12 -->
</div>
<!-- /.row -->
<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading">
                Board Read Page
            </div>
            <!-- /.panel-heading -->
            <div class="panel-body">
                    <div class="form-group">
                        <label>Bno</label> <input class="form-control" name="bno" value="<c:out value='${board.bno}' />" readonly="readonly">
                    </div>
                    <div class="form-group">
                        <label>Title</label> <input class="form-control" name="title" value="<c:out value='${board.title}' />" readonly="readonly">
                    </div>
                    <div class="form-group">
                        <label>Text Area</label> <input rows="3" class="form-control" value="<c:out value='${board.content}' />" name="content" readonly="readonly">
                    </div>
                    <div class="form-group">
                        <label>writer</label> <input class="form-control" name="writer" value="<c:out value='${board.writer}' />" readonly="readonly">
                    </div>
                    <div class="form-group">
                        <label>Update Date</label>
                        <input class="form-control" name="updateDate" value="<fmt:formatDate value='${board.updateDate}' pattern='yyyy-mm-dd' />" readonly="readonly">
                    </div>
                    <div class="form-group">
                        <label>Register Date</label>
                        <input class="form-control" name="registerDate" value="<fmt:formatDate value='${board.regDate}' pattern='yyyy-mm-dd' />" readonly="readonly">
                    </div>
                    <button data-oper="modify" onClick="location.href='/board/modify?bno=<c:out value="${board.bno}" />'" class="btn btn-default">modify</button>
                    <button data-oper="list" onclick="location.href='/board/list' " class="btn btn-info">list</button>

                    <form id="openForm" action="/board/modify" method="get">
                        <input type="hidden" id="bno" name="bno" value="<c:out value='${board.bno}'/>">
                    </form>
            </div>
        </div>
    </div>
</div>

<%@include file="../includes/footer.jsp"%>