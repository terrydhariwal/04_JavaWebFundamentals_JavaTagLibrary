<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="io.nosqlyessql.mvc.model.User" %>
<%@ page import="java.util.Calendar" %> <!-- example of importing standard Java classes (like our custom User above) -->
<!DOCTYPE html>
<html>

<head>
  <%-- initParam maps to the application level settings in <context-param>...</context-param> in web.xml.
        It does NOT map to the @WebInitParams (servlet level settings).
        For EL to access Servlet level parameters, they need to be added to:
          - the global scope via ...   getServletContext().setAtrribute, or
          - the session scope via ...  request.getSession().setAttribute or
          - the request scope via ...  request.setAttribute()
  --%>
  <title>${ initParam.AppLevelParam }</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css">
  <link href="app.css" rel="stylesheet" type="text/css" >
</head>

<body>

<%@include file="_header.jsp"%>

<section class="main container-fluid">
  <div class="container">

    <h1>${ ProductName }</h1>

    <div class="row-fluid">
      <div class="col-md-9">

        <!-- Example of using standard java classes (similar to custom User class) -->
        <%
          Calendar calendar = Calendar.getInstance(); // Java Scriptlet to instantiate Calendar object
        %>
        <%= calendar.getTime().toString() %> <!-- Java expression to output time -->

        <tabset>
          <tab heading="What?">

            <div class="container">
              <ul class="nav nav-tabs">
                <li><a href="#home" data-toggle="tab">${app_settings.tabNames[0]}</a></li>
                <li><a href="#other" data-toggle="tab">${app_settings.tabNames[1]}</a></li>
                <li><a href="#message" data-toggle="tab">${app_settings.tabNames[2]}</a></li>
                <li><a href="#settings" data-toggle="tab">${app_settings.tabNames[3]}</a></li>
              </ul>
            </div>

            <div class="container">
              <div class="${app_settings.scriptletsAndJSPExpressions_CssClass}"> <!-- Funny thing I've found is that for EL to work, you must begin with a lowercase for the attribute - even though the attribute in the bean may start with a upper case!! -->
                <h2>Using JSP Scriplets and JSP Expressions</h2>
                <%--  JSP Scriptlets start/end with <% ... %>
                        They can contain Java code
                --%>
                <%
                  User g_user = (User) request.getServletContext().getAttribute("global_user");
                  if(g_user == null) {
                    g_user = new User();
                  }
                  User s_user = (User) request.getSession().getAttribute("session_user");
                  if(s_user == null) {
                    s_user = new User();
                  }
                  User r_user = (User) request.getAttribute("request_user");
                  if(r_user == null) {
                    r_user = new User();
                  }
                %>
                <%-- JSP Expressions start/end with <%= ... %%>
                      They are used to insert data onto the page
                      And expression is transformed into a statement
                      The value of the statement is converted to a String Object and inserts it into the implicit out object
                --%>
                Global scope: Welcome <%= g_user.getName() %>   <br/>
                Session scope: Welcome <%= s_user.getName() %> <br />
                Request scope: Welcome <%= r_user.getName() %> <br/>
              </div>
             </div>

            <div class="container">

              <div class="${ app_settings.expressionsLanguage_CssClass }"> <!-- Funny thing I've found is that for EL to work, you must begin with a lowercase for the attribute - even though the attribute in the bean may start with a upper case!! -->
                <h2>Using Expression Language which is much simpler ...</h2>
                Global Scope: Welcome ${ global_user.name } </br>
                Session Scope: Welcome ${ session_user.name } </br>
                Request Scope: Welcome ${ request_user.name } </br>

                <div class="container">
                  <h5>Expression Language operators:</h5>
                  &#36;&#123;3+2&#125; equates to <strong>${3+2}</strong>, <br/>
                  &#36;&#123;2==1&#125; equates to <strong>${2 == 1}</strong>, <br/>
                  &#36;&#123;global_user.name == "Terry"&#125; equates to <strong>${global_user.name == "Terry"}</strong>
                </div>
              </div>
            </div>

            <div class="container">
              <h2>Hello world form</h2>
              <form action="/home" method="post"> <!-- Note the browser has no understanding of the application root, therefore, "/" is relative to the serverhost -->
                <p><input name="name" type="text" /></p>
                <p>
                  <select name="response">
                    <option name="html" value="html" selected="selected" >html</option>
                    <option name="xml" value="xml" >xml</option>
                    <option name="json" value="json" >json</option>
                  </select>
                </p>
                <p><input type="submit" value="Enter name"/></p>
              </form>
            </div>
          </tab>
          <tab heading="Next">
            Yet more static content
          </tab>
        </tabset>
      </div>
    </div>
  </div>
</section>
<script src="https://code.jquery.com/jquery-1.11.2.min.js"></script>
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js"></script>
</body>
</html>
