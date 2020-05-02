use pruebas;

CREATE TABLE IF NOT EXISTS ci_sessions (
        id varchar(128) NOT NULL,
        ip_address varchar(45) NOT NULL,
        timestamp int(10) unsigned DEFAULT 0 NOT NULL,
        data blob NOT NULL,
        KEY ci_sessions_timestamp (timestamp)
);

CREATE TABLE clientes (
id         INT NOT NULL AUTO_INCREMENT,
nombres    VARCHAR(100),
apellidos  VARCHAR(100),
dni        VARCHAR(10),
mail       VARCHAR(200),
dir        VARCHAR(200),
cp         VARCHAR(200),
localidad  VARCHAR(100),
provincia  VARCHAR(100),
tel1       VARCHAR(15),
tel2       VARCHAR(15),
comentario TEXT,
PRIMARY KEY (id)
);

CREATE TABLE usuarios (
id         INT NOT NULL AUTO_INCREMENT,
nick       VARCHAR(50),
psw        VARCHAR(50),
nombres    VARCHAR(100),
apellidos  VARCHAR(100),
mail       VARCHAR(200),
PRIMARY KEY (id)
)

