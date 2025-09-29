/**
 * Cart AJAX Operations
 * Handles Add to Cart functionality without page reload
 */

$(document).ready(function () {
    // Load cart count khi trang load
    loadCartCount();

    // Lắng nghe sự kiện click cho tất cả button add-to-cart
    $(document).on('click', '.btn-add-to-cart', function (e) {
        e.preventDefault();

        const button = $(this);
        const productId = button.data('product-id');
        const quantity = button.data('quantity') || 1;

        // Disable button để tránh click nhiều lần
        button.prop('disabled', true);
        const originalText = button.html();
        button.html('<span class="spinner-border spinner-border-sm me-2" role="status"></span>Đang thêm...');

        // Lấy CSRF token
        const csrfToken = $('meta[name="_csrf"]').attr('content');
        const csrfHeader = $('meta[name="_csrf_header"]').attr('content');

        if (!csrfToken || !csrfHeader) {
            showToast('Lỗi bảo mật, vui lòng tải lại trang', 'danger');
            resetButton(button, originalText);
            return;
        }

        // Gửi AJAX request
        $.ajax({
            url: '/api/cart/add',
            type: 'POST',
            data: {
                productId: productId,
                quantity: quantity
            },
            beforeSend: function (xhr) {
                xhr.setRequestHeader(csrfHeader, csrfToken);
            },
            success: function (response) {
                if (response.success) {
                    // Hiển thị thông báo thành công
                    showToast(response.message, 'success');

                    // Cập nhật cart badge count
                    updateCartBadge(response.cartItemCount);

                    // Animation hiệu ứng
                    button.addClass('btn-success').removeClass('border-secondary');
                    setTimeout(function () {
                        button.removeClass('btn-success').addClass('border-secondary');
                    }, 1500);

                } else {
                    showToast(response.error || 'Có lỗi xảy ra', 'danger');
                }
            },
            error: function (xhr, status, error) {
                if (xhr.status === 401) {
                    showToast('Vui lòng đăng nhập để thêm sản phẩm vào giỏ hàng', 'warning');
                } else {
                    showToast('Có lỗi xảy ra khi thêm sản phẩm', 'danger');
                }
            },
            complete: function () {
                // Reset button sau khi hoàn thành
                resetButton(button, originalText);
            }
        });
    });

    function resetButton(button, originalText) {
        button.prop('disabled', false);
        button.html(originalText);
    }

    function loadCartCount() {
        $.ajax({
            url: '/api/cart/count',
            type: 'POST',
            beforeSend: function (xhr) {
                const csrfToken = $('meta[name="_csrf"]').attr('content');
                const csrfHeader = $('meta[name="_csrf_header"]').attr('content');
                if (csrfToken && csrfHeader) {
                    xhr.setRequestHeader(csrfHeader, csrfToken);
                }
            },
            success: function (response) {
                if (response.success) {
                    updateCartBadge(response.cartItemCount);
                }
            },
            error: function (xhr, status, error) {
                // Silently fail - cart count is not critical
            }
        });
    }


    // Lắng nghe sự kiện cho nút update quantity (+ và -)
    $(document).on('click', '.btn-cart-minus', function (e) {
        e.preventDefault();
        e.stopPropagation();

        const button = $(this);

        // Kiểm tra button có bị disabled không
        if (button.prop('disabled') || button.hasClass('updating')) {
            return;
        }

        const itemId = button.data('item-id');
        const quantityInput = button.closest('.quantity').find('input[data-item-id="' + itemId + '"]');
        const currentQuantity = parseInt(quantityInput.val()) || 1;
        const newQuantity = currentQuantity - 1;

        if (newQuantity < 1) {
            // Nếu quantity < 1 thì xóa item
            removeCartItemAjax(itemId);
        } else {
            updateCartQuantityAjax(itemId, newQuantity);
        }
    });

    $(document).on('click', '.btn-cart-plus', function (e) {
        e.preventDefault();
        e.stopPropagation();

        const button = $(this);

        // Kiểm tra button có bị disabled không
        if (button.prop('disabled') || button.hasClass('updating')) {
            return;
        }

        const itemId = button.data('item-id');
        const quantityInput = button.closest('.quantity').find('input[data-item-id="' + itemId + '"]');
        const currentQuantity = parseInt(quantityInput.val()) || 1;
        const newQuantity = currentQuantity + 1;

        if (newQuantity > 99) {
            showToast('Số lượng không được vượt quá 99', 'warning');
            return;
        }

        updateCartQuantityAjax(itemId, newQuantity);
    });

    // Lắng nghe sự kiện cho nút remove item
    $(document).on('click', '.btn-cart-remove', function (e) {
        e.preventDefault();

        const button = $(this);
        const itemId = button.data('item-id');

        // Xóa trực tiếp không cần confirmation
        removeCartItemAjax(itemId);
    });
});

