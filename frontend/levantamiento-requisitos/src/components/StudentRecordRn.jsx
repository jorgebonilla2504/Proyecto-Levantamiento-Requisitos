/* eslint-disable react-hooks/exhaustive-deps */
/* eslint-disable react/prop-types */
import { useEffect } from "react";
import { useState } from "react";
import { Config } from '../../config';
export default function StudentRecordRn(props) {
  const [tableData, setTableData] = useState([{}]);

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
        console.log(solicitudes[0]);
        setTableData(solicitudes[0]);
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
              <th>Cursos con RN mayor a 2</th>
              <th>RN del curso</th>
              <th>Cursos a matricular</th>
              <th>Comentarios</th>
              <th>Estado actual</th>
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
                <td>
                  {item.cursos &&
                    item.cursos[0].map((curso, index) =>
                      <p key={index}>{curso.nombre}</p>
                    )
                  }
                </td>
                <td>{item.nivelRN}</td>
                <td>
                  {item.cursos &&
                    item.cursos[1].map((curso, index) =>
                      <p key={index}>{curso.nombre_curso}</p>
                    )
                  }
                </td>
                <td>{item.razon}</td>
                <td>{item.estado}</td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </>
  );
}