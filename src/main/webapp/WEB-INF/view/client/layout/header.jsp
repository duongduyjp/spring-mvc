<!-- Navbar start -->
<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <div class="container-fluid fixed-top">
            <div class="container px-0">
                <nav class="navbar navbar-light bg-white navbar-expand-xl">
                    <a href="/" class="navbar-brand">
                        <h1 class="text-primary display-6">Laptop Shop</h1>
                    </a>
                    <button class="navbar-toggler py-2 px-3" type="button" data-bs-toggle="collapse"
                        data-bs-target="#navbarCollapse">
                        <span class="fa fa-bars text-primary"></span>
                    </button>
                    <div class="collapse navbar-collapse bg-white justify-content-between mx-5" id="navbarCollapse">
                        <div class="navbar-nav">
                            <a href="/" class="nav-item nav-link active">Home</a>
                            <a href="/products" class="nav-item nav-link">Products</a>
                        </div>
                        <div class="d-flex m-3 me-0">
                            <c:if test="${not empty pageContext.request.userPrincipal}">
                                <a href="/cart/detail" class="position-relative me-4 my-auto">
                                    <i class="fa fa-shopping-bag fa-2x"></i>
                                    <span id="cart-count" 
                                        class="cart-badge position-absolute bg-secondary rounded-circle d-flex align-items-center justify-content-center text-dark px-1"
                                        style="top: -5px; left: 15px; height: 20px; min-width: 20px;">0</span>
                                </a>
                                <!-- Profile dropdown -->
                                <div class="dropdown my-auto">
                                    <a href="#" class="dropdown" role="button" id="dropdownMenuLink"
                                        data-bs-toggle="dropdown" aria-expanded="false">
                                        <i class="fas fa-user-circle fa-2x me-3"></i>
                                    </a>

                                    <ul class="dropdown-menu dropdown-menu-end p-4" aria-labelledby="dropdownMenuLink">
                                        <li class="d-flex align-items-center flex-column" style="min-width: 300px;">
                                            <c:choose>
                                                <c:when
                                                    test="${not empty currentUser and not empty currentUser.avatar}">
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
                                                    <c:when test="${not empty currentUser.email}">
                                                        ${currentUser.email}
                                                    </c:when>
                                                    <c:otherwise>
                                                        ${pageContext.request.userPrincipal.name}
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </li>

                                        <li><a class="dropdown-item" href="#">Quản lý tài khoản</a></li>
                                        <li><a class="dropdown-item" href="#">Lịch sử mua hàng</a></li>
                                        <li>
                                            <hr class="dropdown-divider">
                                        </li>

                                        <li>
                                            <form action="/logout" method="POST" style="display: inline;">
                                                <input type="hidden" name="${_csrf.parameterName}"
                                                    value="${_csrf.token}" />
                                                <button type="submit" class="dropdown-item"
                                                    style="border: none; background: none; width: 100%; text-align: left;">
                                                    Đăng xuất
                                                </button>
                                            </form>
                                        </li>

                                    </ul>
                                </div>
                                <!-- End Profile dropdown -->
                            </c:if>
                            <c:if test="${empty pageContext.request.userPrincipal}">
                                <a href="/login" class="nav-item nav-link">Login</a>
                            </c:if>

                        </div>
                    </div>
                </nav>
            </div>
        </div>
        
        <!-- Toast Container -->
        <div id="toast-container" class="toast-container position-fixed top-0 end-0 p-3" style="z-index: 9999;"></div>
        
        <!-- Navbar End -->
