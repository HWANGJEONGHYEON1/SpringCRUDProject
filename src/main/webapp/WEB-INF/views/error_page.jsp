<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="false" import="java.util.*" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <h4 style="color: aquamarine"> <bold><c:out value="${exception.getMessage()}" /> </bold></h4>
    <ul>
        <c:forEach items="${exception.getStackTrace() }" var="stack">
            <li><c:out value="${stack}" /></li>
        </c:forEach>
    </ul>
</body>
</html>
