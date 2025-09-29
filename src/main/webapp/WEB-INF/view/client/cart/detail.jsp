<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

                <html lang="en">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Laptop Shop - Chi tiết giỏ hàng</title>
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
                                    <li class="breadcrumb-item active" aria-current="page">Cart Detail</li>
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
                                            <th scope="col">Handle</th>
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
                                                                <div class="input-group-btn">
                                                                    <button
                                                                        class="btn btn-sm btn-cart-minus rounded-circle bg-light border"
                                                                        data-item-id="${item.id}">
                                                                        <i class="fa fa-minus"></i>
                                                                    </button>
                                                                </div>
                                                                <input type="text"
                                                                    class="form-control form-control-sm text-center border-0"
                                                                    value="${item.quantity}" data-item-id="${item.id}"
                                                                    readonly>
                                                                <div class="input-group-btn">
                                                                    <button
                                                                        class="btn btn-sm btn-cart-plus rounded-circle bg-light border"
                                                                        data-item-id="${item.id}">
                                                                        <i class="fa fa-plus"></i>
                                                                    </button>
                                                                </div>
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <p class="mb-0 mt-4 item-total">
                                                                <fmt:formatNumber
                                                                    value="${item.unitPrice * item.quantity}"
                                                                    pattern="#,###" /> VND
                                                            </p>
                                                        </td>
                                                        <td>
                                                            <button
                                                                class="btn btn-md btn-cart-remove rounded-circle bg-light border mt-4"
                                                                data-item-id="${item.id}">
                                                                <i class="fa fa-times text-danger"></i>
                                                            </button>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </c:when>
                                            <c:otherwise>
                                                <tr>
                                                    <td colspan="6" class="text-center py-5">
                                                        <div class="text-muted">
                                                            <i class="fa fa-shopping-cart fa-3x mb-3"></i>
                                                            <h5>Giỏ hàng trống</h5>
                                                            <p>Hãy thêm sản phẩm vào giỏ hàng để tiếp tục mua sắm
                                                            </p>
                                                            <a href="/" class="btn btn-primary">Tiếp tục mua sắm</a>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:otherwise>
                                        </c:choose>
                                    </tbody>
                                </table>
                            </div>
                            <div class="row g-4 justify-content-end">
                                <div class="col-8"></div>
                                <div class="col-sm-8 col-md-7 col-lg-6 col-xl-4">
                                    <div class="bg-light rounded">
                                        <div class="p-4">
                                            <h1 class="display-6 mb-4">Cart <span class="fw-normal">Total</span>
                                            </h1>
                                            <div class="d-flex justify-content-between mb-4">
                                                <h5 class="mb-0 me-4">Subtotal:</h5>
                                                <p class="mb-0 cart-total-amount">
                                                    <fmt:formatNumber value="${totalAmount}" pattern="#,###" /> VND
                                                </p>
                                            </div>
                                            <div class="d-flex justify-content-between">
                                                <h5 class="mb-0 me-4">Shipping</h5>
                                                <div class="">
                                                    <p class="mb-0">Miễn phí vận chuyển</p>
                                                </div>
                                            </div>
                                            <p class="mb-0 text-end">Giao hàng toàn quốc.</p>
                                        </div>
                                        <div class="py-4 mb-4 border-top border-bottom d-flex justify-content-between">
                                            <h5 class="mb-0 ps-4 me-4">Total</h5>
                                            <p class="mb-0 pe-4 cart-total-amount">
                                                <fmt:formatNumber value="${totalAmount}" pattern="#,###" /> VND
                                            </p>
                                        </div>
                                        <c:choose>
                                            <c:when test="${cart != null && !empty cart.cartItems}">
                                                <a href="/checkout"
                                                    class="btn border-secondary rounded-pill px-4 py-3 text-primary text-uppercase mb-4 ms-4 btn-checkout"
                                                    type="button">Proceed Checkout</a>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="/checkout"
                                                    class="btn border-secondary rounded-pill px-4 py-3 text-muted text-uppercase mb-4 ms-4"
                                                    type="button" disabled>Proceed Checkout</a>
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