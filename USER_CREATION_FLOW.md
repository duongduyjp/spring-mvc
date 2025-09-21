# 📋 Tài Liệu Luồng Hoạt Động - Chức Năng Tạo User

## 🎯 Tổng Quan

Chức năng tạo user cho phép admin tạo tài khoản mới với đầy đủ thông tin cá nhân, role và avatar. Hệ thống sử dụng Spring MVC pattern với JSP view engine.

---

## 🔄 Luồng Hoạt Động Chi Tiết

### **1. BƯỚC 1: HIỂN THỊ FORM TẠO USER**

#### **1.1 Client Request**
```
GET /admin/user/create
```

#### **1.2 Server Processing**
**File:** `UserController.java`
```java
@GetMapping("/admin/user/create")
public String showCreateUserForm(Model model) {
    model.addAttribute("user", new User());           // Tạo empty User object
    List<Role> roles = this.roleService.getAllRoles(); // Lấy danh sách roles
    
    // Auto-create default roles nếu chưa có
    if (roles.isEmpty()) {
        Role adminRole = new Role();
        adminRole.setName("ADMIN");
        this.roleService.createRole(adminRole);
        
        Role userRole = new Role();
        userRole.setName("USER");
        this.roleService.createRole(userRole);
        
        roles = this.roleService.getAllRoles();
    }
    
    model.addAttribute("roles", roles);
    return "admin/user/create";                       // Trả về JSP view
}
```

#### **1.3 Database Query**
```sql
-- RoleService.getAllRoles() thực thi:
SELECT r.id, r.name FROM roles r;
```

#### **1.4 View Rendering**
**File:** `/WEB-INF/view/admin/user/create.jsp`

**JSP Engine xử lý:**
1. Load layout components (header, sidebar, footer)
2. Bind empty User object vào form
3. Render dropdown roles từ database
4. Generate HTML form với Spring form tags

**HTML Output:**
```html
<form action="/admin/user/create" method="POST" enctype="multipart/form-data">
    <input type="email" name="email" />
    <input type="password" name="password" />
    <input type="text" name="fullName" />
    <input type="tel" name="phoneNumber" />
    <input type="text" name="address" />
    <select name="roleName">
        <option value="ADMIN">ADMIN</option>
        <option value="USER">USER</option>
    </select>
    <input type="file" name="avatarFile" accept="image/*" />
    <button type="submit">Create</button>
</form>
```

---

### **2. BƯỚC 2: CLIENT SUBMIT FORM**

#### **2.1 User Action**
1. User điền thông tin vào form
2. User chọn avatar file (optional)
3. User click "Create" button

#### **2.2 Browser Processing**
```
POST /admin/user/create
Content-Type: multipart/form-data

Form Data:
- email: "test@gmail.com"
- password: "123456"
- fullName: "Test User"
- phoneNumber: "0123456789"
- address: "Test Address"
- roleName: "ADMIN"
- avatarFile: [binary file data]
```

---

### **3. BƯỚC 3: SERVER XỬ LÝ REQUEST**

#### **3.1 Spring MVC Dispatcher**
1. **DispatcherServlet** nhận request
2. **HandlerMapping** tìm controller method tương ứng
3. **HandlerAdapter** chuẩn bị parameters

#### **3.2 Data Binding & Validation**
**File:** `UserController.java`

```java
@InitBinder
public void initBinder(WebDataBinder binder) {
    // Ignore avatar field để tránh conflict với file upload
    binder.setDisallowedFields("avatar");
}
```

**Spring thực hiện:**
1. **Form Data Binding:** Map form fields → User object
   ```java
   User user = new User();
   user.setEmail("test@gmail.com");
   user.setPassword("123456");
   user.setFullName("Test User");
   user.setPhoneNumber("0123456789");
   user.setAddress("Test Address");
   // avatar field bị ignore bởi @InitBinder
   ```

2. **File Parameter Binding:** 
   ```java
   MultipartFile avatarFile = [file data from form]
   String roleName = "ADMIN"
   ```

3. **Validation:** Spring validate User object theo constraints
   ```java
   BindingResult bindingResult = [validation results]
   ```

#### **3.3 Controller Method Processing**
**File:** `UserController.java`

```java
@PostMapping("/admin/user/create")
public String createUser(Model model, 
                        @ModelAttribute("user") User user,
                        BindingResult bindingResult,
                        @RequestParam("roleName") String roleName,
                        @RequestParam(value = "avatarFile", required = false) MultipartFile avatarFile) {
```

**Xử lý theo 4 bước:**

---

### **4. BƯỚC 4: VALIDATION CHECK**

