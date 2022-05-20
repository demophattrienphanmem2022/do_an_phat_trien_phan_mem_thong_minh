use master
go
create database dbQuanLyNhaXe
go
use dbQuanLyNhaXe
go

-- Bảng này dùng để tăng tự động khi 1 record được thêm vào.
-- Dùng để ghép chuỗi mã (VD: NV00001, trong đó NV là tiền tố tuỳ chọn 00001 lấy từ field tương ứng của bảng này)
create table Identify
(
	ID int identity primary key,
	NhanVien int default 0,
	KhachHang int default 0,
	LoTrinh int default 0,
	Xe int default 0,
	LichChay int default 0,
	VeXe int default 0
)
go
create table LoaiNhanVien
(
	MaLoaiNhanVien int identity(1,1) not null primary key,
	TenLoaiNhanVien nvarchar(100) not null,
	fl_Xoa bit not null,
)
go
create table LoaiTaiKhoan
(
	MaLoaiTaiKhoan int identity(1,1) not null primary key,
	TenLoaiTaiKhoan nvarchar(100) not null,
	fl_Xoa bit not null
)
go
create table TaiKhoan
(
	TenDangNhap varchar(50) not null primary key,
	MatKhau varchar(1000) not null,
	MaLoaiTaiKhoan int not null,
	fl_NgayThem datetime not null,
	fl_NgaySua datetime,
	fl_Xoa bit not null,
	CONSTRAINT FK_TaiKhoan_LoaiTaiKhoan FOREIGN KEY (MaLoaiTaiKhoan) REFERENCES LoaiTaiKhoan(MaLoaiTaiKhoan)
)
go
create table NhanVien
(
	MaNhanVien varchar(10) not null primary key,
	TenNhanVien nvarchar(50) not null,
	GioiTinh nvarchar(3) not null,
	NgaySinh Datetime not null,
	DienThoai varchar(10) not null,
	CCCD varchar(15) not null,
	DiaChi nvarchar(500) not null,
	MaLoaiNhanVien int not null,
	TenDangNhap varchar(50) not null unique,
	fl_NgayThem datetime not null,
	fl_NgaySua datetime,
	fl_Xoa bit not null,
	CONSTRAINT FK_NhanVien_LoaiNhanVien FOREIGN KEY (MaLoaiNhanVien) REFERENCES LoaiNhanVien(MaLoaiNhanVien),
	CONSTRAINT FK_NhanVien_TaiKhoan FOREIGN KEY (TenDangNhap) REFERENCES TaiKhoan(TenDangNhap)
)
go
create table KhachHang
(
	MaKhachHang varchar(10) primary key,
	TenKhachHang nvarchar(50) not null,
	GioiTinh nvarchar(3) not null,
	NgaySinh Datetime not null,
	DienThoai varchar(10) not null,
	CCCD varchar(15) not null,
	DiaChi nvarchar(500) not null,
	TenDangNhap varchar(50) not null,
	fl_NgayThem datetime not null,
	fl_NgaySua datetime,
	fl_Xoa bit not null,
	CONSTRAINT FK_KhachHang_TaiKhoan FOREIGN KEY (TenDangNhap) REFERENCES TaiKhoan(TenDangNhap)
)
go
create table LoaiXe
(
	MaLoaiXe int identity(1,1) not null primary key,
	TenLoaiXe nvarchar(100) not null,
	fl_Xoa bit not null
)
go
create table Xe
(
	MaXe varchar(10) primary key,
	BienSo varchar(20) not null,
	SoGhe int not null,
	MaLoaiXe int not null,
	fl_Xoa bit not null,
	CONSTRAINT FK_Xe_LoaiXe FOREIGN KEY (MaLoaiXe) REFERENCES LoaiXe(MaLoaiXe)
)
go
create table LoTrinh
(
	MaLoTrinh varchar(10) not null primary key,
	DiemDi nvarchar(100) not null,
	DiemDen nvarchar(100) not null,
	QuangDuong int not null,
	GiaVe int not null,
	fl_NgayThem datetime not null,
	fl_NgaySua datetime,
	fl_Xoa bit not null
)
go
create table LichChay
(
	MaLichChay varchar(10) not null primary key,
	NgayKhoiHanh Datetime not null,
	GioKhoiHanh varchar(10) not null,
	MaLoTrinh varchar(10) not null,
	MaNhanVien varchar(10) not null,
	fl_NgayThem datetime not null,
	fl_NgaySua datetime,
	fl_Xoa bit not null,
	CONSTRAINT FK_LichChay_LoTrinh FOREIGN KEY (MaLoTrinh) REFERENCES LoTrinh(MaLoTrinh),
	CONSTRAINT FK_LichChay_NhanVien FOREIGN KEY (MaNhanVien) REFERENCES NhanVien(MaNhanVien)
)
go
create table LichChay_Xe 
(
	MaLichChay_Xe varchar(10) not null primary key,
	TrangThai bit not null, --0 là chưa khởi hành, 1 là xe đã khởi hành
	MaLichChay varchar(10) not null,
	MaXe varchar(10) not null,
	fl_NgayThem datetime not null,
	fl_NgaySua datetime,
	fl_Xoa bit not null,
	CONSTRAINT FK_LichChay_Xe_LichChay FOREIGN KEY (MaLichChay) REFERENCES LichChay(MaLichChay),
	CONSTRAINT FK_LichChay_Xe_Xe FOREIGN KEY (MaXe) REFERENCES Xe(MaXe)
)
go
create table DiaChiTrungChuyen
(
	MaDiaChiTrungChuyen varchar(10) not null primary key,
	DiaChi nvarchar(100) not null,
	fl_Xoa bit not null
)
go
create table TrungChuyen
(
	MaTrungChuyen varchar(10) not null primary key,
	NgayKhoiHanh datetime not null,
	GioKhoiHanh varchar(10) not null,
	DiemDen nvarchar(100) not null,
	MaDiaChiTrungChuyen varchar(10) not null,
	fl_NgayThem datetime not null,
	fl_NgaySua datetime,
	fl_Xoa bit not null,
	CONSTRAINT FK_TrungChuyen_DiaChiTrungChuyen FOREIGN KEY (MaDiaChiTrungChuyen) REFERENCES DiaChiTrungChuyen(MaDiaChiTrungChuyen)
)
go
create table VeXe
(
	MaVeXe varchar(10) not null primary key,
	DonGia int not null,
	SoLuong int not null,
	ThanhTien int not null,
	MaNhanVien varchar(10) not null,
	MaKhachHang varchar(10) not null,
	MaLichChay_Xe varchar(10) not null,
	MaTrungChuyen varchar(10) not null,
	fl_Xoa bit not null,
	CONSTRAINT FK_VeXe_KhachHang FOREIGN KEY (MaKhachHang) REFERENCES KhachHang(MaKhachHang),
	CONSTRAINT FK_VeXe_NhanVien FOREIGN KEY (MaNhanVien) REFERENCES NhanVien(MaNhanVien),
	CONSTRAINT FK_VeXe_LichChay_Xe FOREIGN KEY (MaLichChay_Xe) REFERENCES LichChay_Xe(MaLichChay_Xe),
	CONSTRAINT FK_VeXe_TrungChuyen FOREIGN KEY (MaTrungChuyen) REFERENCES TrungChuyen(MaTrungChuyen)
)
go
create table ChiTietVeXe
(
	MaVeXe varchar(10) not null,
	GheNgoi int not null,
	CONSTRAINT pk_ChiTietVeXe primary key(MaVeXe, GheNgoi),
	CONSTRAINT FK_ChiTietVeXe_VeXe FOREIGN KEY (MaVeXe) REFERENCES VeXe(MaVeXe)
)
go

