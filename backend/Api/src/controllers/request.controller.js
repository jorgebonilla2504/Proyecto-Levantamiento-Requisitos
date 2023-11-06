import { getConnection } from '../ConnectionBD'; //import for connection
import { sendEmail, sendEmailDocs, sendEmailDownloadsDocs } from '../emailer'; //import for send email
import { generateUniqueToken } from '../token'; //import for generate token
import { modificarArchivoCSV } from '../docsGenerator'; //import for generate document

// ------------------------------------------- generate documents --------------------------------------------

const InformationRequestDownload = (requestNormal, requestRN) => {
  let requestInformation = [];

  for (let i = 0; i < requestNormal.length; i++) {
    const element = requestNormal[i];
    const {
      carnet,
      nombreCompleto,
      codigo,
      nombreCursoMatricular,
      Sede,
      estadoTexto,
      ComentarioEncargado,
      email,
      PlanEstudio,
      comentario,
      razon,
    } = element;
    requestInformation.push({
      'Sede a la que pertenece': Sede,
      Resultado: estadoTexto,
      Observaciones: ComentarioEncargado,
      Carnet: carnet,
      Nombre: nombreCompleto,
      'Correo electronico para notificar': email,
      Plan: PlanEstudio,
      'Tipo de levantamiento': 'Requisitos',
      'Seleccione el requisito que desea levantar':
        codigo + '  ' + nombreCursoMatricular,
      'Comentario del estudiante': comentario,
      'Detalle adicional': razon,
    });
  }

  for (let i = 0; i < requestRN.length; i++) {
    const element = requestRN[i];
    const {
      carnet,
      nombreCompleto,
      Sede,
      estadoTexto,
      ComentarioEncargado,
      email,
      PlanEstudio,
      comentario,
      razon,
    } = element;
    let requisitoLevantar = '';

    for (let j = 0; j < requestRN[i].cursos.length; j++) {
      if (j === 0) {
        requisitoLevantar =
          requestRN[i].cursos[j].codigo_curso +
          '   ' +
          requestRN[i].cursos[j].nombre_curso;
      } else {
        requisitoLevantar =
          requisitoLevantar +
          '  -  ' +
          requestRN[i].cursos[j].codigo_curso +
          '   ' +
          requestRN[i].cursos[j].nombre_curso;
      }
    }
    requestInformation.push({
      'Sede a la que pertenece': Sede,
      Resultado: estadoTexto,
      Observaciones: ComentarioEncargado,
      Carnet: carnet,
      Nombre: nombreCompleto,
      'Correo electronico para notificar': email,
      Plan: PlanEstudio,
      'Tipo de levantamiento': 'RN',

      'Seleccione el requisito que desea levantar': requisitoLevantar,
      'Comentario del estudiante': comentario,
      'Detalle adicional': razon,
    });
  }

  return requestInformation;
};

export const GetInforme = async (req, res) => {
  try {
    const { email, idFormulario } = req.body;
    const Request = await getStateRequestId(req, res, idFormulario);
    const RequestRN = await getStateRequestRNDocumentsId(
      req,
      res,
      idFormulario
    );
    const Data = InformationRequestDownload(Request, RequestRN);
    await modificarArchivoCSV('src\\DOCS\\InformeRequerimientos.csv', Data);
    sendEmailDownloadsDocs(email);
    res.json({ mensaje: 'Correo Enviado' });
  } catch (error) {
    console.error('Error al obtener solicitudes');
    res.status(500).json({ error: 'Error al obtener solicitudes' });
  }
};

// GetRequests function to get the requests
// Gets the requests
// Returns the requests
// Returns an error message if the requests were not obtained correctly
const InformationRequest = (request) => {
  let requestInformation = [];

  for (let i = 0; i < request.length; i++) {
    const element = request[i];
    const { carnet, nombreCompleto, codigo, nombreCursoMatricular } = element;
    requestInformation.push({
      '#': i + 1,
      CARNET: carnet,
      NOMBRE: nombreCompleto,
      COD: codigo,
      CURSO: nombreCursoMatricular,
    });
  }

  return requestInformation;
};

