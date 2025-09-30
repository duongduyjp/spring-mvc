package vn.hoidanit.laptopshop.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import vn.hoidanit.laptopshop.repository.OrderRepository;
import vn.hoidanit.laptopshop.repository.OrderDetailRepository;
import vn.hoidanit.laptopshop.repository.CartRepository;
import vn.hoidanit.laptopshop.repository.CartItemRepository;
import vn.hoidanit.laptopshop.domain.Order;
import vn.hoidanit.laptopshop.domain.OrderDetail;
import vn.hoidanit.laptopshop.domain.Cart;
import vn.hoidanit.laptopshop.domain.CartItem;
import vn.hoidanit.laptopshop.domain.User;
import java.util.List;
import java.sql.Date;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;

@Service
public class OrderService {
    private final OrderRepository orderRepository;
    private final OrderDetailRepository orderDetailRepository;
    private final CartRepository cartRepository;
    private final CartItemRepository cartItemRepository;

    public OrderService(OrderRepository orderRepository,
            OrderDetailRepository orderDetailRepository,
            CartRepository cartRepository,
            CartItemRepository cartItemRepository) {
        this.orderRepository = orderRepository;
        this.orderDetailRepository = orderDetailRepository;
        this.cartRepository = cartRepository;
        this.cartItemRepository = cartItemRepository;
    }

    @Transactional
    public Order createOrderFromCart(User user, String shippingName,
            String shippingAddress, String shippingPhone) {
        // 1. Lấy cart của user
        Cart cart = cartRepository.findByUser(user);
        if (cart == null || cart.getCartItems().isEmpty()) {
            throw new RuntimeException("Giỏ hàng trống, không thể đặt hàng");
        }

        // 2. Tính tổng tiền
        double totalPrice = 0;
        for (CartItem item : cart.getCartItems()) {
            totalPrice += item.getUnitPrice().doubleValue() * item.getQuantity();
        }

        // 3. Tạo Order
        Order order = new Order();
        order.setUser(user);
        order.setTotalPrice(totalPrice);
        order.setShippingName(shippingName);
        order.setShippingAddress(shippingAddress);
        order.setShippingPhone(shippingPhone);
        order.setStatus("Đã đặt hàng");
        order.setCreatedAt(new Date(System.currentTimeMillis()));

        // 4. Lưu Order
        order = orderRepository.save(order);

        // 5. Tạo OrderDetails từ CartItems
        for (CartItem cartItem : cart.getCartItems()) {
            OrderDetail orderDetail = new OrderDetail();
            orderDetail.setOrder(order);
            orderDetail.setProduct(cartItem.getProduct());
            orderDetail.setPrice(cartItem.getUnitPrice().doubleValue());
            orderDetail.setQuantity(cartItem.getQuantity());

            orderDetailRepository.save(orderDetail);
        }

        // 6. Xóa tất cả CartItems
        cartItemRepository.deleteAll(cart.getCartItems());
        cart.getCartItems().clear();
        cartRepository.save(cart);

        return order;
    }

    public List<Order> getOrdersByUser(User user) {
        return orderRepository.findByUserOrderByIdDesc(user);
    }

    public Order getOrderById(Long id) {
        return orderRepository.findById(id).orElse(null);
    }

    public Page<Order> getAllOrders(int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        return orderRepository.findAll(pageable);
    }

    public long getTotalOrderCount() {
        return orderRepository.count();
    }

    // Update status of order
    public void updateOrder(Long id, Order order) {
        Order existingOrder = orderRepository.findById(id).orElse(null);
        if (existingOrder == null) {
            throw new RuntimeException("Order not found with ID: " + id);
        }
        existingOrder.setStatus(order.getStatus());
        orderRepository.save(existingOrder);
    }

    // Delete order
    @Transactional
    public void deleteOrder(Long id) {
        Order order = orderRepository.findById(id).orElse(null);
        if (order == null) {
            throw new RuntimeException("Order not found with ID: " + id);
        }

        // Xóa tất cả OrderDetails trước
        List<OrderDetail> orderDetails = orderDetailRepository.findByOrder(order);
        orderDetailRepository.deleteAll(orderDetails);

        // Sau đó xóa Order
        orderRepository.deleteById(id);
    }
}