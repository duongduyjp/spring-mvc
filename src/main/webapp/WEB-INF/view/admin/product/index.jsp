<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="utf-8" />
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                <meta name="description" content="Hỏi Dân IT - Dự án laptopshop" />
                <meta name="author" content="Hỏi Dân IT" />
                <title>Product - Hỏi Dân IT</title>
                <link href="/css/styles.css" rel="stylesheet" />
                <link href="/css/main.css" rel="stylesheet" />
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
                                    <h2 class="text-dark fw-bold">Manager Products</h2>
                                </div>
                                <div class="col-md-6 text-end">
                                    <a href="/admin/product/create" class="btn btn-primary">
                                        <i class="fas fa-plus"></i> Create a product
                                    </a>
                                </div>
                            </div>
                            <!-- Breadcrumb Section -->
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="/admin">Admin</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">Products</li>
                                </ol>
                            </nav>
                            <div>
                                Table products
                            </div>

                            <!-- Table Section -->
                            <div class="card shadow-sm mt-3">
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
                                                    <th class="px-3 py-3">Name</th>
                                                    <th class="px-3 py-3">Price</th>
                                                    <th class="px-3 py-3">Quantity</th>
                                                    <th class="px-3 py-3">Sold</th>
                                                    <th class="px-3 py-3">Factory</th>
                                                    <th class="px-3 py-3">Target</th>
                                                    <th class="px-3 py-3 text-center">Action</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <!-- Kiểm tra nếu có data -->
                                                <c:choose>
                                                    <c:when test="${not empty products}">
                                                        <!-- Hiển thị data thật từ database -->
                                                        <c:forEach var="product" items="${products}">
                                                            <tr>
                                                                <td class="px-3 py-3">${product.id}</td>
                                                                <td class="px-3 py-3">${product.name}</td>
                                                                <td class="px-3 py-3">
                                                                    <fmt:formatNumber value="${product.price}"
                                                                        pattern="#,###" /> VND
                                                                </td>
                                                                <td class="px-3 py-3">${product.quantity}</td>
                                                                <td class="px-3 py-3">${product.sold}</td>
                                                                <td class="px-3 py-3">${product.factory}</td>
                                                                <td class="px-3 py-3">${product.target}</td>
                                                                <td class="px-3 py-3 text-center">
                                                                    <div class="btn-group" role="group">
                                                                        <a href="/admin/product/${product.id}"
                                                                            class="btn btn-success btn-sm me-3">
                                                                            <i class="fas fa-eye"></i> View
                                                                        </a>
                                                                        <a href="/admin/product/edit/${product.id}"
                                                                            class="btn btn-warning btn-sm me-3">
                                                                            <i class="fas fa-edit"></i> Update
                                                                        </a>
                                                                        <form
                                                                            action="/admin/product/delete/${product.id}"
                                                                            method="POST"
                                                                            onsubmit="return confirm('You are sure to delete this product?');"
                                                                            style="display: inline-block; margin: 0;">
                                                                            <button type="submit"
                                                                                class="btn btn-danger btn-sm">
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
                                                            <td colspan="9" class="text-center py-3">
                                                                <div class="d-flex flex-column align-items-center">
                                                                    <i
                                                                        class="fas fa-product-hunt fa-3x text-muted mb-3 text-center"></i>
                                                                    <h5 class="text-muted mb-2 text-center">No products
                                                                        found</h5>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </c:otherwise>
                                                </c:choose>
                                            </tbody>
                                        </table>
                                        <!-- Pagination Section -->
                                        <!-- Pagination Component -->
                                        <c:set var="paginationUrl" value="/admin/product" />
                                        <c:set var="itemName" value="sản phẩm" />
                                        <jsp:include page="../layout/pagination.jsp" />
                                    </div>
                                </div>
                            </div>
                        </div>
                </div>
                </div>
                </main>
                <jsp:include page="../layout/footer.jsp" />
                </div>
                </div>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
                    crossorigin="anonymous"></script>
                <script src="js/scripts.js"></script>
            </body>

            </html>