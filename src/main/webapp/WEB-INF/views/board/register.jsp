<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@include file="../includes/header.jsp"%>
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
                   <div class="form-group">
                       <label>Title</label> <input class="form-control" name="title">
                   </div>
                   <div class="form-group">
                       <label>Text Area</label> <input rows="3" class="form-control" name="content">
                   </div>
                   <div class="form-group">
                       <label>writer</label> <input class="form-control" name="writer">
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