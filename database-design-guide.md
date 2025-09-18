# Hướng dẫn Thiết kế Database cho Hệ thống Laptop Shop

## 1. Cách xác định các Table cần thiết

### Phương pháp phân tích:

#### A. Phân tích chức năng nghiệp vụ
```
Laptop Shop cần quản lý:
- 👥 Users (Người dùng)
- 💻 Products (Sản phẩm laptop)
- 🛒 Orders (Đơn hàng)
- 📦 Order Items (Chi tiết đơn hàng)
- 📂 Categories (Danh mục sản phẩm)
- ⭐ Reviews (Đánh giá sản phẩm)
- 💳 Payments (Thanh toán)
- 🚚 Shipping (Vận chuyển)
```

#### B. Phân tích từ User Stories
```
1. "Tôi muốn đăng ký tài khoản" → Users table
2. "Tôi muốn xem danh sách laptop" → Products table
3. "Tôi muốn mua laptop" → Orders + Order Items tables
4. "Tôi muốn đánh giá sản phẩm" → Reviews table
5. "Tôi muốn thanh toán" → Payments table
```

#### C. Phân tích từ Use Cases
```
- Quản lý người dùng → Users
- Quản lý sản phẩm → Products, Categories
- Quản lý đơn hàng → Orders, Order Items
- Quản lý thanh toán → Payments
- Quản lý vận chuyển → Shipping
```

## 2. Cách xác định mối quan hệ giữa các Table

### Các loại mối quan hệ:

#### A. One-to-Many (1:N)
```
Users (1) ←→ (N) Orders
- 1 user có thể có nhiều orders
- 1 order chỉ thuộc về 1 user

Categories (1) ←→ (N) Products
- 1 category có thể có nhiều products
- 1 product chỉ thuộc về 1 category
```

#### B. Many-to-Many (N:N)
```
Products (N) ←→ (N) Orders
- 1 product có thể có trong nhiều orders
- 1 order có thể chứa nhiều products
- Cần bảng trung gian: Order Items

Users (N) ←→ (N) Products (Reviews)
- 1 user có thể review nhiều products
- 1 product có thể được review bởi nhiều users
```

#### C. One-to-One (1:1)
```
Users (1) ←→ (1) User Profiles
- 1 user có 1 profile
- 1 profile thuộc về 1 user
```

### Cách xác định mối quan hệ:

#### 1. Phân tích câu hỏi
```
- "1 User có thể có bao nhiêu Orders?" → Nhiều → 1:N
- "1 Order có thể thuộc về bao nhiêu Users?" → 1 → 1:N
- "1 Product có thể có trong bao nhiêu Orders?" → Nhiều → N:N
- "1 Order có thể chứa bao nhiêu Products?" → Nhiều → N:N
```

#### 2. Sử dụng ERD (Entity Relationship Diagram)
```
Users ----< Orders
  |           |
  |           |
  v           v
Reviews    Order Items
  |           |
  |           |
  v           v
Products >---< Categories
```

## 3. Cách xác định thuộc tính của các Table

### Phương pháp phân tích:

#### A. Phân tích từ yêu cầu nghiệp vụ
```
User cần lưu:
- Thông tin cá nhân: id, email, password, fullName, phoneNumber, address
- Thông tin hệ thống: createdAt, updatedAt, status
- Thông tin bảo mật: role, isActive
```

#### B. Phân tích từ form input
```
Form đăng ký User:
- Email (required)
- Password (required)
- Full Name (required)
- Phone Number (optional)
- Address (optional)
```

#### C. Phân tích từ business rules
```
Product cần lưu:
- Thông tin cơ bản: id, name, description, price
- Thông tin kỹ thuật: brand, model, specifications
- Thông tin kinh doanh: stock, discount, status
- Thông tin hệ thống: createdAt, updatedAt
```

### Các loại thuộc tính thường gặp:

#### 1. Thuộc tính định danh (Primary Key)
- `id`: Khóa chính, tự động tăng
- `uuid`: Khóa chính dạng UUID

#### 2. Thuộc tính nghiệp vụ
- `name`, `title`, `description`: Thông tin mô tả
- `price`, `amount`, `quantity`: Thông tin số liệu
- `status`, `type`, `category`: Thông tin phân loại

