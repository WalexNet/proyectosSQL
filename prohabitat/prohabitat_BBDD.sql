USE prohabitat

# Tabla de Inquilinos
CREATE TABLE inquilinos (
  id          int(11) NOT NULL AUTO_INCREMENT,
  nombres     varchar(50),
  apellidos   varchar(50),
  nick        varchar(25),
  dni         varchar(10),
  telefono    varchar(12),
  mail        varchar(100),
  pax         decimal(3,1),
  piso        BOOL DEFAULT 0 NOT NULL,
  comentario  text,
  PRIMARY KEY (id)
);
ALTER TABLE prohabitat.inquilinos ADD COLUMN descuento decimal (6,2) NOT NULL DEFAULT 0 COMMENT 'Descuento en €uros del pago del servicio';



# Tabla de Servicios
CREATE TABLE servicios (
	id   INT AUTO_INCREMENT PRIMARY KEY,
	des  VARCHAR(50)
);

# Tabla de edificios
CREATE TABLE edificios (
	id        INT AUTO_INCREMENT PRIMARY KEY,
	nombre    VARCHAR(50),
	direccion VARCHAR(100),
	cp        VARCHAR(5),
	poblacion VARCHAR(50)
);
# Añadimos campos notas
ALTER TABLE prohabitat.edificios ADD notas TEXT NULL;


# Tabla de pisos
CREATE TABLE pisos (
	id           INT AUTO_INCREMENT PRIMARY KEY,
	idEdificio   INT,
	planta       VARCHAR(30),
	puerta       VARCHAR(5),
	habitaciones INT DEFAULT 1 NOT NULL,
	escalera     VARCHAR(5)
);
# Añadimos campo Notas, Aqui se podra poner cualquier tipo de descripcion del piso
ALTER TABLE prohabitat.pisos ADD notas TEXT NULL;
ALTER TABLE prohabitat.pisos ADD idTecnico  INT COMMENT 'Tecnico que lo gestiona';
ALTER TABLE prohabitat.pisos ADD idProyecto INT COMMENT 'Proyecto al que pertenece';
ALTER TABLE prohabitat.pisos ADD idseguro   INT COMMENT 'Poliza de seguro delpiso';
ALTER TABLE prohabitat.pisos CHANGE idseguro idpoliza INT COMMENT 'Poliza de seguro delpiso';

# Relaciones Pisos con edificios
ALTER TABLE pisos ADD CONSTRAINT FK_pis_edi FOREIGN KEY (idEdificio) REFERENCES edificios(id)  ON UPDATE CASCADE;
ALTER TABLE pisos ADD CONSTRAINT FK_pis_tec FOREIGN KEY (idTecnico)  REFERENCES tecnicos(id)   ON UPDATE CASCADE;
ALTER TABLE pisos ADD CONSTRAINT FK_pis_pro FOREIGN KEY (idProyecto) REFERENCES proyectos (id) ON UPDATE CASCADE;
ALTER TABLE pisos ADD CONSTRAINT FK_pis_seg FOREIGN KEY (idseguro)   REFERENCES seguro (id)    ON UPDATE CASCADE;
ALTER TABLE pisos DROP CONSTRAINT FK_pis_tec;
ALTER TABLE pisos DROP idTecnico;

# Tabla de facturas
CREATE TABLE facturas (
	id         INT AUTO_INCREMENT PRIMARY KEY,
	numero     VARCHAR(30),
	fechaf     DATE,
	importe    DECIMAL(15,2),
	fdes       DATE,
	fhas       DATE,
	lant       INT,
	lact       INT,
	periodo    VARCHAR(30),
	idservicio INT,
	idpiso     INT
);

ALTER TABLE facturas ADD COLUMN facdoc VARCHAR(100) DEFAULT 'No ha subido Archivo' NOT NULL COMMENT 'Este campo gurada la ruta del cdocumente (Factura real escaneada)';
ALTER TABLE facturas ADD COLUMN docu   BOOL         DEFAULT 0 NOT NULL COMMENT 'Booleano que nos indica si hay documento subido on';

