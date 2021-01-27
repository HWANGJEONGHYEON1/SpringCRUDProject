<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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

<script type="text/javascript" src="/resources/js/reply.js"></script>
<script type="text/javascript">
$(document).ready(function(){

    (function (){
        let bno = '<c:out value="${board.bno}" />';
        $.getJSON("/board/getAttachList", {bno: bno}, function(arr){
            console.log(arr);

            let str = "";

            $(arr).each(function(i, attach){
                if(attach.fileType) {
                    let fileCallPath = encodeURIComponent(attach.uploadPath + "/s_" + attach.uuid + "_" + attach.fileName);
                    str += "<li data-path = '" + attach.uploadPath + "' data-uuid='" + attach.uuid + "' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"'><div>";
                    str += "<img src='/display?fileName=" + fileCallPath + "'>";
                    str += "</div></li>";
                } else {
                    str += "<li data-path = '" + attach.uploadPath + "' data-uuid='" + attach.uuid + "' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"'><div>";
                    str += "<span> " + attach.fileName + "</span><br />";
                    str += "<img src='/resources/img/undraw_rocket.svg'>";
                    str += "</div></li>";
                }
            });
            $(".uploadResult ul").html(str);
        })
    })();
   let operForm = $("#openForm");

   let bnoValue = '<c:out value="${board.bno}" />';
   let replyUL = $(".chat");

    let pageNum;
    let replyPageFooter = $(".panel-footer");

   showList(1);

   function showList(page){
       replyService.getList({ bno : bnoValue, page: page || 1},
           function(replyCnt,list){
               let str = [];

               if(page == -1 ){
                   pageNum = Math.ceil(replyCnt / 10.0);
                   showList(pageNum);
                   return ;
               }
               if(list == null || list.length == 0){
                   replyUL.html("");
                   return ;
               }
               for( let i = 0, len = list.length || 0 ; i < len ; i++){

                   str.push("<li class='left clearfix' data-rno='"+list[i].rno+"'>");
                   str.push("   <div><div class='header'><strong class='primary-font'>" + list[i].replyer+"</strong>");
                   str.push("       <small class='pull-right text-muted'>" + replyService.displayTime(list[i].replyDate) + "</small></div>");
                   str.push("       <p>" + list[i].reply + "</p>");
                   str.push("   </div></li>")
               }
               replyUL.html(str);

               showreplyPage(replyCnt);
       })
   }


   function showreplyPage(replyCnt) {
       let endNum = Math.ceil(pageNum / 10.0) * 10;
       let startNum = endNum - 9;

       let prev = startNum != 1;
       let next = false;

       if(endNum * 10 >= replyCnt) {
           endNum = Math.ceil(pageNum / 10.0);
       }

       if(endNum * 10 < replyCnt){
           next = true;
       }

       let str = "<ul class='pagination pull-right'>";

       if(prev){
           str += "<li class='page-item'><a class='page-link' href='"+(startNum-1)+"'>Previous</a></li>";
       }

       for( let i = startNum; i <= endNum; i++ ){
           let active = pageNum == i? "active" : "";

           str += "<li class='page-item'><a class='page-link' href='"+i+"'>"+i+"</a></li>";
       }

       if(next) {
           str += "<li class='page-item'><a class='page-link' href='"+(endNum + 1)+"'>Next</a></li> ";
           str += "</ul></div>";
       }

       console.log(str);
       replyPageFooter.html(str);
   }

   let modal = $(".modal");
   let modalInputReply = modal.find("input[name='reply']");
   let modalInputReplyer = modal.find("input[name='replyer']");
   let modalInputReplyDate = modal.find("input[name='replyDate']");

   let modalModBtn = $("#modalModBtn");
   let modalRemoveBtn = $("#modalRemoveBtn");
   let modalRegisterBtn = $("#modalRegisterBtn");

   $("#addReplyBtn").on("click", function(e){

       modal.find("input").val("");
       modalInputReplyDate.closest("div").hide();
       modal.find("button[id != 'modalCloseBtn']").hide();

       modalRegisterBtn.show();
       $(".modal").modal("show");
   });

   $("#modalRegisterBtn").on("click", function(e){
       let reply = {
           reply : modalInputReply.val(),
           replyer : modalInputReplyer.val(),
           bno: bnoValue
       };
       console.log("등록버튼 클릭");
       replyService.add(
           reply,
           function (result) {
               console.log("등록버튼 파라메터");
               alert("Result : "+ result);
               modal.find("input").val("");
               modal.modal("hide");
               showList(-1);
           }
       );
   });

   modalModBtn.on("click", function(e){
       let reply = {rno : modal.data("rno"), reply: modalInputReplyer.val()};
       replyService.update(reply, function(result){
           alert(result);
           modal.modal("hide");
           showList(pageNum);
       })
   });

   modalRemoveBtn.on("click", function (e){
       let rno = modal.data("rno");

       replyService.remove(rno, function(result){
           alert(result);
           modal.modal("hide");
           showList(pageNum);
       })
   })

   $(".chat").on("click", "li", function(e){
       let rno = $(this).data("rno");

       replyService.get(rno, function(reply){
           modalInputReply.val(reply.reply);
           modalInputReplyer.val(reply.replyer);
           modalInputReplyDate.val(replyService.displayTime(reply.replyDate)).attr("readonly", "readonly");

           modal.data("rno", reply.rno);

           modal.find("button[ id != 'modalCloseBtn']").hide();
           modalModBtn.show();
           modalRemoveBtn.show();

           $(".modal").modal("show");

       })
   })

    replyPageFooter.on("click", "li a", function (e){
        e.preventDefault();

        console.log("page click");

        let targetPageNum = $(this).attr("href");
        console.log("target : " + targetPageNum);

        pageNum = targetPageNum;
        showList(pageNum);
    } )

   $("button[data-oper='modify']").on("click", function (e){
       operForm.attr("action", "/board/modify").submit();
   });

   $("button[data-oper='list']").on("click", function (e){
       operForm.attr("action", "/board/list");
       operForm.submit();
    });

   $(".uploadResult").on("click", "li", function (e){
       console.log("view image");
       let liObj = $(this);

       let path = encodeURIComponent(liObj.data("path") + "/" + liObj.data("uuid") + "_" + liObj.data("filename"));

       if(liObj.data("type")){
           showImage(path.replace(new RegExp(/\\/g), "/"));
       } else {
           self.location="/download?fileName="+path
       }
   });

   $(".bigPictureWrapper").on("click", function (e){
       $(".bigPicture").animate({width : '0%', height: '0%'}, 1000);
       setTimeout(function(){
           $(".bigPictureWrapper").hide();
       },1000);
   })

    function showImage(fileCallPath) {
       alert(fileCallPath);
       $(".bigPictureWrapper").css("display","flex").show();
       $(".bigPicture")
        .html("<img src='/display?fileName=" + fileCallPath + "'>" )
        .animate({width : '100%', height : '100%'}, 1000);
    }

});
</script>
<div class="row">
    <div class="col-lg-12">
        <h1 class="page-header">Board Read</h1>
    </div>
    <!-- /.col-lg-12 -->