// GetRequests function to get the requests
// Gets the requests
// Returns the requests
const InformationRequestRN = (request) => {
  let requestInformation = [];

  for (let i = 0; i < request.length; i++) {
    const element = request[i];
    const { carnet, nombreCompleto } = element;
    let CODI = '';
    let CURSOI = '';
    for (let j = 0; j < request[i].cursos.length; j++) {
      if (j === 0) {
        CODI = request[i].cursos[j].codigo_curso;
        CURSOI = request[i].cursos[j].nombre_curso;
      } else {
        CODI = CODI + '  -  ' + request[i].cursos[j].codigo_curso;
        CURSOI = CURSOI + '  -  ' + request[i].cursos[j].nombre_curso;
      }
    }
    requestInformation.push({
      '#': i + 1,
      CARNET: carnet,
      NOMBRE: nombreCompleto,
      COD: CODI,
      CURSO: CURSOI,
    });
  }

  return requestInformation;
};

// GetRequests function to get the requests
// Gets the requests
// Returns the requests
export const GenerarInforme = async (req, res) => {
  try {
    const { idFormulario } = req.body;

    const Request = await getStateRequestId(req, res, idFormulario);
    const Data = InformationRequest(Request);
    await modificarArchivoCSV('src\\DOCS\\levantamientoRequisitos.csv', Data);

    const RequestRn = await getStateRequestRNDocumentsId(
      req,
      res,
      idFormulario
    );
    const DataRn = InformationRequestRN(RequestRn);
    await modificarArchivoCSV('src\\DOCS\\condicionRN.csv', DataRn);

    sendEmailDocs('eshuman@itcr.ac.cr');
    sendEmailDocs('bdittel@itcr.ac.cr');

    res.json({ mensaje: 'Correo Enviado' });
  } catch (error) {
    console.log(error);
    console.error('Error al Generar informe');
    res.status(500).json({ error: 'Error al  Generar informe' });
  }
};

// ------------------------------------------- send email --------------------------------------------

// GetRequests function to get the requests
// Gets the requests
// Returns the requests
// Returns an error message if the requests were not obtained correctly
const sendEmailRequest = async (req, res, request) => {
  try {
    const conn = await getConnection();

    for (let i = 0; i < request.length; i++) {
      const element = request[i];
      const [rows] = await conn.execute('CALL ActualizarNotificacion(?)', [
        element.idSolicitud,
      ]);

      const htmlContent = `
    <p>El resultado de su solicitud fue <b> ${element.estadoTexto} </b>:  </p>
    <p>Con respecto ha la solicitado un levantamiento del siguiente curso: </p>
    <ul>
    <li> ${element.nombreCursoLevantar}</li>
    </ul>
    <p> El motivo de la decision fue: ${element.ComentarioEncargado}  .</p>


    `;

      // La solicitud se insertó correctamente
      sendEmail(
        element.nombreCompleto,
        element.email,
        'Resultado de la solicitud de levantamiento',
        htmlContent
      );
    }

    conn.release();
    conn.destroy();
  } catch (error) {
    console.error('Error al obtener solicitudes');
    res.status(500).json({ error: 'Error al obtener solicitudes' });
  }
};

const sendEmailRequestRN = async (req, res, request) => {
  try {
    const conn = await getConnection();

    for (let i = 0; i < request.length; i++) {
      const element = request[i];
      const [rows] = await conn.execute('CALL ActualizarNotificacion(?)', [
        element.idSolicitud,
      ]);

      const cursosLevantar = element.cursos[0]
        .map((nombre) => `<li> ${nombre}</li>`)
        .join('');

      const htmlContent = `
      <p>El resultado de su solicitud fue <b> ${element.estadoTexto} </b>:  </p>
      <p>Con respecto ha la solicitado un levantamiento en los siguientes cursos: </p>
      <ul>
      ${cursosLevantar}
      </ul>
      <p> El motivo de la decision fue: ${element.ComentarioEncargado}  .</p>
      `;

      // La solicitud se insertó correctamente

      sendEmail(
        element.nombreCompleto,
        element.email,
        'Resultado de la solicitud de levantamiento',
        htmlContent
      );
    }
    conn.release();
    conn.destroy();
  } catch (error) {
    console.error('Error al obtener solicitudes');
    res.status(500).json({ error: 'Error al obtener solicitudes' });
  }
};