CREATE TRIGGER trg_CountNhanVien ON NhanVien
AFTER INSERT
AS
BEGIN
    UPDATE Identify SET NhanVien = NhanVien+1
END
GO

CREATE TRIGGER trg_CountKhachHang ON KhachHang
AFTER INSERT
AS
BEGIN
    UPDATE Identify SET KhachHang = KhachHang+1
END
GO

CREATE TRIGGER trg_CountLoTrinh ON LoTrinh
AFTER INSERT
AS
BEGIN
    UPDATE Identify SET LoTrinh = LoTrinh+1
END
GO

CREATE TRIGGER trg_CountXe ON Xe
AFTER INSERT
AS
BEGIN
    UPDATE Identify SET Xe = Xe+1
END
GO

CREATE TRIGGER trg_CountLichChay ON LichChay
AFTER INSERT
AS
BEGIN
    UPDATE Identify SET LichChay = LichChay+1
END
GO

CREATE TRIGGER trg_CountVeXe ON VeXe
AFTER INSERT
AS
BEGIN
    UPDATE Identify SET VeXe = VeXe+1
END
GO

---------------Nhập dữ liệu loại nhân viên
----------------Indentity
go
insert into Identify
values(0,0,0,0,0,0)
go
insert into LoaiNhanVien
values(N'Nhân viên quản lý',0)
go
insert into LoaiNhanVien
values(N'Nhân viên bán vé',0)
go
insert into LoaiNhanVien
values(N'Nhân viên tài xế',0)
go
insert into LoaiNhanVien
values(N'Nhân viên lơ xe',0)
--------------Nhập dữ liệu loại tài khoản
go
insert into LoaiTaiKhoan
values(N'Nhân viên quản lý',0)
go
insert into LoaiTaiKhoan
values(N'Nhân viên bán vé',0)
go
insert into LoaiTaiKhoan
values(N'Khách hàng',0)
-------------Nhập loại xe
go
insert into LoaiXe
values(N'Xe đường dài',0)
go
insert into LoaiXe
values(N'Xe trung chuyển',0)
---------------Nhập tài khoản
go
insert into TaiKhoan
values('NV00001','123',1,'09/05/2022',NULL,0)
go
insert into TaiKhoan
values('NV00002','123',2,'09/05/2022',NULL,0)
go
insert into TaiKhoan
values('KH00001','123',3,'09/05/2022',NULL,0)
---------------Nhập nhân viên
go
insert into NhanVien
values('NV00001',N'Phạm Hữu Tính',N'Nam','08/11/2001','0375075701','660456454545',N'Số nhà 200, Vĩnh Lợi, Vĩnh Thạnh, Lấp Vò, Đồng Tháp',1,'NV00001','05/09/2022',NULL,0)
go
insert into NhanVien
values('NV00002',N'Nguyễn Cẩm Lê',N'Nữ','01/19/2001','0939989999','940565656232',N'Đình Thành, Đông Hải, TP. Bạc Liêu',2,'NV00002','05/09/2022',NULL,0)
---------------Nhập khách hàng
go
insert into KhachHang
values('KH00001',N'Lê Huỳnh Nam',N'Nam','01/10/2001','0856123456','540521541236',N'Quận 6, TP. Hồ Chí Minh','KH00001','05/09/2022',NULL,0)
go
