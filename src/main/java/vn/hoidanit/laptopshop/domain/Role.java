package vn.hoidanit.laptopshop.domain;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import jakarta.persistence.OneToMany;
import jakarta.persistence.FetchType;
import java.util.Set;
import java.util.HashSet;

@Entity
@Table(name = "roles")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor

public class Role {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    private String name;

    @OneToMany(mappedBy = "role", fetch = FetchType.LAZY)
    private Set<User> users = new HashSet<>();

    @Override
    public String toString() {
        return String.format("Role{id=%d, name='%s'}", id, name);
    }
}
