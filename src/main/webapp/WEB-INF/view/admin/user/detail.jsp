<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>User Details</title>
            <!-- Latest compiled and minified CSS -->
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
            <!-- Latest compiled JavaScript -->
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
            <!-- Font Awesome for icons -->
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
            <!-- Custom CSS -->
            <link href="${pageContext.request.contextPath}/css/main.css" rel="stylesheet">
        </head>

        <body>
            <div class="container mt-4">
                <!-- Header Section -->
                <div class="row mb-4">
                    <div class="col-md-6">
                        <h2 class="text-dark fw-bold">
                            <i class="fas fa-user"></i> User Details
                        </h2>
                    </div>
                    <div class="col-md-6 text-end">
                        <a href="/admin/user" class="btn btn-secondary btn-custom">
                            <i class="fas fa-arrow-left"></i> Back to List
                        </a>
                    </div>
                </div>

                <!-- User Details Table -->
                <div class="card shadow-sm">
                    <div class="card-header bg-primary text-white">
                        <h5 class="mb-0">
                            <i class="fas fa-user-circle"></i> User Information
                        </h5>
                    </div>
                    <div class="card-body p-0">
                        <c:choose>
                            <c:when test="${not empty user}">
                                <!-- Table hiển thị thông tin user -->
                                <div class="table-responsive">
                                    <table class="table table-bordered table-hover mb-0">
                                        <tbody>
                                            <tr>
                                                <td class="bg-light fw-bold" style="width: 30%;">
                                                    <i class="fas fa-id-card text-primary me-2"></i>ID
                                                </td>
                                                <td class="px-4 py-3">${user.id}</td>
                                            </tr>
                                            <tr>
                                                <td class="bg-light fw-bold">
                                                    <i class="fas fa-envelope text-primary me-2"></i>Email
                                                </td>
                                                <td class="px-4 py-3">
                                                    <a href="mailto:${user.email}" class="text-decoration-none">
                                                        ${user.email}
                                                    </a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="bg-light fw-bold">
                                                    <i class="fas fa-user text-primary me-2"></i>Full Name
                                                </td>
                                                <td class="px-4 py-3">${user.fullName}</td>
                                            </tr>
                                            <tr>
                                                <td class="bg-light fw-bold">
                                                    <i class="fas fa-phone text-primary me-2"></i>Phone Number
                                                </td>
                                                <td class="px-4 py-3">
                                                    <a href="tel:${user.phoneNumber}" class="text-decoration-none">
                                                        ${user.phoneNumber}
                                                    </a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="bg-light fw-bold">
                                                    <i class="fas fa-map-marker-alt text-primary me-2"></i>Address
                                                </td>
                                                <td class="px-4 py-3">${user.address}</td>
                                            </tr>
                                            <tr>
                                                <td class="bg-light fw-bold">
                                                    <i class="fas fa-calendar text-primary me-2"></i>Created
                                                </td>
                                                <td class="px-4 py-3">
                                                    <span class="badge bg-success">Active</span>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>

                                <!-- Action Buttons -->
                                <div class="p-4 border-top">
                                    <div class="row">
                                        <div class="col-12">
                                            <h6 class="fw-bold mb-3">
                                                <i class="fas fa-cogs text-primary me-2"></i>Actions
                                            </h6>
                                            <div class="btn-group" role="group">
                                                <a href="/admin/user/edit/${user.id}"
                                                    class="btn btn-warning btn-custom me-3">
                                                    <i class="fas fa-edit"></i> Edit User
                                                </a>
                                                <button type="button" class="btn btn-danger btn-custom me-3">
                                                    <i class="fas fa-trash"></i> Delete User
                                                </button>
                                                <a href="/admin/user" class="btn btn-info btn-custom">
                                                    <i class="fas fa-list"></i> All Users
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <!-- User not found -->
                                <div class="text-center py-5">
                                    <i class="fas fa-user-slash fa-3x text-muted mb-3"></i>
                                    <h5 class="text-muted">User not found</h5>
                                    <p class="text-muted">The requested user does not exist.</p>
                                    <a href="/admin/user" class="btn btn-primary btn-custom">
                                        <i class="fas fa-arrow-left"></i> Back to List
                                    </a>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>

            <!-- JavaScript for delete confirmation -->
            <script>
                function confirmDelete(userId) {
                    if (confirm('Are you sure you want to delete this user?')) {
                        // Implement delete functionality here
                        alert('Delete functionality not implemented yet');
                    }
                }
            </script>
        </body>

        </html>