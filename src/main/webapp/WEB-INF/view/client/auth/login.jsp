<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

            <html lang="en">

            <head>
                <meta charset="utf-8" />
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                <meta name="description" content="" />
                <meta name="author" content="" />
                <title>Login - Laptop Shop Client</title>
                <link href="/css/styles.css" rel="stylesheet" />
                <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
            </head>

            <body class="bg-primary">
                <div id="layoutAuthentication">
                    <div id="layoutAuthentication_content">
                        <main>
                            <div class="container">
                                <div class="row justify-content-center">
                                    <div class="col-lg-5">
                                        <div class="card shadow-lg border-0 rounded-lg mt-5">
                                            <div class="card-header">
                                                <h3 class="text-center font-weight-light my-4">Login</h3>
                                            </div>
                                            <c:if test="${param.success != null}">
                                                <div class="alert alert-success mb-3">
                                                    Đăng ký thành công! Vui lòng đăng nhập.
                                                </div>
                                            </c:if>

                                            <c:if test="${not empty error}">
                                                <div class="alert alert-danger mb-3">
                                                    ${error}
                                                </div>
                                            </c:if>
                                            <!-- Thêm error message cho Spring Security -->
                                            <c:if test="${param.error != null}">
                                                <div class="alert alert-danger mb-3">
                                                    Email hoặc mật khẩu không đúng!
                                                </div>
                                            </c:if>

                                            <c:if test="${param.logout != null}">
                                                <div class="alert alert-success mb-3">
                                                    Đăng xuất thành công!
                                                </div>
                                            </c:if>
                                            <div class="card-body">
                                                <!-- Thay thế form Spring form bằng HTML form thông thường -->
                                                <form action="/perform-login" method="POST">
                                                    <div class="form-floating mb-3">
                                                        <input name="username" type="email" class="form-control"
                                                            placeholder="name@example.com" required />
                                                        <label for="username">Email address</label>
                                                    </div>
                                                    <div class="form-floating mb-3">
                                                        <input name="password" type="password" class="form-control"
                                                            placeholder="Password" required />
                                                        <label for="password">Password</label>
                                                    </div>
                                                    <div class="form-check mb-3">
                                                        <input class="form-check-input" id="inputRememberPassword"
                                                            type="checkbox" value="" />
                                                        <label class="form-check-label"
                                                            for="inputRememberPassword">Remember Password</label>
                                                    </div>
                                                    <div
                                                        class="d-flex align-items-center justify-content-between mt-4 mb-0">
                                                        <a class="small" href="password.html">Forgot Password?</a>
                                                        <button type="submit" class="btn btn-primary">Login</button>
                                                    </div>
                                                </form>
                                            </div>
                                            <div class="card-footer text-center py-3">
                                                <div class="small"><a href="/register">Need an account? Sign up!</a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </main>
                    </div>
                    <div id="layoutAuthentication_footer">
                        <footer class="py-4 bg-light mt-auto">
                            <div class="container-fluid px-4">
                                <div class="d-flex align-items-center justify-content-between small">
                                    <div class="text-muted">Copyright &copy; Your Website 2023</div>
                                    <div>
                                        <a href="#">Privacy Policy</a>
                                        &middot;
                                        <a href="#">Terms &amp; Conditions</a>
                                    </div>
                                </div>
                            </div>
                        </footer>
                    </div>
                </div>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
                    crossorigin="anonymous"></script>
                <script src="js/scripts.js"></script>
            </body>

            </html>