// GetRequests function to get the requests
// Gets the requests
// Returns the requests
// Returns an error message if the requests were not obtained correctly
export const SendResultRequest = async (req, res) => {
  try {
    const Request = await getStateRequest(req, res);
    sendEmailRequest(req, res, Request);
    const RequestRN = await getStateRequestRN(req, res);
    sendEmailRequestRN(req, res, RequestRN);
  } catch (error) {
    console.error('Error al obtener solicitudes');
    res.status(500).json({ error: 'Error al obtener solicitudes' });
  }
};

//----------------------------------- GETS  COURSES  -------------------------------------

// getCursos function to get the name of the courses
// Gets the name of the courses
// Returns the name of the courses
// Returns an error message if the courses were not obtained correctly
const getCursos = async (req, res, lista) => {
  let cursos = [];
  lista = lista.split(',');

  const conn = await getConnection();
  for (let i = 0; i < lista.length; i++) {
    try {
      const element = lista[i];
      const [rows] = await conn.execute('CALL obtenerNombreDeCurso(?)', [
        element,
      ]);
      cursos.push(rows[0][0]['nombre']);
    } catch (error) {
      console.error('Error al obtener cursos ');
      res.status(500).json({ error: 'Error al obtener cursos ' });
    }
  }
  conn.release();
  conn.destroy();
  return cursos;
};

// GetCursosForEmail function to get the name of the courses
// Gets the name of the courses
// Returns the name of the courses
const GetCursosForEmail = async (req, res, id) => {
  let cursos = [];
  try {
    const conn = await getConnection();
    const [rows] = await conn.execute(
      'CALL ObtenerCursosXsolicitudRNDeSolicitudId(?)',
      [id]
    );
    const [rows2] = await conn.execute(
      'CALL ObtenerCursosMXsolicitudRNDeSolicitudId(?)',
      [id]
    );

    let cursosLevantar = [];
    let cursosMatricular = [];

    for (let i = 0; i < rows[0].length; i++) {
      const element = rows[0][i];
      cursosLevantar.push(element.nombre);
    }

    for (let i = 0; i < rows2[0].length; i++) {
      const element = rows2[0][i];
      cursosMatricular.push(element.nombre_curso);
    }
    cursos.push(cursosLevantar);

    cursos.push(cursosMatricular);

    conn.release();
    conn.destroy();

    return cursos;
  } catch (error) {
    console.error('Error al obtener cursos ');
    res.status(500).json({ error: 'Error al obtener cursos ' });
  }
};

// get cursos for documentacion
// Gets the name of the courses
// Returns the name of the courses
const GetCursosForDocumentacion = async (req, res, id) => {
  let cursos = [];

  try {
    const conn = await getConnection();
    const [rows] = await conn.execute(
      'CALL ObtenerCursosXsolicitudRNDeSolicitudId(?)',
      [id]
    );
    const [rows2] = await conn.execute(
      'CALL ObtenerCursosMXsolicitudRNDeSolicitudId(?)',
      [id]
    );

    let cursosLevantar = [];
    let cursosMatricular = [];

    for (let i = 0; i < rows[0].length; i++) {
      const element = rows[0][i];
      cursosLevantar.push(element);
    }

    for (let i = 0; i < rows2[0].length; i++) {
      const element = rows2[0][i];
      cursosMatricular.push(element);
    }
    cursos.push(cursosLevantar);

    cursos.push(cursosMatricular);

    conn.release();
    conn.destroy();
    return cursos;
  } catch (error) {
    console.error('Error al obtener cursos ');
    res.status(500).json({ error: 'Error al obtener cursos ' });
  }
};

// ------------------------------------- GETS  STATE REQUEST  -------------------------------------

// getStateRequest function to get the state of the requests
// Gets the state of the requests
// Returns the state of the requests
// Returns an error message if the requests were not obtained correctly
const GetUserRN = async (req, res, carnet) => {
  try {
    const connection = await getConnection();
    const [row] = await connection.execute('CALL ObtenerSolicitudRNCarnet(?)', [
      carnet,
    ]);
    connection.release();
    connection.destroy();
    const request = row[0];
    //add name of the courses in list request
    for (let i = 0; i < request.length; i++) {
      const element = request[i];
      const cursos = await GetCursosForDocumentacion(
        req,
        res,
        element.fkSolicitud
      );
      request[i].cursos = cursos;
    }
    return request;
  } catch (error) {
    console.error('Error al obtener solicitudes carnet RN');
  }
};

