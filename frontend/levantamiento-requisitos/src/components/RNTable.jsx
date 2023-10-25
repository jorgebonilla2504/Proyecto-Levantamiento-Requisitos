/* eslint-disable react-hooks/exhaustive-deps */
/* eslint-disable react/prop-types */
import { useState } from "react";
import { Config } from '../../config';
import ConfirmModal from "../components/ConfirmModal";
import ConfirmModalError from "./ConfirmationModalError";
import { setGlobalState, useGlobalState } from "../state/FormState";
import { useEffect } from "react";
export default function RNTable(props) {
  const [comentario, setComentario] = useState("");
  const [openConfirmationModal] = useGlobalState('openConfirmationModal');
  const [openConfirmationModalError] = useGlobalState('openConfirmationModalError');
  const [cursosMostrar, setCursosMostrar] = useState('');
  const [tableData, setTableData] = useState([{}]);

  useEffect(() => {
    updateData();
  }, []);

  function updateData() {
    const data = {
      'id': props.id
    }

    const requestOptions = {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(data),
    };

    fetch(Config.api_url + 'GetRequestsRN', requestOptions)
      .then(async (response) => {
        if (!response.ok) {
          return 'No se pudo realizar el request';
        }
        else {
          return await response.json();
        }
      })
      .then((solicitudes) => {
        setTableData(solicitudes);
      })
  }

  function verCursosRN(id) {
    const data = {
      'id': id
    }

    const requestOptions = {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(data),
    };

    fetch(Config.api_url + 'ObtenerCursosXSolicitudRN', requestOptions)
      .then(async (response) => {
        if (!response.ok) {
          return 'No se pudo realizar el request';
        }
        else {
          return await response.json();
        }
      })
      .then((cursos) => {
        let cursosStr = '';
        for (let i = 0; i < cursos.length; i++) {
          if (i + 1 == cursos.length) {
            cursosStr += cursos[i].codigo + " " + cursos[i].nombre;
            break;
          }
          cursosStr += cursos[i].codigo + " " + cursos[i].nombre + ", "
        }
        setCursosMostrar(cursosStr);
        setGlobalState('openConfirmationModalError', true);
      })
  }

  function verCursosMatricular(id) {
    const data = {
      'id': id
    }

    const requestOptions = {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(data),
    };

    fetch(Config.api_url + 'ObtenerCursosMXSolicitudRN', requestOptions)
      .then(async (response) => {
        if (!response.ok) {
          return 'No se pudo realizar el request';
        }
        else {
          return await response.json();
        }
      })
      .then((cursos) => {
        let cursosStr = '';
        for (let i = 0; i < cursos.length; i++) {
          if (i + 1 == cursos.length) {
            cursosStr += cursos[i].codigo_curso + " " + cursos[i].nombre_curso;
            break;
          }
          cursosStr += cursos[i].codigo_curso + " " + cursos[i].nombre_curso + ", ";
        }
        setCursosMostrar(cursosStr);
        setGlobalState('openConfirmationModalError', true);
      })
  }


  function aprobar(id) {
    const data = {
      'idSolicitud': id,
      'estado': 1,
      'comentario': comentario
    }

    const requestOptions = {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(data),
    };

    fetch(Config.api_url + 'UpdateSolicitud', requestOptions)
      .then(async (response) => {
        if (!response.ok) {
          return 'No se pudo realizar el request';
        }
        else {
          return await response;
        }
      })
      .then((response) => {
        if (response) {
          setGlobalState('openConfirmationModal', true);
          setComentario("");
          updateData();
        }
      })
  }

  function rechazar(id) {
    const data = {
      'idSolicitud': id,
      'estado': 0,
      'comentario': comentario
    }

    const requestOptions = {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(data),
    };

    fetch(Config.api_url + 'UpdateSolicitud', requestOptions)
      .then(async (response) => {
        if (!response.ok) {
          return 'No se pudo realizar el request';
        }
        else {
          return await response;
        }
      })
      .then((response) => {
        if (response) {
          setGlobalState('openConfirmationModal', true);
          setComentario("");
          updateData();
        }
      })
  }
  return (
    <div className="table-container">
      {
        openConfirmationModal &&
        <ConfirmModal
          title="Éxito"
          label="Solicitud modificada con éxito y lista para enviar su resultado al estudiante.">
        </ConfirmModal>
      }
      {
        openConfirmationModalError &&
        <ConfirmModalError
          title="Cursos"
          label={cursosMostrar}
        >
        </ConfirmModalError>
      }
      <table>
        <thead>
          <tr>
            <th>Número de Carnet</th>
            <th>Nombre</th>
            <th>Sede</th>
            <th>Plan de Estudio</th>
            <th>Cursos con RN mayor a 2</th>
            <th>RN del curso</th>
            <th>Cursos a matricular</th>
            <th>Comentarios</th>
            <th>Estado actual</th>
            <th>Agregar observaciones</th>
            <th>Aprobar</th>
            <th>Rechazar</th>
          </tr>
        </thead>
        <tbody>
          {tableData.length === 0 &&
            <tr>No se encontraron resultados</tr>
          }
          {tableData.map((item, index) => (
            <tr key={index}>
              <td>{item.carnet}</td>
              <td>{item.nombreCompleto}</td>
              <td>{item.nombreSede}</td>
              <td>{item.nombrePlanEstudios}</td>
              <td><button onClick={() => { verCursosRN(item.fkSolicitud) }}>Ver</button></td>
              <td>{item.nivelRN}</td>
              <td><button onClick={() => { verCursosMatricular(item.fkSolicitud) }}>Ver</button></td>
              <td>{item.razon}</td>
              <td>{item.estadoTexto}</td>
              <td><p>{item.comentarioEncargado}</p><input type="text" onChange={event => setComentario(event.target.value)} /></td>
              <td><button onClick={() => { aprobar(item.fkSolicitud) }}>Aprobar</button></td>
              <td><button onClick={() => { rechazar(item.fkSolicitud) }}>Rechazar</button></td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}