# Relaciones Facturas con Pisos y Servicios
ALTER TABLE facturas ADD CONSTRAINT FK_fac_serv FOREIGN KEY (idservicio) REFERENCES servicios(id) ON UPDATE CASCADE;
ALTER TABLE facturas ADD CONSTRAINT FK_fac_pis  FOREIGN KEY (idpiso)     REFERENCES pisos(id)     ON UPDATE CASCADE; 




# Tabla de Entradas y salidas
CREATE TABLE entsal (
  id          int(11) NOT NULL AUTO_INCREMENT,
  idinquilino int(11) DEFAULT NULL,
  idpiso      int(11) DEFAULT NULL,
  ocupado     tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Estado de ocupacion del Piso o Habitacion 1=ocupado 2=desocupado',
  fechaE      date DEFAULT NULL COMMENT 'FECHA DE ENTRADA AL PISO O HABITACION',
  lgasE       int(11) DEFAULT NULL COMMENT 'LECTURA DEL MEDIDOR DE GAS A LA ENTRADA',
  lluzE       int(11) DEFAULT NULL COMMENT 'LECTURA DE LUZ A LA ENTRADA',
  laguaE      int(11) DEFAULT NULL COMMENT 'LECTURA DEL AGUA A LA ENTRADA',
  fechaS      date DEFAULT NULL COMMENT 'FECHA DE SALIDA DEL PISO O HABITACION',
  lgasS       int(11) DEFAULT 0 COMMENT 'LECTURA MEDIDOR DE GAS A LA SALIDA',
  lluzS       int(11) DEFAULT 0 COMMENT 'LECTURA MEDIDOR DE LUZ A LA SALIDA',
  laguaS      int(11) DEFAULT 0 COMMENT 'LECTURA MEDIDOR DE AGUA A LA SALIDA',
  notas       text DEFAULT NULL,
  PRIMARY KEY (id),
  KEY FK_es_inq (idinquilino),
  KEY FK_es_pis (idpiso),
  CONSTRAINT FK_es_inq FOREIGN KEY (idinquilino) REFERENCES inquilinos (id) ON UPDATE CASCADE,
  CONSTRAINT FK_es_pis FOREIGN KEY (idpiso)      REFERENCES pisos (id)      ON UPDATE CASCADE
);

# Tabla Pagos (Borrar esta Tabla), nos quedamos con tabla recpagos
CREATE TABLE pagos (
  id int NOT NULL AUTO_INCREMENT,
  idinqui int COMMENT 'ID de inquilino',
  idfactura int COMMENT 'ID de factura',
  fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL COMMENT 'FECHA Y HORA DEL PAGO',
  PRIMARY KEY (ID),
  KEY FK_pag_inq (idinqui),
  KEY FK_pag_fac (idfactura),
  CONSTRAINT FK_paginq FOREIGN KEY (idinqui)   REFERENCES inquilinos (id) ON UPDATE CASCADE,
  CONSTRAINT FK_pagfac FOREIGN KEY (idfactura) REFERENCES facturas (id)   ON UPDATE CASCADE
);

# Tabla Recibo de Pagos
CREATE TABLE recpagos (
  id        int NOT NULL AUTO_INCREMENT,
  idinqui   int COMMENT 'ID de inquilino',
  idfactura int COMMENT 'ID de factura',
  fecha     DATETIME COMMENT 'FECHA Y HORA DEL PAGO, si campo=null pago no realizado',
  fdes      DATE DEFAULT NULL COMMENT 'Fecha inicio del periodo que paga',
  fhas      DATE DEFAULT NULL COMMENT 'Fecha fin del periodo que paga',
  descuento DECIMAL(6,2) DEFAULT 0 COMMENT 'Descuento en €uros',
  importe   DECIMAL(6,2) DEFAULT 0 COMMENT 'Importe a pagar',
  PRIMARY KEY (ID),
  CONSTRAINT FK_recpaginq FOREIGN KEY (idinqui)   REFERENCES inquilinos (id) ON UPDATE CASCADE,
  CONSTRAINT FK_recpagfac FOREIGN KEY (idfactura) REFERENCES facturas (id)   ON UPDATE CASCADE
);

