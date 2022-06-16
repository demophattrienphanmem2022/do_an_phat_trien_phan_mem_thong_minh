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
	VeXe int default 0,
	LichChay_Xe int default 0
)
go
create table LoaiNhanVien
(
	MaLoaiNhanVien int identity(1,1) not null primary key,
	TenLoaiNhanVien nvarchar(100) not null,
	fl_Xoa int not null,
)
go
create table LoaiTaiKhoan
(
	MaLoaiTaiKhoan int identity(1,1) not null primary key,
	TenLoaiTaiKhoan nvarchar(100) not null,
	fl_Xoa int not null
)
go
create table TaiKhoan
(
	TenDangNhap varchar(50) not null primary key,
	MatKhau varchar(1000) not null,
	MaLoaiTaiKhoan int not null,
	fl_NgayThem datetime not null,
	fl_NgaySua datetime,
	fl_Xoa int not null,
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
	TenDangNhap varchar(50) unique,
	fl_NgayThem datetime not null,
	fl_NgaySua datetime,
	fl_Xoa int not null,
	CONSTRAINT FK_NhanVien_LoaiNhanVien FOREIGN KEY (MaLoaiNhanVien) REFERENCES LoaiNhanVien(MaLoaiNhanVien),
	CONSTRAINT FK_NhanVien_TaiKhoan FOREIGN KEY (TenDangNhap) REFERENCES TaiKhoan(TenDangNhap)
)
go
create table KhachHang
(
	MaKhachHang varchar(10) primary key,
	TenKhachHang nvarchar(50) not null,
	GioiTinh nvarchar(3),
	NgaySinh Datetime,
	DienThoai varchar(10) not null,
	CCCD varchar(15),
	DiaChi nvarchar(500),
	TenDangNhap varchar(50),
	fl_NgayThem datetime not null,
	fl_NgaySua datetime,
	fl_Xoa int not null,
	CONSTRAINT FK_KhachHang_TaiKhoan FOREIGN KEY (TenDangNhap) REFERENCES TaiKhoan(TenDangNhap)
)
go
create table LoaiXe
(
	MaLoaiXe int identity(1,1) not null primary key,
	TenLoaiXe nvarchar(100) not null,
	fl_Xoa int not null
)
go
create table Xe
(
	MaXe varchar(10) primary key,
	BienSo varchar(20) not null,
	SoGhe int not null,
	MaLoaiXe int not null,
	fl_Xoa int not null,
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
	fl_Xoa int not null
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
	fl_Xoa int not null,
	CONSTRAINT FK_LichChay_LoTrinh FOREIGN KEY (MaLoTrinh) REFERENCES LoTrinh(MaLoTrinh),
	CONSTRAINT FK_LichChay_NhanVien FOREIGN KEY (MaNhanVien) REFERENCES NhanVien(MaNhanVien)
)
go
create table LichChay_Xe 
(
	MaLichChay_Xe varchar(10) not null primary key,
	TrangThai int not null, --0 là chưa khởi hành, 1 là xe đã khởi hành
	MaLichChay varchar(10) not null,
	MaXe varchar(10) not null,
	fl_NgayThem datetime not null,
	fl_NgaySua datetime,
	fl_Xoa int not null,
	CONSTRAINT FK_LichChay_Xe_LichChay FOREIGN KEY (MaLichChay) REFERENCES LichChay(MaLichChay),
	CONSTRAINT FK_LichChay_Xe_Xe FOREIGN KEY (MaXe) REFERENCES Xe(MaXe)
)
go
create table DiaChiTrungChuyen
(
	MaDiaChiTrungChuyen varchar(10) not null primary key,
	DiaChi nvarchar(100) not null,
	fl_Xoa int not null
)
go
create table TrungChuyen
(
	MaTrungChuyen varchar(10) not null primary key,
	DiemDi nvarchar(50) not null,
	DiemDen nvarchar(50) not null,
	QuangDuong int not null,
	MaDiaChiTrungChuyen varchar(10) not null,
	fl_Xoa int not null,
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
	fl_Xoa int not null,
	CONSTRAINT FK_VeXe_KhachHang FOREIGN KEY (MaKhachHang) REFERENCES KhachHang(MaKhachHang),
	CONSTRAINT FK_VeXe_NhanVien FOREIGN KEY (MaNhanVien) REFERENCES NhanVien(MaNhanVien),
	CONSTRAINT FK_VeXe_LichChay_Xe FOREIGN KEY (MaLichChay_Xe) REFERENCES LichChay_Xe(MaLichChay_Xe)
)
go
create table ChiTietVeXe
(
	MaVeXe varchar(10) not null,
	GheNgoi varchar(5) not null,
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

CREATE TRIGGER trg_CountLichChay_Xe ON LichChay_Xe
AFTER INSERT
AS
BEGIN
    UPDATE Identify SET LichChay_Xe = LichChay_Xe+1
END
GO

CREATE TRIGGER trg_CountVeXe ON VeXe
AFTER INSERT
AS
BEGIN
    UPDATE Identify SET VeXe = VeXe+1
END
GO

CREATE TRIGGER trg_UpdateVeXe ON ChiTietVeXe
AFTER DELETE
AS
BEGIN
	if((select VeXe.SoLuong from VeXe where VeXe.MaVeXe = (select deleted.MaVeXe from deleted))>1)
		UPDATE VeXe
		set SoLuong = SoLuong - 1, ThanhTien = ThanhTien - DonGia
		where VeXe.MaVeXe = (select deleted.MaVeXe from deleted)
	else
		UPDATE VeXe
		set SoLuong = SoLuong - 1, ThanhTien = ThanhTien - DonGia, fl_Xoa = 1
		where VeXe.MaVeXe = (select deleted.MaVeXe from deleted)
END
---------------Nhập dữ liệu loại nhân viên
----------------Indentity
go
insert into Identify
values(0,0,0,0,0,0,0)
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
values('NV00001','123',1,'05/09/2022',NULL,0)
go
insert into TaiKhoan
values('NV00002','123',2,'05/09/2022',NULL,0)
go
insert into TaiKhoan
values('KH00001','123',3,'05/09/2022',NULL,0)
---------------Nhập nhân viên
go
insert into NhanVien
values('NV00001',N'Phạm Hữu Tính',N'Nam','08/11/2001','0375075701','660456454545',N'Số nhà 200, Vĩnh Lợi, Vĩnh Thạnh, Lấp Vò, Đồng Tháp',1,'NV00001','05/09/2022',NULL,0)
go
insert into NhanVien
values('NV00002',N'Nguyễn Cẩm Lê',N'Nữ','01/19/2001','0939989999','940565656232',N'Đình Thành, Đông Hải, TP. Bạc Liêu',2,'NV00002','05/09/2022',NULL,0)
go
insert into NhanVien
values('NV00003',N'Trần Trọng',N'Nam','01/01/2001','0562134587','558741254875',N'TP. Hồ Chí Minh',3,NULL,'05/09/2022',NULL,0)
---------------Nhập khách hàng
go
insert into KhachHang
values('KH00001',N'Lê Huỳnh Nam',N'Nam','01/10/2001','0856123456','540521541236',N'Quận 6, TP. Hồ Chí Minh','KH00001','05/09/2022',NULL,0)
--------------Nhập lộ trình
go
insert into LoTrinh
values('LT00001',N'Hồ Chí Minh',N'Long An',30,50000,'05/09/2022',NULL,0)
go
insert into LoTrinh
values('LT00002',N'Hồ Chí Minh',N'Tiền Giang',60,75000,'05/09/2022',NULL,0)
go
insert into LoTrinh
values('LT00003',N'Hồ Chí Minh',N'Sa Đéc',170,100000,'05/09/2022',NULL,0)
go
insert into LoTrinh
values('LT00004',N'Hồ Chí Minh',N'Đồng Tháp',200,150000,'05/09/2022',NULL,0)
------------Nhập xe
go
insert into Xe
values('XE00001','51B00001',46,1,0)
go
insert into Xe
values('XE00002','51B00002',46,1,0)
go
insert into Xe
values('XE00003','51B00003',46,1,0)
go
insert into Xe
values('XE00004','51B00004',46,1,0)
go
insert into Xe
values('XE00005','51B00005',46,1,0)
go
insert into Xe
values('XE00006','51B00006',46,1,0)
go
insert into Xe
values('XE00007','51B00007',46,1,0)
go
insert into Xe
values('XE00008','51B00008',46,1,0)
go
insert into Xe
values('XE00009','51B00009',46,1,0)
go
insert into Xe
values('XE00010','51B00010',46,1,0)
go
insert into Xe
values('XE00011','51B00011',16,2,0)
go
insert into Xe
values('XE00012','51B00012',16,2,0)
go
insert into Xe
values('XE00013','51B00013',16,2,0)
go
insert into Xe
values('XE00014','51B00014',16,2,0)
go
insert into Xe
values('XE00015','51B00015',16,2,0)
-------------Nhập lịch chạy
go
insert into LichChay
values('LC00001','05/25/2022','19','LT00001','NV00003','05/09/2022',NULL,0)
go
insert into LichChay
values('LC00002','05/25/2022','6','LT00002','NV00003','05/09/2022',NULL,0)
--------------Nhập lịch chạy xe
go
insert into LichChay_Xe
values('LCX00001',0,'LC00001','XE00001','05/09/2022',NULL,0)
go
insert into LichChay_Xe
values('LCX00002',0,'LC00001','XE00002','05/09/2022',NULL,0)
go
insert into LichChay_Xe
values('LCX00003',0,'LC00002','XE00003','05/09/2022',NULL,0)
go
insert into LichChay_Xe
values('LCX00004',0,'LC00002','XE00004','05/09/2022',NULL,0)
-------------Nhập vé xe
go
insert into VeXe
values('VX00001',50000,2,100000,'NV00002','KH00001','LCX00001',0)
------------Nhập chi tiết vé xe
go
insert into ChiTietVeXe
values('VX00001','01A')
go
insert into ChiTietVeXe
values('VX00001','02A')
------------Nhập địa chỉ
go
insert into DiaChiTrungChuyen
values('DC00001',N'Hồ Chí Minh',0)
go
insert into DiaChiTrungChuyen
values('DC00002',N'Đồng Tháp',0)
go
insert into DiaChiTrungChuyen
values('DC00003',N'Bạc Liêu',0)
---------------Nhập trung chuyển
go
insert into TrungChuyen
values('TC00001','BXMT','Bình Tân',5,'DC00001',0)
go
insert into TrungChuyen
values('TC00002','BXMT','Tân Phú',16,'DC00001',0)
go
insert into TrungChuyen
values('TC00003','BXMT','Q6',3,'DC00001',0)
go
insert into TrungChuyen
values('TC00004','Bình Tân','Q12',18,'DC00001',0)
go
insert into TrungChuyen
values('TC00005','Tân Phú','Q12',2,'DC00001',0)
go
insert into TrungChuyen
values('TC00006','Tân Phú','Q5',7,'DC00001',0)
go
insert into TrungChuyen
values('TC00007','Tân Phú','Q10',6,'DC00001',0)
go
insert into TrungChuyen
values('TC00008','Q6','Q10',5,'DC00001',0)
go
insert into TrungChuyen
values('TC00009','Q6','Tân Phú',10,'DC00001',0)
go
insert into TrungChuyen
values('TC00010','Q12','BXMD',20,'DC00001',0)
go
insert into TrungChuyen
values('TC00011','Q5','BXMD',10,'DC00001',0)
go
insert into TrungChuyen
values('TC00012','Q10','Q5',8,'DC00001',0)
go
insert into TrungChuyen
values('TC00013','Q10','BXMD',5,'DC00001',0)
