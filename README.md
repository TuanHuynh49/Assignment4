# Murach Music Store - Web Programming Assignment

Ứng dụng web quản lý & tải nhạc số (**Music Downloads Application**) xây dựng theo mô hình kiến trúc chuẩn **MVC (Model-View-Controller)** dựa trên kiến thức **Chapter 07: Sessions & Cookies** (Murach's Java Servlets and JSP).

---

## 🛠️ Công nghệ sử dụng
- **Ngôn ngữ**: Java 17+ (Jakarta EE / Servlet 6.0)
- **Controller**: `murach.download.DownloadServlet` (`/download`)
- **Model**: `murach.business.User`, `Product`, `Song`, `murach.data.UserIO`, `murach.util.CookieUtil`
- **View**: JSP (JavaServer Pages) & Vanilla CSS Responsive Design
- **Web Server**: Apache Tomcat 10.1+ / Tomcat 11
- **Quản lý dự án**: Apache Maven
- **Container**: Docker & Docker Compose

---

## 🚀 Cách chạy dự án

### Cách 1: Chạy bằng Docker (Khuyên dùng)
Chỉ cần chạy 1 lệnh sau ở thư mục gốc của dự án:
```bash
docker compose up -d --build
```
Mở trình duyệt truy cập: **`http://localhost:8080/`** (hoặc `http://localhost:8080/Assignment3/`)

Để dừng container:
```bash
docker compose down
```

---

### Cách 2: Chạy trực tiếp trên IDE (NetBeans / IntelliJ / Eclipse)
1. Mở thư mục dự án bằng **Apache NetBeans** hoặc IDE Java của bạn.
2. Chuột phải vào Project chọn **Clean and Build** (hoặc chạy lệnh terminal `mvn clean package`).
3. Nhấn **Run** (chọn server Apache Tomcat).
4. Truy cập đường dẫn: **`http://localhost:8080/Assignment3/`**

---

## 📋 Các tính năng chính (MVC Chapter 7)
1. **Duyệt danh mục Album**: Xem các album nhạc (`86 (the band)`, `Paddlefoot`, `Joe Rut`).
2. **Session Tracking**: Lưu trữ trạng thái người dùng trong phiên làm việc (`HttpSession`).
3. **Persistent Cookie**: Lưu Cookie `emailCookie` (thời hạn 2 năm) để tự động đăng nhập khi quay lại tải nhạc.
4. **URL Rewriting & Hidden Fields**: Điều hướng tham số qua query string và form POST.
5. **Trình nghe nhạc & Tải bài hát**: Nghe thử file MP3 trực tiếp trên trình duyệt và tải bài hát.
6. **Quản lý tài khoản & Cookie**: Xem và xóa toàn bộ cookies đã lưu khi đăng xuất.
