/* eslint-disable react/prop-types */
/* eslint-disable react-hooks/exhaustive-deps */
import { useEffect } from "react";
import { useState } from "react";
import ReactPaginate from 'react-paginate';
import { Config } from '../../config';
export default function StudentRecord(props) {
  const [tableData, setTableData] = useState([{}]);

  const [currentPage, setCurrentPage] = useState(0); // Página actual
  const itemsPerPage = 5; // Cantidad de elementos por página
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

  function updateData() {
    const data = {
      'carnet': props.carnet
    }

    const requestOptions = {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(data),
    };

    fetch(Config.api_url + 'GetUserHistory', requestOptions)
      .then(async (response) => {
        if (!response.ok) {
          return 'No se pudo realizar el request';
        }
        else {
          return await response.json();
        }
      })
      .then((solicitudes) => {
        setTableData(solicitudes[1]);
      })
  }

  return (
    <>
      <div className="btn-div">
        <button onClick={updateData} className="button">Buscar</button>
      </div>
      <div className="table-container">
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
                <td>{item.estado}</td>
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
    </>
  );
}