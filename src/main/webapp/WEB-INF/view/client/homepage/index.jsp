<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html>

            <head>
                <meta charset="UTF-8">
                <title>Home Page</title>
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
                <link href="/client/css/style.css" rel="stylesheet" />

                <!-- Custom Styles -->
                <link href="/css/pagination.css" rel="stylesheet" />
            </head>

            <body>

                <!-- Spinner Start -->
                <!-- Bắt đầu spinner loading khi trang đang tải -->
                <div id="spinner"
                    class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
                    <div class="spinner-grow text-primary" role="status"></div>
                </div>
                <!-- Kết thúc spinner loading -->
                <!-- Spinner End -->

                <!-- Header (Thanh điều hướng) -->
                <jsp:include page="../layout/header.jsp" />
                <!-- Banner quảng cáo -->
                <jsp:include page="../layout/banner.jsp" />

                <!-- Fruits Shop Start-->
                <!-- Bắt đầu block danh sách sản phẩm nổi bật -->
                <div class="container-fluid fruite py-5">
                    <div class="container py-5">
                        <!-- Tab class cho tiêu đề và filter -->
                        <div class="tab-class text-center">
                            <div class="row g-4">
                                <div class="col-lg-4 text-start">
                                    <h1>Sản phẩm nổi bật</h1>
                                </div>
                                <div class="col-lg-8 text-end">
                                    <ul class="nav nav-pills d-inline-flex text-center mb-5">
                                        <li class="nav-item">
                                            <a class="d-flex m-2 py-2 bg-light rounded-pill active"
                                                data-bs-toggle="pill" href="#tab-1">
                                                <span class="text-dark" style="width: 130px;">All Products</span>
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                            <!-- Tab content chứa danh sách sản phẩm -->
                            <div class="tab-content">
                                <div id="tab-1" class="tab-pane fade show p-0 active">
                                    <div class="row g-4">
                                        <div class="col-lg-12">
                                            <!-- Danh sách sản phẩm dạng lưới -->
                                            <div class="row g-4">
                                                <c:forEach var="product" items="${products}" varStatus="status">
                                                    <div class="col-md-6 col-lg-4 col-xl-3 mb-4">
                                                        <!-- Card sản phẩm -->
                                                        <div
                                                            class="rounded position-relative fruite-item h-100 d-flex flex-column">
                                                            <!-- Ảnh sản phẩm -->
                                                            <div class="fruite-img"
                                                                style="height: 200px; overflow: hidden;">
                                                                <a href="/product/${product.id}">
                                                                    <c:choose>
                                                                        <c:when
                                                                            test="${product.image != null && product.image.startsWith('http')}">
                                                                            <img src="${product.image}"
                                                                                class="img-fluid w-100 rounded-top"
                                                                                alt="${product.name}"
                                                                                style="height: 200px; object-fit: cover;">
                                                                        </c:when>
                                                                        <c:when test="${product.image != null}">
                                                                            <img src="/images/products/${product.image}"
                                                                                class="img-fluid w-100 rounded-top"
                                                                                alt="${product.name}"
                                                                                style="height: 200px; object-fit: cover;">
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <img src="https://via.placeholder.com/400x300/CCCCCC/FFFFFF?text=No+Image"
                                                                                class="img-fluid w-100 rounded-top"
                                                                                alt="No Image"
                                                                                style="height: 200px; object-fit: cover;">
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </a>
                                                            </div>
                                                            <!-- Tag mục tiêu sản phẩm -->
                                                            <div class="text-white bg-secondary px-3 py-1 rounded position-absolute"
                                                                style="top: 10px; left: 10px;">${product.target}
                                                            </div>
                                                            <!-- Thông tin sản phẩm -->
                                                            <div
                                                                class="p-4 border border-secondary border-top-0 rounded-bottom flex-fill d-flex flex-column">
                                                                <h4
                                                                    style="height: 60px; overflow: hidden; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical;">
                                                                    <a href="/product/${product.id}"
                                                                        class="text-decoration-none">${product.name}</a>
                                                                </h4>
                                                                <p
                                                                    style="height: 48px; overflow: hidden; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; font-size: 14px;">
                                                                    ${product.shortDesc}
                                                                </p>
                                                                <div class="mt-auto">
                                                                    <div
                                                                        class="d-flex justify-content-between align-items-center flex-wrap">
                                                                        <p class="text-dark fs-5 fw-bold mb-2">
                                                                            <fmt:formatNumber value="${product.price}"
                                                                                pattern="#,###" /> VND
                                                                        </p>
                                                                        <a href="#"
                                                                            class="btn border border-secondary rounded-pill px-3 text-primary btn-sm">
                                                                            <i
                                                                                class="fa fa-shopping-bag me-2 text-primary"></i>
                                                                            Add to cart
                                                                        </a>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <!-- Kết thúc thông tin sản phẩm -->
                                                        </div>
                                                        <!-- Kết thúc card sản phẩm -->
                                                    </div>
                                                </c:forEach>
                                            </div>
                                            <!-- Kết thúc danh sách sản phẩm dạng lưới -->
                                            <!-- Các tính năng nổi bật -->

                                            <!-- Pagination Start -->
                                            <!-- Phân trang sản phẩm -->
                                            <c:if test="${totalPages > 1}">
                                                <div class="d-flex justify-content-center mt-5">
                                                    <nav aria-label="Product pagination">
                                                        <ul class="pagination">
                                                            <!-- Nút trang trước -->
                                                            <c:if test="${currentPage > 0}">
                                                                <li class="page-item">
                                                                    <a class="page-link"
                                                                        href="/?page=${currentPage - 1}"
                                                                        aria-label="Previous">
                                                                        <span aria-hidden="true">&laquo;</span>
                                                                    </a>
                                                                </li>
                                                            </c:if>

                                                            <!-- Số trang -->
                                                            <c:forEach begin="0" end="${totalPages - 1}" var="i">
                                                                <li
                                                                    class="page-item ${i == currentPage ? 'active' : ''}">
                                                                    <a class="page-link" href="/?page=${i}">${i + 1}</a>
                                                                </li>
                                                            </c:forEach>

                                                            <!-- Nút trang sau -->
                                                            <c:if test="${currentPage < totalPages - 1}">
                                                                <li class="page-item">
                                                                    <a class="page-link"
                                                                        href="/?page=${currentPage + 1}"
                                                                        aria-label="Next">
                                                                        <span aria-hidden="true">&raquo;</span>
                                                                    </a>
                                                                </li>
                                                            </c:if>
                                                        </ul>
                                                    </nav>
                                                </div>

                                                <!-- Thông tin phân trang -->
                                                <div class="text-center mt-3">
                                                    <p class="text-muted">
                                                        Hiển thị trang ${currentPage + 1} / ${totalPages}
                                                        (Tổng ${totalElements} sản phẩm)
                                                    </p>
                                                </div>
                                            </c:if>
                                            <!-- Kết thúc phân trang -->
                                            <!-- Pagination End -->
                                            <jsp:include page="../layout/feature.jsp" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- Kết thúc tab content -->
                        </div>
                        <!-- Kết thúc tab class -->
                    </div>
                </div>
                <!-- Kết thúc block danh sách sản phẩm nổi bật -->
                <!-- Fruits Shop End-->

                <!-- Footer -->
                <jsp:include page="../layout/footer.jsp" />

                <!-- Back to Top -->
                <!-- Nút quay về đầu trang -->
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
            </body>

            </html>