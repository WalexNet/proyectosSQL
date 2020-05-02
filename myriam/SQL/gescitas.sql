use gescitas;

# Tabla sessions, se guardan las sessiones de los usuarios/clientes
CREATE TABLE IF NOT EXISTS ci_sessions (
  id          varchar(128)  NOT NULL,
  ip_address  varchar(45)   NOT NULL,
  timestamp   int(10)       unsigned DEFAULT 0 NOT NULL,
  data        blob          NOT NULL,
KEY ci_sessions_timestamp (timestamp)
);

# Tabla clientes
CREATE TABLE clientes (
  id         INT NOT NULL AUTO_INCREMENT,
  nombres    VARCHAR(100),
  apellidos  VARCHAR(100),
  dni        VARCHAR(10),
  mail       VARCHAR(200),
  psw        VARCHAR(50),
  dir        VARCHAR(200),
  cp         VARCHAR(200),
  localidad  VARCHAR(100),
  provincia  VARCHAR(100),
  tel1       VARCHAR(15),
  tel2       VARCHAR(15),
  comentario TEXT,
PRIMARY KEY (id)
);

ALTER TABLE clientes ADD COLUMN mailhash   VARCHAR(65) COMMENT 'Guardamos el Hash de la mail mas timestamp, para enviar como clave y comprobarlo';
ALTER TABLE clientes ADD COLUMN verificado BOOLEAN NOT NULL DEFAULT 0 COMMENT 'Si TRUE mail verificado';

UPDATE clientes SET verificado = false WHERE id=9

# Tabla citas
CREATE TABLE citas (
  id          INT NOT NULL AUTO_INCREMENT,
  idcliente   INT,
  title       VARCHAR(50),
  descripcion VARCHAR(100),
  start       DATETIME,
  end         DATETIME,
  color       VARCHAR(10) DEFAULT '#9a5680' NOT NULL,
  textcolor   VARCHAR(10) DEFAULT '#000000' NOT NULL,
  editable    BIT DEFAULT 0 NOT NULL,
PRIMARY KEY (id)
);

ALTER TABLE citas ADD pago BIT DEFAULT 0 NOT NULL;
ALTER TABLE citas ADD CONSTRAINT FK_cli_ci FOREIGN KEY (idcliente) REFERENCES clientes(id) ON UPDATE CASCADE;


# Tabla hisnotas, aqui estara el historial de visitas y notas de los clientes
CREATE TABLE hisnotas (
  id        INT NOT NULL AUTO_INCREMENT,
  fecha     DATETIME,
  notas     TEXT,
PRIMARY KEY (id)
);

ALTER TABLE hisnotas ADD idcita INT;
ALTER TABLE hisnotas ADD CONSTRAINT FK_cit_his FOREIGN KEY (idcita) REFERENCES citas(id) ON UPDATE CASCADE;



# PRUEBAS

SELECT * from clientes WHERE psw = md5(1234); 

DELETE FROM citas WHERE start = '';

SELECT * FROM clientes WHERE mailhash = 'dc7f32c0c57b83516b093d7f2d04f331'