ALTER TABLE recpagos ADD COLUMN pax    DECIMAL(5,2) DEFAULT 1 NOT NULL COMMENT 'PAX o cantidad de usuarios por habitacion';
ALTER TABLE recpagos ADD COLUMN pagado BOOL         DEFAULT 0 NOT NULL COMMENT 'Bandera 1=pagado 2=pte pago';
ALTER TABLE recpagos ADD COLUMN preuni DECIMAL(6,2) DEFAULT 0 NOT NULL COMMENT 'Precio por unidad de consumo';
ALTER TABLE recpagos ADD COLUMN confac INT          DEFAULT 0 NOT NULL COMMENT 'Consumo corres';
ALTER TABLE recpagos ADD COLUMN conusr INT          DEFAULT 0 NOT NULL COMMENT 'Consumo correspondiente al usuario';



# Tabla de usuarios Ahora PERFILES
CREATE TABLE usuarios (
	id     INT AUTO_INCREMENT PRIMARY KEY,
	nomusr VARCHAR(100),
	psw    VARCHAR(64)
);
ALTER TABLE prohabitat.usuarios ADD idtecnico INT;
ALTER TABLE prohabitat.usuarios ADD nivel INT COMMENT 'Nivel de Acceso a la APP 0=admin, 1=Tecnico ...';
ALTER TABLE prohabitat.usuarios ADD descnivel VARCHAR(20) COMMENT 'Descripcion del nivel ADMINISTRADOR, TECNICO, OFICINA'
ALTER TABLE prohabitat.usuarios ADD CONSTRAINT FK_usu_tec  FOREIGN KEY (idtecnico) REFERENCES prohabitat.tecnicos (id) ON UPDATE CASCADE;
RENAME TABLE prohabitat.usuarios TO perfiles


# Tabla de Tecnicos
CREATE TABLE tecnicos (
  id          int(11) NOT NULL AUTO_INCREMENT,
  nombres     varchar(50),
  apellidos   varchar(50),
  nomcorto    varchar(25),
  dni         varchar(10),
  telefono    varchar(12),
  mail        varchar(100),
  comentario  text,
  PRIMARY KEY (id)
);

# Tabla Proyectos
CREATE TABLE proyectos (
  id     int NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(100),
  notas  TEXT,
  PRIMARY KEY (id)
);

# Tabla proyectecnic (Crea relacion Mucho a Muchos entre Proyectos y Tecnicos)
CREATE TABLE proyectecnic (
  idtecnic int,
  idproyec int,
  CONSTRAINT FK_tec_pro FOREIGN KEY (idtecnic) REFERENCES tecnicos (id) ON UPDATE CASCADE,
  CONSTRAINT FK_pro_tec FOREIGN KEY (idproyec) REFERENCES proyectos (id) ON UPDATE CASCADE
);

# TABLAS PARA INCIDENCIAS
# Tabla incidencias
CREATE TABLE incidencias (
  id          INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  idpiso      INT,
  idtipologia INT,
  idseguro    INT,
  falta       DATETIME NOT NULL COMMENT 'Fecha en que entra la incidencia'
);

ALTER TABLE incidencias ADD COLUMN idprof INT;
# Relaciones incidencias
ALTER TABLE incidencias ADD CONSTRAINT FK_inc_pis FOREIGN KEY (idpiso) REFERENCES pisos (id) ON UPDATE CASCADE;
ALTER TABLE incidencias ADD CONSTRAINT FK_inc_tip FOREIGN KEY (idtipologia) REFERENCES tipologia (id) ON UPDATE CASCADE;
ALTER TABLE incidencias ADD CONSTRAINT FK_inc_pro FOREIGN KEY (idprof) REFERENCES profesionales (id) ON UPDATE CASCADE;