</div>
<!-- /.row -->

<!-- Modal reply -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">Reply Modal</h4>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <label>Reply</label>
                    <input class="form-control" name="reply" value="New Reply">
                </div>
                <div class="form-group">
                    <label>Replyer</label>
                    <input class="form-control" name="replyer" value="replyer">
                </div>
                <div class="form-group">
                    <label>Reply Date</label>
                    <input class="form-control" name="replyDate" value="">
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" id="modalModBtn" class="btn btn-warning">Modifys</button>
                <button type="button" id="modalRemoveBtn" class="btn btn-danger">Remove</button>
                <button type="button" id="modalRegisterBtn" class="btn btn-primary">Register</button>
                <button type="button" id="modalCloseBtn" class="btn btn-warning" data-dismiss="modal">Close</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>

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
                    <input type="hidden" id="pageNum" name="pageNum" value="<c:out value='${cri.pageNum}'/>">
                    <input type="hidden" id="amount" name="amount" value="<c:out value='${cri.amount}'/>">
                    <input type="hidden" id="keyword" name="keyword" value="<c:out value='${cri.keyword}'/>">
                    <input type="hidden" id="type" name="type" value="<c:out value='${cri.type}'/>">
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
                <div class="uploadResult">
                    <ul>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading">
                <i class="fa fa-comments fa-fw"></i> Reply
                <button id="addReplyBtn" class="btn btn-primary btn-xs pull-right">New Reply</button>
            </div>
            <div class="panel-body">
                <ul class="chat">
                    <li class="left clearfix" data-rno="135">
                        <div>
                            <div class="header">
                                <strong class="primary-font">user00</strong>
                                <small class="pull-right text-muted">2021-01-21 23:377</small>
                            </div>
                            <p>Good Job!</p>
                        </div>
                    </li>
                </ul>
            </div>
            <div class="panel-footer"></div>
        </div>
    </div>
</div>
<%@include file="../includes/footer.jsp"%>