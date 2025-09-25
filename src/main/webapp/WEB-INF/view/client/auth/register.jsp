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
                <title>Register - Laptop Shop Client</title>
                <link href="/css/styles.css" rel="stylesheet" />
                <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
            </head>

            <body class="bg-primary">
                <div id="layoutAuthentication">
                    <div id="layoutAuthentication_content">
                        <main>
                            <div class="container">
                                <div class="row justify-content-center">
                                    <div class="col-lg-7">
                                        <div class="card shadow-lg border-0 rounded-lg mt-5">
                                            <div class="card-header">
                                                <h3 class="text-center font-weight-light my-4">Create Account</h3>
                                            </div>
                                            <div class="card-body">
                                                <form:form action="/register" method="POST" modelAttribute="registerDTO"
                                                    enctype="multipart/form-data">

                                                    <!-- Global Error Messages -->
                                                    <c:if test="${not empty error}">
                                                        <div class="alert alert-danger mb-3">
                                                            ${error}
                                                        </div>
                                                    </c:if>

                                                    <!-- Row 1: First Name & Last Name -->
                                                    <div class="row mb-3">
                                                        <div class=" col-12 col-md-6">
                                                            <form:label path="firstName"
                                                                cssClass="form-label fw-medium">
                                                                First Name:
                                                                <span class="text-danger">*</span>
                                                            </form:label>
                                                            <form:input path="firstName" type="text"
                                                                cssClass="form-control form-control-lg"
                                                                placeholder="Enter first name" />
                                                            <form:errors path="firstName"
                                                                cssClass="text-danger small d-block mt-1" />
                                                        </div>
                                                        <div class=" col-12 col-md-6">
                                                            <form:label path="lastName" cssClass="form-label fw-medium">
                                                                Last Name: <span class="text-danger">*</span>
                                                            </form:label>
                                                            <form:input path="lastName" type="text"
                                                                cssClass="form-control form-control-lg"
                                                                placeholder="Enter last name" />
                                                            <form:errors path="lastName"
                                                                cssClass="text-danger small d-block mt-1" />
                                                        </div>
                                                    </div>

                                                    <!-- Row 2: Password & Confirm Password -->
                                                    <div class="row mb-3">
                                                        <div class=" col-12 col-md-6">
                                                            <form:label path="password" cssClass="form-label fw-medium">
                                                                Password: <span class="text-danger">*</span>
                                                            </form:label>
                                                            <form:input path="password" type="password"
                                                                cssClass="form-control form-control-lg" />
                                                            <form:errors path="password"
                                                                cssClass="text-danger small d-block mt-1" />
                                                        </div>
                                                        <div class=" col-12 col-md-6">
                                                            <form:label path="confirmPassword"
                                                                cssClass="form-label fw-medium">
                                                                Confirm Password: <span class="text-danger">*</span>
                                                            </form:label>
                                                            <form:input path="confirmPassword" type="password"
                                                                cssClass="form-control form-control-lg" />
                                                            <form:errors path="confirmPassword"
                                                                cssClass="text-danger small d-block mt-1" />
                                                        </div>
                                                    </div>
                                                    <!-- Row 3: Email -->
                                                    <div class="row mb-3">
                                                        <div class="col-md-12">
                                                            <form:label path="email" cssClass="form-label">Email:
                                                                <span class="text-danger">*</span>
                                                            </form:label>
                                                            <form:input path="email" type="email"
                                                                cssClass="form-control form-control-lg" />
                                                            <form:errors path="email"
                                                                cssClass="text-danger small d-block mt-1" />
                                                        </div>
                                                    </div>
                                                    <div class="row mb-3">
                                                        <div class="col-md-12">
                                                            <button type="submit" class="btn btn-primary w-100">Create
                                                                Account</button>
                                                        </div>
                                                    </div>

                                                    <div class="card-footer text-center py-3">
                                                        <div class="small"><a href="/login">Have an account? Go to
                                                                login</a>
                                                        </div>
                                                    </div>
                                                </form:form>
                                            </div>
                                        </div>
                                    </div>
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