# tabla profesionales
CREATE TABLE profesionales (
  id          INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  razonsocial VARCHAR(100),
  cif         VARCHAR(15),
  idsector    INT,
  nombres     VARCHAR(100) COMMENT 'Persona responsable de la empresa',
  apellidos   VARCHAR(100),
  tel1        VARCHAR(15),
  tel2        VARCHAR(15),
  dir         VARCHAR(100),
  pob         VARCHAR(50),
  prov        VARCHAR(50),
  cp          VARCHAR(5)
);
ALTER TABLE profesionales ADD COLUMN comentario TEXT
ALTER TABLE profesionales ADD COLUMN cargo      VARCHAR(50)
ALTER TABLE profesionales ADD COLUMN mail       VARCHAR(100) AFTER tel2;
# Relaciones profesionales
ALTER TABLE profesionales ADD CONSTRAINT FK_pro_sec FOREIGN KEY (idsector) REFERENCES sector (id) ON UPDATE CASCADE;


# Tabla sector
CREATE TABLE sector (
  id  INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  des VARCHAR(100) COMMENT 'Tipo de sector al que pertenece la empresa, ELECTRICIDAD, FONTANERIA, REFORMAS, ETC'
);

# Tabla aseguradora
CREATE TABLE aseguradora (
  id        INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nombre    VARCHAR(100),
  tel1      VARCHAR(15),
  contacto1 VARCHAR(50),
  email1    VARCHAR(100),
  tel2      VARCHAR(15),
  contacto2 VARCHAR(50),
  email2    VARCHAR(100),
  dir       VARCHAR(100),
  pob       VARCHAR(50),
  prov      VARCHAR(50),
  cp        DECIMAL(5,0) UNSIGNED ZEROFILL NOT NULL,
  obs       TEXT
);

ALTER TABLE aseguradora ADD propietario VARCHAR(100) AFTER id           COMMENT 'Nombre del propietario';
ALTER TABLE aseguradora ADD titular     VARCHAR(100) COMMENT 'Nombre del propietario' AFTER propietario  
ALTER TABLE aseguradora ADD compania    VARCHAR(100) COMMENT 'Nombre de la compañia'  AFTER titular      ;
ALTER TABLE aseguradora DROP COLUMN nombre;


# Tabla seguros
CREATE TABLE poliza (
  id            INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  idaseg        INT COMMENT 'ID de la aseguradora',
  npoliza       VARCHAR(50) COMMENT 'Nro de la poliza',
  referencia    VARCHAR(50),
  titular       VARCHAR(100),
  femision      DATE COMMENT 'Fecha de emision de la poliza',
  fvencimiento  DATE COMMENT 'Fecha de vencimiento de la poliza',
  cobertura     TEXT COMMENT 'Breve descripcion de la cobertura de la poliza'
);

# Relaciones seguro con aseguradora
ALTER TABLE poliza ADD CONSTRAINT FK_seg_ase FOREIGN KEY (idaseg) REFERENCES aseguradora (id) ON UPDATE CASCADE;
# RENAME TABLE seguro TO poliza;

# Tabla tipologia
CREATE TABLE tipologia (
  id  INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  des VARCHAR(50)
) COMMENT 'Tipo de incidencia: SINIESTRO, INCIDENCIA, REPARACION...';

INSERT INTO prohabitat.tipologia (des)
VALUES
('SINIESTRO'),
('INCIDENCIA'),
('REPARACION'),
('MANTENIMIENTO');

# Tabla estados
CREATE TABLE estados (
  id  INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  des VARCHAR(50)
) COMMENT 'Tipo de estado: ABIERTA, INFORMADA, EN TRAMITE, CERRADA...';

INSERT INTO prohabitat.estados (des)
VALUES
('ABIERTA'),
('INFORMADA'),
('EN TAMITE'),
('EN INCIDENCIA'),
('CERRADA');


