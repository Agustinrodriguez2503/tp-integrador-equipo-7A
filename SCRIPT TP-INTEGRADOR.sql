-- Para Eliminar la Base de Datos.
ALTER DATABASE TpIntegradorVeterinarias SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
DROP DATABASE TpIntegradorVeterinarias;


----------------------------------------------------------------------------------------
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
	UrlImagen VARCHAR(500) NOT NULL DEFAULT '',
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
    Correo VARCHAR(50),
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
    FechaHora DATETIME,
    Estado VARCHAR(10) NOT NULL DEFAULT 'PENDIENTE',
    Activo BIT DEFAULT 1,
    FOREIGN KEY (MatriculaVeterinario) REFERENCES Veterinarios(Matricula),
    FOREIGN KEY (IDMascota) REFERENCES Mascotas(IDMascota),
    CONSTRAINT UQ_Turnos_Matricula_Fecha UNIQUE (MatriculaVeterinario, FechaHora)
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
	NroComprobante VARCHAR(20) NOT NULL DEFAULT 'SIN-COMPROBANTE',
    Activo BIT DEFAULT 1,
    FOREIGN KEY (IDTurno) REFERENCES Turnos(IDTurno),
    FOREIGN KEY (LegajoRecepcionista) REFERENCES Recepcionistas(Legajo)
);
GO
-- TABLA MENSAJERIA
CREATE TABLE Mensajeria (
    IDMensaje INT PRIMARY KEY IDENTITY(1,1),
    Asunto VARCHAR(100) NOT NULL,
	Usuario VARCHAR(25) NOT NULL,
	UltimoMensaje VARCHAR(500) NOT NULL,
	Fecha DATETIME NOT NULL DEFAULT GETDATE()
);
GO
-- TABLA MENSAJES
CREATE TABLE Mensajes (
    IDConversacion INT PRIMARY KEY IDENTITY(1,1),
    IDMensaje INT NOT NULL,
    Emisor VARCHAR(25) NOT NULL,
    Contenido VARCHAR(500) NOT NULL,
    Fecha DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (IDMensaje) REFERENCES Mensajeria(IDMensaje),
    FOREIGN KEY (Emisor) REFERENCES Usuarios(Usuario),
);
GO


------------------------------------------------- REGISTROS! ----------------------------------------------

-- ROL
INSERT INTO Rol (Nombre) VALUES ('Dueño'), ('Recepcionista'), ('Veterinario'), ('Administrador');

-- USUARIOS
INSERT INTO Usuarios (Usuario, IDRol, Clave) VALUES
('vet1', 3, 'clavevet1'),
('vet2', 3, 'clavevet2'),
('vet3', 3, 'clavevet3'),
('rec1', 2, 'claverec1'),
('rec2', 2, 'claverec2'),
('due1', 1, 'clavedue1'),
('due2', 1, 'clavedue2'),
('due3', 1, 'clavedue3'),
('due4', 1, 'clavedue4'),
('agustin', 1, 'claveagustin'),
('admin', 4, 'admin');

-- VETERINARIOS
INSERT INTO Veterinarios (Matricula, Usuario, Nombre, Apellido, Dni, Telefono, Correo, UrlImagen) VALUES
('VET001', 'vet1', 'Ana', 'Pérez', '30000001', '1111-1111', 'ana@vet.com', 'https://nervet.cl/wp-content/uploads/2023/05/Eliana-Gaymer-500x500.jpg'),
('VET002', 'vet2', 'Luis', 'Gomez', '30000002', '2222-2222', 'luis@vet.com', 'https://hospitalveterinarioretiro.com/wp-content/uploads/2024/09/MONICA-1024x1024.jpg'),
('VET003', 'vet3', 'Clara', 'Suárez', '30000003', '3333-3333', 'clara@vet.com', 'https://img1.wsimg.com/isteam/ip/29eafd7f-23ea-4d2e-aaf9-9adb56ec59ff/3.png/:/cr=t:0%25,l:0%25,w:100%25,h:100%25/rs=w:365,h:365,cg:true');

-- RECEPCIONISTAS
INSERT INTO Recepcionistas (Usuario, Nombre, Apellido, Dni, Telefono, Correo) VALUES
('rec1', 'Valeria', 'Dominguez', '40000001', '4444-4444', 'valeria@vet.com'),
('rec2', 'Pedro', 'Sosa', '40000002', '5555-5555', 'pedro@vet.com');

