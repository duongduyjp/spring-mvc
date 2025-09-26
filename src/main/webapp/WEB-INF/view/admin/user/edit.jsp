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
                <!-- jQuery for compatibility -->
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
                                            <form:form action="/admin/user/edit/${user.id}" method="POST"
                                                modelAttribute="user" enctype="multipart/form-data">
                                                <!-- Row 1: Email & Password -->
                                                <div class="row mb-3">
                                                    <div class=" col-12 col-md-6">
                                                        <form:label path="email" cssClass="form-label fw-medium">Email:
                                                        </form:label>
                                                        <form:input path="email" type="email"
                                                            cssClass="form-control form-control-lg"
                                                            placeholder="Enter email address" />
                                                        <form:errors path="email"
                                                            cssClass="text-danger small d-block mt-1" />
                                                    </div>
                                                    <div class=" col-12 col-md-6">
                                                        <form:label path="password" cssClass="form-label fw-medium">
                                                            Password:</form:label>
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
                                                    </div>
                                                    <div class=" col-12 col-md-6">
                                                        <form:label path="fullName" cssClass="form-label fw-medium">Full
                                                            Name:</form:label>
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
                                                    </div>
                                                </div>

                                                <!-- Row 4: Role & Avatar -->
                                                <div class="row mb-4">
                                                    <div class="col-12 col-md-6">
                                                        <label class="form-label fw-medium">Role:</label>
                                                        <select class="form-select form-select-lg" name="roleName">
                                                            <c:forEach var="role" items="${roles}">
                                                                <option value="${role.name}" ${user.role !=null &&
                                                                    user.role.name==role.name ? 'selected' : '' }>
                                                                    ${role.name}
                                                                </option>
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
                                                <!-- Row 5: Current Avatar & Preview -->
                                                <div class="row mb-4">
                                                    <div class="col-12">
                                                        <label class="form-label fw-medium">
                                                            <i class="fas fa-image text-primary me-2"></i>Avatar
                                                        </label>
                                                        <div
                                                            class="d-flex align-items-center justify-content-center gap-4 p-3 bg-light rounded">
                                                            <!-- Avatar hiện tại -->
                                                            <div class="text-center">
                                                                <c:choose>
                                                                    <c:when test="${not empty user.avatar}">
                                                                        <img src="/images/avatar/${user.avatar}"
                                                                            alt="Current Avatar"
                                                                            class="img-fluid rounded-circle border border-3 border-primary"
                                                                            style="width: 80px; height: 80px; object-fit: cover;">
                                                                        <p class="small text-muted mt-2 mb-0 fw-bold">
                                                                            Hiện tại</p>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <div class="bg-secondary rounded-circle d-flex align-items-center justify-content-center border border-3 border-secondary"
                                                                            style="width: 80px; height: 80px;">
                                                                            <i class="fas fa-user text-white fa-2x"></i>
                                                                        </div>
                                                                        <p class="small text-muted mt-2 mb-0">Chưa có
                                                                        </p>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </div>

                                                            <!-- Arrow -->
                                                            <div class="text-center" id="arrowIcon"
                                                                style="display: none;">
                                                                <i class="fas fa-arrow-right text-success fa-2x"></i>
                                                            </div>

                                                            <!-- Preview avatar mới -->
                                                            <div class="text-center" id="newAvatarContainer"
                                                                style="display: none;">
                                                                <img id="avatarPreview" alt="New Avatar Preview"
                                                                    class="img-fluid rounded-circle border border-3 border-success"
                                                                    style="width: 80px; height: 80px; object-fit: cover;">
                                                                <p class="small text-success mt-2 mb-0 fw-bold">Mới</p>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div>
                                                    <button type="submit" class="btn btn-primary">Update</button>
                                                </div>
                                            </form:form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                    </main>
                    <jsp:include page="../layout/footer.jsp" />
                </div>
                <script>
                    document.getElementById('avatarFile').addEventListener('change', function (e) {
                        const file = e.target.files[0];
                        const preview = document.getElementById('avatarPreview');
                        const container = document.getElementById('newAvatarContainer');
                        const arrow = document.getElementById('arrowIcon');

                        if (file) {
                            // Validate file type
                            if (!file.type.startsWith('image/')) {
                                alert('Vui lòng chọn file ảnh!');
                                this.value = '';
                                return;
                            }

                            // Validate file size (5MB)
                            if (file.size > 5 * 1024 * 1024) {
                                alert('File quá lớn! Vui lòng chọn file nhỏ hơn 5MB.');
                                this.value = '';
                                return;
                            }

                            const reader = new FileReader();
                            reader.onload = function (e) {
                                preview.src = e.target.result;
                                container.style.display = 'block';
                                arrow.style.display = 'block';
                            }
                            reader.readAsDataURL(file);
                        } else {
                            container.style.display = 'none';
                            arrow.style.display = 'none';
                        }
                    });
                </script>

            </body>

            </html>