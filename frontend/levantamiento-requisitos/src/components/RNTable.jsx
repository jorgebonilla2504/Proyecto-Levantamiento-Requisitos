/* eslint-disable react/prop-types */
import { useState } from "react";
import { Config } from '../../config';
import ConfirmModal from "../components/ConfirmModal";
import { setGlobalState, useGlobalState } from "../state/FormState";
export default function RNTable({ data }) {
  const [comentario, setComentario] = useState("");
  const [openConfirmationModal] = useGlobalState('openConfirmationModal');

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
            <th>Agregar observaciones</th>
            <th>Aprobar</th>
            <th>Rechazar</th>
          </tr>
        </thead>
        <tbody>
          {data.map((item, index) => (
            <tr key={index}>
              <td>{item.carnet}</td>
              <td>{item.nombreCompleto}</td>
              <td>{item.nombreSede}</td>
              <td>{item.nombrePlanEstudios}</td>
              <td>tbd</td>
              <td>{item.nivelRN}</td>
              <td>tbd</td>
              <td>{item.razon}</td>
              <td><input type="text" value={comentario} onChange={event => setComentario(event.target.value)} /></td>
              <td><button onClick={() => { aprobar(item.fkSolicitud) }}>Aprobar</button></td>
              <td><button onClick={() => { rechazar(item.fkSolicitud) }}>Rechazar</button></td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}