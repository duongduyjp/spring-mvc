package vn.hoidanit.laptopshop.domain;

import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import jakarta.persistence.FetchType;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.CascadeType;
import jakarta.persistence.OneToMany;
import java.util.List;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import java.util.ArrayList;
import jakarta.persistence.OneToOne;

@Entity
@Table(name = "carts")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Cart {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @OneToMany(mappedBy = "cart", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<CartItem> cartItems = new ArrayList<>();

    public void addItem(CartItem item) {
        item.setCart(this);
        this.cartItems.add(item);
    }

    public void removeItem(CartItem item) {
        item.setCart(null);
        this.cartItems.remove(item);
    }
}
