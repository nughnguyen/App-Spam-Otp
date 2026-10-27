# App Spam OTP (CTDOTECH) ⚡

Ứng dụng iOS native (Objective-C / Objective-C++) thực hiện kiểm thử độ tải (stress testing) và benchmark dịch vụ OTP qua 36 cổng API đồng thời.

---

## 🚀 Tính năng nổi bật

- **Giao diện Cyber Neo-Glassmorphism**: Thiết kế nền tối sang trọng kết hợp hiệu ứng kính mờ (frosted glass) và dải màu gradient công nghệ cao.
- **Tương thích mọi thiết bị iOS**: Sử dụng `UIScrollView` và thuật toán tính toán layout động theo `safeAreaInsets`, thích ứng hoàn hảo từ iPhone SE đến iPhone 16 Pro Max.
- **Hỗ trợ bàn phím thông minh (Keyboard-Adaptive)**: Tự động nâng nội dung khi bàn phím số mở lên, tích hợp cử chỉ chạm ngoài để ẩn bàn phím.
- **Nhập liệu SĐT thông minh**:
  - Hỗ trợ nút **"Dán SĐT"** từ bộ nhớ tạm (tự động làm sạch dấu cách, ký tự đặc biệt, chuyển `+84` thành `0`).
  - Kiểm tra tính hợp lệ thời gian thực với icon hiệu ứng nảy (Spring animation).
  - Nút ẩn/hiện số điện thoại và nút xoá nhanh (X).
- **Chế độ chạy linh hoạt**:
  - **Chạy 1 lần (Run Once)**: Gửi 1 đợt 36 API đồng thời, hỗ trợ rung xúc giác (Haptic Feedback) và hiệu ứng nhún (Touch scale animation).
  - **Spam Vô Hạn (Auto Loop)**: Tự động lặp lại chu kỳ 2.0 giây cho tới khi tắt công tắc.
- **Terminal Console thời gian thực**: Giả lập cửa sổ dòng lệnh macOS với mốc thời gian `[HH:mm:ss]`, bộ đếm số lượng log và nút dọn dẹp console.
- **Ủng hộ tác giả (Donate)**: Tích hợp nút sao chép nhanh số tài khoản ngân hàng / MOMO kèm thông báo popup HUD.

---

## 🛠️ Đóng gói & Cài đặt (.IPA)

Dự án đã được tích hợp sẵn GitHub Actions CI/CD (`.github/workflows/objective-c-xcode.yml`). Mỗi khi push code lên nhánh `main`, hệ thống sẽ tự động:
1. Biên dịch ứng dụng bằng `xcodebuild` trên môi trường macOS mới nhất.
2. Đóng gói thành file `App-Spam-OTP.ipa`.
3. Tải lên phần **Artifacts** của GitHub Actions để bạn có thể tải về cài đặt trực tiếp qua TrollStore, AltStore, Sideloadly hoặc Scarlet.

---

## ⚠️ Tuyên bố miễn trừ trách nhiệm

Ứng dụng được phát triển phục vụ mục đích học tập, nghiên cứu bảo mật và kiểm thử khả năng chịu tải của hệ thống. Người dùng tự chịu trách nhiệm về mục đích và hành vi sử dụng của mình.

---

## 💖 Donate & Tác giả

- **Tác giả**: @YoungGumballZ (NGUYEN QUOC HUNG)
- **MOMO / Ngân hàng**: `PSP2602016500000627`
- **Chủ tài khoản**: NGUYEN QUOC HUNG
- **Facebook**: [hungnq188.2k5](https://www.facebook.com/hungnq188.2k5)