// getStateRequest function to get the state of the requests
// Gets the state of the requests
// Returns the state of the requests
// Returns an error message if the requests were not obtained correctly
const GetUser = async (req, res, carnet) => {
  try {
    const connection = await getConnection();
    const [row] = await connection.execute(
      'CALL ObtenerSolicitudReqCarnet(?)',
      [carnet]
    );
    connection.release();
    connection.destroy();
    const request = row[0];
    return request;
  } catch (error) {
    console.error('Error al obtener solicitudes carnet RN');
  }
};

// getStateRequest function to get the state of the requests
// Gets the state of the requests
// Returns the state of the requests
// Returns an error message if the requests were not obtained correctly
export const GetHistoryUser = async (req, res) => {
  try {
    let History = [];
    const carnet = req.body.carnet;
    const UserRN = await GetUserRN(req, res, carnet);
    const User = await GetUser(req, res, carnet);
    History.push(UserRN);
    History.push(User);
    res.json(History);
  } catch (error) {
    console.error('Error al obtener solicitudes carnet RN');
    res.status(500).json({ error: 'Error al obtener solicitudes' });
  }
};

//getStateRequest function to get the state of the requests
// Gets the state of the requests
// Returns the state of the requests
// Returns an error message if the requests were not obtained correctly
const getStateRequest = async (req, res) => {
  let request = [];

  try {
    const conn = await getConnection();
    const [rows] = await conn.execute('CALL ObtenerResultadosNormal()');
    request = rows[0];
    conn.release();
    conn.destroy();
  } catch (error) {
    console.error('Error al obtener solicitudes normal');
    res.status(500).json({ error: 'Error al obtener solicitudes' });
  }

  return request;
};

//getStateRequestid function to get the state of the requests
// Gets the state of the requests
// Returns the state of the requests
// Returns an error message if the requests were not obtained correctly
const getStateRequestId = async (req, res, id) => {
  let request = [];
  try {
    const conn = await getConnection();
    const [rows] = await conn.execute('CALL ObtenerResultadosNormalId(?)', [
      id,
    ]);
    request = rows[0];
    conn.release();
    conn.destroy();
  } catch (error) {
    console.error('Error al obtener solicitudes RequestId');
    res.status(500).json({ error: 'Error al obtener solicitudes' });
  }

  return request;
};

//getStateRequest function to get the state of the requests
// Gets the state of the requests
// Returns the state of the requests
// Returns an error message if the requests were not obtained correctly
const getStateRequestRN = async (req, res) => {
  let request = [];

  try {
    const conn = await getConnection();
    const [rows] = await conn.execute('CALL ObtenerResultadosRN()');
    request = rows[0];
    conn.release();
    conn.destroy();
    //add name of the courses in list request
    for (let i = 0; i < request.length; i++) {
      const element = request[i];
      const cursos = await GetCursosForEmail(req, res, element.idSolicitud);
      request[i].cursos = cursos;
    }
  } catch (error) {
    console.error('Error al obtener solicitudes rn');
    res.status(500).json({ error: 'Error al obtener solicitudes' });
  }
  return request;
};

// getStateRequestRNDocuments function to get the state of the requests
// Gets the state of the requests
// Returns the state of the requests
const getStateRequestRNDocuments = async (req, res) => {
  let request = [];

  try {
    const conn = await getConnection();
    const [rows] = await conn.execute('CALL ObtenerResultadosRN()');
    request = rows[0];
    conn.release();
    conn.destroy();
    //add name of the courses in list request
    for (let i = 0; i < request.length; i++) {
      const element = request[i];
      const cursos = await GetCursosForDocumentacion(
        req,
        res,
        element.idSolicitud
      );
      request[i].cursos = cursos[1];
    }
  } catch (error) {
    console.error('Error al obtener solicitudes');
    res.status(500).json({ error: 'Error al obtener solicitudes' });
  }
  return request;
};

// getStateRequestRNDocumentsId function to get the state of the requests
// Gets the state of the requests
// Returns the state of the requests
const getStateRequestRNDocumentsId = async (req, res, id) => {
  let request = [];

  try {
    const conn = await getConnection();
    const [rows] = await conn.execute('CALL ObtenerResultadosRNId(?)', [id]);
    request = rows[0];
    conn.release();
    conn.destroy();
    //add name of the courses in list request
    for (let i = 0; i < request.length; i++) {
      const element = request[i];
      const cursos = await GetCursosForDocumentacion(
        req,
        res,
        element.idSolicitud
      );
      request[i].cursos = cursos[1];
    }
  } catch (error) {
    console.log(error);
    console.error('Error al obtener solicitudes');
    res.status(500).json({ error: 'Error al obtener solicitudes' });
  }
  return request;
};