// Function cập nhật quantity
function updateCartQuantityAjax(itemId, newQuantity) {
    const csrfToken = $('meta[name="_csrf"]').attr('content');
    const csrfHeader = $('meta[name="_csrf_header"]').attr('content');

    if (!csrfToken || !csrfHeader) {
        showToast('Lỗi bảo mật, vui lòng tải lại trang', 'danger');
        return;
    }

    // Disable buttons during update
    const quantityContainer = $(`input[data-item-id="${itemId}"]`).closest('.quantity');
    const buttons = quantityContainer.find('.btn-cart-minus, .btn-cart-plus');

    // Disable buttons và thêm loading state
    buttons.prop('disabled', true);
    buttons.addClass('updating');

    $.ajax({
        url: `/api/cart/update/${itemId}`,
        type: 'POST',
        data: {
            quantity: newQuantity
        },
        beforeSend: function (xhr) {
            xhr.setRequestHeader(csrfHeader, csrfToken);
        },
        success: function (response) {
            if (response.success) {
                showToast(response.message, 'success');
                updateCartUI(itemId, newQuantity, response);
            } else {
                showToast(response.error || 'Có lỗi xảy ra', 'danger');
            }
        },
        error: function (xhr, status, error) {
            if (xhr.status === 401) {
                showToast('Vui lòng đăng nhập để cập nhật giỏ hàng', 'warning');
            } else {
                showToast('Có lỗi xảy ra khi cập nhật', 'danger');
            }
        },
        complete: function () {
            // Re-enable buttons
            buttons.prop('disabled', false);
            buttons.removeClass('updating');
            buttons.find('.spinner-border').remove();
        }
    });
}

// Function xóa item
function removeCartItemAjax(itemId) {
    const csrfToken = $('meta[name="_csrf"]').attr('content');
    const csrfHeader = $('meta[name="_csrf_header"]').attr('content');

    if (!csrfToken || !csrfHeader) {
        showToast('Lỗi bảo mật, vui lòng tải lại trang', 'danger');
        return;
    }

    // Tìm và đánh dấu row đang xóa
    const itemRow = $(`input[data-item-id="${itemId}"]`).closest('tr');
    const removeButton = $(`button[data-item-id="${itemId}"].btn-cart-remove`);

    itemRow.addClass('removing');
    removeButton.prop('disabled', true);

    $.ajax({
        url: `/api/cart/remove/${itemId}`,
        type: 'POST',
        beforeSend: function (xhr) {
            xhr.setRequestHeader(csrfHeader, csrfToken);
        },
        success: function (response) {
            if (response.success) {
                showToast(response.message, 'success');

                // Animation xóa row
                itemRow.fadeOut(500, function () {
                    $(this).remove();

                    // Cập nhật UI sau khi xóa
                    updateCartTotals(response);

                    // Kiểm tra nếu cart trống
                    checkEmptyCart();
                });

            } else {
                itemRow.removeClass('removing');
                removeButton.prop('disabled', false);
                showToast(response.error || 'Có lỗi xảy ra', 'danger');
            }
        },
        error: function (xhr, status, error) {
            itemRow.removeClass('removing');
            removeButton.prop('disabled', false);

            if (xhr.status === 401) {
                showToast('Vui lòng đăng nhập để xóa sản phẩm', 'warning');
            } else {
                showToast('Có lỗi xảy ra khi xóa sản phẩm', 'danger');
            }
        }
    });
}

