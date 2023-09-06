show databases ;

use sql9644232;

show tables;


-- Creación de la tabla Administrador
CREATE TABLE Administrador (
                               idAdmin BIGINT PRIMARY KEY AUTO_INCREMENT,
                               nombre VARCHAR(128),
                               clave VARCHAR(128),
                               email VARCHAR(128)
);

-- Creación de la tabla Sede
CREATE TABLE Sede (
                      idSede BIGINT PRIMARY KEY AUTO_INCREMENT,
                      nombre VARCHAR(128)
);

-- Creación de la tabla PlanEstudios
CREATE TABLE PlanEstudios (
                              idPlanEstudios BIGINT PRIMARY KEY AUTO_INCREMENT,
                              nombre VARCHAR(128)
);


-- Creación de la tabla Periodo
CREATE TABLE Periodo (
                         idPeriodo BIGINT PRIMARY KEY AUTO_INCREMENT,
                         semestre INT,
                         periodo DATE
);

-- Creación de la tabla Curso
CREATE TABLE Curso (
                       idCurso BIGINT PRIMARY KEY AUTO_INCREMENT,
                       codigo VARCHAR(128),
                       nombre VARCHAR(128)
);


-- Creación de la tabla cursoXperiodo
CREATE TABLE cursoXperiodo (
                               idCursoPeriodo BIGINT PRIMARY KEY AUTO_INCREMENT,
                               fkCurso BIGINT,
                               fkPeriodo BIGINT,
                               FOREIGN KEY (fkCurso) REFERENCES Curso(idCurso),
                               FOREIGN KEY (fkPeriodo) REFERENCES Periodo(idPeriodo)
);

-- Creación de la tabla Formulario
CREATE TABLE Formulario (
                            idFormulario BIGINT PRIMARY KEY AUTO_INCREMENT,
                            fechaVencimiento DATETIME,
                            nombre VARCHAR(64),
                            fkPeriodo BIGINT,
                            FOREIGN KEY (fkPeriodo) REFERENCES Periodo(idPeriodo)
);

-- Creación de la tabla Solicitud
CREATE TABLE Solicitud (
                           idSolicitud BIGINT PRIMARY KEY AUTO_INCREMENT,
                           carnet INT,
                           nombreCompleto VARCHAR(256),
                           fkPlanEstudios BIGINT,
                           fkFormulario BIGINT,
                           fkSede BIGINT,
                           comentario VARCHAR(256),
                           email VARCHAR(128),
                           razon VARCHAR(256),
                           estado BIT,
                           notificado BIT,
                           comentarioEncargado VARCHAR(128),
                           FOREIGN KEY (fkPlanEstudios) REFERENCES PlanEstudios(idPlanEstudios),
                           FOREIGN KEY (fkFormulario) REFERENCES Formulario(idFormulario),
                           FOREIGN KEY (fkSede) REFERENCES Sede(idSede)
);

alter table Solicitud add (
    token VARCHAR(128)
    );

-- Creación de la tabla SolicitudReq
CREATE TABLE SolicitudReq (
                              fkSolicitud BIGINT,
                              fkCursoLevantar BIGINT,
                              fkCursoMatricular BIGINT,
                              FOREIGN KEY (fkSolicitud) REFERENCES Solicitud(idSolicitud),
                              FOREIGN KEY (fkCursoLevantar) REFERENCES Curso(idCurso),
                              FOREIGN KEY (fkCursoMatricular) REFERENCES Curso(idCurso)
);

-- Creación de la tabla SolicitudRN
CREATE TABLE SolicitudRN (
                             fkSolicitud BIGINT,
                             nivelRN INT,
                             FOREIGN KEY (fkSolicitud) REFERENCES Solicitud(idSolicitud)
);

-- Creación de la tabla cursosrnXsolicitudRN
CREATE TABLE cursosrnXsolicitudRN (
                                      idCursosrnXsolicitudRN BIGINT PRIMARY KEY AUTO_INCREMENT,
                                      fkSolicitudRN BIGINT,
                                      fkCurso BIGINT,
                                      FOREIGN KEY (fkSolicitudRN) REFERENCES SolicitudRN(fkSolicitud),
                                      FOREIGN KEY (fkCurso) REFERENCES Curso(idCurso)
);