-- DUEÑOS
INSERT INTO Dueños (Dni, Usuario, Nombre, Apellido, Telefono, Correo, Domicilio) VALUES
('50000001', 'due1', 'María', 'Rodríguez', '11 6666-1111', 'maria@due.com', 'Pichincha 123, Lanus'),
('50000002', 'due2', 'Jorge', 'Ramírez', '11 6666-2222', 'jorge@due.com', 'Corrientes 456, Avellaneda'),
('50000003', 'due3', 'Lucía', 'Martínez', '15 6666-3333', 'lucia@due.com', 'Venezuela 789, Ramos Mejia'),
('50000004', 'due4', 'Jose', 'Fernandez', '15 6666-4444', 'jose@due.com', 'Argentina 123, Pilar'),
('50000005', 'agustin', 'Agustin', 'Rodriguez', '11 6666-5555', 'agustinrodriguez2503@gmail.com', 'Juncal 456, Moreno');

-- MASCOTAS
INSERT INTO Mascotas (DniDueño, Nombre, Edad, FechaNacimiento, Peso, Tipo, Raza, Sexo) VALUES
('50000001', 'Firulais', 4, '2020-01-10', 12.5, 'Perro', 'Labrador', 'Macho'),
('50000001', 'Mishi', 2, '2022-06-05', 4.2, 'Gato', 'Siamés', 'Hembra'),
('50000002', 'Toby', 6, '2018-03-22', 10.0, 'Perro', 'Beagle', 'Macho'),
('50000003', 'Luna', 1, '2023-02-15', 3.8, 'Gato', 'Persa', 'Hembra'),
('50000004', 'Bonnie', 6, '2019-05-02', 9, 'Perro', 'BullDog', 'Hembra'),
('50000004', 'Corona', 3, '2022-05-02', 6, 'Gato', 'Tricolor', 'Hembra'),
('50000005', 'Gina', 3, '2022-05-03', 3, 'Gato', 'Tricolor', 'Hembra'),
('50000005', 'Pipino', 5, '2020-05-03', 1.2, 'Loro', 'Perico', 'Macho');

-- TURNOS
-- Fecha de hoy: supongamos es '2025-06-06'
INSERT INTO Turnos (MatriculaVeterinario, IDMascota, FechaHora, Estado) VALUES
('VET002', 6, '2025-05-23 14:13:45', 'CANCELADO'),
('VET001', 7, '2025-05-14 10:47:45', 'CANCELADO'),
('VET003', 4, '2025-06-03 17:42:45', 'CANCELADO'),
('VET001', 1, '2025-06-05 10:15:45', 'CANCELADO'),
('VET003', 3, '2025-06-21 12:08:45', 'CANCELADO'),
('VET001', 1, '2025-06-22 14:19:45', 'CANCELADO'),
('VET001', 4, '2025-06-18 11:18:45', 'CANCELADO'),
('VET003', 7, '2025-05-27 13:08:45', 'CANCELADO'),
('VET002', 8, '2025-06-24 16:24:45', 'CANCELADO'),
('VET002', 6, '2025-06-17 12:42:45', 'CANCELADO'),
('VET001', 6, '2025-07-29 15:00:45', 'PENDIENTE'),
('VET003', 3, '2025-07-12 14:23:45', 'PENDIENTE'),
('VET002', 5, '2025-07-15 13:01:45', 'PENDIENTE'),
('VET002', 4, '2025-07-20 11:11:45', 'PENDIENTE'),
('VET001', 5, '2025-07-03 12:47:45', 'PENDIENTE'),
('VET003', 1, '2025-08-01 09:17:45', 'PENDIENTE'),
('VET002', 4, '2025-08-07 17:34:45', 'PENDIENTE'),
('VET001', 5, '2025-07-10 13:47:45', 'PENDIENTE'),
('VET001', 3, '2025-07-28 12:01:45', 'PENDIENTE'),
('VET003', 5, '2025-07-26 10:53:45', 'PENDIENTE'),
('VET002', 2, '2025-07-01 14:30:45', 'PENDIENTE'),
('VET002', 8, '2025-06-06 11:45:45', 'PENDIENTE'),
('VET003', 2, '2025-07-31 12:38:45', 'PENDIENTE'),
('VET003', 5, '2025-07-25 15:22:45', 'PENDIENTE'),
('VET002', 4, '2025-08-08 10:45:45', 'PENDIENTE'),
('VET003', 6, '2025-06-13 10:01:45', 'REALIZADO'),
('VET002', 4, '2025-05-26 12:47:45', 'REALIZADO'),
('VET002', 6, '2025-06-16 15:36:45', 'REALIZADO'),
('VET001', 3, '2025-06-30 11:22:45', 'REALIZADO'),
('VET003', 6, '2025-06-04 13:49:45', 'REALIZADO'),
('VET002', 5, '2025-06-11 10:02:45', 'REALIZADO'),
('VET001', 3, '2025-05-25 14:05:45', 'REALIZADO'),
('VET002', 7, '2025-06-09 17:15:45', 'REALIZADO'),
('VET003', 1, '2025-06-19 12:10:45', 'REALIZADO'),
('VET001', 4, '2025-05-28 10:00:45', 'REALIZADO'),
('VET003', 2, '2025-06-14 15:30:45', 'REALIZADO'),
('VET001', 7, '2025-06-23 16:43:45', 'REALIZADO'),
('VET002', 5, '2025-06-27 09:57:45', 'COBRADO'),
('VET003', 1, '2025-06-02 14:44:45', 'COBRADO'),
('VET001', 4, '2025-06-19 11:45:45', 'COBRADO'),
('VET003', 6, '2025-06-03 15:13:45', 'COBRADO'),
('VET003', 7, '2025-06-05 17:00:45', 'COBRADO'),
('VET002', 8, '2025-06-06 13:12:45', 'COBRADO'),
('VET003', 5, '2025-06-08 15:01:45', 'COBRADO'),
('VET001', 2, '2025-06-10 16:40:45', 'COBRADO'),
('VET003', 8, '2025-06-14 11:55:45', 'COBRADO'),
('VET002', 3, '2025-06-01 13:22:45', 'COBRADO');


