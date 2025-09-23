<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Create User</title>
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
                                    <h2 class="text-dark fw-bold">Create a user</h2>
                                </div>
                            </div>
                            <!-- Breadcrumb Section -->
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="/admin">Admin</a></li>
                                    <li class="breadcrumb-item"><a href="/admin/user">Users</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">Create</li>
                                </ol>
                            </nav>
                            <div class="row justify-content-center">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <h3>Create user</h3>
                                    </div>
                                    <div class="card">
                                        <div class="card-body">
                                            <form:form action="/admin/user/create" method="POST" modelAttribute="user"
                                                enctype="multipart/form-data">

                                                <!-- Global Error Messages -->
                                                <c:if test="${not empty error}">
                                                    <div class="alert alert-danger mb-3">
                                                        ${error}
                                                    </div>
                                                </c:if>

                                                <!-- Row 1: Email & Password -->
                                                <div class="row mb-3">
                                                    <div class=" col-12 col-md-6">
                                                        <form:label path="email" cssClass="form-label fw-medium">Email:
                                                            <span class="text-danger">*</span>
                                                        </form:label>
                                                        <form:input path="email" type="email"
                                                            cssClass="form-control form-control-lg"
                                                            placeholder="Enter email address" />
                                                        <form:errors path="email"
                                                            cssClass="text-danger small d-block mt-1" />
                                                    </div>
                                                    <div class=" col-12 col-md-6">
                                                        <form:label path="password" cssClass="form-label fw-medium">
                                                            Password: <span class="text-danger">*</span></form:label>
                                                        <form:password path="password"
                                                            cssClass="form-control form-control-lg"
                                                            placeholder="Enter password" />
                                                        <form:errors path="password"
                                                            cssClass="text-danger small d-block mt-1" />
                                                    </div>
                                                </div>

                                                <!-- Row 2: Phone & Full Name -->
                                                <div class="row mb-3">
                                                    <div class=" col-12 col-md-6">
                                                        <form:label path="phoneNumber" cssClass="form-label fw-medium">
                                                            Phone number:</form:label>
                                                        <form:input path="phoneNumber" type="tel"
                                                            cssClass="form-control form-control-lg" />
                                                        <form:errors path="phoneNumber"
                                                            cssClass="text-danger small d-block mt-1" />
                                                    </div>
                                                    <div class=" col-12 col-md-6">
                                                        <form:label path="fullName" cssClass="form-label fw-medium">Full
                                                            Name: <span class="text-danger">*</span></form:label>
                                                        <form:input path="fullName" type="text"
                                                            cssClass="form-control form-control-lg" />
                                                        <form:errors path="fullName"
                                                            cssClass="text-danger small d-block mt-1" />
                                                    </div>
                                                </div>
                                                <!-- Row 3: Address (Full Width) -->
                                                <div class="row mb-3">
                                                    <div class="col-md-12">
                                                        <form:label path="address" cssClass="form-label">Address:
                                                        </form:label>
                                                        <form:input path="address" type="text"
                                                            cssClass="form-control form-control-lg" />
                                                        <form:errors path="address"
                                                            cssClass="text-danger small d-block mt-1" />
                                                    </div>
                                                </div>

                                                <!-- Row 4: Role & Avatar -->
                                                <div class="row mb-4">
                                                    <div class="col-12 col-md-6">
                                                        <label class="form-label fw-medium">Role:</label>
                                                        <select class="form-select form-select-lg" name="roleName">
                                                            <c:forEach var="role" items="${roles}">
                                                                <option value="${role.name}">${role.name}</option>
                                                            </c:forEach>
                                                        </select>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <label class="form-label fw-medium">Avatar:</label>
                                                        <div class="input-group">
                                                            <input type="file" class="form-control form-control-lg"
                                                                name="avatarFile" id="avatarFile"
                                                                accept="image/png, image/jpeg, image/jpg" />
                                                        </div>
                                                    </div>
                                                </div>
                                                <!-- Row 5: Avatar Preview (TRONG row) -->
                                                <div class="row mb-3">
                                                    <div class="col-12 text-center">
                                                        <img style="max-height: 250px; display: none; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1);"
                                                            alt="avatar preview" id="avatarPreview" />
                                                    </div>
                                                </div>
                                                <div>
                                                    <button type="submit" class="btn btn-primary">Create</button>
                                                </div>
                                            </form:form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </main>
                    <jsp:include page="../layout/footer.jsp" />
                </div>
                <script>
                    $(function () {
                        $('#avatarFile').on('change', function (e) {
                            const file = this.files && this.files[0];
                            const $preview = $('#avatarPreview');
                            if (file && file.type.match('image.*')) {
                                const imgURL = URL.createObjectURL(file);
                                $preview.attr('src', imgURL).show();
                            } else {
                                $preview.hide().removeAttr('src');
                            }
                        });
                    });
                </script>

            </body>

            </html>