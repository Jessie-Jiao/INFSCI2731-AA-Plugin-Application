<%-- 
    Document   : activitylog
    Created on : Apr 20, 2016, 6:05:11 PM
    Author     : shaoNPC
--%>
<%@page import="java.util.List"%>
<%@page import="dataAccessObject.RBACDao"%>
<%@page import="model.UserAccountInfo"%>
<%@page import="dataAccessObject.ActivityLogDao"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.sql.ResultSet"%>

<%
    if (request.getSession().getAttribute("user") != null) {
        UserAccountInfo user = (UserAccountInfo) session.getAttribute("user");
        RBACDao accessControl = new RBACDao();
        List<Integer> UserPool = accessControl.getRolebyPath("activitylog.jsp");
        if (!UserPool.contains(user.getAccess_role_id())) {
            response.sendRedirect("index.jsp");
        }
    } else {
        response.sendRedirect("login.jsp");
    }
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" />
        
        <style>
            .container.table-div { width:100%;}
            .table { display:table; border-collapse:collapse; padding-bottom:1em; }
            .table-row { display:table-row; }
            .table-row.columnname { border-bottom:1px #000 solid; }
            .table-row.columnname .table-cell { text-align:center; }
            .table-cell { display:table-cell; border: 1px #000 solid; padding:0 1em 0 1em; white-space:nowrap; }
            .table-cell.center { text-align:center; }
            .header{margin-top:70px}
        </style>
        <title>Activity Log</title>
    </head>
    <body>
         <!-- Fixed navbar -->
    <nav class="navbar navbar-default navbar-fixed-top">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="#">IS2731</a>
        </div>
        <div id="navbar" class="collapse navbar-collapse">
          <ul class="nav navbar-nav">
            <li><a href="index.jsp">Home</a></li>
            <li><a href="hostilelist.jsp">Hostile</a></li>
            <li  class="active"><a href="activitylog.jsp">Activity Log</a></li>
            <li><a href="roleManage.jsp">Role Management</a></li>
            <li><a href="admin.jsp">Admin Page</a></li>
            <li><a href="RBACtest.jsp">RBAC Test</a></li>
          </ul>
          <ul class="nav navbar-nav navbar-right">
            <!--put the name on the navigation bar-->
                <br>
                        <% 
                                if(request.getSession().getAttribute("user")!=null){
                                   UserAccountInfo user = (UserAccountInfo)session.getAttribute("user");
                                 out.print("<a href='#'>" + user.getFirstName() + user.getLastName() +"</a>");
                                 out.print("&nbsp;&nbsp;|&nbsp;&nbsp;");
                                 out.print("<a href='LogOut'>Log Out</a>");
                                }
                        %>
                  
            </ul>
        </div><!--/.nav-collapse -->
      </div>
    </nav>
        
        
        
        <div class="container table-div">
            <div class="header">
            <h1>Activity Log</h1>
            </div>
            <%
                String queryterm = request.getParameter("term"); 
                String querycolumn = request.getParameter("column"); 
                String querysort = request.getParameter("sort"); 
                String querylimit = request.getParameter("limit"); 
                
                int limit = 20;
                String displaysearch = "";
                String method = "LIKE";
                
                ResultSet rs;
                ActivityLogDao ald = new ActivityLogDao();
                if (queryterm == null || queryterm.equals("") || querycolumn == null || querycolumn.equals("") || querysort == null || querysort.equals("") || querylimit == null || querylimit.equals("")) {
                    if(querylimit != null) {
                        try {
                            limit = Integer.parseInt(querylimit);
                        } catch (NumberFormatException e) {
                            
                        }
                    }
                    rs = ald.getActivityLog(limit);
                } else {
                    if (querycolumn.equals("id")) {
                        querycolumn = "activity_log.id";
                        method = "=";
                    }
                    if (querycolumn.equals("activity_count") || querycolumn.equals("account_info_id")) {
                        method = "=";
                    }
                    rs = ald.getActivityLog(queryterm, querycolumn, querysort, querylimit, method);
                    displaysearch = "Searched '" + queryterm + "' on '" + querycolumn + "', sort '" + querysort + "', limit '" + querylimit + "'";
                }

                if (rs != null) {

                    ResultSetMetaData rsmd = rs.getMetaData();
            %>         
            <h3><%=displaysearch%></h3>
            <div style="display:table; padding-bottom:1em;">
                <div style="display:table-cell;">Search Term: <input type="text" id="term"></div>
                <div style="display:table-cell; padding-left:1em;">Column: <select id="column">
            <%
                    for(int i = 1; i < rsmd.getColumnCount() + 1; i++) {
                        %>
                        <option value="<%=rsmd.getColumnName(i)%>"><%=rsmd.getColumnName(i)%></option>
                        <%
                    }
            %>
                </select></div>
                <div style="display:table-cell; padding-left:1em;">Limit: 
                    <select id="limit">
                        <option value="20">20</option>
                        <option value="50">50</option>
                        <option value="100">100</option>
                        <option value="200">200</option>
                    </select>
                </div>
                <div style="display:table-cell; padding-left:1em;">Sort: 
                    <select id="sort">
                        <option value="DESC">Descending</option>
                        <option value="ASC">Ascending</option>

                    </select>
                </div>
                <div style="display:table-cell; padding-left:1em;">
                    <a type="button" href="#" id="btnSearchLog" class="btn btn-default" onclick="searchLog();">Search</a>
                </div>
                <div style="display:table-cell; padding-left:1em;">
                    <a type="button" href="#" id="btnSearchLog" class="btn btn-default" onclick="resetLog();">Reset</a>
                </div>
            </div>
            <div class="table">
                <div class="table-row columnname">
            <%
                    for(int i = 1; i < rsmd.getColumnCount() + 1; i++) {
                        %>
                        <div class='table-cell'><%=rsmd.getColumnName(i)%></div>
                        <%
                    }
            %>

                </div>
            <%
                    while(rs.next()) {

            %>
                        <div style="display:table-row;">
                            <div class="table-cell center"><%=rs.getInt("id")%></div>
                            <div class="table-cell"><%=rs.getString("ip_addr")%></div>
                            <div class="table-cell"><%=rs.getString("system_source")%></div>
                            <div class="table-cell center"><%=rs.getInt("activity_count")%></div>
                            <div class="table-cell"><%=rs.getString("description")%></div>
                            <div class="table-cell center"><%=rs.getInt("account_info_id")%></div>
                            <div class="table-cell"><%=rs.getTimestamp("create_time")%></div>
                            <div class="table-cell"><%=rs.getTimestamp("update_time")%></div>
                        </div>
            <%

                    }
            } else {
                %> 
                <h3><%=displaysearch%></h3>
                <p>There has been an error with data retrieval.</p> 
                <div style="display:table-cell; padding-left:1em;">
                    <a type="button" href="#" id="btnSearchLog" class="btn btn-default" onclick="resetLog();">Reset</a>
                </div>
                <%
            }
            %>
            </div>
            <!-- FOOTER -->
            <br/>
	<div class="container marketing">

            <footer>
                    <p>
                            &copy; 2016 E-Commerce Security &middot; <a href="#">Privacy</a>
                            &middot; <a href="#">Terms</a>
                    </p>
            </footer>

	</div>
	<!-- /.container -->
        </div>
            <script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
            <script type="text/javascript" src="//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
            <script>
                function searchLog() {
                    var term = document.getElementById("term").value;
                    var column = document.getElementById("column").value;
                    var limit = document.getElementById("limit").value;
                    var sort = document.getElementById("sort").value;
                    
                    var url = "activitylog.jsp?term=" + term + "&column=" + column + "&limit=" + limit + "&sort=" + sort;
                    window.location = url;
                }
                function resetLog() {
                    window.location = "activitylog.jsp";
                }
            </script>
            
            <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <!-- Latest compiled and minified JavaScript -->
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous">
        </script>
    </body>
</html>