```java
// 1. Kiểm tra validation errors
if (bindingResult.hasErrors()) {
    List<Role> roles = this.roleService.getAllRoles();
    model.addAttribute("roles", roles);
    return "admin/user/create";  // Trả về form với errors
}
```

**Nếu có lỗi:** Trả về form với thông báo lỗi
**Nếu OK:** Tiếp tục xử lý

---

### **5. BƯỚC 5: FILE UPLOAD PROCESSING**

#### **5.1 UploadService Processing**
**File:** `UploadService.java`

```java
// 2. Xử lý upload avatar bằng UploadService
try {
    String avatarFileName = this.uploadService.handleSaveAvatarFile(avatarFile);
    if (avatarFileName != null) {
        user.setAvatar(avatarFileName);
    }
} catch (RuntimeException e) {
    // Xử lý lỗi upload
}
```

#### **5.2 File Upload Logic**
**Method:** `handleSaveAvatarFile(MultipartFile avatarFile)`

1. **Validate File:**
   ```java
   if (avatarFile == null || avatarFile.isEmpty()) {
       return null;  // Không có file, skip
   }
   ```

2. **Create Directory:**
   ```java
   String rootPath = servletContext.getRealPath("/resources/images");
   File dir = new File(rootPath + File.separator + "avatar");
   if (!dir.exists()) {
       dir.mkdirs();  // Tạo thư mục nếu chưa có
   }
   ```

3. **Generate Unique Filename:**
   ```java
   String fileName = System.currentTimeMillis() + "-" + avatarFile.getOriginalFilename();
   // VD: "1727018456789-profile.jpg"
   ```

4. **Save File:**
   ```java
   File serverFile = new File(dir.getAbsolutePath() + File.separator + fileName);
   try (BufferedOutputStream stream = new BufferedOutputStream(
           new FileOutputStream(serverFile))) {
       stream.write(avatarFile.getBytes());
   }
   ```

5. **Return Filename:**
   ```java
   return fileName;  // Trả về tên file để lưu vào database
   ```

#### **5.3 File System Result**
```
/resources/images/avatar/1727018456789-profile.jpg  [File được lưu]
```

#### **5.4 User Object Update**
```java
user.setAvatar("1727018456789-profile.jpg");  // Lưu tên file vào User object
```

---

### **6. BƯỚC 6: ROLE ASSIGNMENT**

#### **6.1 Role Service Processing**
```java
// 3. Tìm và set Role
Role role = this.roleService.getRoleByName(roleName);
if (role != null) {
    user.setRole(role);
} else {
    // Xử lý lỗi role không tồn tại
}
```

#### **6.2 Database Query**
**File:** `RoleRepository.java`
```sql
-- RoleService.getRoleByName("ADMIN") thực thi:
SELECT r.id, r.name FROM roles r WHERE r.name = 'ADMIN';
```

#### **6.3 User Object Update**
```java
User user = {
    email: "test@gmail.com",
    password: "123456",
    fullName: "Test User",
    phoneNumber: "0123456789", 
    address: "Test Address",
    avatar: "1727018456789-profile.jpg",
    role: Role{id=7, name='ADMIN'}  // ← Role được set
}
```

---

### **7. BƯỚC 7: DATABASE SAVE**

#### **7.1 UserService Processing**
```java
// 4. Lưu user
try {
    this.userService.handleCreateUser(user);
    return "redirect:/admin/user?success=true&message=User created successfully";
} catch (Exception e) {
    // Xử lý lỗi database
}
```

#### **7.2 UserService Method**
**File:** `UserService.java`
```java
public User handleCreateUser(User user) {
    return this.userRepository.save(user);  // JPA save
}
```

#### **7.3 Database Transaction**
**Hibernate thực thi SQL:**
```sql
INSERT INTO users (
    email, password, full_name, phone_number, 
    address, avatar, role_id
) VALUES (
    'test@gmail.com', '123456', 'Test User', '0123456789',
    'Test Address', '1727018456789-profile.jpg', 7
);
```

#### **7.4 Database Result**
```sql
-- User record được tạo:
id | email           | password | full_name | phone_number | address      | avatar                    | role_id
10 | test@gmail.com  | 123456   | Test User | 0123456789   | Test Address | 1727018456789-profile.jpg| 7
```

---

### **8. BƯỚC 8: RESPONSE & REDIRECT**

#### **8.1 Controller Response**
```java
return "redirect:/admin/user?success=true&message=User created successfully";
```

#### **8.2 HTTP Response**
```
HTTP/1.1 302 Found
Location: /admin/user?success=true&message=User%20created%20successfully
```

