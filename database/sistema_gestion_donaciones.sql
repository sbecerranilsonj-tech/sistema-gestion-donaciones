-- ============================================
-- SISTEMA DE GESTION DE DONACIONES
-- Script Completo
-- ============================================

DROP DATABASE IF EXISTS sistema_gestion_donaciones;
CREATE DATABASE sistema_gestion_donaciones;
USE sistema_gestion_donaciones;

SET FOREIGN_KEY_CHECKS = 0;

-- ============================================
-- TABLA: pais
-- ============================================
DROP TABLE IF EXISTS pais;
CREATE TABLE pais (
    id_pais INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

INSERT INTO pais (nombre) VALUES
('Perú'),
('Colombia'),
('Ecuador'),
('Canadá'),
('Reino Unido'),
('Australia'),
('Alemania');

-- ============================================
-- TABLA: rol_usuario
-- ============================================
DROP TABLE IF EXISTS rol_usuario;
CREATE TABLE rol_usuario (
    id_rol INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

INSERT INTO rol_usuario (nombre) VALUES
('Administrador'),
('Institucion Donante'),
('Institucion Donante'),
('Persona Natural '),
('Comunidades Vulnerables');

-- ============================================
-- TABLA: usuario_sistema
-- ============================================
DROP TABLE IF EXISTS usuario_sistema;
CREATE TABLE usuario_sistema (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    id_rol INT,
    estado TINYINT DEFAULT 1,
    FOREIGN KEY (id_rol) REFERENCES rol_usuario(id_rol)
);

INSERT INTO usuario_sistema 
(nombre, username, password, id_rol, estado)
VALUES
('Administrador', 'admin', 'nilson1234', 1, 1);

-- ============================================
-- TABLA: donante
-- ============================================
DROP TABLE IF EXISTS donante;
CREATE TABLE donante (
    id_donante INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    id_pais INT,
    telefono VARCHAR(20),
    correo VARCHAR(100),
    estado TINYINT DEFAULT 1,
    FOREIGN KEY (id_pais) REFERENCES pais(id_pais)
);

INSERT INTO donante (nombre, id_pais, telefono, correo) VALUES
('Carlos Mendoza',1,'987654321','carlos@gmail.com'),
('Fundación Esperanza',1,'999888777','fundacion@gmail.com'),
('Municipalidad de Lima',1,'955444333','muni@gmail.com'),
('Corporación Vida',2,'911222333','vida@gmail.com'),
('Lucía Fernández',1,'900111222','lucia@gmail.com');

-- ============================================
-- TABLA: campania
-- ============================================
DROP TABLE IF EXISTS campania;
CREATE TABLE campania (
    id_campania INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    descripcion TEXT,
    fecha_inicio DATE,
    fecha_fin DATE,
    estado TINYINT DEFAULT 1
);

INSERT INTO campania (nombre, descripcion, fecha_inicio, fecha_fin) VALUES
('Colecta Invierno','Apoyo con ropa de abrigo','2026-06-01','2026-08-30'),
('Donación Escolar 2026','Entrega de útiles escolares','2026-03-01','2026-04-30'),
('Ayuda Médica Solidaria','Apoyo en medicamentos','2026-01-10','2026-12-30'),
('Navidad con Amor','Campaña navideña','2026-12-01','2026-12-25');

-- ============================================
-- TABLA: donacion
-- ============================================
DROP TABLE IF EXISTS donacion;
CREATE TABLE donacion (
    id_donacion INT AUTO_INCREMENT PRIMARY KEY,
    id_donante INT,
    id_campania INT,
    tipo_donacion ENUM('Monetaria','En especie','Servicios') NOT NULL,
    estado_donacion ENUM('Pendiente','Confirmada','Completada','Cancelada') NOT NULL,
    monto DECIMAL(10,2) NULL,
    fecha DATE DEFAULT CURRENT_DATE,
    FOREIGN KEY (id_donante) REFERENCES donante(id_donante),
    FOREIGN KEY (id_campania) REFERENCES campania(id_campania)
);

INSERT INTO donacion 
(id_donante, id_campania, tipo_donacion, estado_donacion, monto)
VALUES
(1,1,'Monetaria','Confirmada',500.00),
(2,2,'Monetaria','Confirmada',1500.00),
(3,3,'Monetaria','Pendiente',300.00),
(4,4,'En especie','Completada',NULL),
(5,2,'Monetaria','Confirmada',750.00);

SET FOREIGN_KEY_CHECKS = 1;

-- ============================================
-- FIN DEL SCRIPT
-- ============================================
