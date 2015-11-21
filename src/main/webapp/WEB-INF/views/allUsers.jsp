<%--<%@ page contentType="text/html; charset=cp1251" %>--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<html>

<head>
    <title>Intership CRUD</title>
   <%--ПОМЕНЯТЬ!!!!--%>
    <style type="text/css">
        .tg  {border-collapse:collapse;border-spacing:0;border-color:#ccc;}
        .tg td{font-family:Arial, sans-serif;font-size:14px;padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;border-color:#ccc;color:#333;background-color:#fff;}
        .tg th{font-family:Arial, sans-serif;font-size:14px;font-weight:normal;padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;border-color:#ccc;color:#333;background-color:#f0f0f0;}
        .tg .tg-4eph{background-color:#f9f9f9}
    </style>
</head>

<body>
<table width="100%" border="0" cellpadding="5" cellspacing="0">
    <tr>
        <td width="40%" valign="top" align="center">
            <h2>
                <c:if test= "${user.id != 0}">
                    Редатировать пользователя
                </c:if>
                <c:if test= "${user.id == 0}">
                    Добавить пользователя
                </c:if>
            </h2>


            <%-- Редактировать и добавить пользователя --%>
            <c:url var="addAction" value="/user/add" ></c:url>
            <form:form action="${addAction}" commandName="user">
                <c:if test= "${user.id != 0}">
                    <b><p style="font-size:20px" align="center"> Пользователь № ${user.id}
                    </p>
                    </b>
                </c:if>
                <table>
                    <td>&nbsp;</td>
                    <tr>
                        <td style='text-align:right;vertical-align:middle'>
                            <form:label path="id"/>
                        </td>
                        <td style='vertical-align:middle'>
                            <form:hidden path="id" />
                        </td>
                    </tr>
                    <tr>
                        <td style='text-align:right;vertical-align:middle'>
                            <form:label path="name">
                                <spring:message text="Имя"/>
                            </form:label>
                        </td>
                        <td>
                            <form:input path="name" />
                        </td>
                    </tr>
                    <tr>
                        <td style='text-align:right;vertical-align:middle'>
                            <form:label path="age">
                                <spring:message text="Возраст"/>
                            </form:label>
                        </td>
                        <td>
                            <form:input path="age" />
                        </td>
                    </tr>
                    <tr>
                        <td style='text-align:right;vertical-align:middle'>
                            <form:label path="isAdmin">Админ.права</form:label>
                        <td>
                        <form:select path="isAdmin">
                            <option value="true">Yes</option>
                            <option value="false">No</option>
                    </td>
                        </form:select>
                        </td>
                    </tr>
                        <%--!!!--%>
                    <tr>
                        <td style='text-align:right;vertical-align:middle'>
                            <form:label path="createdDate">
                                <spring:message text="Дата добавления"/>
                            </form:label>
                        </td>
                        <td>
                            <form:input path="createdDate" />
                        </td>
                        <td>
                            <form:errors path="createdDate" cssClass="error"/>
                        </td>
                    </tr>
                    <td>&nbsp;</td>
                    <tr>
                        <td colspan="2" align="center">
                            <c:if test="${user.id != 0}">
                                <input type="image" src=<c:url value='/images/save.png' />
                                </c:if>
                                <c:if test="${user.id == 0}">
                                        <input type="image" src=<c:url value='/images/add.png' />
                                </c:if>
                                        </td>
                        </td>
                    </tr>
                </table>
            </form:form>
        </td>


        <%-- Поиск --%>
        <td valign="top" align="center">
            <c:if test= "${user.id == 0}">
                <h2> Список пользователей </h2>
                <c:url var="search" value="/users" ></c:url>
                <form:form action="/users" method ="POST" commandName="pageProperty" >
                    <table>
                        <tr>
                            <td style='text-align:right;vertical-align:middle'>
                                <form:label path="nameFilter">
                                    <spring:message text="Поиск по имени:"/>
                                </form:label>
                            </td>
                            <td>
                                <form:input path="nameFilter" />
                            </td>
                            <td colspan="2">
                                <input type="image" src=<c:url value='/images/search.png' />
                                        </td>
                        </tr>
                    </table>
                </form:form>
            </c:if>

            <%-- Список пользователей --%>
            <c:if test= "${user.id == 0}">
                <c:if test="${empty listUsers}">
                    <h2> Пользователи не найдены </h2>
                </c:if>
                <c:if test="${!empty listUsers}">
                    <table>
                        <style type="text/css">
                            BODY {
                                background: white;
                                word-wrap: break-word;
                            }
                            TABLE {
                                border-collapse: collapse;
                                border: 0px solid white;
                            }
                            TD, TH {
                                padding: 0px;
                                border: 0px solid maroon;
                            }

                        </style>
                        <tr>
                            <th><img src= <c:url value='/images/id.png'/>/></th>
                            <th><img src= <c:url value='/images/name.png'/>/></th>
                            <th><img src= <c:url value='/images/age.png'/>/></th>
                            <th><img src= <c:url value='/images/admin.png'/>/></th>
                            <th><img src= <c:url value='/images/date.png'/>/></th>
                            <th><img src= <c:url value='/images/noneImage.png'/>/></th>
                            <th><img src= <c:url value='/images/none2Image.png'/>/></th>
                        </tr>
                    </table>
                    <table class="tg">
                        <c:forEach items="${listUsers}" var="user">
                            <tr>
                                <td width="60" style='text-align:center'>${user.id}</td>
                                <td width="120" style='text-align:center'>${user.name}</td>
                                <td width="60" style='text-align:center'>${user.age}</td>
                                <td width="60" style='text-align:center'>${user.isAdmin}</td>
                                <td width="80" style='text-align:center'>${user.createdDate}</td>
                                <td width="40" style='text-align:center'><a href="<c:url value='/edit/${user.id}' />" > <img src= <c:url value='/images/edit.png'/>/></a></td>
                                <td width="40" style='text-align:center'><a href="<c:url value='/remove/${user.id}' />" > <img src=<c:url value='/images/delete.png'/>/></a></td>
                            </tr>
                        </c:forEach>
                    </table>

                    <%-- Странички --%>
                    <c:url var="search" value="/users" ></c:url>
                    <p>
                    <table>
                    <tr>
                        <td>
                            <form:form action="${search}" method ="POST" commandName="pageProperty" >
                                    <form:input path="pageNumber" type="hidden" value="${pageProperty.pageNumber-1}"/>
                        <td><input type="image" src=<c:url value='/images/left.png'/>/></td>
                        </form:form>
                        </td>

                        <td>&nbsp;&nbsp;&nbsp;</td>

                        <td style='text-align:right;vertical-align:middle'>
                            <p style="font-size:20px">  Страница  ${pageProperty.pageNumber}   из   ${pageProperty.size}</p>
                        </td>

                        <td>&nbsp;&nbsp;&nbsp;</td>

                        <td vertical-align:sub>
                            <form:form action="${search}" method ="POST" commandName="pageProperty" >
                                    <form:input path="pageNumber" type="hidden" value="${pageProperty.pageNumber+1}"/>
                        <td><input type="image" src=<c:url value='/images/right.png'/>/></td>
                        </form:form>
                        </td>

                        <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>

                        <td>
                            <form:form action="${search}" method ="POST" commandName="pageProperty" >
                        <td style='text-align:right;vertical-align:middle'>
                        <p style="font-size:20px">Переход   </p>
                    </td>

                        <td>
                            <form:input path="pageNumber" />
                        </td>

                        <td>
                            <input type="image" src=<c:url value='/images/goto.png' />
                                    </td>
                            </form:form>
                    </tr>
                </table>
                    </p>
                </c:if>
            </c:if>
        </td>
    </tr>
</table>
</body>
</html>