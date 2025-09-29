<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

                <html lang="en">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Laptop Shop - Checkout</title>
                    <meta content="laptop shop, cart, shopping cart, chi tiết giỏ hàng" name="keywords">
                    <meta content="Chi tiết giỏ hàng của Laptop Shop" name="description">
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

                    <style>
                        /* Cart AJAX Animation Styles */
                        .highlight {
                            background-color: #28a745 !important;
                            color: white !important;
                            transition: all 0.3s ease;
                            border-radius: 4px;
                            padding: 2px 4px;
                        }

                        .removing {
                            opacity: 0.5;
                            background-color: #f8d7da;
                        }

                        .quantity button:disabled {
                            opacity: 0.6;
                            cursor: not-allowed;
                        }

                        .cart-total-amount {
                            transition: all 0.3s ease;
                        }

                        .item-total {
                            transition: all 0.3s ease;
                        }

                        /* Loading animation */
                        .btn-cart-minus:disabled,
                        .btn-cart-plus:disabled,
                        .btn-cart-remove:disabled {
                            position: relative;
                        }

                        .btn-cart-minus:disabled::after,
                        .btn-cart-plus:disabled::after,
                        .btn-cart-remove:disabled::after {
                            content: '';
                            position: absolute;
                            width: 12px;
                            height: 12px;
                            top: 50%;
                            left: 50%;
                            margin: -6px 0 0 -6px;
                            border: 2px solid #ccc;
                            border-radius: 50%;
                            border-top-color: #007bff;
                            animation: spin 1s linear infinite;
                        }

                        @keyframes spin {
                            to {
                                transform: rotate(360deg);
                            }
                        }

                        .updating {
                            opacity: 0.7;
                            pointer-events: none;
                        }
                    </style>
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

                            <!-- Breadcrumb -->
                            <nav aria-label="breadcrumb" class="mb-3">
                                <ol class="breadcrumb mb-0">
                                    <li class="breadcrumb-item"><a href="/" class="text-decoration-none">Home</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">Checkout</li>
                                </ol>
                            </nav>

                            <div class="table-responsive">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th scope="col">Products</th>
                                            <th scope="col">Name</th>
                                            <th scope="col">Price</th>
                                            <th scope="col">Quantity</th>
                                            <th scope="col">Total</th>
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
                                                            <div class="input-group quantity mt-4"
                                                                style="width: 100px;">
                                                                <input type="text"
                                                                    class="form-control form-control-sm text-center border-0"
                                                                    value="${item.quantity}" data-item-id="${item.id}"
                                                                    readonly>
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <p class="mb-0 mt-4 item-total">
                                                                <fmt:formatNumber
                                                                    value="${item.unitPrice * item.quantity}"
                                                                    pattern="#,###" /> VND
                                                            </p>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </c:when>
                                            <c:otherwise>
                                            </c:otherwise>
                                        </c:choose>
                                    </tbody>
                                </table>
                            </div>

                            <!-- Form thông tin người nhận -->
                            <div class="row mb-4">
                                <div class="col-lg-8">
                                    <div class="bg-light rounded p-4">
                                        <h4 class="mb-4">
                                            <i class="fa fa-user me-2"></i>Thông Tin Người Nhận
                                        </h4>

                                        <form id="checkoutForm" action="/checkout/process" method="post">
                                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                            <input type="hidden" name="totalAmount" value="${totalAmount}" />
                                            <input type="hidden" name="shippingFee" value="0" />
                                            <input type="hidden" name="paymentMethod" value="COD" />
                                            <input type="hidden" name="status" value="PENDING" />
                                            <input type="hidden" name="userId" value="${user.id}" />

                                            <div class="mb-3">
                                                <label class="form-label">Tên người nhận</label>
                                                <input type="text" name="customerName" class="form-control"
                                                    value="${user.fullName}" placeholder="Nhập tên người nhận"
                                                    required />
                                            </div>

                                            <div class="mb-3">
                                                <label class="form-label">Địa chỉ người nhận</label>
                                                <input type="text" name="shippingAddress" class="form-control"
                                                    value="${user.address}" placeholder="Nhập địa chỉ người nhận"
                                                    required />
                                            </div>

                                            <div class="mb-3">
                                                <label class="form-label">Số điện thoại</label>
                                                <input type="tel" name="customerPhone" class="form-control"
                                                    value="${user.phone}" placeholder="Nhập số điện thoại" required />
                                            </div>

                                            <div class="mt-3">
                                                <a href="/cart/detail" class="btn btn-outline-secondary">
                                                    <i class="fa fa-arrow-left me-2"></i>Quay lại giỏ hàng
                                                </a>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>

                            <div class="row g-4 justify-content-end">
                                <div class="col-12"></div>
                                <div class="col-sm-12 col-md-10 col-lg-8 col-xl-6">
                                    <div class="bg-light rounded">
                                        <div class="p-4">
                                            <h1 class="display-6 mb-4">Thông tin thanh toán</h1>

                                            <div class="d-flex justify-content-between mb-4">
                                                <h5 class="mb-0 me-4">Phí vận chuyển:</h5>
                                                <p class="mb-0 cart-total-amount">
                                                    Miễn phí
                                                </p>
                                            </div>
                                            <div class="d-flex justify-content-between">
                                                <h5 class="mb-0 me-4">Hình thức thanh toán</h5>
                                                <div class="">
                                                    <p class="mb-0">Thanh toán khi nhận hàng(COD)</p>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="py-4 mb-4 border-top border-bottom d-flex justify-content-between">
                                            <h5 class="mb-0 ps-4 me-4">Tổng tiền</h5>
                                            <p class="mb-0 pe-4 cart-total-amount">
                                                <fmt:formatNumber value="${totalAmount}" pattern="#,###" /> VND
                                            </p>
                                        </div>
                                        <c:choose>
                                            <c:when test="${cart != null && !empty cart.cartItems}">
                                                <button type="submit" form="checkoutForm"
                                                    class="btn btn-primary rounded-pill px-4 py-3 text-uppercase mb-4 ms-4">
                                                    <i class="fa fa-credit-card me-2"></i>Xác nhận thanh toán
                                                </button>
                                            </c:when>
                                            <c:otherwise>
                                                <button type="button" disabled
                                                    class="btn btn-secondary rounded-pill px-4 py-3 text-uppercase mb-4 ms-4">
                                                    Xác nhận thanh toán
                                                </button>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Cart Page End -->


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
                        // Disable main.js quantity handlers for cart page
                        $(document).ready(function () {
                            $('.quantity button').off('click');
                        });
                    </script>

                    <!-- Cart AJAX JavaScript -->
                    <script src="/static/js/cart.js"></script>

                    <script>
                        // Ẩn spinner khi trang load xong
                        $(document).ready(function () {
                            $('#spinner').removeClass('show');
                        });
                    </script>

                </body>

                </html>