# Tabla materiales
CREATE TABLE materiales (
  id            INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  idincidencia  INT,
  des           VARCHAR(100),
  imp           DECIMAL(8,2),
  comentario    TEXT
);

# Relaciones materiales con incidencias
ALTER TABLE materiales ADD CONSTRAINT FK_mat_inc FOREIGN KEY (idincidencia) REFERENCES incidencias (id) ON UPDATE CASCADE;

 
# Tabla img
CREATE TABLE img (
  id            INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  idincidencia  INT,
  nompath       VARCHAR(200) COMMENT 'Nombre y ruta donde se guarda la imagen',
  estado        VARCHAR(50) COMMENT 'Estado de la imagen. ANTES, DESPUES o DURANTE',
  comentario    TEXT
) COMMENT 'Imagenes correspondientes a la incidencia, antes y despues';

# Relaciones img con incidencias
ALTER TABLE img ADD CONSTRAINT FK_img_inc FOREIGN KEY (idincidencia) REFERENCES incidencias (id) ON UPDATE CASCADE;
ALTER TABLE img DROP CONSTRAINT FK_img_inc;
ALTER TABLE img DROP estado;
ALTER TABLE img DROP comentario;
ALTER TABLE img DROP idincidencia;

# Tabla hisinc ahora se llama detincidencias
CREATE TABLE detincidencias (
  id        INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  idinc     INT,
  idestado  INT,
  fecha     DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  nota      TEXT
) COMMENT 'Tabla con el historial del proceso de la incidencia';

# Relaciones historial con incidencias estado
ALTER TABLE hisinc ADD CONSTRAINT FK_his_inc FOREIGN KEY (idinc) REFERENCES incidencias (id) ON UPDATE CASCADE;
ALTER TABLE hisinc ADD CONSTRAINT FK_his_est FOREIGN KEY (idestado) REFERENCES estados (id) ON UPDATE CASCADE;
RENAME TABLE prohabitat.hisinc TO detincidencias
ALTER TABLE detincidencias ADD idimg INT;
ALTER TABLE detincidencias ADD CONSTRAINT FK_det_img FOREIGN KEY (idimg) REFERENCES img (id) ON UPDATE CASCADE; 
 

CREATE TABLE empresa (
  id          INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nombre      VARCHAR(100),
  razonsocial VARCHAR(100),
  nif         VARCHAR(12),
  tel1        VARCHAR(15),
  contacto1   VARCHAR(50),
  email1      VARCHAR(100),
  tel2        VARCHAR(15),
  contacto2   VARCHAR(50),
  email2      VARCHAR(100),
  dir         VARCHAR(100),
  pob         VARCHAR(50),
  prov        VARCHAR(50),
  cp          DECIMAL(5,0) UNSIGNED ZEROFILL NOT NULL,
  logo        VARCHAR(100),
  obs         TEXT
) COMMENT 'Tabla de configuracion, datos y logo de la empresa';

ALTER TABLE empresa ADD COLUMN nomcorto  VARCHAR(15)
ALTER TABLE empresa ADD COLUMN tienelogo BOOL NOT NULL DEFAULT 0 COMMENT 'Bandera que nos permite verificar si hay logo o no';

# Tabla ci_sessions, la encargada de manejar las sesiones
CREATE TABLE IF NOT EXISTS ci_sessions (
  id          varchar(128)  NOT NULL,
  ip_address  varchar(45)   NOT NULL,
  timestamp   int(10)       unsigned DEFAULT 0 NOT NULL,
  data        blob          NOT NULL,
  KEY ci_sessions_timestamp (timestamp)
);


# ***********************************************
#                   VISTAS
# ***********************************************
# Vista Todo Facturas
CREATE OR REPLACE VIEW todo_facturas AS
SELECT facturas.id, numero, fechaf, importe, fdes, fhas,lant, lact, periodo, servicios.des AS servicio, facdoc, docu, servicios.id  AS idservicio, idpiso, escalera, puerta, planta, edificios.nombre as edificio, edificios.direccion AS edi_dir
FROM facturas
LEFT JOIN servicios ON facturas.idservicio = servicios.id
LEFT JOIN pisos     ON facturas.idpiso = pisos.id
LEFT JOIN edificios ON pisos.idEdificio = edificios.id;