-- FICHACONSULTA (solo para turnos anteriores: IDs 1, 2 y 3)
INSERT INTO FichaConsulta (IDTurno, Descripcion) VALUES
(27, 'Control general y aplicación de vacunas anuales'),
(28, 'Revisión por cojera en pata trasera derecha'),
(29, 'Consulta por pérdida de apetito y vómitos'),
(30, 'Desparasitación interna y externa'),
(31, 'Limpieza de oídos por otitis leve'),
(32, 'Revisión post operatoria de castración'),
(33, 'Corte de uñas y limpieza dental'),
(34, 'Consulta por sarpullido en la zona del abdomen'),
(35, 'Aplicación de vacuna antirrábica'),
(36, 'Revisión por secreción ocular'),
(37, 'Aplicación de refuerzo de vacuna séxtuple'),
(38, 'Consulta por caída de pelo excesiva'),
(39, 'Extracción de cuerpo extraño del hocico'),
(40, 'Seguimiento de tratamiento por artrosis'),
(42, 'Control de fiebre y decaimiento general'),
(43, 'Aplicación de pipeta antiparasitaria'),
(44, 'Control prequirúrgico para esterilización'),
(45, 'Consulta por tos persistente'),
(46, 'Examen de sangre de rutina'),
(47, 'Consulta por temblores y espasmos musculares');



-- COBROS (turnos anteriores 1, 2 y 3, recepcionistas con legajo 100 y 101)
INSERT INTO Cobros (IDTurno, LegajoRecepcionista, FormaPago, Costo, NroComprobante) VALUES
(38, 100, 'Efectivo', 4589.22, 'COMP001'),
(39, 100, 'Crédito', 4648.26, 'COMP002'),
(40, 100, 'Débito', 2935.05, 'COMP003'),
(41, 101, 'Débito', 4885.34, 'COMP004'),
(42, 101, 'Débito', 4983.43, 'COMP005'),
(43, 100, 'Débito', 1440.73, 'COMP006'),
(44, 101, 'Débito', 4920.63, 'COMP007'),
(45, 100, 'Efectivo', 1023.82, 'COMP008'),
(46, 100, 'Crédito', 2132.36, 'COMP009'),
(47, 100, 'Crédito', 3944.22, 'COMP010');



