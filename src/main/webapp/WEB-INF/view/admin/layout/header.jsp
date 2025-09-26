<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <body class="sb-nav-fixed">
            <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
                <!-- Navbar Brand-->
                <a class="navbar-brand ps-3" href="/admin">Laptopshop</a>
                <!-- Sidebar Toggle-->
                <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!"><i
                        class="fas fa-bars"></i></button>
                <!-- Navbar Search-->
                <form class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0">
                    <span style="color: white;">Welcome</span>
                </form>
                <!-- Navbar-->
                <!-- Profile dropdown -->
                <div class="dropdown my-auto">
                    <a href="#" class="dropdown" role="button" id="dropdownMenuLink" data-bs-toggle="dropdown"
                        aria-expanded="false">
                        <i class="fas fa-user-circle fa-2x me-3"></i>
                    </a>

                    <ul class="dropdown-menu dropdown-menu-end p-4" aria-labelledby="dropdownMenuLink">
                        <li class="d-flex align-items-center flex-column" style="min-width: 300px;">
                            <c:choose>
                                <c:when test="${not empty currentUser and not empty currentUser.avatar}">
                                    <img style="width: 150px; height: 150px; border-radius: 50%; overflow: hidden;"
                                        src="/images/avatar/${currentUser.avatar}" />
                                </c:when>
                                <c:otherwise>
                                    <img style="width: 150px; height: 150px; border-radius: 50%; overflow: hidden;"
                                        src="/images/avatar/default-avatar.png" />
                                </c:otherwise>
                            </c:choose>
                            <div class="text-center my-3">
                                <c:choose>
                                    <c:when test="${not empty currentUser.fullName}">
                                        ${currentUser.fullName}
                                    </c:when>
                                    <c:otherwise>
                                        ${pageContext.request.userPrincipal.name}
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </li>

                        <li><a class="dropdown-item" href="#">Quản lý tài khoản</a></li>
                        <li>
                            <hr class="dropdown-divider">
                        </li>

                        <li>
                            <form action="/logout" method="POST" style="display: inline;">
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                <button type="submit" class="dropdown-item"
                                    style="border: none; background: none; width: 100%; text-align: left;">
                                    Đăng xuất
                                </button>
                            </form>
                        </li>

                    </ul>
                </div>
                <!-- End Profile dropdown -->
            </nav>