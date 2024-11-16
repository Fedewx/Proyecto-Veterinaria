-- Eliminar la base de datos si ya existe
DROP DATABASE IF EXISTS veterinaria;

-- Crear la base de datos
CREATE DATABASE veterinaria;

-- Seleccionar la base de datos
USE veterinaria;

-- Crear las tablas principales
CREATE TABLE Clientes (
    ID_Cliente INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    Apellido VARCHAR(50) NOT NULL,
    Telefono VARCHAR(20) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Direccion VARCHAR(255) NOT NULL
);

CREATE TABLE Veterinarios (
    ID_Veterinario INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    Apellido VARCHAR(50) NOT NULL,
    Especialidad VARCHAR(100) NOT NULL,
    Telefono VARCHAR(20) NOT NULL,
    Email VARCHAR(100) NOT NULL
);

CREATE TABLE Tratamientos (
    ID_Tratamiento INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Nombre_Tratamiento VARCHAR(100) NOT NULL,
    Descripcion TEXT, -- Opcional
    Costo DECIMAL(10,2) NOT NULL
);

CREATE TABLE Productos (
    ID_Producto INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Categoria VARCHAR(50) NOT NULL,
    Descripcion TEXT, -- Opcional
    Precio DECIMAL(10,2) NOT NULL,
    Stock INT NOT NULL
);

-- TABLAS FORÁNEAS
CREATE TABLE Mascotas (
    ID_Mascota INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    Especie VARCHAR(50) NOT NULL,
    Raza VARCHAR(50) NOT NULL,
    Edad INT NOT NULL,
    Sexo ENUM('Macho', 'Hembra') NOT NULL,
    ID_Cliente INT NOT NULL
);

CREATE TABLE Citas (
    ID_Cita INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Fecha_Hora DATETIME NOT NULL,
    Motivo VARCHAR(255) NOT NULL,
    ID_Mascota INT NOT NULL,
    ID_Veterinario INT NOT NULL
);

CREATE TABLE Historial_Medico (
    ID_Historial INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ID_Mascota INT NOT NULL,
    Fecha DATE NOT NULL,
    ID_Tratamiento INT NOT NULL,
    Comentarios TEXT -- Opcional
);

CREATE TABLE Pagos (
    ID_Pago INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Fecha_Pago DATE NOT NULL,
    Monto DECIMAL(10,2) NOT NULL,
    ID_Cita INT NOT NULL
);

CREATE TABLE Ventas (
    ID_Venta INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ID_Producto INT NOT NULL,
    ID_Cliente INT NOT NULL,
    ID_Mascota INT NOT NULL,
    Fecha_Venta DATE NOT NULL,
    Cantidad INT NOT NULL,
    Total DECIMAL(10,2) NOT NULL
);

CREATE TABLE Emergencias (
    ID_Emergencia INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Fecha_Hora DATETIME NOT NULL,
    Motivo VARCHAR(255) NOT NULL,
    ID_Mascota INT NOT NULL,
    ID_Veterinario INT NOT NULL,
    Tratamiento_Emergencia TEXT NOT NULL,
    Costo_Emergencia DECIMAL(10,2) NOT NULL
);

-- REFERENCIAS
ALTER TABLE Mascotas
ADD CONSTRAINT fk_mascotas_clientes
FOREIGN KEY (ID_Cliente) REFERENCES Clientes(ID_Cliente);

ALTER TABLE Citas
ADD CONSTRAINT fk_citas_mascotas
FOREIGN KEY (ID_Mascota) REFERENCES Mascotas(ID_Mascota);

ALTER TABLE Citas
ADD CONSTRAINT fk_citas_veterinarios
FOREIGN KEY (ID_Veterinario) REFERENCES Veterinarios(ID_Veterinario);

ALTER TABLE Historial_Medico
ADD CONSTRAINT fk_historial_mascotas
FOREIGN KEY (ID_Mascota) REFERENCES Mascotas(ID_Mascota);

ALTER TABLE Historial_Medico
ADD CONSTRAINT fk_historial_tratamientos
FOREIGN KEY (ID_Tratamiento) REFERENCES Tratamientos(ID_Tratamiento);

ALTER TABLE Pagos
ADD CONSTRAINT fk_pagos_citas
FOREIGN KEY (ID_Cita) REFERENCES Citas(ID_Cita);

ALTER TABLE Ventas
ADD CONSTRAINT fk_ventas_productos
FOREIGN KEY (ID_Producto) REFERENCES Productos(ID_Producto);

ALTER TABLE Ventas
ADD CONSTRAINT fk_ventas_clientes
FOREIGN KEY (ID_Cliente) REFERENCES Clientes(ID_Cliente);

ALTER TABLE Ventas
ADD CONSTRAINT fk_ventas_mascotas
FOREIGN KEY (ID_Mascota) REFERENCES Mascotas(ID_Mascota);

ALTER TABLE Emergencias
ADD CONSTRAINT fk_emergencias_mascotas
FOREIGN KEY (ID_Mascota) REFERENCES Mascotas(ID_Mascota);

ALTER TABLE Emergencias
ADD CONSTRAINT fk_emergencias_veterinarios
FOREIGN KEY (ID_Veterinario) REFERENCES Veterinarios(ID_Veterinario);