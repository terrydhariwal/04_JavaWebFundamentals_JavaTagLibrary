<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>URL Test</title>
</head>
<body>

<div>
  <a href="/signup.jsp">This is relative to server root</a>
</div>

<div>
  <a href="signup.jsp">This is relative to the current directory</a>
</div>

<div>
  <a href='<c:url value="/signup.jsp"/>' > This is relative to the application context (root of app location)</a>
</div>


</body>
</html>
