-- Creación de la Base de Datos
CREATE DATABASE DB_PhoneCorp;
GO
USE DB_PhoneCorp;
GO

-- 1. Tabla Cliente
-- Almacena la información validada con RENIEC
CREATE TABLE Cliente (
    id_cliente INT IDENTITY(1,1) PRIMARY KEY,
    dni_ce VARCHAR(20) NOT NULL UNIQUE,
    nombres_completos VARCHAR(150) NOT NULL,
    direccion VARCHAR(200) NOT NULL,
    telefono VARCHAR(15),
    email VARCHAR(100),
    historial_crediticio VARCHAR(20) DEFAULT 'NORMAL' -- Para regla de negocio de crédito
);
GO

-- 2. Tabla Producto
-- Catálogo comercial de equipos
CREATE TABLE Producto (
    id_producto INT IDENTITY(1,1) PRIMARY KEY,
    sku VARCHAR(50) NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    marca VARCHAR(50) NOT NULL,
    modelo VARCHAR(50) NOT NULL,
    gama VARCHAR(20),
    precio_unitario DECIMAL(10, 2) NOT NULL CHECK (precio_unitario >= 0),
    descripcion VARCHAR(255)
);
GO

-- 3. Tabla Inventario
-- Control físico (Kardex). Relación 1 a 1 con Producto
CREATE TABLE Inventario (
    id_inventario INT IDENTITY(1,1) PRIMARY KEY,
    id_producto INT NOT NULL,
    stock_fisico INT NOT NULL CHECK (stock_fisico >= 0),
    stock_comprometido INT DEFAULT 0,
    ubicacion_almacen VARCHAR(50),
    fecha_actualizacion DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_Inventario_Producto FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);
GO

-- 4. Tabla OrdenVenta
-- Encabezado de la transacción
CREATE TABLE OrdenVenta (
    id_orden INT IDENTITY(1,1) PRIMARY KEY,
    id_cliente INT NOT NULL,
    fecha_emision DATETIME DEFAULT GETDATE(),
    estado VARCHAR(20) DEFAULT 'PENDIENTE', -- Pendiente, Pagado, Entregado
    modalidad_entrega VARCHAR(50) NOT NULL, -- Tienda o Domicilio
    monto_total DECIMAL(10, 2) NOT NULL,
    CONSTRAINT FK_Orden_Cliente FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
);
GO

-- 5. Tabla DetalleOrden
-- Items específicos de cada venta
CREATE TABLE DetalleOrden (
    id_detalle INT IDENTITY(1,1) PRIMARY KEY,
    id_orden INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL CHECK (cantidad > 0),
    precio_pactado DECIMAL(10, 2) NOT NULL,
    subtotal DECIMAL(10, 2) NOT NULL,
    CONSTRAINT FK_Detalle_Orden FOREIGN KEY (id_orden) REFERENCES OrdenVenta(id_orden),
    CONSTRAINT FK_Detalle_Producto FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);
GO

-- 6. Tabla Pago
-- Registro financiero. Relación 1 a 1 con OrdenVenta
CREATE TABLE Pago (
    id_pago INT IDENTITY(1,1) PRIMARY KEY,
    id_orden INT NOT NULL UNIQUE, -- Garantiza 1 pago por orden
    metodo_pago VARCHAR(50) NOT NULL, -- Efectivo, Tarjeta, Crédito
    monto_cancelado DECIMAL(10, 2) NOT NULL,
    fecha_pago DATETIME DEFAULT GETDATE(),
    codigo_operacion VARCHAR(50), -- Para vouchers de tarjeta
    CONSTRAINT FK_Pago_Orden FOREIGN KEY (id_orden) REFERENCES OrdenVenta(id_orden)
);
GO

-- 7. Tabla Comprobante
-- Documento tributario (SUNAT). Relación 1 a 1 con Pago
CREATE TABLE Comprobante (
    id_comprobante INT IDENTITY(1,1) PRIMARY KEY,
    id_pago INT NOT NULL UNIQUE,
    tipo_comprobante VARCHAR(20) NOT NULL, -- Boleta o Factura
    serie VARCHAR(10) NOT NULL,
    numero_correlativo VARCHAR(20) NOT NULL,
    hash_sunat VARCHAR(255), -- Código de validación OSE
    fecha_emision DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_Comprobante_Pago FOREIGN KEY (id_pago) REFERENCES Pago(id_pago)
);
GO

-- 8. Tabla TicketPostventa
-- Gestión de reclamos asociados al cliente y orden
CREATE TABLE TicketPostventa (
    id_ticket INT IDENTITY(1,1) PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_orden INT NULL, -- Puede ser una consulta sin orden específica
    motivo VARCHAR(50) NOT NULL,
    descripcion_caso VARCHAR(500),
    estado_ticket VARCHAR(20) DEFAULT 'ABIERTO',
    fecha_registro DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_Ticket_Cliente FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
    CONSTRAINT FK_Ticket_Orden FOREIGN KEY (id_orden) REFERENCES OrdenVenta(id_orden)
);
GO
