<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
                <html lang="en">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=, initial-scale=1.0">
                    <title>Document</title>
                    <link href="/css/styles.css" rel="stylesheet" />
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
                        rel="stylesheet">
                    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
                        crossorigin="anonymous"></script>
                    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
                    <link href="/css/main.css" rel="stylesheet" />
                    <style>
                        /* Đảm bảo form controls có cùng chiều cao */
                        .form-control-lg,
                        .form-select.form-control-lg {
                            height: 3rem;
                            line-height: 1.5;
                        }

                        /* Đồng bộ padding */
                        .form-control-lg,
                        .form-select.form-control-lg {
                            padding: 0.75rem 1rem;
                        }
                    </style>
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
                                        <h2 class="text-dark fw-bold">Update a order</h2>
                                    </div>
                                </div>
                                <!-- Breadcrumb Section -->
                                <nav aria-label="breadcrumb">
                                    <ol class="breadcrumb">
                                        <li class="breadcrumb-item"><a href="/admin">Admin</a></li>
                                        <li class="breadcrumb-item"><a href="/admin/order">Orders</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">Update</li>
                                    </ol>
                                </nav>

                                <!-- Create Product Section -->
                                <div class="container mb-4 justify-content-center">
                                    <div class="row justify-content-center">
                                        <div class="col-md-8">
                                            <div class="mb-3">
                                                <h3>Update order</h3>
                                            </div>
                                            <div class="card border-1 shadow-sm">
                                                <div class="card-body">
                                                    <form:form action="/admin/order/edit/${order.id}" method="POST"
                                                        modelAttribute="order" enctype="multipart/form-data">
                                                        <!-- Row 1: Name & Price -->
                                                        <div class="row mb-3">
                                                            <div class="col-12 col-md-6">
                                                                <form:label path="id" cssClass="form-label fw-medium">
                                                                    Order ID:
                                                                </form:label>
                                                                <form:input path="id" type="text"
                                                                    cssClass="form-control form-control-lg"
                                                                    readonly="true" />
                                                                <form:errors path="id"
                                                                    cssClass="text-danger small d-block mt-1" />
                                                            </div>
                                                            <div class="col-12 col-md-6">
                                                                <form:label path="status"
                                                                    cssClass="form-label fw-medium">
                                                                    Status:
                                                                </form:label>
                                                                <form:select path="status" id="status"
                                                                    cssClass="form-select form-control-lg">
                                                                    <form:option value="Đã đặt hàng">Đã đặt hàng
                                                                    </form:option>
                                                                    <form:option value="Hoàn tất">Hoàn tất
                                                                    </form:option>
                                                                    <form:option value="Đã huỷ">Đã huỷ</form:option>
                                                                </form:select>
                                                                <form:errors path="status"
                                                                    cssClass="text-danger small d-block mt-1" />
                                                            </div>
                                                            <input type="hidden" name="${_csrf.parameterName}"
                                                                value="${_csrf.token}" />
                                                        </div>
                                                </div>

                                                <div class="p-3">
                                                    <button type="submit" class="btn btn-primary">Update</button>
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