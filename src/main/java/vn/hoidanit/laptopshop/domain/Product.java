package vn.hoidanit.laptopshop.domain;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "products")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor

public class Product {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    private String name;
    private String detailDesc;
    private String shortDesc;
    private double price;
    private long quantity;
    private long sold;
    private String image;
    private String factory;
    private String target;

    @Override
    public String toString() {
        return String.format("Product{id=%d, name='%s', price=%,.0f VND, quantity=%d, sold=%d}",
                id, name, price, quantity, sold);
    }
}
