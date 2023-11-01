/* eslint-disable react-hooks/exhaustive-deps */
import { useState } from "react";
import ReactPaginate from 'react-paginate';
import { Config } from '../../config';
import ConfirmModal from "../components/ConfirmModal";
import { setGlobalState, useGlobalState } from "../state/FormState";
import { useEffect } from "react";
/* eslint-disable react/prop-types */
export default function LevantamientosTable(props) {
  const [comentario, setComentario] = useState("");
  const [openConfirmationModal] = useGlobalState('openConfirmationModal');
  const [tableData, setTableData] = useState([{}]);

  const [currentPage, setCurrentPage] = useState(0); // Página actual
  const itemsPerPage = 10; // Cantidad de elementos por página
  const pageCount = Math.ceil(tableData.length / itemsPerPage); // Cantidad de páginas

  const handlePageClick = ({ selected }) => {
    setCurrentPage(selected);
  };

  // Obtén los elementos a mostrar en la página actual
  const displayedItems = tableData.slice(
    currentPage * itemsPerPage,
    (currentPage + 1) * itemsPerPage
  );

  useEffect(() => {
    updateData();
  }, []);

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

    fetch(Config.api_url + 'GetRequests', requestOptions)
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
      <table>
        <thead>
          <tr>
            <th>Número de Carnet</th>
            <th>Nombre</th>
            <th>Sede</th>
            <th>Plan de Estudio</th>
            <th>Curso a Matricular</th>
            <th>Curso a Levantar</th>
            <th>Comentarios</th>
            <th>Otros Detalles</th>
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
          {displayedItems.map((item, index) => (
            <tr key={index}>
              <td>{item.carnet}</td>
              <td>{item.nombreCompleto}</td>
              <td>{item.nombreSede}</td>
              <td>{item.nombrePlanEstudios}</td>
              <td>{item.nombreCursoMatricular}</td>
              <td>{item.nombreCursoLevantar}</td>
              <td>{item.comentario}</td>
              <td>{item.razon}</td>
              <td>{item.estadoTexto}</td>
              <td><p>{item.comentarioEncargado}</p><input type="text" onChange={event => setComentario(event.target.value)} /></td>
              <td><button onClick={() => { aprobar(item.fkSolicitud) }}>Aprobar</button></td>
              <td><button onClick={() => { rechazar(item.fkSolicitud) }}>Rechazar</button></td>
            </tr>
          ))}
        </tbody>
      </table>
      <ReactPaginate 
        className="paginate"
        previousLabel={'< Anterior'}
        nextLabel={'Siguiente >'}
        breakLabel={'...'}
        pageCount={pageCount}
        marginPagesDisplayed={2}
        pageRangeDisplayed={5}
        onPageChange={handlePageClick}
        containerClassName={'pagination'}
        subContainerClassName={'pages pagination'}
        activeClassName={'active'}
      />
    </div>
  );
}