-- Creación de la tabla cursosmXsolicitudRN
CREATE TABLE cursosmXsolicitudRN (
                                     idCursosmXsolicitudRN BIGINT PRIMARY KEY AUTO_INCREMENT,
                                     fkSolicitudRN BIGINT,
                                     fkCurso BIGINT,
                                     FOREIGN KEY (fkSolicitudRN) REFERENCES SolicitudRN(fkSolicitud),
                                     FOREIGN KEY (fkCurso) REFERENCES Curso(idCurso)
);

-- Procedimiento almacenado para INSERT (Crear) un nuevo Administrador
DELIMITER //
CREATE PROCEDURE InsertarAdministrador(
    IN p_nombre VARCHAR(128),
    IN p_clave VARCHAR(128),
    IN p_email VARCHAR(128)
)
BEGIN
    INSERT INTO Administrador (nombre, clave, email)
    VALUES (p_nombre, p_clave, p_email);
END //
DELIMITER ;

-- Procedimiento almacenado para SELECT (Leer) todos los Administradores
DELIMITER //
CREATE PROCEDURE ListarAdministradores()
BEGIN
    SELECT idAdmin, nombre, email
    FROM Administrador;
END //
DELIMITER ;

-- Procedimiento almacenado para SELECT (Leer) un Administrador por su ID
DELIMITER //
CREATE PROCEDURE ObtenerAdministradorPorID(
    IN p_idAdmin BIGINT
)
BEGIN
    SELECT idAdmin, nombre, email
    FROM Administrador
    WHERE idAdmin = p_idAdmin;
END //
DELIMITER ;

-- Procedimiento almacenado para UPDATE (Actualizar) un Administrador por su ID
DELIMITER //
CREATE PROCEDURE ActualizarAdministrador(
    IN p_idAdmin BIGINT,
    IN p_nombre VARCHAR(128),
    IN p_clave VARCHAR(128),
    IN p_email VARCHAR(128)
)
BEGIN
    UPDATE Administrador
    SET nombre = p_nombre, clave = p_clave, email = p_email
    WHERE idAdmin = p_idAdmin;
END //
DELIMITER ;

-- Procedimiento almacenado para DELETE (Eliminar) un Administrador por su ID
DELIMITER //
CREATE PROCEDURE VerificarCredenciales(
    IN p_email VARCHAR(128),
    IN p_clave VARCHAR(128)
)
BEGIN
    DECLARE adminCount INT;

    SELECT COUNT(*) INTO adminCount
    FROM Administrador
    WHERE email = p_email AND clave = p_clave;

    IF adminCount = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Credenciales inválidas';
    ELSE
        SELECT idAdmin, nombre, email
        FROM Administrador
        WHERE email = p_email AND clave = p_clave;
    END IF;
END //
DELIMITER ;

-- Procedimiento almacenado para INSERT (Crear) una nueva Sede
DELIMITER //
CREATE PROCEDURE InsertarSede(
    IN p_nombre VARCHAR(128)
)
BEGIN
    INSERT INTO Sede (nombre)
    VALUES (p_nombre);
END //
DELIMITER ;

-- Procedimiento almacenado para SELECT (Leer) todas las Sedes
DELIMITER //
CREATE PROCEDURE ListarSedes()
BEGIN
    SELECT idSede, nombre
    FROM Sede;
END //
DELIMITER ;

-- Procedimiento almacenado para SELECT (Leer) una Sede por su ID
DELIMITER //
CREATE PROCEDURE ObtenerSedePorID(
    IN p_idSede BIGINT
)
BEGIN
    SELECT idSede, nombre
    FROM Sede
    WHERE idSede = p_idSede;
END //
DELIMITER ;

-- Procedimiento almacenado para UPDATE (Actualizar) una Sede por su ID
DELIMITER //
CREATE PROCEDURE ActualizarSede(
    IN p_idSede BIGINT,
    IN p_nombre VARCHAR(128)
)
BEGIN
    UPDATE Sede
    SET nombre = p_nombre
    WHERE idSede = p_idSede;
END //
DELIMITER ;

