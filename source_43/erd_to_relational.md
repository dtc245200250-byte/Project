# Chuyển đổi ERD sang mô hình dữ liệu quan hệ

## Bước 1. Xác định các thực thể

Từ ERD được cung cấp, xác định 6 thực thể:

1. **PHIEUXUAT**
   - SoPX
   - NgayXuat

2. **VATTU**
   - MaVTU
   - TenVTU

3. **PHIEUNHAP**
   - SoPN
   - NgayNhap

4. **DONDH**
   - SoDH
   - NgayDH

5. **NHACC**
   - MaNCC
   - TenNCC
   - DiaChi
   - SDT

6. **Thuộc tính đa trị của NHACC**
   - SDT được biểu diễn bằng hình oval kép trong ERD nên phải tách thành một bảng riêng khi chuyển sang mô hình quan hệ.

## Bước 2. Xác định các mối quan hệ

### Quan hệ 1 - Chi tiết phiếu xuất

Quan hệ **N - N** giữa **PHIEUXUAT** và **VATTU**.

Các thuộc tính của quan hệ:
- DGXuat
- SLXuat

Khi chuyển sang mô hình quan hệ, tạo bảng trung gian:

**CT_PHIEUXUAT**
- SoPX
- MaVTU
- DGXuat
- SLXuat

Khóa chính: **(SoPX, MaVTU)**.

### Quan hệ 2 - Chi tiết phiếu nhập

Quan hệ **N - N** giữa **PHIEUNHAP** và **VATTU**.

Các thuộc tính của quan hệ:
- DGNhap
- SLNhap

Tạo bảng:

**CT_PHIEUNHAP**
- SoPN
- MaVTU
- DGNhap
- SLNhap

Khóa chính: **(SoPN, MaVTU)**.

### Quan hệ 3 - Chi tiết đơn đặt hàng

Quan hệ **N - N** giữa **DONDH** và **VATTU**.

Tạo bảng trung gian:

**CT_DONDH**
- SoDH
- MaVTU

Khóa chính: **(SoDH, MaVTU)**.

### Quan hệ 4 - Cung cấp

Quan hệ **N - 1** giữa **DONDH** và **NHACC**:
- Một nhà cung cấp có thể cung cấp nhiều đơn đặt hàng.
- Mỗi đơn đặt hàng thuộc một nhà cung cấp.

Do đó đưa khóa của NHACC sang DONDH:

**DONDH**
- SoDH
- NgayDH
- MaNCC (FK)

## Bước 3. Xử lý thuộc tính đa trị

Trong ERD, **SDT** của NHACC là thuộc tính đa trị.

Không lưu nhiều số điện thoại trong một ô của bảng NHACC. Tách thành bảng:

**NHACC_SDT**
- MaNCC
- SDT

Khóa chính: **(MaNCC, SDT)**.

## Bước 4. Danh sách các bảng sau khi chuyển đổi

### 1. PHIEUXUAT
`PHIEUXUAT(SoPX PK, NgayXuat)`

### 2. VATTU
`VATTU(MaVTU PK, TenVTU)`

### 3. PHIEUNHAP
`PHIEUNHAP(SoPN PK, NgayNhap)`

### 4. NHACC
`NHACC(MaNCC PK, TenNCC, DiaChi)`

### 5. NHACC_SDT
`NHACC_SDT(MaNCC FK, SDT, PK(MaNCC, SDT))`

### 6. DONDH
`DONDH(SoDH PK, NgayDH, MaNCC FK)`

### 7. CT_PHIEUXUAT
`CT_PHIEUXUAT(SoPX FK, MaVTU FK, DGXuat, SLXuat, PK(SoPX, MaVTU))`

### 8. CT_PHIEUNHAP
`CT_PHIEUNHAP(SoPN FK, MaVTU FK, DGNhap, SLNhap, PK(SoPN, MaVTU))`

### 9. CT_DONDH
`CT_DONDH(SoDH FK, MaVTU FK, PK(SoDH, MaVTU))`

## Sơ đồ quan hệ rút gọn

```
PHIEUXUAT
    |
    | 1 - N
    |
CT_PHIEUXUAT
    |
    | N - 1
    |
VATTU
    |
    | 1 - N
    |
CT_PHIEUNHAP
    |
    | N - 1
    |
PHIEUNHAP


DONDH ---- N : 1 ---- NHACC
  |
  | N : N
  |
CT_DONDH
  |
  |
VATTU

NHACC ---- 1 : N ---- NHACC_SDT
```

## Kết quả

Từ ERD ban đầu, mô hình dữ liệu quan hệ thu được **9 bảng**:

**PHIEUXUAT, VATTU, PHIEUNHAP, NHACC, NHACC_SDT, DONDH, CT_PHIEUXUAT, CT_PHIEUNHAP, CT_DONDH.**
