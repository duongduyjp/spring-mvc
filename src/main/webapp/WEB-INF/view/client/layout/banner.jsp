<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <!-- Hero Start -->
        <div class="container-fluid py-5 mb-5 hero-header">
            <div class="container py-5">
                <div class="row g-5 align-items-center">
                    <div class="col-md-12 col-lg-7">
                        <h4 class="mb-3 text-secondary">100% Laptops</h4>
                        <h1 class="mb-5 display-3 text-primary">Laptops</h1>
                        <div class="position-relative mx-auto">
                            <input class="form-control border-2 border-secondary w-75 py-3 px-4 rounded-pill"
                                type="number" placeholder="Search">
                            <button type="submit"
                                class="btn btn-primary border-2 border-secondary py-3 px-4 position-absolute rounded-pill text-white h-100"
                                style="top: 0; right: 25%;">Search</button>
                        </div>
                    </div>
                    <div class="col-md-12 col-lg-5">
                        <div id="carouselId" class="carousel slide position-relative" data-bs-ride="carousel">
                            <div class="carousel-inner" role="listbox">
                                <c:choose>
                                    <c:when test="${not empty featuredProducts}">
                                        <c:forEach var="featuredProduct" items="${featuredProducts}" varStatus="status">
                                            <div class="carousel-item ${status.index == 0 ? 'active' : ''} rounded">
                                                <div class="position-relative">
                                                    <c:choose>
                                                        <c:when
                                                            test="${featuredProduct.image != null && featuredProduct.image.startsWith('http')}">
                                                            <img src="${featuredProduct.image}"
                                                                class="img-fluid w-100 rounded"
                                                                alt="${featuredProduct.name}"
                                                                style="height: 350px; object-fit: cover;">
                                                        </c:when>
                                                        <c:when test="${featuredProduct.image != null}">
                                                            <img src="/images/products/${featuredProduct.image}"
                                                                class="img-fluid w-100 rounded"
                                                                alt="${featuredProduct.name}"
                                                                style="height: 350px; object-fit: cover;">
                                                        </c:when>
                                                        <c:otherwise>
                                                            <img src="https://via.placeholder.com/600x350/CCCCCC/FFFFFF?text=Featured+Product"
                                                                class="img-fluid w-100 rounded" alt="Featured Product"
                                                                style="height: 350px; object-fit: cover;">
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <div
                                                        class="carousel-caption d-flex flex-column align-items-center justify-content-center">
                                                        <h5 class="text-white fs-4 fw-bold">${featuredProduct.name}</h5>
                                                        <p class="text-white-50">${featuredProduct.target}</p>
                                                        <a href="/product/${featuredProduct.id}"
                                                            class="btn btn-primary px-4 py-2 text-white rounded">
                                                            Xem chi tiết
                                                        </a>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <!-- Fallback nếu không có sản phẩm -->
                                        <div class="carousel-item active rounded">
                                            <img src="https://via.placeholder.com/600x350/007BFF/FFFFFF?text=Laptop+Shop"
                                                class="img-fluid w-100 rounded" alt="Laptop Shop"
                                                style="height: 350px; object-fit: cover;">
                                            <div
                                                class="carousel-caption d-flex flex-column align-items-center justify-content-center">
                                                <h5 class="text-white fs-4 fw-bold">Laptop Shop</h5>
                                                <a href="#" class="btn btn-primary px-4 py-2 text-white rounded">Khám
                                                    phá</a>
                                            </div>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <button class="carousel-control-prev" type="button" data-bs-target="#carouselId"
                                data-bs-slide="prev">
                                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                <span class="visually-hidden">Previous</span>
                            </button>
                            <button class="carousel-control-next" type="button" data-bs-target="#carouselId"
                                data-bs-slide="next">
                                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                <span class="visually-hidden">Next</span>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Hero End -->