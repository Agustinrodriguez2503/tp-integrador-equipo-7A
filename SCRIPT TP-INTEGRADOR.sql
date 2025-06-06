
-- CREAR LA BASE DE DATOS
CREATE DATABASE TpIntegradorVeterinarias
COLLATE Latin1_General_CI_AI;
GO

-- USAR LA BD
USE TpIntegradorVeterinarias;
GO

-- TABLA ROL
CREATE TABLE Rol(
    IDRol INT PRIMARY KEY IDENTITY (1,1),
    Nombre VARCHAR(25) NOT NULL UNIQUE
);
GO

-- TABLA USUARIOS
CREATE TABLE Usuarios(
    Usuario VARCHAR(25) PRIMARY KEY,
    IDRol INT NOT NULL,
    Clave VARCHAR(255) NOT NULL,
    Activa BIT DEFAULT 1,
    FOREIGN KEY (IDRol) REFERENCES Rol(IDRol)
);
GO

-- TABLA RECEPCIONISTAS
CREATE TABLE Recepcionistas(
    Legajo INT PRIMARY KEY IDENTITY (100,1),
    Usuario VARCHAR(25) UNIQUE,
    Nombre VARCHAR(25) NOT NULL,
    Apellido VARCHAR(25) NOT NULL,
    Dni VARCHAR(10) NOT NULL UNIQUE,
    Telefono VARCHAR(20),
    Correo VARCHAR(50),
    Activo BIT DEFAULT 1,
    FOREIGN KEY (Usuario) REFERENCES Usuarios(Usuario)
);
GO

-- TABLA VETERINARIOS
CREATE TABLE Veterinarios(
    Matricula VARCHAR(10) PRIMARY KEY,
    Usuario VARCHAR(25) UNIQUE,
    Nombre VARCHAR(25) NOT NULL,
    Apellido VARCHAR(25) NOT NULL,
    Dni VARCHAR(10) NOT NULL UNIQUE,
    Telefono VARCHAR(20),
    Correo VARCHAR(50),
    Activo BIT DEFAULT 1,
    FOREIGN KEY (Usuario) REFERENCES Usuarios(Usuario)
);
GO

-- TABLA DUEÑOS
CREATE TABLE Dueños(
    Dni VARCHAR(10) PRIMARY KEY,
    Usuario VARCHAR(25) UNIQUE,
    Nombre VARCHAR(25) NOT NULL,
    Apellido VARCHAR(25) NOT NULL,
    Telefono VARCHAR(20),
    Correo VARCHAR(50) UNIQUE,
    Domicilio VARCHAR(50),
    Activo BIT DEFAULT 1,
    FOREIGN KEY (Usuario) REFERENCES Usuarios(Usuario)
);
GO

-- TABLA MASCOTAS
CREATE TABLE Mascotas(
    IDMascota INT PRIMARY KEY IDENTITY (1,1),
    DniDueño VARCHAR(10) NOT NULL,
    Nombre VARCHAR(25) NOT NULL,
    Edad INT,
    FechaNacimiento DATETIME,
    Peso DECIMAL(5,2),
    Tipo VARCHAR(25),
    Raza VARCHAR(25),
    Sexo VARCHAR(20),
    FechaRegistro DATETIME DEFAULT GETDATE(),
    Activo BIT DEFAULT 1,
    FOREIGN KEY (DniDueño) REFERENCES Dueños(Dni)
);
GO

-- TABLA TURNOS
CREATE TABLE Turnos(
    IDTurno INT PRIMARY KEY IDENTITY (1,1),
    MatriculaVeterinario VARCHAR(10) NOT NULL,
    IDMascota INT NOT NULL,
    FechaHora DATETIME UNIQUE,
    Activo BIT DEFAULT 1,
    FOREIGN KEY (MatriculaVeterinario) REFERENCES Veterinarios(Matricula),
    FOREIGN KEY (IDMascota) REFERENCES Mascotas(IDMascota)
);
GO

-- TABLA FICHACONSULTA
CREATE TABLE FichaConsulta(
    IDConsulta INT PRIMARY KEY IDENTITY (1,1),
    IDTurno INT UNIQUE NOT NULL,
    Descripcion VARCHAR(500) NOT NULL,
    Activo BIT DEFAULT 1,
    FOREIGN KEY (IDTurno) REFERENCES Turnos(IDTurno)
);
GO

