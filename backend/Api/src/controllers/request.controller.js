import { getConnection } from '../ConnectionBD'; //import for connection
import { sendEmail } from '../emailer'; //import for send email
import { generateUniqueToken } from '../token'; //import for generate token

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

const ResultRequest = async (req, res) => {
  try {
    const conn = await getConnection();

    const [rows] = await conn.execute('CALL ObtenerResultados()');

    conn.release();
    conn.destroy();

    for (let i = 0; i < rows[0].length; i++) {
      const element = rows[0][i];
      sendEmail(
        element.email,
        'Solicitud de levantamiento',
        'Se ha solicitado un levantamiento, su token es: ' +
          token +
          '\n' +
          'Para el curso' +
          idCursoLevanta +
          'y matricularse en el curso' +
          idCursoMatricular
      );
    }
    res.json(rows[0]);
  } catch (error) {
    console.error('Error con el Enviar Request');
    res.status(500).json({ error: 'Error en el procedimiento' });
  }
};

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
        console.log(error);
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

export const prueba = async (req, res) => {
  const cursos = ['A', 'B', 'C'];
  const listaCursosHTML = cursos.map((curso) => `<li> ${curso}</li>`).join(''); //lista de cursos en html
  const htmlContent = `
      <p>Que se ha generado una solicitud de levantamiento,para la cual, su token es: 1111111  </p>
      <p>Se ha solicitado un levantamiento en los siguientes cursos: </p>
      <ul>
      ${listaCursosHTML}
      </ul>
      `;
  sendEmail(
    'Luis Rivel',
    'ljrivel@gmail.com',
    'Solicitud de levantamiento',
    htmlContent
  );
  res.json({ mensaje: 'Solicitud insertada correctamente' });
};

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
