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
            self.location = "/board/register";
        });

        let actionForm = $("#actionForm");

        $(".paginate_button a").on("click", function (e){
            e.preventDefault();

            console.log("click");

            actionForm.find("input[name='pageNum']").val($(this).attr("href"));
            console.log($(this).attr("href"));
            actionForm.submit();
        });

        $(".move").on("click", function (e){
            e.preventDefault();
            actionForm.append("<input type='hidden' name='bno' value='" + $(this).attr("href") + "'>");
            actionForm.attr("action", "/board/get");
            console.log(actionForm)
            actionForm.submit();
        });

        let searchForm = $("searchForm");

        $("searchForm button").on("click", function (e){
            if(!searchForm.find("option:selected").val()){
                alert('검색 조건을 선택하세요');
                return ;
            }

            if(!searchForm.find("input[name='keyword']").val()){
                alerT('키워드를 입력하세요');
                return ;
            }

            searchForm.find("input[name='pageNum']").val("1");
            e.preventDefault();

            searchForm.submit();

        })

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
                                        <td> <a class="move" href='<c:out value="${board.bno}" />'><c:out value="${board.title}" /></a> </td>
                                        <td> <c:out value="${board.writer}" /></td>
                                        <td> <fmt:formatDate pattern="yyyy-mm-dd" value="${board.regDate}" /></td>
                                        <td> <fmt:formatDate pattern="yyyy-mm-dd" value="${board.updateDate}" /></td>
                                    </tr>
                                </c:forEach>
                            </thead>
                        </table>
                        <div class="row">
                            <div class="col-lg-12">
                                <form id="searchForm" action="/board/list" method="get">
                                    <select name="type">
                                        <option value="" <c:out value="${pageMaker.cri.type == null ? 'selected' : ''}" /> >--</option>
                                        <option value="T" <c:out value="${pageMaker.cri.type == 'T' ? 'selected' : ''}" />>제목</option>
                                        <option value="C" <c:out value="${pageMaker.cri.type == 'C' ? 'selected' : ''}" />>내용</option>
                                        <option value="W" <c:out value="${pageMaker.cri.type == 'W' ? 'selected' : ''}" />>작성자 </option>
                                        <option value="TC" <c:out value="${pageMaker.cri.type == 'TC' ? 'selected' : ''}" />>제목 또는 내용</option>
                                        <option value="TW" <c:out value="${pageMaker.cri.type == 'TW' ? 'selected' : ''}" />>제목 또는 작성자</option>
                                        <option value="TWC" <c:out value="${pageMaker.cri.type == 'TWC' ? 'selected' : ''}" />>제목 또는 내용 또는 작성자</option>
                                    </select>
                                    <input type="text" name="keyword" value="${pageMaker.cri.keyword}"/>
                                    <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}" />
                                    <input type="hidden" name="amount" value="${pageMaker.cri.amount}" />
                                    <button class="btn btn-default">Search</button>
                                </form>
                            </div>
                        </div>
                        <div class="pull-right">
                            <ul class="pagination">
                                <form id="actionForm" action="/board/list" method="get">
                                    <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
                                    <input type="hidden" name="amount" value="${pageMaker.cri.amount}">
                                    <input type="hidden" name="type" value="${pageMaker.cri.type}">
                                    <input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
                                </form>

                                <c:if test="${pageMaker.prev}">
                                    <li class="paginate_button prev"><a href="${pageMaker.startPage - 1}">Previous</a></li>
                                </c:if>

                                <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
                                    <li class="paginate_button ${pageMaker.cri.pageNum == num ? "active" : ""}"><a href="${num}">${num}</a></li>
                                </c:forEach>

                                <c:if test="${pageMaker.next}">
                                    <li class="paginate_button prev"><a href="${pageMaker.endPage + 1}">Next</a></li>
                                </c:if>
                            </ul>
                        </div>
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