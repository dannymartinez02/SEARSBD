CREATE DATABASE SEARS
GO

USE SEARS
GO

CREATE TABLE Usuario (
   IDusuario INT IDENTITY(1,1) PRIMARY KEY,
   NombreUsuario VARCHAR(50) NOT NULL,
   PasswordHash VARBINARY(64) NULL,
   Salt VARBINARY(16) NOT NULL
)

INSERT INTO Usuario (NombreUsuario, PasswordHash, Salt)
VALUES 
       ('usuario2', HASHBYTES('SHA2_256', 'password2'), 0xFEDCBA9876543210),
       ('usuario3', HASHBYTES('SHA2_256', 'password3'), 0xA1B2C3D4E5F6),
       ('usuario4', HASHBYTES('SHA2_256', 'password4'), 0x0F0F0F0F0F0F0F0F);

SELECT * FROM Usuario

CREATE LOGIN [AdminLogin] WITH PASSWORD = 'password1';
CREATE USER [AdminUser] FOR LOGIN [AdminLogin];

ALTER SERVER ROLE sysadmin ADD MEMBER [AdminLogin];


CREATE ROLE Contabilidad;
CREATE ROLE [Gestor de Entregas];

GRANT SELECT, INSERT, UPDATE, DELETE ON ConteoDeTarjetas TO Contabilidad;

GRANT SELECT, INSERT, UPDATE, DELETE ON EntregaDeTarjetas TO [Gestor de Entregas];

DENY SELECT, INSERT, UPDATE, DELETE ON Usuario TO Contabilidad;

DENY SELECT, INSERT, UPDATE, DELETE ON ConteoDeTarjetas TO [Gestor de Entregas];


-- Insertar usuario 'usuario1'
DECLARE @salt1 VARBINARY(16) = CONVERT(VARBINARY(16), NEWID());
DECLARE @password1 VARCHAR(50) = '123456789';
DECLARE @hash1 VARBINARY(64) = HASHBYTES('SHA2_256', @password1 + CONVERT(VARCHAR(36), @salt1));

INSERT INTO Usuario (NombreUsuario, Salt, PasswordHash)
VALUES ('usuario1', @salt1, @hash1);

-- Insertar usuario 'Manuel'
DECLARE @salt2 VARBINARY(16) = CONVERT(VARBINARY(16), NEWID());
DECLARE @password2 VARCHAR(50) = '123456789';
DECLARE @hash2 VARBINARY(64) = HASHBYTES('SHA2_256', @password2 + CONVERT(VARCHAR(36), @salt2));

INSERT INTO Usuario (NombreUsuario, Salt, PasswordHash)
VALUES ('Manuel', @salt2, @hash2);


CREATE TABLE ConteoDeTarjetas (
   TarjetaDeCreditoID INT IDENTITY(1,1) PRIMARY KEY,
   Correlativo VARCHAR(5) NOT NULL,
   TipoDeTarjeta VARCHAR(5) NOT NULL
)

INSERT INTO ConteoDeTarjetas (Correlativo, TipoDeTarjeta)
VALUES
   ('12345', '02'),
   ('23456', '02'),
   ('54657', '01'),
   ('09821', '02'),
   ('23298', '01'),
   ('67890', '02'),
   ('01832', '02'),
   ('32650', '01'),
   ('98722', '02'),
   ('83272', '02'),
   ('98320', '01'),
   ('23365', '01'),
   ('79320', '01'),
   ('02391', '02'),
   ('09321', '02');

CREATE TABLE EntregaDeTarjetas (
   TarjetaDeCreditoID INT IDENTITY(1,1) PRIMARY KEY,
   TitularTarjeta VARCHAR(50) NOT NULL,
   NumCuenta VARCHAR(12) NOT NULL,
   FechaExpiracion VARCHAR(5) NOT NULL,
   Correlativo VARCHAR(5) NOT NULL,
   TipoDeTarjeta VARCHAR(5) NOT NULL,
   FechaDeEntrega DATE NOT NULL
)

INSERT INTO EntregaDeTarjetas (TitularTarjeta, NumCuenta, FechaExpiracion, Correlativo, TipoDeTarjeta, FechaDeEntrega)
VALUES
   ('Xavier Ramos', '000123456789', '08/99', '12345', '02', '2003/07/22'),
   ('Carlos Herrera', '103948576324', '05/99', '23456', '02', '2004/03/19'),
   ('Josue Hernandez', '184930457483', '06/67', '54657', '01', '2014/09/05'),
   ('Saul Fuentes', '167373559075', '07/89', '09821', '02', '2009/04/14'),
   ('Carlos Rivera', '133694700908', '09/56', '23298', '01', '2008/05/02'),
   ('Axel Beltran', '145360009809', '06/89', '67890', '02', '2018/03/26'),
   ('Manuel Alvarado', '241843790004', '04/76', '01832', '02', '2007/03/17'),
   ('Bryan Rosales', '263784900045', '03/57', '32650', '01', '2020/02/01'),
   ('Carmen Ramirez', '372890098632', '07/45', '98722', '02', '2004/06/03'),
   ('Kevin Figueroa', '846930827809', '07/84', '83272', '02', '2007/04/03'),
   ('Alejandro Fuentes', '389462738903', '03/87', '98320', '01', '2003/03/09'),
   ('Daniel Montes', '172849098485', '08/93', '23365', '01', '2007/12/03'),
   ('Jose Martinez', '192300048912', '08/90', '79320', '01', '2020/04/17'),
   ('Andres Ramos', '212375890067', '02/89', '02391', '02', '2018/04/10'),
   ('Raul Flores', '184740009801', '08/93', '09321', '02', '2008/10/03');


SELECT * FROM EntregaDeTarjetas

CREATE TRIGGER VerificarFechaEntrega
ON EntregaDeTarjetas
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @FechaActual DATE;
    SET @FechaActual = GETDATE();

    IF EXISTS (
        SELECT 1
        FROM inserted
        WHERE FechaDeEntrega > @FechaActual
    )
    BEGIN
        RAISERROR ('No se puede entregar una tarjeta en una fecha futura.', 16, 1);
        ROLLBACK TRANSACTION;
    END;
END;

INSERT INTO EntregaDeTarjetas (TitularTarjeta, NumCuenta, FechaExpiracion, Correlativo, TipoDeTarjeta, FechaDeEntrega)
VALUES
   ('Xavier Ramos', '000123456789', '08/99', '12345', '02', '2003/07/22')