-- Procedimiento almacenado para DELETE (Eliminar) una Sede por su ID
DELIMITER //
CREATE PROCEDURE EliminarSede(
    IN p_idSede BIGINT
)
BEGIN
    DECLARE sedeCount INT;

    -- Verificar si hay solicitudes asociadas a la sede
    SELECT COUNT(*) INTO sedeCount
    FROM Solicitud
    WHERE fkSede = p_idSede;

    IF sedeCount > 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'No se puede eliminar la sede debido a solicitudes asociadas';
    ELSE
        DELETE FROM Sede
        WHERE idSede = p_idSede;
    END IF;
END //
DELIMITER ;

select * from Formulario;
-- Procedimiento almacenado para INSERT (Crear) un nuevo Plan de Estudios
DELIMITER //
CREATE PROCEDURE InsertarPlanEstudios(
    IN p_nombre VARCHAR(128)
)
BEGIN
    INSERT INTO PlanEstudios (nombre)
    VALUES (p_nombre);
END //
DELIMITER ;

-- Procedimiento almacenado para SELECT (Leer) todos los Planes de Estudios
DELIMITER //
CREATE PROCEDURE ListarPlanesEstudios()
BEGIN
    SELECT idPlanEstudios, nombre
    FROM PlanEstudios;
END //
DELIMITER ;

-- Procedimiento almacenado para SELECT (Leer) un Plan de Estudios por su ID
DELIMITER //
CREATE PROCEDURE ObtenerPlanEstudiosPorID(
    IN p_idPlanEstudios BIGINT
)
BEGIN
    SELECT idPlanEstudios, nombre
    FROM PlanEstudios
    WHERE idPlanEstudios = p_idPlanEstudios;
END //
DELIMITER ;

-- Procedimiento almacenado para UPDATE (Actualizar) un Plan de Estudios por su ID
DELIMITER //
CREATE PROCEDURE ActualizarPlanEstudios(
    IN p_idPlanEstudios BIGINT,
    IN p_nombre VARCHAR(128)
)
BEGIN
    UPDATE PlanEstudios
    SET nombre = p_nombre
    WHERE idPlanEstudios = p_idPlanEstudios;
END //
DELIMITER ;

-- Procedimiento almacenado para DELETE (Eliminar) un Plan de Estudios por su ID
DELIMITER //
CREATE PROCEDURE EliminarPlanEstudios(
    IN p_idPlanEstudios BIGINT
)
BEGIN
    DECLARE solicitudCount INT;

    -- Verificar si hay solicitudes asociadas al plan de estudios
    SELECT COUNT(*) INTO solicitudCount
    FROM Solicitud
    WHERE fkPlanEstudios = p_idPlanEstudios;

    IF solicitudCount > 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'No se puede eliminar el plan de estudios debido a solicitudes asociadas';
    ELSE
        DELETE FROM PlanEstudios
        WHERE idPlanEstudios = p_idPlanEstudios;
    END IF;
END //
DELIMITER ;


show procedure status ;

-- Procedimiento almacenado para INSERT (Crear) un nuevo Curso
DELIMITER //
CREATE PROCEDURE InsertarCurso(
    IN p_codigo VARCHAR(128),
    IN p_nombre VARCHAR(128)
)
BEGIN
    DECLARE cursoCount INT;

    -- Verificar si ya existe un curso con el mismo código
    SELECT COUNT(*) INTO cursoCount
    FROM Curso
    WHERE codigo = p_codigo;

    IF cursoCount > 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Ya existe un curso con el mismo código';
    ELSE
        INSERT INTO Curso (codigo, nombre)
        VALUES (p_codigo, p_nombre);
    END IF;
END //
DELIMITER ;

-- Procedimiento almacenado para SELECT (Leer) todos los Cursos
DELIMITER //
CREATE PROCEDURE ListarCursos()
BEGIN
    SELECT idCurso, codigo, nombre
    FROM Curso;
END //
DELIMITER ;

-- Procedimiento almacenado para SELECT (Leer) un Curso por su ID
DELIMITER //
CREATE PROCEDURE ObtenerCursoPorID(
    IN p_idCurso BIGINT
)
BEGIN
    SELECT idCurso, codigo, nombre
    FROM Curso
    WHERE idCurso = p_idCurso;