# Vista Todo Pisos
CREATE OR REPLACE VIEW todo_pisos AS
SELECT pisos.id, edificios.id AS idedificio, planta, puerta, escalera, habitaciones, edificios.nombre AS nom_edificio, poliza.npoliza, poliza.id AS idpoliza
FROM pisos
LEFT JOIN edificios ON pisos.idEdificio = edificios.id
LEFT JOIN poliza    ON pisos.idpoliza   = poliza.id;

# Vista Todo Edificios, me sirve para ver la ficha con todos sus pisos
CREATE OR REPLACE VIEW todo_edificios AS
SELECT edificios.id, nombre, direccion, cp, poblacion, edificios.notas AS notas, pisos.id AS idpisos, planta, puerta, escalera, habitaciones, pisos.notas AS notaspiso
FROM edificios
LEFT JOIN pisos ON edificios.id = pisos.idEdificio;

# Vista de Inquilinos + EntSal (para modulo Entsal)
CREATE OR REPLACE VIEW inqui_entsal AS
SELECT entsal.id AS id, inquilinos.id AS idinqui, nick, CONCAT(nombres, ', ', apellidos) AS nomape, dni, telefono, fechaE, fechaS, inquilinos.piso AS tienepiso, pisos.id AS idpiso, CONCAT(edificios.nombre,', ',pisos.planta,'-',pisos.puerta) AS edipiso
FROM inquilinos
LEFT JOIN entsal    ON inquilinos.id = entsal.idinquilino
LEFT JOIN pisos  ON entsal.idpiso = pisos.id
LEFT JOIN edificios ON pisos.idEdificio = edificios.id;

# Vista con todos los datos de los pagos
CREATE OR REPLACE VIEW pagos AS
SELECT idinqui, idfactura, facturas.numero AS numfac, servicios.des AS servicio, recpagos.fecha AS fpago, facturas.fechaf AS ffactura, recpagos.fdes, recpagos.fhas, recpagos.descuento , recpagos.importe as impusr, facturas.importe as impfac, recpagos.pax, pagado, preuni, confac, conusr, inquilinos.nick  
FROM recpagos
LEFT JOIN inquilinos ON inquilinos.id = recpagos.idinqui
LEFT JOIN facturas   ON recpagos.idfactura = facturas.id
LEFT JOIN servicios  ON facturas.idservicio = servicios.id; 

# Vista de tecnicoa y sus perfiles
CREATE OR REPLACE VIEW tec_perfiles AS
SELECT tecnicos.id as idtecnico, nombres, apellidos, nomcorto, dni, telefono, mail, perfiles.id as idperfil, nomusr, psw, nivel, descnivel
FROM prohabitat.tecnicos
LEFT JOIN perfiles ON perfiles.idtecnico = tecnicos.id;

# VISTA Facturas pendientes de pago
CREATE OR REPLACE VIEW fac_ptes AS
SELECT idfactura, numfac, ffactura, servicio, sum(impusr) as imppte, impfac, pagado 
FROM pagos 
GROUP BY idfactura, pagado
HAVING !pagado;

# VISTA Facturas Pagadas 
CREATE OR REPLACE VIEW fac_pagadas AS
SELECT idfactura, numfac, ffactura, servicio, sum(impusr) as impusr, impfac, pagado 
FROM pagos 
GROUP BY idfactura, pagado
HAVING pagado AND (ABS(impusr) = ABS(impfac));

#VISTA completa de profesionaeles con sector de trabajo
CREATE OR REPLACE VIEW todo_profesional AS
SELECT profesionales.*, sector.des AS sector
FROM prohabitat.profesionales
LEFT JOIN sector ON sector.id = profesionales.idsector;