// Function cập nhật UI sau khi thay đổi quantity
function updateCartUI(itemId, newQuantity, response) {
    // Cập nhật quantity input
    const quantityInput = $(`input[data-item-id="${itemId}"]`);
    quantityInput.val(newQuantity);

    // Cập nhật item total
    if (response.itemTotal) {
        const itemRow = quantityInput.closest('tr');
        const itemTotalCell = itemRow.find('.item-total');
        const formattedTotal = formatCurrency(response.itemTotal) + ' VND';
        itemTotalCell.html(formattedTotal);

        // Animation highlight
        itemTotalCell.addClass('highlight');
        setTimeout(() => itemTotalCell.removeClass('highlight'), 1500);
    }

    // Cập nhật totals
    updateCartTotals(response);
}

// Function cập nhật cart totals
function updateCartTotals(response) {
    // Cập nhật cart badge
    updateCartBadge(response.cartItemCount);

    // Cập nhật total amount
    if (response.totalAmount !== undefined) {
        const totalAmountElements = $('.cart-total-amount');
        const formattedAmount = formatCurrency(response.totalAmount) + ' VND';
        totalAmountElements.html(formattedAmount);

        // Animation highlight totals
        totalAmountElements.addClass('highlight');
        setTimeout(() => totalAmountElements.removeClass('highlight'), 1500);
    }
}

// Function kiểm tra cart trống
function checkEmptyCart() {
    const remainingItems = $('tbody tr:visible').length;
    if (remainingItems === 0) {
        // Hiển thị empty cart message
        const emptyCartHtml = `
            <tr>
                <td colspan="6" class="text-center py-5">
                    <div class="text-muted">
                        <i class="fa fa-shopping-cart fa-3x mb-3"></i>
                        <h5>Giỏ hàng trống</h5>
                        <p>Hãy thêm sản phẩm vào giỏ hàng để tiếp tục mua sắm</p>
                        <a href="/" class="btn btn-primary">Tiếp tục mua sắm</a>
                    </div>
                </td>
            </tr>
        `;
        $('tbody').html(emptyCartHtml);

        // Disable checkout button
        $('.btn-checkout').prop('disabled', true).addClass('text-muted');
    }
}

// Utility function format currency
function formatCurrency(amount) {
    return new Intl.NumberFormat('vi-VN').format(amount);
}

/**
 * Hiển thị Toast notification
 * @param {string} message - Nội dung thông báo
 * @param {string} type - Loại thông báo: success, danger, warning, info
 */
function showToast(message, type = 'info') {
    type = type || 'info';

    const toastId = 'toast-' + Date.now();
    const iconClass = getToastIcon(type);

    const toastHtml = `
        <div id="${toastId}" class="toast align-items-center text-white bg-${type} border-0" role="alert" aria-live="assertive" aria-atomic="true">
            <div class="d-flex">
                <div class="toast-body">
                    <i class="${iconClass} me-2"></i>
                    ${message}
                </div>
                <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
            </div>
        </div>
    `;

    // Thêm toast vào container
    let container = $('#toast-container');
    if (container.length === 0) {
        // Tạo container nếu chưa có
        container = $('<div id="toast-container" class="toast-container position-fixed top-0 end-0 p-3" style="z-index: 9999;"></div>');
        $('body').append(container);
    }

    container.append(toastHtml);

    // Hiển thị toast
    const toast = new bootstrap.Toast(document.getElementById(toastId), {
        autohide: true,
        delay: 4000
    });

    toast.show();

    // Xóa toast khỏi DOM sau khi ẩn
    $('#' + toastId).on('hidden.bs.toast', function () {
        $(this).remove();
    });
}

function getToastIcon(type) {
    const icons = {
        'success': 'fas fa-check-circle',
        'danger': 'fas fa-exclamation-circle',
        'warning': 'fas fa-exclamation-triangle',
        'info': 'fas fa-info-circle'
    };
    return icons[type] || icons['info'];
}

// Function cập nhật cart badge
function updateCartBadge(count) {
    const badge = $('.cart-badge, #cart-count, .cart-count');

    if (badge.length > 0) {
        badge.text(count || 0);
        if (count > 0) {
            badge.show();
        } else {
            badge.hide();
        }

        // Animation cho badge
        badge.addClass('animate__animated animate__pulse');
        setTimeout(function () {
            badge.removeClass('animate__animated animate__pulse');
        }, 1000);
    }
}