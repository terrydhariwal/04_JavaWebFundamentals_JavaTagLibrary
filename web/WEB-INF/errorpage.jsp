<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<%@ page import="io.nosqlyessql.mvc.model.User" %>
<!-- example of importing standard Java classes (like our custom User above) -->
<%@ page import="java.util.Calendar" %>
<!-- use taglib directive to import the Java Core Tag Library --> <!-- This works -->
<%--<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>--%>
<!-- use taglib directive to import the Java Core Tag Library --> <!-- This also works -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<head>
    <title>Error Page</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css">
    <link href="app.css" rel="stylesheet" type="text/css">
</head>

<body>

<%@include file="_header.jsp" %>

<section class="main container-fluid">

    <div class="container">
        <h1>Error Page</h1>
        <!-- Example of using standard java classes (similar to custom User class) -->
        <%
            Calendar calendar = Calendar.getInstance(); // Java Scriptlet to instantiate Calendar object
        %>
        <div class="container">
            <%= calendar.getTime().toString() %> <br/><br/> <!-- Java expression to output time -->
            <%= exception.getMessage() %>
        </div>
    </div>

</section>
<script src="https://code.jquery.com/jquery-1.11.2.min.js"></script>
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js"></script>
</body>
</html>
