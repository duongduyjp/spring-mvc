<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>User Management</title>
            <!-- Latest compiled and minified CSS -->
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
            <!-- Latest compiled JavaScript -->
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
            <!-- Font Awesome for icons -->
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
            <link href="${pageContext.request.contextPath}/css/main.css" rel="stylesheet">
        </head>

        <body>

            <div class="container mt-4">
                <!-- Header Section -->
                <div class="row mb-4">
                    <div class="col-md-6">
                        <h2 class="text-dark fw-bold">Table users</h2>
                    </div>
                    <div class="col-md-6 text-end">
                        <a href="/admin/user/create" class="btn btn-primary">
                            <i class="fas fa-plus"></i> Create a user
                        </a>
                    </div>
                </div>

                <!-- Table Section -->
                <div class="card shadow-sm">
                    <!-- Thêm vào đầu table, sau <div class="card shadow-sm"> -->
                    <c:if test="${param.success == 'true'}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <i class="fas fa-check-circle"></i> ${param.message}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <c:if test="${param.error == 'true'}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="fas fa-exclamation-circle"></i> ${param.message}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <table class="table table-hover mb-0">
                                <thead class="table-light">
                                    <tr>
                                        <th class="px-3 py-3">ID</th>
                                        <th class="px-3 py-3">Email</th>
                                        <th class="px-3 py-3">Full Name</th>
                                        <th class="px-3 py-3">Phone Number</th>
                                        <th class="px-3 py-3">Address</th>
                                        <th class="px-3 py-3 text-center">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <!-- Kiểm tra nếu có data -->
                                    <c:choose>
                                        <c:when test="${not empty users}">
                                            <!-- Hiển thị data thật từ database -->
                                            <c:forEach var="user" items="${users}">
                                                <tr>
                                                    <td class="px-3 py-3">${user.id}</td>
                                                    <td class="px-3 py-3">${user.email}</td>
                                                    <td class="px-3 py-3">${user.fullName}</td>
                                                    <td class="px-3 py-3">${user.phoneNumber}</td>
                                                    <td class="px-3 py-3">${user.address}</td>
                                                    <td class="px-3 py-3 text-center">
                                                        <div class="btn-group" role="group">
                                                            <a href="/admin/user/${user.id}"
                                                                class="btn btn-success btn-sm me-3">
                                                                <i class="fas fa-eye"></i> View
                                                            </a>
                                                            <a href="/admin/user/edit/${user.id}"
                                                                class="btn btn-warning btn-sm me-3">
                                                                <i class="fas fa-edit"></i> Update
                                                            </a>
                                                            <form action="/admin/user/delete/${user.id}" method="POST"
                                                                onsubmit="return confirm('You are sure to delete this user?');"
                                                                style="display: inline-block; margin: 0;">
                                                                <button type="submit" class="btn btn-danger btn-sm">
                                                                    <i class="fas fa-trash"></i> Delete
                                                                </button>
                                                            </form>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <!-- Hiển thị thông báo khi không có data -->
                                            <tr>
                                                <td colspan="6" class="text-center py-5">
                                                    <div class="d-flex flex-column align-items-center">
                                                        <i class="fas fa-users fa-3x text-muted mb-3"></i>
                                                        <h5 class="text-muted mb-2">No users found</h5>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:otherwise>
                                    </c:choose>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </body>

        </html>