END //
DELIMITER ;

-- Procedimiento almacenado para UPDATE (Actualizar) un Curso por su ID
DELIMITER //
CREATE PROCEDURE ActualizarCurso(
    IN p_idCurso BIGINT,
    IN p_codigoNuevo VARCHAR(128),
    IN p_nombre VARCHAR(128)
)
BEGIN
    DECLARE cursoCount INT;

    -- Verificar si ya existe un curso con el mismo código nuevo
    SELECT COUNT(*) INTO cursoCount
    FROM Curso
    WHERE codigo = p_codigoNuevo AND idCurso <> p_idCurso;

    IF cursoCount > 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Ya existe un curso con el mismo código nuevo';
    ELSE
        UPDATE Curso
        SET codigo = p_codigoNuevo, nombre = p_nombre
        WHERE idCurso = p_idCurso;
    END IF;
END //
DELIMITER ;

-- Procedimiento almacenado para DELETE (Eliminar) un Curso por su ID
DELIMITER //
CREATE PROCEDURE EliminarCurso(
    IN p_idCurso BIGINT
)
BEGIN
    DECLARE cursosrnXsolicitudRNCount INT;
    DECLARE cursosmXsolicitudRNCount INT;
    DECLARE solicitudReqCount INT;
    DECLARE cursoXperiodoCount INT;

    -- Verificar si hay registros asociados al curso
    SELECT COUNT(*) INTO cursosrnXsolicitudRNCount
    FROM cursosrnXsolicitudRN
    WHERE fkCurso = p_idCurso;

    SELECT COUNT(*) INTO cursosmXsolicitudRNCount
    FROM cursosmXsolicitudRN
    WHERE fkCurso = p_idCurso;

    SELECT COUNT(*) INTO solicitudReqCount
    FROM SolicitudReq
    WHERE fkCursoLevantar = p_idCurso OR fkCursoMatricular = p_idCurso;

    SELECT COUNT(*) INTO cursoXperiodoCount
    FROM cursoXperiodo
    WHERE fkCurso = p_idCurso;

    IF cursosrnXsolicitudRNCount > 0 OR cursosmXsolicitudRNCount > 0 OR solicitudReqCount > 0 OR cursoXperiodoCount > 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'No se puede eliminar el curso debido a registros asociados';
    ELSE
        DELETE FROM Curso
        WHERE idCurso = p_idCurso;
    END IF;
END //
DELIMITER ;
-- Procedimiento para insertar un nuevo registro en la tabla cursosXsolicitudRN
DELIMITER //
CREATE PROCEDURE InsertarCursoXsolicitudRN(
    IN p_fkSolicitudRN BIGINT,
    IN p_fkCurso BIGINT
)
BEGIN
    -- Verificar si el curso existe antes de insertar
    DECLARE cursoExistente INT;
    SET cursoExistente = (SELECT COUNT(*) FROM Curso WHERE idCurso = p_fkCurso);

    IF cursoExistente > 0 THEN
        INSERT INTO cursosrnXsolicitudRN(fkSolicitudRN, fkCurso)
        VALUES (p_fkSolicitudRN, p_fkCurso);
    ELSE
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'El curso no existe.';
    END IF;
END //
DELIMITER ;


-- Procedimiento para actualizar un registro en la tabla cursosXsolicitudRN
DELIMITER //
CREATE PROCEDURE ActualizarCursoXsolicitudRN(
    IN p_idCursosrnXsolicitudRN BIGINT,
    IN p_fkSolicitudRN BIGINT,
    IN p_fkCurso BIGINT
)
BEGIN
    -- Verificar si el curso existe antes de actualizar
    DECLARE cursoExistente INT;
    SET cursoExistente = (SELECT COUNT(*) FROM Curso WHERE idCurso = p_fkCurso);

    IF cursoExistente > 0 THEN
        UPDATE cursosrnXsolicitudRN
        SET fkSolicitudRN = p_fkSolicitudRN,
            fkCurso = p_fkCurso
        WHERE idCursosrnXsolicitudRN = p_idCursosrnXsolicitudRN;
    ELSE
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'El curso no existe.';
    END IF;
