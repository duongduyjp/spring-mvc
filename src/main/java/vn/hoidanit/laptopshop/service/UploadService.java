package vn.hoidanit.laptopshop.service;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import jakarta.servlet.ServletContext;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

@Service
public class UploadService {
    private ServletContext servletContext;

    public UploadService(ServletContext servletContext) {
        this.servletContext = servletContext;
    }

    /**
     * Upload avatar file và trả về tên file đã lưu
     * 
     * @param avatarFile file upload từ form
     * @return tên file đã lưu (để lưu vào database), null nếu có lỗi
     * @throws RuntimeException nếu có lỗi upload
     */
    public String handleSaveUploadFile(MultipartFile avatarFile, String targetFolder) {
        // Kiểm tra file có tồn tại không
        if (avatarFile == null || avatarFile.isEmpty()) {
            return null;
        }

        try {
            byte[] bytes = avatarFile.getBytes();

            // Tạo đường dẫn thư mục lưu file
            String rootPath = this.servletContext.getRealPath("/resources/images");
            File dir = new File(rootPath + File.separator + targetFolder);

            // Tạo thư mục nếu chưa tồn tại
            if (!dir.exists()) {
                dir.mkdirs();
            }

            // Tạo tên file unique với timestamp
            String fileName = System.currentTimeMillis() + "-" + avatarFile.getOriginalFilename();
            File serverFile = new File(dir.getAbsolutePath() + File.separator + fileName);

            // Lưu file
            try (BufferedOutputStream stream = new BufferedOutputStream(
                    new FileOutputStream(serverFile))) {
                stream.write(bytes);
            }

            return fileName;

        } catch (IOException e) {
            throw new RuntimeException("Lỗi khi upload file: " + e.getMessage(), e);
        }
    }

    /**
     * Upload avatar file (shortcut method cho avatar)
     */
    public String handleSaveAvatarFile(MultipartFile avatarFile) {
        return handleSaveUploadFile(avatarFile, "avatar");
    }

    /**
     * Xóa file đã upload
     * 
     * @param fileName     tên file cần xóa
     * @param targetFolder thư mục chứa file
     * @return true nếu xóa thành công, false nếu có lỗi
     */
    public boolean deleteUploadFile(String fileName, String targetFolder) {
        if (fileName == null || fileName.isEmpty()) {
            return false;
        }

        try {
            String rootPath = this.servletContext.getRealPath("/resources/images");
            File file = new File(rootPath + File.separator + targetFolder + File.separator + fileName);

            if (file.exists()) {
                return file.delete();
            }
            return false;
        } catch (Exception e) {
            System.err.println("Lỗi khi xóa file: " + e.getMessage());
            return false;
        }
    }

    /**
     * Xóa file avatar
     * 
     * @param fileName tên file cần xóa
     */
    public void deleteAvatarFile(String fileName) {
        deleteUploadFile(fileName, "avatar");
    }
}
