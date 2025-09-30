<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>


                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Order detail</title>
                    <link href="/css/styles.css" rel="stylesheet" />
                    <link href="/css/main.css" rel="stylesheet" />
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
                        rel="stylesheet">
                    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
                        crossorigin="anonymous"></script>
                    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
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
                                        <h2 class="text-dark fw-bold">Detail an order</h2>
                                    </div>
                                </div>
                                <!-- Breadcrumb Section -->
                                <nav aria-label="breadcrumb">
                                    <ol class="breadcrumb">
                                        <li class="breadcrumb-item"><a href="/admin">Admin</a></li>
                                        <li class="breadcrumb-item"><a href="/admin/order">Orders</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">Detail</li>
                                    </ol>
                                </nav>

                                <!-- Product Details Table -->
                                <div class="card shadow-sm">
                                    <div class="card-header bg-primary text-white">
                                        <h5 class="mb-0">
                                            <i class="fas fa-receipt"></i> Order Information
                                        </h5>
                                    </div>
                                    <div class="card-body p-3">
                                        <c:choose>
                                            <c:when test="${not empty order}">
                                                <!-- Order Information -->
                                                <div class="table-responsive mb-4">
                                                    <table class="table table-bordered table-hover mb-0">
                                                        <tbody>
                                                            <tr>
                                                                <td class="bg-light fw-bold" style="width: 30%;">
                                                                    <i
                                                                        class="fas fa-id-card text-primary me-2"></i>Order
                                                                    ID
                                                                </td>
                                                                <td class="px-4 py-3">${order.id}</td>
                                                            </tr>
                                                            <tr>
                                                                <td class="bg-light fw-bold">
                                                                    <i class="fas fa-user text-primary me-2"></i>Tên
                                                                    người nhận
                                                                </td>
                                                                <td class="px-4 py-3">${order.shippingName}</td>
                                                            </tr>
                                                            <tr>
                                                                <td class="bg-light fw-bold">
                                                                    <i
                                                                        class="fas fa-map-marker-alt text-primary me-2"></i>Địa
                                                                    chỉ
                                                                </td>
                                                                <td class="px-4 py-3">${order.shippingAddress}</td>
                                                            </tr>
                                                            <tr>
                                                                <td class="bg-light fw-bold">
                                                                    <i class="fas fa-phone text-primary me-2"></i>Số
                                                                    điện thoại
                                                                </td>
                                                                <td class="px-4 py-3">${order.shippingPhone}</td>
                                                            </tr>
                                                            <tr>
                                                                <td class="bg-light fw-bold">
                                                                    <i
                                                                        class="fas fa-money-bill text-primary me-2"></i>Tổng
                                                                    tiền
                                                                </td>
                                                                <td class="px-4 py-3">
                                                                    <fmt:formatNumber value="${order.totalPrice}"
                                                                        pattern="#,###" /> VND
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="bg-light fw-bold">
                                                                    <i
                                                                        class="fas fa-info-circle text-primary me-2"></i>Trạng
                                                                    thái
                                                                </td>
                                                                <td class="px-4 py-3">
                                                                    <span
                                                                        class="badge bg-success">${order.status}</span>
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </div>

                                                <!-- Order Details List -->
                                                <div class="card">
                                                    <div class="card-header bg-secondary text-white">
                                                        <h6 class="mb-0">
                                                            <i class="fas fa-list"></i> Chi tiết đơn hàng
                                                        </h6>
                                                    </div>
                                                    <div class="card-body p-0">
                                                        <div class="table-responsive">
                                                            <table class="table table-hover mb-0">
                                                                <thead class="table-light">
                                                                    <tr>
                                                                        <th>Sản phẩm</th>
                                                                        <th>Giá</th>
                                                                        <th>Số lượng</th>
                                                                        <th>Thành tiền</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <c:choose>
                                                                        <c:when test="${not empty orderDetails}">
                                                                            <c:forEach var="orderDetail"
                                                                                items="${orderDetails}">
                                                                                <tr>
                                                                                    <td>${orderDetail.product.name}</td>
                                                                                    <td>
                                                                                        <fmt:formatNumber
                                                                                            value="${orderDetail.price}"
                                                                                            pattern="#,###" /> VND
                                                                                    </td>
                                                                                    <td>${orderDetail.quantity}</td>
                                                                                    <td>
                                                                                        <fmt:formatNumber
                                                                                            value="${orderDetail.price * orderDetail.quantity}"
                                                                                            pattern="#,###" /> VND
                                                                                    </td>
                                                                                </tr>
                                                                            </c:forEach>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <tr>
                                                                                <td colspan="4"
                                                                                    class="text-center py-3">
                                                                                    <div class="text-muted">Không có chi
                                                                                        tiết đơn hàng</div>
                                                                                </td>
                                                                            </tr>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                    </div>
                                                </div>

                                                <!-- Action Buttons -->
                                                <div class="p-4 border-top">
                                                    <div class="row">
                                                        <div class="col-12">
                                                            <h6 class="fw-bold mb-3">
                                                                <i class="fas fa-cogs text-primary me-2"></i>Actions
                                                            </h6>
                                                            <div class="btn-group" role="group">
                                                                <a href="/admin/order/edit/${order.id}"
                                                                    class="btn btn-warning btn-sm me-3">
                                                                    <i class="fas fa-edit"></i> Edit Order
                                                                </a>
                                                                <form action="/admin/order/delete/${order.id}"
                                                                    method="POST"
                                                                    onsubmit="return confirm('You are sure to delete this order?');"
                                                                    style="display: inline-block; margin: 0;">
                                                                    <button type="submit"
                                                                        class="btn btn-danger btn-sm me-3">
                                                                        <i class="fas fa-trash"></i> Delete
                                                                    </button>
                                                                </form>
                                                                <a href="/admin/order" class="btn btn-info btn-sm">
                                                                    <i class="fas fa-list"></i> All Orders
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
                                                    <h5 class="text-muted">Order not found</h5>
                                                    <p class="text-muted">The requested order does not exist.</p>
                                                    <a href="/admin/order" class="btn btn-primary btn-custom">
                                                        <i class="fas fa-arrow-left"></i> Back to List
                                                    </a>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>

                                <!-- Success/Error Messages -->
                                <c:if test="${param.success != null}">
                                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                                        <strong>Thành công!</strong> Đã thêm đơn hàng.
                                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                    </div>
                                </c:if>

                                <c:if test="${param.error != null}">
                                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                        <strong>Lỗi!</strong> ${param.error}
                                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                    </div>
                                </c:if>
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
                        </main>
                        <jsp:include page="../layout/footer.jsp" />
                    </div>
                </body>