// ----------------------------------------------------------TOKEN-----------------------------------------------------------

//getToken function to generate a unique token
//Generates a unique token
//If the token is not unique, it generates another one
//Returns the token
const getToken = async (req, res) => {
  try {
    while (true) {
      const conn = await getConnection();

      const token = await generateUniqueToken();

      const [rows] = await conn.execute('CALL VerificarTokenUnico(?)', [token]);

      conn.release();
      conn.destroy();
      if (rows[0][0].mensaje === 'Token es único en la tabla Solicitud.') {
        return token;
      }
    }
  } catch (error) {
    console.error('Error con el SP VerificarToken unico');
    res.status(500).json({ error: 'Error con el SP VerificarToken' });
  }
};

// ----------------------------------------------------------INSERTS-----------------------------------------------------------

// InsertRequest function to insert a request
// Inserts a request into the database
// call getToken function
// need carnet, fullname, idplan, email, comment, idform,
// idsede, reason, id course to lift, id course to enroll
// Returns a message if the request was inserted correctly
// Returns an error message if the request was not inserted correctly
export const InsertRequest = async (req, res) => {
  try {
    const {
      carnet,
      nombreCompleto,
      idPlan,
      email,
      comentario,
      idFormulario,
      idSede,
      motivoLevantamiento,
      idCursoLevanta,
      idCursoMatricular,
    } = req.body;

    const token = await getToken(req, res);
    const connection = await getConnection();

    const [rows] = await connection.execute(
      'CALL InsertarSolicitudReq(?,?,?,?,?,?,?,?,?,?,?)',
      [
        carnet,
        nombreCompleto,
        idPlan,
        email,
        token,
        comentario,
        idFormulario,
        idSede,
        motivoLevantamiento,
        idCursoLevanta,
        idCursoMatricular,
      ]
    );

    if (rows.warningStatus >= 1) {
      res.status(401).json({ error: 'Error al insertar solicitud ' });
    } else {
      try {
        const [CursoLevanta] = await connection.execute(
          'CALL obtenerNombreDeCurso(?)',
          [idCursoLevanta]
        );

        const [CursoMatricular] = await connection.execute(
          'CALL obtenerNombreDeCurso(?)',
          [idCursoMatricular]
        );

        const htmlContent = `
        <p>Que se ha generado una solicitud de levantamiento,para la cual su token es: ${token}  </p>
        <p>Se ha solicitado un levantamiento en los siguiente curso: </p>
        <ul>
        <li> ${CursoLevanta[0][0]['nombre']}</li>
        </ul>
        <p> para poder matricular el siguiente curso <b>${CursoMatricular[0][0]['nombre']}</b> .</p>
  
        `;

        // La solicitud se insertó correctamente
        sendEmail(
          nombreCompleto,
          email,
          'Solicitud de levantamiento',
          htmlContent
        );

        connection.release();
        connection.destroy();
        res.json({ mensaje: 'Solicitud insertada correctamente' });
      } catch (error) {
        console.error('Error al Obtener Nombres de Cursos');
        res.status(500).json({ error: 'Error al enviar correo' });
      }
    }
  } catch (error) {
    console.error('Error al insertar solicitud', error);
    res.status(500).json({ error: 'Error al insertar solicitud' });
  }
};

