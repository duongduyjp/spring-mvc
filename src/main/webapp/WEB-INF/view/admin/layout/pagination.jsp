<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
        <%@ page contentType="text/html" pageEncoding="UTF-8" %>

            <!-- Pagination Component -->
            <c:if test="${totalPages > 1}">
                <div class="d-flex justify-content-between align-items-center p-3">
                    <!-- Info Display -->
                    <div class="text-muted">
                        Hiển thị ${(currentPage * pageSize) + 1} -
                        ${(currentPage + 1) * pageSize > totalElements ? totalElements : (currentPage + 1) * pageSize}
                        trong tổng số ${totalElements} ${empty itemName ? 'mục' : itemName}
                    </div>

                    <!-- Pagination Controls -->
                    <nav aria-label="Pagination">
                        <ul class="pagination mb-0">
                            <!-- Previous Button -->
                            <li class="page-item ${currentPage == 0 ? 'disabled' : ''}">
                                <a class="page-link"
                                    href="${paginationUrl}?page=${currentPage - 1}&size=${pageSize}${empty queryParams ? '' : '&' + queryParams}">
                                    <i class="fas fa-chevron-left"></i>
                                </a>
                            </li>

                            <!-- Page Numbers -->
                            <c:forEach begin="0" end="${totalPages - 1}" var="pageNum">
                                <c:choose>
                                    <c:when test="${pageNum == currentPage}">
                                        <li class="page-item active">
                                            <span class="page-link">${pageNum + 1}</span>
                                        </li>
                                    </c:when>
                                    <c:when test="${pageNum >= currentPage - 2 && pageNum <= currentPage + 2}">
                                        <li class="page-item">
                                            <a class="page-link"
                                                href="${paginationUrl}?page=${pageNum}&size=${pageSize}${empty queryParams ? '' : '&' + queryParams}">
                                                ${pageNum + 1}
                                            </a>
                                        </li>
                                    </c:when>
                                    <c:when test="${pageNum == 0 || pageNum == totalPages - 1}">
                                        <li class="page-item">
                                            <a class="page-link"
                                                href="${paginationUrl}?page=${pageNum}&size=${pageSize}${empty queryParams ? '' : '&' + queryParams}">
                                                ${pageNum + 1}
                                            </a>
                                        </li>
                                    </c:when>
                                    <c:when test="${pageNum == currentPage - 3 || pageNum == currentPage + 3}">
                                        <li class="page-item disabled">
                                            <span class="page-link">...</span>
                                        </li>
                                    </c:when>
                                </c:choose>
                            </c:forEach>

                            <!-- Next Button -->
                            <li class="page-item ${currentPage == totalPages - 1 ? 'disabled' : ''}">
                                <a class="page-link"
                                    href="${paginationUrl}?page=${currentPage + 1}&size=${pageSize}${empty queryParams ? '' : '&' + queryParams}">
                                    <i class="fas fa-chevron-right"></i>
                                </a>
                            </li>
                        </ul>
                    </nav>

                    <!-- Page Size Selector -->
                    <div class="d-flex align-items-center">
                        <label class="form-label me-2 mb-0">Hiển thị:</label>
                        <select class="form-select form-select-sm" style="width: auto;"
                            onchange="changePageSize('${paginationUrl}', this.value, '${queryParams}')">
                            <option value="5" ${pageSize==5 ? 'selected' : '' }>5</option>
                            <option value="10" ${pageSize==10 ? 'selected' : '' }>10</option>
                            <option value="20" ${pageSize==20 ? 'selected' : '' }>20</option>
                            <option value="50" ${pageSize==50 ? 'selected' : '' }>50</option>
                        </select>
                    </div>
                </div>
            </c:if>

            <!-- Pagination JavaScript -->
            <script>
                function changePageSize(url, newSize, queryParams) {
                    const params = queryParams ? '&' + queryParams : '';
                    window.location.href = url + '?page=0&size=' + newSize + params;
                }
            </script>