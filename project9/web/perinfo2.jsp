<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>能力规范文稿管理系统</title>
    <!-- Bootstrap CSS 文件 -->
    <link rel="stylesheet" href="./static/bootstrap/css/bootstrap.min.css">
</head>
<body>
<%  String id=request.getParameter("id");
    Integer userid=Integer.valueOf(id).intValue();%>
<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
                   url="jdbc:mysql://localhost:3306/dbgirl?useUnicode=true&characterEncoding=utf-8"
                   user="root" password="111"/>
<sql:query var="result" dataSource="${snapshot}">
    select *from userinfo where UserId = <%=userid%>
</sql:query>
<sql:query var="result2" dataSource="${snapshot}">
    select *from userinfo where UserId = (select UserId from logininfo where UName='<%=session.getAttribute("user_now")%>')
</sql:query>
<!-- 头部 -->
<div class="jumbotron">
    <div class="container">
        <div class="row">
            <div class="col-md-7">
                <h2>BJUT</h2>
                <p>能力规范文稿管理系统</p>
            </div>
            <div class="col-md-5">
                <c:forEach var="row" items="${result2.rows}">
                    <c:if test="${row.Feature==2}">
                        <h3>欢迎您！专委会管理员：<c:out value="${row.Name}"/></h3>
                        <button class="btn btn-warning" onclick="window.location.href='lay_loginout.jsp';">注销</button>
                    </c:if>
                </c:forEach>
                <c:forEach var="row" items="${result2.rows}">
                    <c:if test="${row.Feature==1}">
                        <h3>欢迎您！写者：<c:out value="${row.Name}"/></h3>
                        <button class="btn btn-warning" onclick="window.location.href='lay_loginout.jsp';">注销</button>
                    </c:if>
                </c:forEach>
                <c:forEach var="row" items="${result2.rows}">
                    <c:if test="${row.Feature==3}">
                        <h3>欢迎您！行业分会管理员：<c:out value="${row.Name}"/></h3>
                        <button class="btn btn-warning" onclick="window.location.href='lay_loginout.jsp';">注销</button>
                    </c:if>
                </c:forEach>
                <c:forEach var="row" items="${result2.rows}">
                    <c:if test="${row.Feature==4}">
                        <h3>欢迎您！研究会管理员：<c:out value="${row.Name}"/></h3>
                        <button class="btn btn-warning" onclick="window.location.href='lay_loginout.jsp';">注销</button>
                    </c:if>
                </c:forEach>
                <c:forEach var="row" items="${result2.rows}">
                    <c:if test="${row.Feature==5}">
                        <h3>欢迎您！系统管理员：<c:out value="${row.Name}"/></h3>
                        <button class="btn btn-warning" onclick="window.location.href='lay_loginout.jsp';">注销</button>
                    </c:if>
                </c:forEach>
            </div>
        </div>
    </div>
</div>