// InsertRequestRN function to insert a request
// Inserts a request into the database
// call getToken function
// need carnet, fullname, idplan, email, comment, idform,
// idsede, reason, id course to lift, id course to enroll
// Returns a message if the request was inserted correctly
// Returns an error message if the request was not inserted correctly
export const InsertRequestRN = async (req, res) => {
  try {
    const {
      carnet,
      nombreCompleto,
      idPlan,
      email,
      comentario,
      idFormulario,
      idSede,
      motivoLevantamiento,
      nivelRn,
      cursosMXRNString,
      cursosRNSrign,
    } = req.body;

    const token = await getToken(req, res);

    const connection = await getConnection();
    const [rows] = await connection.execute(
      'CALL InsertarSolicitudRnConCursos(?,?,?,?,?,?,?,?,?,?,?,?)',
      [
        carnet,
        nombreCompleto,
        idPlan,
        email,
        token,
        comentario,
        idFormulario,
        idSede,
        motivoLevantamiento,
        nivelRn,
        cursosMXRNString,
        cursosRNSrign,
      ]
    );

    connection.release();
    connection.destroy();

    // La solicitud se insertó correctamente
    if (rows.warningStatus >= 1) {
      res.status(401).json({ error: 'Error al insertar solicitud ' });
    } else {
      const NombrecursosMatricular = await getCursos(
        req,
        res,
        cursosMXRNString
      );
      const NombrecursosLevantar = await getCursos(req, res, cursosRNSrign);
      const cursosMatricular = NombrecursosMatricular.map(
        (NombrecursosMatricular) => `<li> ${NombrecursosMatricular}</li>`
      ).join('');
      const cursosLevantar = NombrecursosLevantar.map(
        (NombrecursosLevantar) => `<li> ${NombrecursosLevantar}</li>`
      ).join('');

      const htmlContent = `
      <p>Que se ha generado una solicitud de levantamiento,para la cual su token es: ${token}  </p>
      <p>Se ha solicitado un levantamiento en los siguiente curso: </p>
      <ul>
      ${cursosLevantar}
      </ul>
      <p> para poder matricular el siguientes cursos: </b> .</p>
      <ul>
      ${cursosMatricular}
      </ul>

      `;

      sendEmail(
        nombreCompleto,
        email,
        'Solicitud de levantamiento',
        htmlContent
      );
      res.json({ mensaje: 'Solicitud insertada correctamente' });
    }
  } catch (error) {
    console.error('Error al insertar solicitud', error);
    res.status(500).json({ error: 'Error al insertar solicitud' });
  }
};

// delete a request from the database

// DeleteRequest function to delete a request
// Deletes a request from the database
// need carnet and token
// Returns a message if the request was deleted correctly
// Returns an error message if the request was not deleted correctly
export const DeleteRequest = async (req, res) => {
  try {
    const { carnet, token } = req.body;

    const connection = await getConnection();
    const [rows] = await connection.execute('CALL EliminarSolicitudReq(?,?)', [
      carnet,
      token,
    ]);
    connection.release();
    connection.destroy();
    if (rows.warningStatus >= 1) {
      res.status(401).json({ error: 'Error al eliminar solicitud ' });
    } else {
      res.json({ mensaje: 'Solicitud eliminada correctamente' });
    }
  } catch (error) {
    console.error('Error al eliminar solicitud');
    res.status(500).json({ error: 'Error al eliminar solicitud' });
  }
};

// DeleteRequestRN function to delete a request
// Deletes a request from the database
// need carnet and token
// Returns a message if the request was deleted correctly
// Returns an error message if the request was not deleted correctly
export const DeleteRequestRN = async (req, res) => {
  try {
    const { carnet, token } = req.body;
    const connection = await getConnection();
    const [rows] = await connection.execute(
      'CALL EliminarSolicitudRNYRegistros(?,?)',
      [carnet, token]
    );
    connection.release();
    connection.destroy();
    if (rows.warningStatus >= 1) {
      res.status(401).json({ error: 'Error al eliminar solicitud ' });
    } else {
      res.json({ mensaje: 'Solicitud eliminada correctamente' });
    }
  } catch (error) {
    console.error('Error al eliminar solicitud');
    res.status(500).json({ error: 'Error al eliminar solicitud' });
  }
};

// ----------------------------------------------------------GETS-----------------------------------------------------------

// GetRequestsRN function to get the requests
// Gets the requests
// Returns the requests
// Returns an error message if the requests were not obtained correctly
export const GetRequestsRN = async (req, res) => {
  try {
    const { id } = req.body;
    const connection = await getConnection();
    const [rows] = await connection.execute(
      'CALL ObtenerSolicitudesRNDeFormulario(?)',
      [id]
    );
    connection.release();
    connection.destroy();
    res.json(rows[0]);
  } catch (error) {
    console.error('Error al obtener solicitudes RN');
    res.status(500).json({ error: 'Error al obtener solicitudes' });
  }
};

