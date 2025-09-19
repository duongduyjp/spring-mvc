<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Edit User</title>
                <!-- Load demo.css TRƯỚC Bootstrap -->
                <link href="/css/demo.css" rel="stylesheet">
                <!-- Latest compiled and minified CSS -->
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
                <!-- Latest compiled JavaScript -->
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
                <!-- Font Awesome for icons -->
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
                <link href="${pageContext.request.contextPath}/css/main.css" rel="stylesheet">
                <link href="/css/styles.css" rel="stylesheet" />
                <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
            </head>

            <body>
                <jsp:include page="../layout/header.jsp" />
                <jsp:include page="../layout/sidebar.jsp" />
                <div id="layoutSidenav_content">
                    <main>
                        <div class="container-fluid mt-4">
                            <!-- Header Section -->
                            <div class="row mb-1">
                                <div class="col-md-6">
                                    <h2 class="text-dark fw-bold">Edit a user</h2>
                                </div>
                            </div>
                            <!-- Breadcrumb Section -->
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="/admin">Admin</a></li>
                                    <li class="breadcrumb-item"><a href="/admin/user">Users</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">Edit</li>
                                </ol>
                            </nav>
                            <div class="row justify-content-center">
                                <div class="col-md-6">
                                    <div class="card">
                                        <div class="card-body">
                                            <h2 class="card-title text-left mb-4">Edit user</h2>

                                            <form:form action="/admin/user/edit/${user.id}" method="POST"
                                                modelAttribute="user">
                                                <form:hidden path="id" />

                                                <div class="mb-3">
                                                    <form:label path="email" cssClass="form-label">Email:</form:label>
                                                    <form:input path="email" type="email" cssClass="form-control"
                                                        readonly="true" />
                                                </div>

                                                <div class="mb-3">
                                                    <form:label path="password" cssClass="form-label">Password:
                                                    </form:label>
                                                    <form:password path="password" cssClass="form-control" />
                                                </div>

                                                <div class="mb-3">
                                                    <form:label path="phoneNumber" cssClass="form-label">Phone Number:
                                                    </form:label>
                                                    <form:input path="phoneNumber" type="tel" cssClass="form-control" />
                                                </div>

                                                <div class="mb-3">
                                                    <form:label path="fullName" cssClass="form-label">Full Name:
                                                    </form:label>
                                                    <form:input path="fullName" type="text" cssClass="form-control" />
                                                </div>

                                                <div class="mb-3">
                                                    <form:label path="address" cssClass="form-label">Address:
                                                    </form:label>
                                                    <form:input path="address" type="text" cssClass="form-control" />
                                                </div>

                                                <button type="submit" class="btn btn-primary">Update</button>
                                            </form:form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                    </main>
                    <jsp:include page="../layout/footer.jsp" />
                </div>

            </body>

            </html>