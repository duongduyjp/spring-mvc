<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Laptop Shop - Chi tiết đơn hàng</title>
                    <meta content="laptop shop, order detail, chi tiết đơn hàng" name="keywords">
                    <meta content="Chi tiết đơn hàng của Laptop Shop" name="description">
                    <meta name="_csrf" content="${_csrf.token}" />
                    <meta name="_csrf_header" content="${_csrf.headerName}" />

                    <!-- Google Web Fonts -->
                    <link rel="preconnect" href="https://fonts.googleapis.com">
                    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                    <link
                        href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
                        rel="stylesheet">

                    <!-- Icon Font Stylesheet -->
                    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
                        rel="stylesheet">

                    <!-- Libraries Stylesheet -->
                    <link href="/client/lib/lightbox/css/lightbox.min.css" rel="stylesheet">
                    <link href="/client/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">

                    <!-- Customized Bootstrap Stylesheet -->
                    <link href="/client/css/bootstrap.min.css" rel="stylesheet">

                    <!-- Template Stylesheet -->
                    <link href="/client/css/style.css" rel="stylesheet">
                </head>

                <body>

                    <!-- Spinner Start -->
                    <div id="spinner"
                        class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
                        <div class="spinner-grow text-primary" role="status"></div>
                    </div>
                    <!-- Spinner End -->

                    <!-- Header Start -->
                    <jsp:include page="../layout/header.jsp" />
                    <!-- Header End -->

                    <!-- Order Detail Page Start -->
                    <div class="container-fluid py-5">
                        <div class="container py-5">
                            <!-- Error Messages -->
                            <c:if test="${param.error != null}">
                                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                    <strong>Lỗi!</strong> ${param.error}
                                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                </div>
                            </c:if>

                            <!-- Page Header -->
                            <div class="row mb-4">
                                <div class="col-12">
                                    <h2 class="text-dark fw-bold mb-2">Chi tiết đơn hàng</h2>
                                </div>
                            </div>

                            <!-- Breadcrumb -->
                            <nav aria-label="breadcrumb" class="mb-4">
                                <ol class="breadcrumb mb-0">
                                    <li class="breadcrumb-item"><a href="/" class="text-decoration-none">Home</a></li>
                                    <li class="breadcrumb-item"><a href="/orders-history"
                                            class="text-decoration-none">Orders</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">Detail</li>
                                </ol>
                            </nav>

                            <c:choose>
                                <c:when test="${not empty order}">
                                    <!-- Order Information Card -->
                                    <div class="card shadow-sm mb-4">
                                        <div class="card-header bg-primary text-white">
                                            <h5 class="mb-0">
                                                <i class="fas fa-info-circle"></i> Thông tin đơn hàng
                                            </h5>
                                        </div>
                                        <div class="card-body">
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <p><strong>Tên người nhận:</strong> ${order.shippingName}</p>
                                                    <p><strong>Địa chỉ:</strong> ${order.shippingAddress}</p>
                                                    <p><strong>Số điện thoại:</strong> ${order.shippingPhone}</p>
                                                </div>
                                                <div class="col-md-6">
                                                    <p><strong>Trạng thái:</strong>
                                                        <c:choose>
                                                            <c:when test="${order.status == 'Đã đặt hàng'}">
                                                                <span
                                                                    class="badge bg-warning text-dark">${order.status}</span>
                                                            </c:when>
                                                            <c:when test="${order.status == 'Hoàn tất'}">
                                                                <span class="badge bg-success">${order.status}</span>
                                                            </c:when>
                                                            <c:when test="${order.status == 'Đã huỷ'}">
                                                                <span class="badge bg-danger">${order.status}</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="badge bg-secondary">${order.status}</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </p>
                                                    <p><strong>Ngày đặt:</strong>
                                                        <fmt:formatDate value="${order.createdAt}"
                                                            pattern="dd/MM/yyyy HH:mm" />
                                                    </p>
                                                    <p><strong>Tổng tiền:</strong>
                                                        <span class="text-primary fw-bold">
                                                            <fmt:formatNumber value="${order.totalPrice}"
                                                                pattern="#,###" /> VND
                                                        </span>
                                                    </p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Order Details Table -->
                                    <div class="card shadow-sm">
                                        <div class="card-header bg-secondary text-white">
                                            <h5 class="mb-0">
                                                <i class="fas fa-list"></i> Chi tiết sản phẩm
                                            </h5>
                                        </div>
                                        <div class="card-body p-0">
                                            <div class="table-responsive">
                                                <table class="table table-hover mb-0">
                                                    <thead class="table-light">
                                                        <tr>
                                                            <th scope="col">Sản phẩm</th>
                                                            <th scope="col">Giá</th>
                                                            <th scope="col">Số lượng</th>
                                                            <th scope="col">Thành tiền</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <c:choose>
                                                            <c:when test="${not empty orderDetails}">
                                                                <c:forEach var="orderDetail" items="${orderDetails}">
                                                                    <tr>
                                                                        <td class="align-middle">
                                                                            ${orderDetail.product.name}
                                                                        </td>
                                                                        <td class="align-middle">
                                                                            <fmt:formatNumber
                                                                                value="${orderDetail.price}"
                                                                                pattern="#,###" /> VND
                                                                        </td>
                                                                        <td class="align-middle">${orderDetail.quantity}
                                                                        </td>
                                                                        <td class="align-middle">
                                                                            <fmt:formatNumber
                                                                                value="${orderDetail.price * orderDetail.quantity}"
                                                                                pattern="#,###" /> VND
                                                                        </td>
                                                                    </tr>
                                                                </c:forEach>
                                                                <!-- Total Row -->
                                                                <tr class="table-secondary">
                                                                    <td colspan="3" class="text-end fw-bold">
                                                                        <strong>Tổng cộng:</strong>
                                                                    </td>
                                                                    <td class="fw-bold text-primary">
                                                                        <fmt:formatNumber value="${order.totalPrice}"
                                                                            pattern="#,###" /> VND
                                                                    </td>
                                                                </tr>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <tr>
                                                                    <td colspan="4" class="text-center py-5">
                                                                        <div class="text-muted">
                                                                            <i class="fas fa-box-open fa-3x mb-3"></i>
                                                                            <h5>Không có chi tiết đơn hàng</h5>
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

                                    <!-- Back Button -->
                                    <div class="mt-4">
                                        <a href="/orders-history" class="btn btn-primary">
                                            <i class="fas fa-arrow-left"></i> Quay lại danh sách
                                        </a>
                                    </div>

                                </c:when>
                                <c:otherwise>
                                    <!-- Order not found -->
                                    <div class="card shadow-sm">
                                        <div class="card-body text-center py-5">
                                            <i class="fas fa-exclamation-triangle fa-3x text-warning mb-3"></i>
                                            <h5 class="text-muted">Không tìm thấy đơn hàng</h5>
                                            <p class="text-muted">Đơn hàng bạn yêu cầu không tồn tại hoặc đã bị xóa.</p>
                                            <a href="/orders-history" class="btn btn-primary">
                                                <i class="fas fa-arrow-left"></i> Quay lại danh sách
                                            </a>
                                        </div>
                                    </div>
                                </c:otherwise>
                            </c:choose>

                        </div>
                    </div>
                    <!-- Order Detail Page End -->

                    <!-- Footer Start -->
                    <jsp:include page="../layout/footer.jsp" />
                    <!-- Footer End -->

                    <!-- Back to Top -->
                    <a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i
                            class="fa fa-arrow-up"></i></a>

                    <!-- JavaScript Libraries -->
                    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
                    <script src="/client/lib/easing/easing.min.js"></script>
                    <script src="/client/lib/waypoints/waypoints.min.js"></script>
                    <script src="/client/lib/lightbox/js/lightbox.min.js"></script>
                    <script src="/client/lib/owlcarousel/owl.carousel.min.js"></script>

                    <!-- Template Javascript -->
                    <script src="/client/js/main.js"></script>

                    <script>
                        // Ẩn spinner khi trang load xong
                        $(document).ready(function () {
                            $('#spinner').removeClass('show');
                        });
                    </script>

                </body>

                </html>