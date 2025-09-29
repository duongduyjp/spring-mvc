<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Laptop Shop - Checkout</title>
                <meta content="laptop shop, checkout, thanh toán" name="keywords">
                <meta content="Thanh toán đơn hàng của Laptop Shop" name="description">
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
                    class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50 d-flex align-items-center justify-content-center">
                    <div class="spinner-grow text-primary" role="status"></div>
                </div>
                <!-- Spinner End -->

                <!-- Header Start -->
                <jsp:include page="../layout/header.jsp" />
                <!-- Header End -->

                <!-- Checkout Page Start -->
                <div class="container-fluid py-5">
                    <div class="container py-5">
                        <!-- Error Messages -->
                        <c:if test="${param.error != null}">
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                <strong>Lỗi!</strong> ${param.error}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        </c:if>

                        <!-- Breadcrumb -->
                        <nav aria-label="breadcrumb" class="mb-3">
                            <ol class="breadcrumb mb-0">
                                <li class="breadcrumb-item"><a href="/" class="text-decoration-none">Home</a></li>
                                <li class="breadcrumb-item"><a href="/cart/detail" class="text-decoration-none">Giỏ
                                        hàng</a></li>
                                <li class="breadcrumb-item active" aria-current="page">Checkout</li>
                            </ol>
                        </nav>

                        <h2 class="mb-4">Xác nhận đơn hàng</h2>

                        <!-- Order Items Table -->
                        <div class="table-responsive mb-4">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th scope="col">Sản phẩm</th>
                                        <th scope="col">Tên</th>
                                        <th scope="col">Đơn giá</th>
                                        <th scope="col">Số lượng</th>
                                        <th scope="col">Thành tiền</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:choose>
                                        <c:when test="${cart != null && !empty cart.cartItems}">
                                            <c:forEach var="item" items="${cart.cartItems}">
                                                <tr>
                                                    <th scope="row">
                                                        <div class="d-flex align-items-center">
                                                            <c:choose>
                                                                <c:when
                                                                    test="${item.product.image != null && item.product.image.startsWith('http')}">
                                                                    <img src="${item.product.image}"
                                                                        class="img-fluid me-5 rounded-circle"
                                                                        style="width: 80px; height: 80px; object-fit: cover;"
                                                                        alt="${item.product.name}">
                                                                </c:when>
                                                                <c:when test="${item.product.image != null}">
                                                                    <img src="/images/products/${item.product.image}"
                                                                        class="img-fluid me-5 rounded-circle"
                                                                        style="width: 80px; height: 80px; object-fit: cover;"
                                                                        alt="${item.product.name}">
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <img src="/client/img/vegetable-item-3.png"
                                                                        class="img-fluid me-5 rounded-circle"
                                                                        style="width: 80px; height: 80px; object-fit: cover;"
                                                                        alt="No Image">
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </div>
                                                    </th>
                                                    <td>
                                                        <p class="mb-0 mt-4">${item.product.name}</p>
                                                    </td>
                                                    <td>
                                                        <p class="mb-0 mt-4">
                                                            <fmt:formatNumber value="${item.unitPrice}"
                                                                pattern="#,###" /> VND
                                                        </p>
                                                    </td>
                                                    <td>
                                                        <div class="input-group quantity mt-4" style="width: 100px;">
                                                            <input type="text"
                                                                class="form-control form-control-sm text-center border-0"
                                                                value="${item.quantity}" readonly>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <p class="mb-0 mt-4">
                                                            <fmt:formatNumber value="${item.unitPrice * item.quantity}"
                                                                pattern="#,###" /> VND
                                                        </p>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <tr>
                                                <td colspan="5" class="text-center py-5">
                                                    <i class="fas fa-shopping-cart fa-3x text-muted mb-3"></i>
                                                    <p class="text-muted">Giỏ hàng của bạn đang trống</p>
                                                    <a href="/" class="btn btn-primary mt-2">Tiếp tục mua sắm</a>
                                                </td>
                                            </tr>
                                        </c:otherwise>
                                    </c:choose>
                                </tbody>
                            </table>
                        </div>

                        <!-- Form and Payment Info Row -->
                        <div class="row">
                            <!-- Customer Info Form -->
                            <div class="col-lg-6">
                                <div class="bg-light rounded p-4 h-100">
                                    <h4 class="mb-4">
                                        <i class="fa fa-user me-2"></i>Thông tin người nhận
                                    </h4>

                                    <form id="checkoutForm" action="/checkout/process" method="post">
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                                        <div class="mb-3">
                                            <label class="form-label">Tên người nhận <span
                                                    class="text-danger">*</span></label>
                                            <input type="text" name="customerName" class="form-control" required />
                                        </div>

                                        <div class="mb-3">
                                            <label class="form-label">Địa chỉ người nhận <span
                                                    class="text-danger">*</span></label>
                                            <input type="text" name="shippingAddress" class="form-control" required />
                                        </div>

                                        <div class="mb-3">
                                            <label class="form-label">Số điện thoại <span
                                                    class="text-danger">*</span></label>
                                            <input type="tel" name="customerPhone" class="form-control" required
                                                pattern="[0-9]{10,11}" />
                                        </div>

                                        <div class="mt-3">
                                            <a href="/cart/detail" class="btn btn-outline-secondary">
                                                <i class="fa fa-arrow-left me-2"></i>Quay lại giỏ hàng
                                            </a>
                                        </div>
                                    </form>
                                </div>
                            </div>

                            <!-- Payment Info -->
                            <div class="col-lg-6">
                                <div class="bg-light rounded p-4 h-100">
                                    <h4 class="mb-4">
                                        <i class="fa fa-credit-card me-2"></i>Thông tin thanh toán
                                    </h4>

                                    <div class="d-flex justify-content-between mb-3">
                                        <h6 class="mb-0">Phí vận chuyển:</h6>
                                        <p class="mb-0">Miễn phí</p>
                                    </div>

                                    <div class="d-flex justify-content-between mb-3">
                                        <h6 class="mb-0">Hình thức thanh toán:</h6>
                                        <p class="mb-0">COD</p>
                                    </div>

                                    <hr>

                                    <div class="d-flex justify-content-between mb-3">
                                        <h5 class="mb-0">Tổng tiền:</h5>
                                        <h5 class="mb-0 text-primary">
                                            <fmt:formatNumber value="${totalAmount}" pattern="#,###" /> VND
                                        </h5>
                                    </div>

                                    <c:choose>
                                        <c:when test="${cart != null && !empty cart.cartItems}">
                                            <button type="submit" form="checkoutForm"
                                                class="btn btn-primary w-100 py-3 rounded-pill">
                                                <i class="fa fa-credit-card me-2"></i>Xác nhận thanh toán
                                            </button>
                                        </c:when>
                                        <c:otherwise>
                                            <button type="button" disabled
                                                class="btn btn-secondary w-100 py-3 rounded-pill">
                                                Xác nhận thanh toán
                                            </button>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Checkout Page End -->

                <!-- Footer Start -->
                <jsp:include page="../layout/footer.jsp" />
                <!-- Footer End -->

                <!-- Back to Top -->
                <a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top">
                    <i class="fa fa-arrow-up"></i>
                </a>

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