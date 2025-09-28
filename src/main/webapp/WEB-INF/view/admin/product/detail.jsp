<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>


                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Create Product</title>
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
                                        <h2 class="text-dark fw-bold">Detail a product</h2>
                                    </div>
                                </div>
                                <!-- Breadcrumb Section -->
                                <nav aria-label="breadcrumb">
                                    <ol class="breadcrumb">
                                        <li class="breadcrumb-item"><a href="/admin">Admin</a></li>
                                        <li class="breadcrumb-item"><a href="/admin/product">Products</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">Detail</li>
                                    </ol>
                                </nav>

                                <!-- Product Details Table -->
                                <div class="card shadow-sm">
                                    <div class="card-header bg-primary text-white">
                                        <h5 class="mb-0">
                                            <i class="fas fa-circle-info"></i> Product Information
                                        </h5>
                                    </div>
                                    <div class="card-body p-3">
                                        <c:choose>
                                            <c:when test="${not empty product}">

                                                <div class="table-responsive">
                                                    <table class="table table-bordered table-hover mb-0">
                                                        <tbody>
                                                            <tr>
                                                                <td class="bg-light fw-bold" style="width: 30%;">
                                                                    <i class="fas fa-id-card text-primary me-2"></i>ID
                                                                </td>
                                                                <td class="px-4 py-3">${product.id}</td>
                                                            </tr>
                                                            <tr>
                                                                <td class="bg-light fw-bold">
                                                                    <i
                                                                        class="fas fa-envelope text-primary me-2"></i>Name
                                                                </td>
                                                                <td class="px-4 py-3">
                                                                    <a href="mailto:${product.name}"
                                                                        class="text-decoration-none">
                                                                        ${product.name}
                                                                    </a>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="bg-light fw-bold">
                                                                    <i class="fas fa-user text-primary me-2"></i>Price

                                                                </td>
                                                                <td class="px-4 py-3">
                                                                    <fmt:formatNumber value="${product.price}"
                                                                        pattern="#,###" /> VND
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="bg-light fw-bold">
                                                                    <i
                                                                        class="fas fa-phone text-primary me-2"></i>Quantity
                                                                </td>
                                                                <td class="px-4 py-3">
                                                                    <a href="tel:${product.quantity}"
                                                                        class="text-decoration-none">
                                                                        ${product.quantity}
                                                                    </a>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="bg-light fw-bold">
                                                                    <i
                                                                        class="fas fa-map-marker-alt text-primary me-2"></i>Sold
                                                                </td>
                                                                <td class="px-4 py-3">${product.sold}</td>
                                                            </tr>
                                                            <tr>
                                                                <td class="bg-light fw-bold">
                                                                    <i
                                                                        class="fas fa-calendar text-primary me-2"></i>Factory
                                                                </td>
                                                                <td class="px-4 py-3">
                                                                    <span
                                                                        class="badge bg-success">${product.factory}</span>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="bg-light fw-bold">
                                                                    <i
                                                                        class="fas fa-calendar text-primary me-2"></i>Target
                                                                </td>
                                                                <td class="px-4 py-3">
                                                                    <span
                                                                        class="badge bg-success">${product.target}</span>
                                                                </td>
                                                            </tr>


                                                            <tr>
                                                                <td class="bg-light fw-bold">
                                                                    <i
                                                                        class="fas fa-calendar text-primary me-2"></i>Image
                                                                </td>
                                                                <td class="px-4 py-3">
                                                                    <img src="/images/products/${product.image}"
                                                                        alt="Image" class="img-fluid"
                                                                        style="max-width: 100px; max-height: 100px;">
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
                                                                <a href="/admin/product/edit/${product.id}"
                                                                    class="btn btn-warning btn-sm me-3">
                                                                    <i class="fas fa-edit"></i> Edit Product
                                                                </a>
                                                                <form action="/admin/product/delete/${product.id}"
                                                                    method="POST"
                                                                    onsubmit="return confirm('You are sure to delete this user?');"
                                                                    style="display: inline-block; margin: 0;">
                                                                    <button type="submit"
                                                                        class="btn btn-danger btn-sm me-3">
                                                                        <i class="fas fa-trash"></i> Delete
                                                                    </button>
                                                                </form>
                                                                <a href="/admin/product" class="btn btn-info btn-sm">
                                                                    <i class="fas fa-list"></i> All Products
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
                                                    <h5 class="text-muted">Product not found</h5>
                                                    <p class="text-muted">The requested user does not exist.</p>
                                                    <a href="/admin/product" class="btn btn-primary btn-custom">
                                                        <i class="fas fa-arrow-left"></i> Back to List
                                                    </a>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                                <!-- Add to Cart Form -->
                                <div class="row mb-4">
                                    <div class="col-md-6">
                                        <form action="/cart/add/${product.id}" method="POST">
                                            <div class="input-group mb-3">
                                                <label class="input-group-text" for="quantity">Số lượng:</label>
                                                <input type="number" class="form-control" id="quantity" name="quantity"
                                                    value="1" min="1" max="10">
                                                <button class="btn btn-primary" type="submit">
                                                    <i class="fas fa-shopping-cart"></i> Thêm vào giỏ
                                                </button>
                                            </div>
                                        </form>
                                    </div>
                                </div>

                                <!-- Success/Error Messages -->
                                <c:if test="${param.success != null}">
                                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                                        <strong>Thành công!</strong> Đã thêm sản phẩm vào giỏ hàng.
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