// GetRequestsNormal function to get the requests
// Gets the requests
// Returns the requests
// Returns an error message if the requests were not obtained correctly
export const GetRequestsNormal = async (req, res) => {
  try {
    const { id } = req.body;
    const connection = await getConnection();
    const [rows] = await connection.execute(
      'CALL ObtenerSolicitudReqDeFormulario(?)',
      [id]
    );
    connection.release();
    connection.destroy();
    res.json(rows[0]);
  } catch (error) {
    console.error('Error al obtener solicitudes');
    res.status(500).json({ error: 'Error al obtener solicitudes' });
  }
};

// GetRequests function to get the requests
// Gets the requests
// Returns the requests
// Returns an error message if the requests were not obtained correctly
export const GetRequests = async (req, res) => {
  try {
    const connection = await getConnection();
    const [rows] = await connection.execute(
      'CALL ObtenerSolicitudReqDeSolicitud()'
    );
    connection.release();
    connection.destroy();
    res.json(rows[0]);
  } catch (error) {
    console.error('Error al obtener solicitudes');
    res.status(500).json({ error: 'Error al obtener solicitudes' });
  }
};

// GetRequests function to update state of the requests
// Gets the requests
// Returns the requests
// Returns an error message if the requests were not obtained correctly
export const UpdateSolicitud = async (req, res) => {
  try {
    const { idSolicitud, estado, comentario } = req.body;
    const connection = await getConnection();
    const [rows] = await connection.execute(
      'CALL ActualizarEstadoSolicitud(?,?,?)',
      [idSolicitud, estado, comentario]
    );
    connection.release();
    connection.destroy();
    res.json(rows[0]);
  } catch (error) {
    console.error('Error al obtener solicitudes');
    res.status(500).json({ error: 'Error al obtener solicitudes' });
  }
};

// GetRequests function to update state of the requests notificacion
// Gets the requests
// Returns the requests
// Returns an error message if the requests were not obtained correctly
export const UpdateSolicitudNotificacion = async (req, res) => {
  try {
    const { idSolicitud, notificado } = req.body;
    const connection = await getConnection();
    const [rows] = await connection.execute(
      'CALL ActualizarEstadoSolicitudNotificacion(?,?)',
      [idSolicitud, notificado]
    );
    connection.release();
    connection.destroy();
    res.json(rows[0]);
  } catch (error) {
    console.error('Error al obtener solicitudes');
    res.status(500).json({ error: 'Error al obtener solicitudes' });
  }
};

// GetRequests function to update state of the requests with id
// Gets the requests
// Returns the requests
// Returns an error message if the requests were not obtained correctly
export const ObtenerSolicitudesRNPorId = async (req, res) => {
  try {
    const { idSolicitud } = req.body;
    const connection = await getConnection();
    const [rows] = await connection.execute(
      'CALL ObtenerSolicitudesRNDeSolicitud(?)',
      [idSolicitud]
    );
    connection.release();
    connection.destroy();
    res.json(rows[0]);
  } catch (error) {
    console.error('Error al obtener solicitudes');
    res.status(500).json({ error: 'Error al obtener solicitudes' });
  }
};

// GetRequests function to update state of the requests courses levantar with id
// Gets the requests
// Returns the requests
// Returns an error message if the requests were not obtained correctly
export const ObtenerCursosXSolicitudRN = async (req, res) => {
  try {
    const { id } = req.body;
    const connection = await getConnection();
    const [rows] = await connection.execute(
      'CALL ObtenerCursosXsolicitudRNDeSolicitudId(?)',
      [id]
    );
    connection.release();
    connection.destroy();
    res.json(rows[0]);
  } catch (error) {
    console.error('Error al obtener solicitudes');
    res.status(500).json({ error: 'Error al obtener solicitudes' });
  }
};

// GetRequests function to update state of the requests courses matricular with id
// Gets the requests
// Returns the requests
// Returns an error message if the requests were not obtained correctly
export const ObtenerCursosMXSolicitudRN = async (req, res) => {
  try {
    const { id } = req.body;
    const connection = await getConnection();
    const [rows] = await connection.execute(
      'CALL ObtenerCursosMXsolicitudRNDeSolicitudId(?)',
      [id]
    );
    connection.release();
    connection.destroy();
    res.json(rows[0]);
  } catch (error) {
    console.error('Error al obtener solicitudes');
    res.status(500).json({ error: 'Error al obtener solicitudes' });
  }
};
