CREATE DATABASE IF NOT EXISTS parcial;
USE parcial;

-- -----------------------------------------------------
-- Table `usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS usuario (
  email VARCHAR(50) NOT NULL,
  contraseña VARCHAR(45) NOT NULL,
  imagen TEXT NOT NULL,
  telefono BIGINT NOT NULL,
  nombre VARCHAR(100) NOT NULL,
  cargo INT ZEROFILL NOT NULL,
  PRIMARY KEY (email)
);

-- -----------------------------------------------------
-- Table `dispositivo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS dispositivo (
  idDispositivo INT NOT NULL AUTO_INCREMENT,
  fcm_token TEXT NOT NULL,
  usuario_email VARCHAR(50) NOT NULL,
  PRIMARY KEY (idDispositivo),
  CONSTRAINT fk_Dispositivo_usuario1
    FOREIGN KEY (usuario_email)
    REFERENCES usuario (email)
);

-- -----------------------------------------------------
-- Table `mensaje`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS mensaje (
  idmensaje INT NOT NULL AUTO_INCREMENT,
  titulo VARCHAR(45) NOT NULL,
  contenido TEXT NOT NULL,
  tiempo TIMESTAMP NOT NULL,
  email_destinatario VARCHAR(50) NOT NULL,
  email_origen VARCHAR(50) NOT NULL,
  PRIMARY KEY (idmensaje),
  CONSTRAINT fk_mensaje_usuario1
    FOREIGN KEY (email_destinatario)
    REFERENCES usuario (email)
);

-- -----------------------------------------------------
-- Table `dispositivo_has_mensaje`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS dispositivo_has_mensaje (
  dispositivo_idDispositivo INT NOT NULL,
  mensaje_idmensaje INT NOT NULL,
  PRIMARY KEY (dispositivo_idDispositivo, mensaje_idmensaje),
  CONSTRAINT fk_dispositivo_has_mensaje_dispositivo1
    FOREIGN KEY (dispositivo_idDispositivo)
    REFERENCES dispositivo (idDispositivo),
  CONSTRAINT fk_dispositivo_has_mensaje_mensaje1
    FOREIGN KEY (mensaje_idmensaje)
    REFERENCES mensaje (idmensaje)
);
