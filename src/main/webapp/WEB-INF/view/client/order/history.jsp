<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

                <html lang="en">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Laptop Shop - Lịch sử mua hàng</title>
                    <meta content="laptop shop, cart, shopping cart, lịch sử mua hàng" name="keywords">
                    <meta content="Lịch sử mua hàng của Laptop Shop" name="description">
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

                    <!-- Single Page Header start -->

                    <!-- Single Page Header End -->
                    <!-- Cart Page Start -->
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
                                    <h2 class="text-dark fw-bold mb-2">Lịch sử đơn hàng</h2>
                                    <p class="text-muted">Xem tất cả đơn hàng bạn đã đặt</p>
                                </div>
                            </div>

                            <!-- Breadcrumb -->
                            <nav aria-label="breadcrumb" class="mb-4">
                                <ol class="breadcrumb mb-0">
                                    <li class="breadcrumb-item"><a href="/" class="text-decoration-none">Home</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">Order History</li>
                                </ol>
                            </nav>

                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead class="table-light">
                                        <tr>
                                            <th scope="col">Order ID</th>
                                            <th scope="col">Shipping Name</th>
                                            <th scope="col">Total Price</th>
                                            <th scope="col">Status</th>
                                            <th scope="col">Created At</th>
                                            <th scope="col">Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:choose>
                                            <c:when test="${not empty orders}">
                                                <c:forEach var="order" items="${orders}">
                                                    <tr>
                                                        <td class="align-middle">
                                                            <strong>#${order.id}</strong>
                                                        </td>
                                                        <td class="align-middle">
                                                            ${order.shippingName}
                                                        </td>
                                                        <td class="align-middle">
                                                            <fmt:formatNumber value="${order.totalPrice}"
                                                                pattern="#,###" /> VND
                                                        </td>
                                                        <td class="align-middle">
                                                            <c:choose>
                                                                <c:when test="${order.status == 'Đã đặt hàng'}">
                                                                    <span
                                                                        class="badge bg-warning text-dark">${order.status}</span>
                                                                </c:when>
                                                                <c:when test="${order.status == 'Hoàn tất'}">
                                                                    <span
                                                                        class="badge bg-success">${order.status}</span>
                                                                </c:when>
                                                                <c:when test="${order.status == 'Đã huỷ'}">
                                                                    <span class="badge bg-danger">${order.status}</span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span
                                                                        class="badge bg-secondary">${order.status}</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td class="align-middle">
                                                            <fmt:formatDate value="${order.createdAt}"
                                                                pattern="dd/MM/yyyy HH:mm" />
                                                        </td>
                                                        <td class="align-middle">
                                                            <a href="/order-history/${order.id}"
                                                                class="btn btn-primary btn-sm">
                                                                <i class="fas fa-eye"></i> View Details
                                                                <input type="hidden" name="${_csrf.parameterName}"
                                                                    value="${_csrf.token}" />
                                                            </a>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </c:when>
                                        </c:choose>
                                    </tbody>
                                </table>
                            </div>

                        </div>
                    </div>
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
                    </script> <!-- Order History Page End -->


                </body>

                </html>