#### 3. Thuộc tính hệ thống
- `created_at`, `updated_at`: Thời gian tạo/cập nhật
- `created_by`, `updated_by`: Người tạo/cập nhật
- `is_active`, `is_deleted`: Trạng thái hoạt động

#### 4. Thuộc tính liên kết (Foreign Key)
- `user_id`: Liên kết đến bảng Users
- `category_id`: Liên kết đến bảng Categories
- `order_id`: Liên kết đến bảng Orders

## Quy trình thiết kế Database

### Bước 1: Phân tích yêu cầu
```
1. Xác định các chức năng chính
2. Xác định các đối tượng cần quản lý
3. Xác định các mối quan hệ
```

### Bước 2: Tạo ERD
```
1. Vẽ các entities (tables)
2. Vẽ các relationships
3. Xác định cardinality (1:1, 1:N, N:N)
```

### Bước 3: Thiết kế chi tiết
```
1. Xác định attributes cho mỗi table
2. Xác định data types
3. Xác định constraints (NOT NULL, UNIQUE, etc.)
4. Xác định indexes
```

### Bước 4: Normalization
```
1. Kiểm tra 1NF (First Normal Form)
2. Kiểm tra 2NF (Second Normal Form)
3. Kiểm tra 3NF (Third Normal Form)
```

## Công cụ hỗ trợ

### 1. ERD Tools
- **Lucidchart**
- **Draw.io**
- **MySQL Workbench**
- **pgAdmin**

### 2. Database Design Tools
- **MySQL Workbench**
- **phpMyAdmin**
- **DBeaver**
- **DataGrip**

## Nguyên tắc thiết kế Database

### 1. Naming Convention
- **Tables**: Số ít, snake_case (users, products, order_items)
- **Columns**: snake_case (user_id, created_at, is_active)
- **Indexes**: idx_tablename_columnname
- **Foreign Keys**: fk_tablename_referencedtable

### 2. Data Types
- **ID**: BIGINT AUTO_INCREMENT
- **String**: VARCHAR(255) cho tên, TEXT cho mô tả
- **Number**: DECIMAL(10,2) cho tiền, INT cho số lượng
- **Date/Time**: TIMESTAMP với timezone
- **Boolean**: BOOLEAN hoặc TINYINT(1)

### 3. Constraints
- **Primary Key**: Mỗi table phải có
- **Foreign Key**: Đảm bảo tính toàn vẹn dữ liệu
- **NOT NULL**: Các trường bắt buộc
- **UNIQUE**: Các trường không được trùng lặp
- **CHECK**: Ràng buộc giá trị hợp lệ

### 4. Indexes
- **Primary Key**: Tự động tạo index
- **Foreign Key**: Tạo index cho performance
- **Frequently Queried Columns**: Tạo index cho các cột thường xuyên query
- **Composite Indexes**: Tạo index cho nhiều cột cùng lúc

## Best Practices

### 1. Database Design
- **Normalize** nhưng không over-normalize
- **Denormalize** khi cần thiết cho performance
- **Use appropriate data types**
- **Plan for scalability**

### 2. Performance
- **Index strategically**
- **Avoid SELECT \***
- **Use pagination for large datasets**
- **Optimize queries**

### 3. Security
- **Validate input data**
- **Use parameterized queries**
- **Implement proper access control**
- **Encrypt sensitive data**

### 4. Maintenance
- **Document your schema**
- **Version control database changes**
- **Regular backups**
- **Monitor performance**

## Tóm tắt

### 1. Xác định Tables
- Phân tích chức năng nghiệp vụ
- Phân tích user stories
- Phân tích use cases

### 2. Xác định Relationships
- Phân tích câu hỏi "1 X có thể có bao nhiêu Y?"
- Sử dụng ERD
- Xác định cardinality

### 3. Xác định Attributes
- Phân tích yêu cầu nghiệp vụ
- Phân tích form input
- Phân tích business rules

**Kết quả**: Database được thiết kế hoàn chỉnh, đáp ứng yêu cầu nghiệp vụ và có thể mở rộng trong tương lai.
