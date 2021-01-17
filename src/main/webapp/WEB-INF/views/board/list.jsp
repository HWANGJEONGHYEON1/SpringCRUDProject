<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@include file="../includes/header.jsp"%>

<script type="text/javascript">

    $(document).ready(function(){

        let result = '<c:out value="${result}" />';

        checkModal(result);

        history.replaceState({}, null, null);

        function checkModal(result) {
            if( result === '' || history.state) {
                return ;
            }

            if(parseInt(result) > 0) {
                $(".modal-body").html("게시글 " + parseInt(result) + " 번이 등록되었습니다.");
            }

            $("#myModal").modal("show");

        }

        $("#regBtn").on("click", function(e){
            console.log("CLICK");
            self.location = "/board/register";
        });
    });

</script>


        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">BOARD LIST</h1>
            </div>
            <!-- /.col-lg-12 -->
        </div>
        <!-- /.row -->
        <div class="row">
            <div class="panel-heading">Board List Page
                <button id="regBtn" type="button" class="btn btn-xs pull-right">Register New Board</button>
            </div>
            <div class="col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        DataTables Advanced Tables
                    </div>
                    <!-- /.panel-heading -->
                    <div class="panel-body">
                        <table width="100%" class="table table-striped table-bordered table-hover" id="dataTables-example">
                            <thead>
                                <tr>
                                    <th>#번호</th>
                                    <th>제목</th>
                                    <th>작성자</th>
                                    <th>작성일</th>
                                    <th>수정일</th>
                                </tr>
                                <c:forEach items="${list}" var="board">
                                    <tr>
                                        <td> <c:out value="${board.bno}" /></td>
                                        <td> <a href='/board/get?bno=<c:out value="${board.bno}" />'><c:out value="${board.title}" /> </td>
                                        <td> <c:out value="${board.writer}" /></td>
                                        <td> <fmt:formatDate pattern="yyyy-mm-dd" value="${board.regDate}" /></td>
                                        <td> <fmt:formatDate pattern="yyyy-mm-dd" value="${board.updateDate}" /></td>
                                    </tr>
                                </c:forEach>
                            </thead>
                        </table>
                    </div>
                </div>
            </div>
        </div>

<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">Modal title</h4>
            </div>
            <div class="modal-body">
                처리가 완료되었습니다.
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary">Save changes</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>

<%@include file="../includes/footer.jsp"%>