<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>


                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Edit Product</title>
                    <link href="/css/styles.css" rel="stylesheet" />
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
                        rel="stylesheet">
                    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
                        crossorigin="anonymous"></script>
                    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
                    <link href="/css/main.css" rel="stylesheet" />
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
                                        <h2 class="text-dark fw-bold">Edit a product</h2>
                                    </div>
                                </div>
                                <!-- Breadcrumb Section -->
                                <nav aria-label="breadcrumb">
                                    <ol class="breadcrumb">
                                        <li class="breadcrumb-item"><a href="/admin">Admin</a></li>
                                        <li class="breadcrumb-item"><a href="/admin/product">Products</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">Edit</li>
                                    </ol>
                                </nav>
                                <!-- Success/Error Message -->
                                <c:if test="${not empty success}">
                                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                                        <i class="fas fa-check-circle"></i> ${success}
                                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                    </div>
                                </c:if>
                                <c:if test="${not empty error}">
                                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                        <i class="fas fa-exclamation-circle"></i> ${error}
                                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                    </div>
                                </c:if>
                                <!-- Create Product Section -->
                                <div class="container mb-4 justify-content-center">
                                    <div class="row justify-content-center">
                                        <div class="col-md-8">
                                            <div class="mb-3">
                                                <h3>Edit product</h3>
                                            </div>
                                            <div class="card border-1 shadow-sm">
                                                <div class="card-body">
                                                    <form:form action="/admin/product/edit/${product.id}" method="POST"
                                                        modelAttribute="product" enctype="multipart/form-data">
                                                        <!-- Row 1: Name & Price -->
                                                        <div class="row mb-3">
                                                            <div class=" col-12 col-md-6">
                                                                <form:label path="name" cssClass="form-label fw-medium">
                                                                    Name:
                                                                </form:label>
                                                                <form:input path="name" type="text"
                                                                    cssClass="form-control form-control-lg" />
                                                                <form:errors path="name"
                                                                    cssClass="text-danger small d-block mt-1" />
                                                            </div>
                                                            <div class=" col-12 col-md-6">
                                                                <form:label path="price"
                                                                    cssClass="form-label fw-medium">
                                                                    Price:
                                                                </form:label>
                                                                <div class="input-group">
                                                                    <form:input path="price" type="text" id="price"
                                                                        cssClass="form-control form-control-lg"
                                                                        placeholder="Nhập giá sản phẩm" />
                                                                    <span class="input-group-text">VNĐ</span>
                                                                    <form:errors path="price"
                                                                        cssClass="text-danger small d-block mt-1" />
                                                                </div>

                                                                <small class="text-muted">Ví dụ: 15000000 (15 triệu
                                                                    VNĐ)</small>
                                                            </div>
                                                        </div>

                                                        <!-- Row 2: Quantity & Sold -->
                                                        <div class="row mb-3">
                                                            <div class=" col-12 col-md-6">
                                                                <form:label path="quantity"
                                                                    cssClass="form-label fw-medium">
                                                                    Quantity:</form:label>
                                                                <form:input path="quantity" type="number"
                                                                    cssClass="form-control form-control-lg" />
                                                                <form:errors path="quantity"
                                                                    cssClass="text-danger small d-block mt-1" />
                                                            </div>
                                                            <div class=" col-12 col-md-6">
                                                                <form:label path="sold" cssClass="form-label fw-medium">
                                                                    Sold:
                                                                </form:label>
                                                                <form:input path="sold" type="number"
                                                                    cssClass="form-control form-control-lg" />
                                                                <form:errors path="sold"
                                                                    cssClass="text-danger small d-block mt-1" />
                                                            </div>
                                                        </div>

                                                        <!-- Row 3: Factory & Target -->
                                                        <div class="row mb-3">
                                                            <div class=" col-12 col-md-6">
                                                                <form:label path="factory"
                                                                    cssClass="form-label fw-medium">
                                                                    Factory:</form:label>
                                                                <form:select path="factory"
                                                                    cssClass="form-select form-control-lg">
                                                                    <form:option value="Dell" label="Dell" />
                                                                    <form:option value="Apple" label="Apple" />
                                                                    <form:option value="Samsung" label="Samsung" />
                                                                    <form:option value="Lenovo" label="Lenovo" />
                                                                    <form:option value="Toshiba" label="Toshiba" />
                                                                </form:select>
                                                                <form:errors path="factory"
                                                                    cssClass="text-danger small d-block mt-1" />
                                                            </div>
                                                            <div class=" col-12 col-md-6">
                                                                <form:label path="target"
                                                                    cssClass="form-label fw-medium">
                                                                    Target:
                                                                </form:label>
                                                                <form:select path="target"
                                                                    cssClass="form-select form-control-lg">
                                                                    <form:option value="Developer" label="Developer" />
                                                                    <form:option value="Sinh viên" label="Sinh viên" />
                                                                    <form:option value="Office" label="Office" />
                                                                    <form:option value="Gaming" label="Gaming" />
                                                                    <form:option value="Designer" label="Designer" />
                                                                </form:select>
                                                                <form:errors path="target"
                                                                    cssClass="text-danger small d-block mt-1" />
                                                            </div>
                                                        </div>

                                                        <!-- Row 4: Short Description -->
                                                        <div class="row mb-3">
                                                            <div class="col-md-12">
                                                                <form:label path="shortDesc" cssClass="form-label">Short
                                                                    Description:
                                                                </form:label>
                                                                <form:textarea path="shortDesc" rows="2"
                                                                    cssClass="form-control form-control-lg" />
                                                                <form:errors path="shortDesc"
                                                                    cssClass="text-danger small d-block mt-1" />
                                                            </div>
                                                        </div>

                                                        <!-- Row 5: Detail Description -->
                                                        <div class="row mb-3">
                                                            <div class="col-md-12">
                                                                <form:label path="detailDesc" cssClass="form-label">
                                                                    Detail
                                                                    Description:
                                                                </form:label>
                                                                <form:textarea path="detailDesc" rows="4"
                                                                    cssClass="form-control form-control-lg" />
                                                                <form:errors path="detailDesc"
                                                                    cssClass="text-danger small d-block mt-1" />
                                                            </div>
                                                        </div>

                                                        <!-- Row 6: Image -->
                                                        <div class="row mb-4">
                                                            <div class="col-md-6">
                                                                <label class="form-label fw-medium">Image:</label>
                                                                <div class="input-group">
                                                                    <input type="file"
                                                                        class="form-control form-control-lg"
                                                                        name="imageFile" id="imageFile"
                                                                        accept="image/png, image/jpeg, image/jpg" />
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <!-- Row 7: Image Preview -->
                                                        <div class="row mb-3">
                                                            <div class="col-12 text-center">
                                                                <img style="max-height: 250px; display: none; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1);"
                                                                    alt="image preview" id="imagePreview" />
                                                            </div>
                                                        </div>

                                                        <div>
                                                            <button type="submit" class="btn btn-primary">Edit</button>
                                                        </div>
                                                    </form:form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                        </main>
                        <jsp:include page="../layout/footer.jsp" />
                    </div>
                    <!-- Script Section -->
                    <script>
                        $(function () {
                            // Image preview
                            $('#imageFile').on('change', function (e) {
                                const file = this.files && this.files[0];
                                const $preview = $('#imagePreview');
                                if (file && file.type.match('image.*')) {
                                    const imgURL = URL.createObjectURL(file);
                                    $preview.attr('src', imgURL).show();
                                } else {
                                    $preview.hide().removeAttr('src');
                                }
                            });

                            // Price input validation - only allow numbers
                            $('#price').on('input', function () {
                                // Remove non-numeric characters
                                let value = this.value.replace(/[^0-9]/g, '');
                                this.value = value;
                            });

                            // Price input formatting - add thousand separators for display
                            $('#price').on('blur', function () {
                                let value = this.value.replace(/[^0-9]/g, '');
                                if (value) {
                                    // Store raw value for form submission
                                    $(this).data('raw-value', value);
                                    // Display formatted value
                                    this.value = new Intl.NumberFormat('vi-VN').format(value);
                                }
                            });

                            // Remove formatting before form submission
                            $('#price').closest('form').on('submit', function () {
                                const priceInput = $('#price');
                                const rawValue = priceInput.data('raw-value') || priceInput.val().replace(/[^0-9]/g, '');
                                priceInput.val(rawValue);
                            });
                        });
                    </script>

                </body>

                </html>