-----------------------------------------------------
-- 1) DATABASE OLUŞTUR
-----------------------------------------------------
IF DB_ID('test') IS NOT NULL
BEGIN
    ALTER DATABASE test SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE test;
END
GO

CREATE DATABASE test;
GO

USE test;
GO

-----------------------------------------------------
-- 2) STATUS TABLOSU
-----------------------------------------------------
IF OBJECT_ID('dbo.STATUS', 'U') IS NOT NULL DROP TABLE dbo.STATUS;
GO

CREATE TABLE dbo.STATUS
(
    ID INT IDENTITY(1,1) PRIMARY KEY,
    STATUS_NAME VARCHAR(100),
    STATUS_COLOR VARCHAR(20),
    RECORD_DATE DATETIME NULL,
    RECORD_EMP INT NULL,
    UPDATE_DATE DATETIME NULL,
    UPDATE_EMP INT NULL
);
GO

-- STATUS DATA
INSERT INTO dbo.STATUS (STATUS_NAME, STATUS_COLOR, RECORD_DATE, RECORD_EMP, UPDATE_DATE, UPDATE_EMP)
VALUES
('Yapılacak',   '#0d6efd', NULL, NULL, NULL, NULL),
('Devam Ediyor','#ffc107', NULL, NULL, NULL, NULL),
('Tamamlandı',  '#198754', NULL, NULL, NULL, NULL);
GO

-----------------------------------------------------
-- 3) USERS TABLOSU
-----------------------------------------------------
IF OBJECT_ID('dbo.USERS', 'U') IS NOT NULL DROP TABLE dbo.USERS;
GO

CREATE TABLE dbo.USERS
(
    ID INT IDENTITY(1,1) PRIMARY KEY,
    NAME VARCHAR(100),
    SURNAME VARCHAR(100),
    EMAIL VARCHAR(150),
    RECORD_DATE DATETIME NULL,
    RECORD_EMP INT NULL,
    UPDATE_DATE DATETIME NULL,
    UPDATE_EMP INT NULL
);
GO

-- USERS DATA
INSERT INTO dbo.USERS (NAME, SURNAME, EMAIL, RECORD_DATE, RECORD_EMP, UPDATE_DATE, UPDATE_EMP)
VALUES
('Test isim',  'Test Soyad',      'test@g.c',      '2025-11-23 13:11:00.273', 1, NULL, NULL),
('Çalışan 2',  'Çalışan soy 2',   'calisan2@g.c',  '2025-11-23 13:27:02.853', 1, NULL, NULL);
GO

-----------------------------------------------------
-- 4) TASKS TABLOSU
-----------------------------------------------------
IF OBJECT_ID('dbo.TASKS', 'U') IS NOT NULL DROP TABLE dbo.TASKS;
GO

CREATE TABLE dbo.TASKS
(
    ID INT IDENTITY(1,1) PRIMARY KEY,
    TITLE VARCHAR(200),
    DESCRIPTION VARCHAR(MAX),
    STATUS_ID INT,
    USER_ID INT,
    RECORD_DATE DATETIME NULL,
    RECORD_EMP INT NULL,
    UPDATE_DATE DATETIME NULL,
    UPDATE_EMP INT NULL
);
GO

-- TASKS DATA
-- Dikkat:
-- STATUS_ID: 1=Yapılacak, 2=Devam Ediyor, 3=Tamamlandı
-- USER_ID:   1=Test isim,  2=Çalışan 2
INSERT INTO dbo.TASKS (TITLE, DESCRIPTION, STATUS_ID, USER_ID, RECORD_DATE, RECORD_EMP, UPDATE_DATE, UPDATE_EMP)
VALUES
('Test Görev 1', 'Test Açıklama 1', 1, 1, '2025-10-23 13:26:34.460', 1, NULL, NULL),
('Görev 2',      'Açıklama 2',      2, 2, '2025-11-23 13:27:19.920', 1, NULL, NULL),
('Görev 3',      'Görev 3',         3, 1, '2025-11-23 13:27:39.680', 1, NULL, NULL);
GO

-----------------------------------------------------
-- 5) FOREIGN KEY’LER
-----------------------------------------------------
ALTER TABLE dbo.TASKS 
    ADD CONSTRAINT FK_TASKS_STATUS FOREIGN KEY (STATUS_ID) REFERENCES dbo.STATUS(ID);

ALTER TABLE dbo.TASKS 
    ADD CONSTRAINT FK_TASKS_USERS FOREIGN KEY (USER_ID) REFERENCES dbo.USERS(ID);
GO

-----------------------------------------------------
-- BİTTİ
-----------------------------------------------------
PRINT 'Kurulum başarıyla tamamlandı!';