#VISTA completa de polizas con la aseguradora
CREATE OR REPLACE VIEW todo_poliza AS
SELECT poliza.id, npoliza, referencia, poliza.titular AS titular, femision, fvencimiento, cobertura, aseguradora.id AS idaseg, aseguradora.propietario AS asegprop, aseguradora.titular AS asegtit, aseguradora.compania AS asegcomp
FROM prohabitat.poliza
RIGHT JOIN aseguradora ON aseguradora.id = poliza.idaseg;


# PROCEDIMIENTOS ALMACENADOS
# Procedimiento 
DELIMITER //
CREATE OR REPLACE PROCEDURE userxfactura (
  IN finicio DATE,
  IN ffinal  DATE,
  IN piso    INT
) 
BEGIN
	SELECT entsal.id AS id, idinquilino, idpiso, inquilinos.descuento , inquilinos.nick AS usuario, inquilinos.pax AS pax, ocupado, fechaE, lgasE, lluzE, laguaE, fechaS, lgasS, lluzS, laguaS, notas
	FROM entsal
	INNER JOIN inquilinos ON inquilinos.id = entsal.idinquilino
	WHERE idpiso = piso AND ((fechaE BETWEEN finicio AND ffinal) OR (fechaS BETWEEN finicio AND ffinal) OR (fechaE <= finicio AND fechaS IS NULL) OR (fechaE <= finicio and fechaS >= ffinal ));
END
//
DELIMITER ;

# Modo de Uso
CALL userxfactura('2020-03-01', '2020-05-30', 7)
#DROP PROCEDURE userxfactura
# CONSULTAS





# PRUEBAS...
# -----------------------------------------------------------------------------
SELECT * FROM todo_edificios WHERE id = 5;
SELECT DISTINCT id, nombre FROM todo_edificios;
# Diferencia entre fechas
SELECT fdes, fhas, TIMESTAMPDIFF(day, fdes, fhas) AS dias FROM facturas;
SELECT fdes, fhas, DATEDIFF(fhas, fdes) AS dias FROM facturas;

SELECT entsal.id AS id, idinquilino, idpiso, inquilinos.nick AS usuario, ocupado, fechaE, lgasE, lluzE, laguaE, fechaS, lgasS, lluzS, laguaS, notas
FROM entsal
INNER JOIN inquilinos ON inquilinos.id = entsal.idinquilino
WHERE idpiso = 6 AND ((fechaE BETWEEN '2019-09-13' AND '2019-12-12') OR (fechaS BETWEEN '2019-09-13' AND '2019-12-12') OR (fechaE <= '2019-09-13' AND fechaS IS NULL )) 
					 

show create PROCEDURE userxfactura;
					 
SELECT * FROM `pagos` WHERE `idfactura` = '3'	

UPDATE prohabitat.inquilinos SET descuento = 0;
UPDATE prohabitat.facturas   SET facdoc = 'No ha subido Archivo';
SELECT * FROM pagos WHERE idfactura=3;

SELECT curdate()

SELECT tecnicos.id as idtecnico, nombres, apellidos, nomcorto, dni, telefono, mail, perfiles.id as idperfil, nomusr, psw, nivel, descnivel
FROM prohabitat.tecnicos
LEFT JOIN perfiles ON perfiles.idtecnico = tecnicos.id;

# Facturas Pagadas
SELECT idfactura, sum(impusr) as impusr, impfac, pagado
FROM pagos 
GROUP BY idfactura, pagado
HAVING pagado AND (ABS(impusr) = ABS(impfac));
# Facturas pendientes de pago
SELECT idfactura, sum(impusr) as impusr, impfac, pagado
FROM pagos 
GROUP BY idfactura, pagado
HAVING !pagado;

SELECT *
FROM prohabitat.fac_ptes fp
WHERE YEAR(ffactura) = 2020;

DESCRIBE prohabitat.pisos ;

# Fin de pruebas
# ------------------------------------------------------------------------------