END //
DELIMITER ;


-- Procedimiento para eliminar un registro de la tabla cursosXsolicitudRN
DELIMITER //
CREATE PROCEDURE EliminarCursoXsolicitudRN(
    IN p_idCursosrnXsolicitudRN BIGINT
)
BEGIN
    DELETE FROM cursosrnXsolicitudRN
    WHERE idCursosrnXsolicitudRN = p_idCursosrnXsolicitudRN;
END //
DELIMITER ;


-- Procedimiento para obtener los registros de cursosmXsolicitudRN de una solicitud específica
DELIMITER //

CREATE PROCEDURE ObtenerCursosXsolicitudRNDeSolicitudId(
    IN p_fkSolicitudRN BIGINT
)
BEGIN
    SELECT C.codigo, C.nombre
    FROM cursosrnXsolicitudRN AS CXSRN
             INNER JOIN Curso AS C ON CXSRN.fkCurso = C.idCurso
    WHERE CXSRN.fkSolicitudRN = p_fkSolicitudRN;
END //

DELIMITER ;

-- Procedimiento para insertar un nuevo registro en la tabla cursosmXsolicitudRN
DELIMITER //
CREATE PROCEDURE InsertarCursoMXsolicitudRN(
    IN p_fkSolicitudRN BIGINT,
    IN p_fkCurso BIGINT
)
BEGIN
    -- Verificar si el curso existe antes de insertar
    DECLARE cursoExistente INT;
    SET cursoExistente = (SELECT COUNT(*) FROM Curso WHERE idCurso = p_fkCurso);

    IF cursoExistente > 0 THEN
        INSERT INTO cursosmXsolicitudRN(fkSolicitudRN, fkCurso)
        VALUES (p_fkSolicitudRN, p_fkCurso);
    ELSE
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'El curso no existe.';
    END IF;
END //
DELIMITER ;

-- Procedimiento para actualizar un registro en la tabla cursosmXsolicitudRN
DELIMITER //
CREATE PROCEDURE ActualizarCursoMXsolicitudRN(
    IN p_idCursosmXsolicitudRN BIGINT,
    IN p_fkSolicitudRN BIGINT,
    IN p_fkCurso BIGINT
)
BEGIN
    -- Verificar si el curso existe antes de actualizar
    DECLARE cursoExistente INT;
    SET cursoExistente = (SELECT COUNT(*) FROM Curso WHERE idCurso = p_fkCurso);

    IF cursoExistente > 0 THEN
        UPDATE cursosmXsolicitudRN
        SET fkSolicitudRN = p_fkSolicitudRN,
            fkCurso = p_fkCurso
        WHERE idCursosmXsolicitudRN = p_idCursosmXsolicitudRN;
    ELSE
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'El curso no existe.';
    END IF;
END //
DELIMITER ;

-- Procedimiento para eliminar un registro de la tabla cursosmXsolicitudRN
DELIMITER //
CREATE PROCEDURE EliminarCursoMXsolicitudRN(
    IN p_idCursosmXsolicitudRN BIGINT
)
BEGIN
    DELETE FROM cursosmXsolicitudRN
    WHERE idCursosmXsolicitudRN = p_idCursosmXsolicitudRN;
END //
DELIMITER ;

-- Procedimiento para obtener todos los registros de la tabla cursosmXsolicitudRN
DELIMITER //
CREATE PROCEDURE ObtenerCursosMXsolicitudRN()
BEGIN
    SELECT * FROM cursosmXsolicitudRN;
END //
DELIMITER ;


-- Procedimiento para obtener los registros de cursosmXsolicitudRN de una solicitud específica
DELIMITER //

CREATE PROCEDURE ObtenerCursosMXsolicitudRNDeSolicitudId(
    IN p_fkSolicitudRN BIGINT
)
BEGIN
    SELECT C.codigo AS codigo_curso, C.nombre AS nombre_curso
    FROM cursosmXsolicitudRN AS CMX
             JOIN Curso AS C ON CMX.fkCurso = C.idCurso
    WHERE CMX.fkSolicitudRN = p_fkSolicitudRN;
END //