#### **8.3 Browser Redirect**
Browser tự động redirect đến:
```
GET /admin/user?success=true&message=User%20created%20successfully
```

#### **8.4 User List Page**
**File:** `UserController.java`
```java
@GetMapping("/admin/user")
public String getUserPage(Model model) {
    List<User> users = this.userService.getAllUsers();  // Lấy danh sách users
    model.addAttribute("users", users);
    return "admin/user/index";  // Hiển thị danh sách
}
```

#### **8.5 Success Message Display**
**File:** `/WEB-INF/view/admin/user/index.jsp`
```jsp
<c:if test="${param.success == 'true'}">
    <div class="alert alert-success">
        <i class="fas fa-check-circle"></i> ${param.message}
    </div>
</c:if>
```

---

## 📊 Sơ Đồ Luồng Hoạt Động

```
[Client Browser]
       ↓ GET /admin/user/create
[DispatcherServlet]
       ↓
[UserController.showCreateUserForm()]
       ↓
[RoleService.getAllRoles()] → [Database: SELECT roles]
       ↓
[JSP Engine] → [create.jsp] → [HTML Form]
       ↓
[Client fills form & submits]
       ↓ POST /admin/user/create (multipart/form-data)
[DispatcherServlet]
       ↓
[Data Binding] → [@InitBinder filters avatar field]
       ↓
[UserController.createUser()]
       ↓
[Validation Check] → [BindingResult]
       ↓ (if valid)
[UploadService.handleSaveAvatarFile()]
       ↓
[File System] → [Save avatar file]
       ↓
[RoleService.getRoleByName()] → [Database: SELECT role]
       ↓
[UserService.handleCreateUser()] → [Database: INSERT user]
       ↓
[HTTP 302 Redirect] → [/admin/user?success=true]
       ↓
[UserController.getUserPage()]
       ↓
[UserService.getAllUsers()] → [Database: SELECT users]
       ↓
[JSP Engine] → [index.jsp] → [User List + Success Message]
       ↓
[Client Browser displays result]
```

---

## 🗂️ Cấu Trúc File Liên Quan

### **Backend Files:**
```
src/main/java/vn/hoidanit/laptopshop/
├── controller/admin/
│   └── UserController.java           # Main controller logic
├── service/
│   ├── UserService.java             # User business logic
│   ├── RoleService.java             # Role business logic
│   └── UploadService.java           # File upload logic
├── repository/
│   ├── UserRepository.java          # User data access
│   └── RoleRepository.java          # Role data access
└── domain/
    ├── User.java                    # User entity
    └── Role.java                    # Role entity
```

### **Frontend Files:**
```
src/main/webapp/
├── WEB-INF/view/admin/
│   ├── user/
│   │   ├── create.jsp              # Create form
│   │   └── index.jsp               # User list
│   └── layout/
│       ├── header.jsp              # Header component
│       ├── sidebar.jsp             # Sidebar component
│       └── footer.jsp              # Footer component
└── resources/
    ├── css/main.css                # Custom styles
    └── images/avatar/              # Avatar upload directory
```

### **Configuration Files:**
```
src/main/resources/
├── application.properties          # Database & app config
└── ...

src/main/java/vn/hoidanit/laptopshop/config/
└── WebMvcConfig.java              # MVC & resource mapping
```

---

## 🔐 Security & Error Handling

### **Security Measures:**
1. **File Upload Security:**
   - Accept only image files (`accept="image/*"`)
   - File size limits (50MB max)
   - Unique filename generation

2. **Data Binding Security:**
   - `@InitBinder` prevents avatar field binding conflicts
   - `@RequestParam` validation

3. **Database Security:**
   - JPA/Hibernate prevents SQL injection
   - Transaction management

### **Error Handling:**
1. **Validation Errors:** Trả về form với error messages
2. **File Upload Errors:** Hiển thị lỗi upload
3. **Database Errors:** Catch exceptions và hiển thị lỗi
4. **Role Not Found:** Hiển thị lỗi role không tồn tại

---

## 🎯 Kết Luận

Luồng hoạt động tạo user được thiết kế theo Spring MVC pattern với:
- **Separation of Concerns:** Controller, Service, Repository tách biệt
- **Clean Architecture:** Logic nghiệp vụ tách khỏi presentation
- **Error Handling:** Xử lý lỗi toàn diện
- **Security:** Bảo mật file upload và data binding
- **User Experience:** Form validation và success messages

Hệ thống đảm bảo tính nhất quán dữ liệu, bảo mật và trải nghiệm người dùng tốt.