-- TABLA COBROS
CREATE TABLE Cobros(
    IDCobro INT PRIMARY KEY IDENTITY (1,1),
    IDTurno INT NOT NULL,
    LegajoRecepcionista INT NOT NULL,
    FormaPago VARCHAR(30),
    Costo DECIMAL(10,2) CHECK (Costo >= 0),
    Activo BIT DEFAULT 1,
    FOREIGN KEY (IDTurno) REFERENCES Turnos(IDTurno),
    FOREIGN KEY (LegajoRecepcionista) REFERENCES Recepcionistas(Legajo)
);
GO

------------------------------------------------- REGISTROS! ----------------------------------------------

-- ROL
INSERT INTO Rol (Nombre) VALUES ('Dueño'), ('Recepcionista'), ('Veterinario');

-- USUARIOS
INSERT INTO Usuarios (Usuario, IDRol, Clave) VALUES
('vet1', 3, 'clavevet1'),
('vet2', 3, 'clavevet2'),
('vet3', 3, 'clavevet3'),
('rec1', 2, 'claverec1'),
('rec2', 2, 'claverec2'),
('due1', 1, 'clavedue1'),
('due2', 1, 'clavedue2'),
('due3', 1, 'clavedue3');

-- VETERINARIOS
INSERT INTO Veterinarios (Matricula, Usuario, Nombre, Apellido, Dni, Telefono, Correo) VALUES
('VET001', 'vet1', 'Ana', 'Pérez', '30000001', '1111-1111', 'ana@vet.com'),
('VET002', 'vet2', 'Luis', 'Gomez', '30000002', '2222-2222', 'luis@vet.com'),
('VET003', 'vet3', 'Clara', 'Suárez', '30000003', '3333-3333', 'clara@vet.com');

-- RECEPCIONISTAS
INSERT INTO Recepcionistas (Usuario, Nombre, Apellido, Dni, Telefono, Correo) VALUES
('rec1', 'Valeria', 'Dominguez', '40000001', '4444-4444', 'valeria@vet.com'),
('rec2', 'Pedro', 'Sosa', '40000002', '5555-5555', 'pedro@vet.com');

-- DUEÑOS
INSERT INTO Dueños (Dni, Usuario, Nombre, Apellido, Telefono, Correo, Domicilio) VALUES
('50000001', 'due1', 'María', 'Rodríguez', '6666-1111', 'maria@due.com', 'Calle 1 123'),
('50000002', 'due2', 'Jorge', 'Ramírez', '6666-2222', 'jorge@due.com', 'Calle 2 456'),
('50000003', 'due3', 'Lucía', 'Martínez', '6666-3333', 'lucia@due.com', 'Calle 3 789');

-- MASCOTAS
INSERT INTO Mascotas (DniDueño, Nombre, Edad, FechaNacimiento, Peso, Tipo, Raza, Sexo) VALUES
('50000001', 'Firulais', 4, '2020-01-10', 12.5, 'Perro', 'Labrador', 'Macho'),
('50000001', 'Mishi', 2, '2022-06-05', 4.2, 'Gato', 'Siamés', 'Hembra'),
('50000002', 'Toby', 6, '2018-03-22', 10.0, 'Perro', 'Beagle', 'Macho'),
('50000003', 'Luna', 1, '2023-02-15', 3.8, 'Gato', 'Persa', 'Hembra');

-- TURNOS
-- Fecha de hoy: supongamos es '2025-06-06'
INSERT INTO Turnos (MatriculaVeterinario, IDMascota, FechaHora) VALUES
('VET001', 1, '2025-06-01 10:00'), -- Anterior
('VET001', 2, '2025-06-02 11:00'), -- Anterior
('VET002', 3, '2025-06-03 09:30'), -- Anterior
('VET002', 4, '2025-06-07 12:00'),
('VET003', 1, '2025-06-08 10:00'),
('VET003', 2, '2025-06-09 11:00'),
('VET001', 3, '2025-06-10 15:00'),
('VET002', 4, '2025-06-11 16:00');

-- FICHACONSULTA (solo para turnos anteriores: IDs 1, 2 y 3)
INSERT INTO FichaConsulta (IDTurno, Descripcion) VALUES
(1, 'Consulta por resfrío leve.'),
(2, 'Vacunación anual.'),
(3, 'Chequeo general, sin novedades.');

-- COBROS (turnos anteriores 1, 2 y 3, recepcionistas con legajo 100 y 101)
INSERT INTO Cobros (IDTurno, LegajoRecepcionista, FormaPago, Costo, Activo) VALUES
(1, 100, 'Efectivo', 3500.00, 1),
(2, 100, 'Tarjeta', 4000.00, 1),
(3, 101, 'Transferencia', 3200.00, 1);


