package io.nosqlyessql.mvc.controllers;

import io.nosqlyessql.mvc.model.MyCustomApplicationSettings;
import io.nosqlyessql.mvc.model.User;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "HelloworldServlet",urlPatterns = {"/home"}, initParams = {@WebInitParam(name = "ProductName", value = "Hello World Application")})
public class HelloworldServlet extends HttpServlet {

    String product = "My Application";
    String appLevelParam = "";

    @Override
    public void init() throws ServletException {

        // getInitParameter gets Servlet level parameters (in annotations or web.xml). Servlet level params in web.xml will override annotation values
        product = getInitParameter("ProductName");
        getServletContext().setAttribute("ProductName", product);

        // getServletContext().getInitParameter(...) gets application level parameters (in web.xml nested inside <context-param>)
        appLevelParam = getServletContext().getInitParameter("AppLevelParam");

        // setting application settings using application level parameter "app_settings"
        System.out.print("in ControllerServlet init");
        MyCustomApplicationSettings globalAppsettings = new MyCustomApplicationSettings();
        globalAppsettings.setScriptletsAndJSPExpressions_CssClass("redUser");
        globalAppsettings.setExpressionsLanguage_CssClass("blueUser");

        //Demonstrating access to nested properties via EL
        String [] tabNames = {"SignIn","Home","Profile","Settings"};
        globalAppsettings.setTabNames(tabNames);
        getServletContext().setAttribute("app_settings", globalAppsettings);

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.print("in ControllerServlet doGet");
        User user = new User();
        user.setName("Terry");
        user.setEmail("terry@nosqlyessql.io");

        RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher("/WEB-INF/index.jsp");
        //We need to pass the bean to the view (/index.jsp)
        //1. We can pass the bean through global scope - all requests (jsp or servlet) can see it
        getServletContext().setAttribute("global_user", user);
        //2. Or pass via session scope - all requests for this user (session) can see it
        request.getSession().setAttribute("session_user", user);
        //3. Or pass via request scope - only this request (this servlet and dispatched request can see it (bean is destroyed once the request completes
        request.setAttribute("request_user", user);

        //Dispatch request to the view
        //1. if we use include, the request can be sent to the jsp, but returns here for further processing (i.e. after user has seen the JSP response)
        // 2. if we use forward the request finishes at the forwarded jsp
        requestDispatcher.forward(request, response);
    }

    @Override
    protected void doPost  (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String responseType = request.getParameter("response");
        String requestType = request.getMethod();
        if(name != null && !name.equals("")) {
            if(responseType.equals("xml")) {
                response.setContentType("text/xml");
                response.getWriter().write("<root>");
                response.getWriter().printf("<name>Hello %s</name>", name);
                response.getWriter().printf("<app-setting>%s</app-setting>", appLevelParam);
                response.getWriter().printf("<product>%s</product>", product);
                response.getWriter().printf("<requestType>%s</requestType>", requestType);
                response.getWriter().write("</root>");
            }
            else if(responseType.equals("json")) {
                response.setContentType("application/json");
                response.getWriter().printf("{ \"response\" : \"Hello %s\", \"app-setting\":\"%s\", \"product\":\"%s\", \"requestType\":\"%s\"}", name, appLevelParam, product, requestType);

            }
            else {
                response.setContentType("text/html");
                response.getWriter().printf("<div>Hello %s</div>", name);
                response.getWriter().printf("<div>App setting = %s</div>", appLevelParam);
                response.getWriter().printf("<div>Product = %s</div>", product);
                response.getWriter().printf("<div>request = %s</div>", requestType);
            }
        }
        else {
            if(requestType.equals("GET")) {
                //response.sendRedirect("/WEB-INF/index.jsp"); //redirect form back to self if no name value
                getServletContext().getRequestDispatcher("/WEB-INF/index.jsp").forward(request, response);
            }
            else {
                //This error handling example is for example purposes only
                //Obviously in the context of form submission we would have client site validation and therefore this wouldn't be called
                //but this is a good demo of how to setup error handling on the server side
                throw new ServletException("A name should be entered.");
            }
        }
    }
}