<!-- 中间内容区局 -->
<div class="container">
    <div class="row">

        <!-- 左侧菜单区域   -->
        <div class="col-md-3">
            <div class="list-group" id="listgroup">
                <a href="supermanager.jsp" class="list-group-item">提案管理</a>
                <a href="vipmanage.jsp" class="list-group-item">会员管理</a>
            </div>
        </div>

        <!-- 右侧内容区域 -->
        <div class="col-md-9">

            <!-- 自定义内容区域 -->
            <div class="panel panel-default">
                <div class="panel-heading">用户信息</div>
                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <tbody>
                        <c:forEach var="row" items="${result.rows}">
                            <tr>
                                <th>用户ID：</th>
                                <th><c:out value="${row.UserId}"/> </th>
                            </tr>
                            <tr>
                                <th>姓名：</th>
                                <td><c:out value="${row.Name}"/></td>
                            </tr>
                            <tr>
                                <th>性别：</th>
                                <c:if test="${row.Gender=='M'}">
                                    <td>男</td>
                                </c:if>
                                <c:if test="${row.Gender=='F'||row.Gender=='N'}">
                                    <td>女</td>
                                </c:if>
                                <%--韩雨修改2017年8月31日09:35:13--%>
                            </tr>
                            <tr>
                                <th>生日：</th>
                                <td><c:out value="${row.Birth}"/></td>
                            </tr>
                            <tr>
                                <th>地址：</th>
                                <td><c:out value="${row.Address}"/></td>
                            </tr>
                            <tr>
                                <th>电话：</th>
                                <td><c:out value="${row.Tel}"/></td>
                            </tr>
                            <tr>
                                <%--<th>推荐人：</th>--%>
                                <%--<td><c:out value="${row.ReferrerId}"/></td>--%>
                            <tr>
                                <sql:query var="result3" dataSource="${snapshot}">
                                    select *from userinfo where UserId = (select ReferrerId from referrerlist where UserId = <c:out value="${row.UserId}"></c:out>)
                                </sql:query>
                                <th>推荐人：</th>
                                <c:forEach var="row2" items="${result3.rows}">
                                    <td><c:out value="${row2.Name}"></c:out></td>
                                </c:forEach>
                            </tr>
                                <%--韩雨修改2017年8月31日09:36:44--%>
                            </tr>
                            <tr>
                                <th>行业分会：</th>
                                <td><c:out value="${row.IndustryId}"/></td>
                            </tr>
                            <tr>
                                <th>专委会：</th>
                                <td><c:out value="${row.CommitteeId}"/></td>
                            </tr>
                            <tr>
                                <th>身份：</th>
                                <c:if test="${row.Feature==1}">
                                    <td>写者</td>
                                </c:if>
                                <c:if test="${row.Feature==2}">
                                    <td>专委会管理员</td>
                                </c:if>
                                <c:if test="${row.Feature==3}">
                                    <td>行业分会管理员</td>
                                </c:if>
                                <c:if test="${row.Feature==4}">
                                    <td>研究会管理员</td>
                                </c:if>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
            <!-- 分页  -->
            <%--<div>--%>
                <%--<ul class="pagination pull-right">--%>
                    <%--<li>--%>
                        <%--<a href="#" aria-label="Previous">--%>
                            <%--<span aria-hidden="true">&laquo;</span>--%>
                        <%--</a>--%>
                    <%--</li>--%>
                    <%--<li class="active"><a href="#">1</a></li>--%>
                    <%--<li><a href="#">2</a></li>--%>
                    <%--<li><a href="#">3</a></li>--%>
                    <%--<li><a href="#">4</a></li>--%>
                    <%--<li><a href="#">5</a></li>--%>
                    <%--<li>--%>
                        <%--<a href="#" aria-label="Next">--%>
                            <%--<span aria-hidden="true">&raquo;</span>--%>
                        <%--</a>--%>
                    <%--</li>--%>
                <%--</ul>--%>
            <%--</div>--%>

        </div>
    </div>
</div>

<!-- 尾部 -->
<div class="jumbotron" style="margin:0;">
    <div class="container">
        <span>  @2017 BJUT</span>
    </div>
</div>
<%--<script>--%>
    <%--window.onload=function(){--%>
        <%--var div=document.getElementById("listgroup")--%>
        <%--var a=div.getElementsByTagName("a");--%>
        <%--for(var i=0;i<a.length;i++){--%>

            <%--a[i].onclick=function(){--%>
                <%--for(var j=0;j<a.length;j++){--%>
                    <%--a[j].className="list-group-item"--%>
                <%--}--%>
                <%--this.className="list-group-item active"--%>
            <%--}--%>
        <%--}--%>
    <%--}--%>

<%--</script>--%>
<!-- jQuery 文件 -->
<script src="./static/jquery/jquery.min.js"></script>
<!-- Bootstrap JavaScript 文件 -->
<script src="./static/bootstrap/js/bootstrap.min.js"></script>

</body>
</html>
