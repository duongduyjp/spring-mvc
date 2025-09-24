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
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.Size;

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

    @NotBlank(message = "Tên sản phẩm không được để trống")
    private String name;

    @Size(max = 1000, message = "Mô tả chi tiết không được vượt quá 1000 ký tự")
    @NotBlank(message = "Mô tả chi tiết không được để trống")
    private String detailDesc;

    @Size(max = 255, message = "Mô tả ngắn không được vượt quá 255 ký tự")
    @NotBlank(message = "Mô tả ngắn không được để trống")
    private String shortDesc;

    @NotNull(message = "Giá không được để trống")
    @Min(value = 0, message = "Giá không được nhỏ hơn 0")
    private double price;

    @NotNull(message = "Số lượng không được để trống")
    @Min(value = 0, message = "Số lượng không được nhỏ hơn 0")
    private long quantity;

    @NotNull(message = "Số lượng đã bán không được để trống")
    @Min(value = 0, message = "Số lượng đã bán không được nhỏ hơn 0")
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