DELIMITER ;

CALL InsertarSolicitudRnConCursos(202077101,'Juan Perez',5,'ljrivel16@gmail.com','prueba121','',2,1,'',1,'[1,2]','[1,2]');

-- validar que el plan exista
-- Procedimiento para insertar registros en solicitudRN con cursos
DELIMITER //
CREATE PROCEDURE InsertarSolicitudRnConCursos(
    IN p_carnet INT,
    IN p_nombreCompleto VARCHAR(256),
    IN v_fkPlanEstudios BIGINT,
    IN p_email VARCHAR(128),
    IN p_token VARCHAR(128),
    IN p_comentario VARCHAR(256),
    IN p_fkFormulario BIGINT,
    IN p_fkSede BIGINT,
    IN p_razon VARCHAR(128),
    IN p_nivelRn INT,
    IN p_cursosMXRNString VARCHAR(500), -- Formato: ["id1","id2","id3"...]
    IN p_cursosRNString VARCHAR(500) -- Formato: ["id1","id2","id3"...]

)
BEGIN
    DECLARE v_fkFormularioExist INT;
    DECLARE v_idSolicitud BIGINT;
    DECLARE v_cursoID INT;
    DECLARE v_elementos INT;
    DECLARE v_elementos2 INT;
    DECLARE i INT DEFAULT 0;
    DECLARE j INT DEFAULT 0;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION ROLLBACK;

    SET v_fkFormularioExist = (SELECT COUNT(*) FROM Formulario WHERE idFormulario = p_fkFormulario);

    IF v_fkFormularioExist > 0 THEN


        START TRANSACTION;

-- Insertar en la tabla solicitud
        INSERT INTO Solicitud(carnet, nombreCompleto, fkPlanEstudios, email, fkFormulario, fkSede, comentario, token, estado, notificado, comentarioEncargado, razon)
        VALUES (p_carnet, p_nombreCompleto, v_fkPlanEstudios, p_email, p_fkFormulario, p_fkSede, p_comentario, p_token, 0, 0, '', p_razon);

        SET v_idSolicitud = LAST_INSERT_ID();

        -- Insertar en la tabla solicitudRN
        INSERT INTO SolicitudRN(fkSolicitud, nivelRN)
        VALUES (v_idSolicitud, p_nivelRn);

        -- Insertar en la tabla cursosrnXsolicitudRN

-- Eliminar los corchetes "[" y "]" del parámetro
        SET p_cursosRNString = TRIM(BOTH '[]' FROM p_cursosRNString);
        -- Contar los elementos separados por comas
        SET v_elementos2 = LENGTH(p_cursosRNString) - LENGTH(REPLACE(p_cursosRNString, ',', '')) + 1;


        WHILE i < v_elementos2 DO

                SET v_cursoID = CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(p_cursosRNString, ',', i + 1), ',', -1) AS UNSIGNED);

                IF EXISTS (SELECT * FROM Curso WHERE idCurso = v_cursoID) THEN
                    INSERT INTO cursosrnXsolicitudRN(fkSolicitudRN, fkCurso)
                    VALUES (v_idSolicitud, v_cursoID);
                END IF;

                SET i = i + 1;
            END WHILE;

        -- Insertar en la tabla cursosmXsolicitudRN

        -- Eliminar los corchetes "[" y "]" del parámetro
        SET p_cursosMXRNString = TRIM(BOTH '[]' FROM p_cursosMXRNString);

        -- Contar los elementos separados por comas
        SET v_elementos = LENGTH(p_cursosMXRNString) - LENGTH(REPLACE(p_cursosMXRNString, ',', '')) + 1;

        WHILE j < v_elementos DO

                SET v_cursoID = CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(p_cursosMXRNString, ',', j + 1), ',', -1) AS UNSIGNED);

                IF EXISTS (SELECT * FROM Curso WHERE idCurso = v_cursoID) THEN
                    INSERT INTO cursosmXsolicitudRN(fkSolicitudRN, fkCurso)
                    VALUES (v_idSolicitud, v_cursoID);
                END IF;

                SET j = j + 1;
            END WHILE;

        COMMIT;
    ELSE
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'El plan de estudios no existe o el formulario asociado no existe.';
    END IF;
