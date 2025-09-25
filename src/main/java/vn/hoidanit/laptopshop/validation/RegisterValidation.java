package vn.hoidanit.laptopshop.validation;

import jakarta.validation.Constraint;
import jakarta.validation.Payload;
import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

// @Documented: Đánh dấu annotation này sẽ được ghi vào tài liệu Javadoc.
// @Constraint(validatedBy = RegisterValidationValidator.class): Xác định đây là một annotation kiểm tra ràng buộc (constraint) và sẽ được xử lý bởi lớp RegisterValidationValidator.
// @Target({ ElementType.TYPE }): Annotation này chỉ áp dụng cho class, interface (cấp độ kiểu).
// @Retention(RetentionPolicy.RUNTIME): Annotation này sẽ được giữ lại tại thời điểm runtime để framework có thể truy xuất và xử lý.
// public @interface RegisterValidation { ... }: Định nghĩa một custom annotation tên là RegisterValidation dùng để xác thực dữ liệu đăng ký.
// String message() default "Invalid register data";: Thông báo lỗi mặc định khi validation thất bại.
// Class<?>[] groups() default {};: Cho phép phân nhóm các constraint (ít dùng, để mở rộng).
// Class<? extends Payload>[] payload() default {};: Cho phép đính kèm thông tin bổ sung cho constraint (ít dùng, để mở rộng).

@Documented
@Constraint(validatedBy = RegisterValidator.class)
@Target({ ElementType.TYPE })
@Retention(RetentionPolicy.RUNTIME)
public @interface RegisterValidation {
    String message() default "Invalid register data";

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};
}