END //
DELIMITER ;


DELIMITER //


CREATE PROCEDURE EliminarSolicitudRNYRegistros(
    IN p_carnet INT,
    IN p_token VARCHAR(128)
)
BEGIN
    DECLARE v_fkSolicitudRN BIGINT;

    SELECT idSolicitud INTO v_fkSolicitudRN
    FROM Solicitud
    WHERE carnet = p_carnet AND token = p_token;

    IF v_fkSolicitudRN IS NOT NULL THEN


        -- Eliminar registros de cursosrnXsolicitudRN
        DELETE FROM cursosrnXsolicitudRN WHERE fkSolicitudRN = v_fkSolicitudRN;

        -- Eliminar registros de cursosmXsolicitudRN
        DELETE FROM cursosmXsolicitudRN WHERE fkSolicitudRN = v_fkSolicitudRN;

        -- Eliminar solicitudRN
        DELETE FROM SolicitudRN WHERE fkSolicitud = v_fkSolicitudRN;

        -- Eliminar solicitud
        DELETE FROM Solicitud WHERE idSolicitud = v_fkSolicitudRN;

    ELSE
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'No se encontró una solicitud con el carnet y token especificados.';
    END IF;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE InsertarSolicitudReq(
    IN p_carnet INT,
    IN p_nombreCompleto VARCHAR(256),
    IN p_fkPlanEstudios BIGINT,
    IN p_email VARCHAR(128),
    IN p_token VARCHAR(128),
    IN p_comentario VARCHAR(256),
    IN p_fkFormulario BIGINT,
    IN p_fkSede BIGINT,
    IN p_razon VARCHAR(128),
    IN p_fkCursoLevantar BIGINT,
    IN p_fkCursoMatricular BIGINT
)
BEGIN

    START TRANSACTION;

    -- Insertar en la tabla solicitud
    INSERT INTO Solicitud(carnet, nombreCompleto, fkPlanEstudios, email, fkFormulario, fkSede, comentario, token, estado, notificado, comentarioEncargado, razon)
    VALUES (p_carnet, p_nombreCompleto, p_fkPlanEstudios, p_email, p_fkFormulario, p_fkSede, p_comentario, p_token, 0, 0, '', p_razon);

    -- Obtener el ID de la solicitud recién insertada
    SET @lastSolicitudID = LAST_INSERT_ID();

    -- Insertar en la tabla solicitudReq utilizando la herencia
    INSERT INTO SolicitudReq(fkSolicitud, fkCursoLevantar, fkCursoMatricular)
    VALUES (@lastSolicitudID, p_fkCursoLevantar, p_fkCursoMatricular);

    COMMIT;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE EliminarSolicitudReq(
    IN p_carnet INT,
    IN p_token VARCHAR(128)
)
BEGIN
    DECLARE v_idSolicitud BIGINT;

    -- Buscar el ID de solicitud con el carnet y el token proporcionados
    SELECT idSolicitud INTO v_idSolicitud
    FROM Solicitud
    WHERE carnet = p_carnet AND token = p_token;

    IF v_idSolicitud IS NOT NULL THEN

        -- Eliminar registro en SolicitudReq
        DELETE FROM SolicitudReq WHERE fkSolicitud = v_idSolicitud;

        -- Eliminar registro en Solicitud
        DELETE FROM Solicitud WHERE idSolicitud = v_idSolicitud;

    ELSE
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'No se encontró una solicitud con el carnet y token proporcionados.';
    END IF;
END //

DELIMITER ;


DELIMITER //

CREATE PROCEDURE VerificarTokenUnico(
    IN p_token VARCHAR(128)
)
BEGIN
    DECLARE v_tokenCount INT;

    -- Contar cuántas solicitudes tienen el mismo token
    SELECT COUNT(*) INTO v_tokenCount
    FROM Solicitud
    WHERE token = p_token;

    IF v_tokenCount = 0 THEN
        SELECT 'Token es único en la tabla Solicitud.' AS mensaje;
    ELSE
        SELECT 'Token ya existe en la tabla Solicitud.' AS mensaje;
    END IF;
END //

DELIMITER ;


