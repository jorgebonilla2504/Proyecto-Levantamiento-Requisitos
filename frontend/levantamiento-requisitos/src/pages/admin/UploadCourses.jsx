import { useState } from "react";
import AdminHeader from "../../components/AdminHeader";
import * as XLSX from 'xlsx';
import { setGlobalState, useGlobalState } from "../../state/FormState";
import { Config } from "../../../config";
import ConfirmModalError from "../../components/ConfirmationModalError";
import ConfirmModal from "../../components/ConfirmModal";
export default function UploadCourses() {
    const [coursesData, setCoursesData] = useState("");
    const [periodo, setPeriodo] = useState('1');
    const [openConfirmationModal] = useGlobalState('openConfirmationModal');
    const [openConfirmationModalError] = useGlobalState('openConfirmationModalError');
    function handleFileUpload(e) {
        const file = e.target.files[0];
        const reader = new FileReader();

        reader.onload = (event) => {
            const data = event.target.result;
            const workbook = XLSX.read(data, { type: 'binary' });
            const jsonData = [];

            const sheetName = workbook.SheetNames[0]; // Obtén el nombre de la primera hoja
            const sheet = workbook.Sheets[sheetName];

            const range = XLSX.utils.decode_range(sheet['!ref']);

            for (let i = 2; i < range.e.r; i++) {
                const cellB = sheet['B' + (i + 1)]; // Columna B (B3 en adelante)
                const cellC = sheet['C' + (i + 1)]; // Columna C (C3 en adelante)

                if (cellB && cellC) {
                    // Verifica si las celdas existen antes de agregarlas al JSON
                    jsonData.push({ 'codigo': cellB.v, nombre: cellC.v });
                }
            }
            setCoursesData(JSON.stringify(jsonData));
        };

        reader.readAsBinaryString(file);
    }

    function uploadCoursesJson() {
        const data = {
            'idPeriodo': periodo,
            'cursos': coursesData
        }

        const requestOptions = {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(data),
        };

        fetch(Config.api_url + 'InsertarCursosDesdeJson', requestOptions)
            .then((response) => {
                if (!response.ok) {
                    setGlobalState('openConfirmationModalError', true);
                }
                else {
                    setGlobalState('openConfirmationModal', true);
                }
            })
    }

    return <>
        <AdminHeader></AdminHeader>
        {
            openConfirmationModal &&
            <ConfirmModal
                title="Éxito"
                label="Cursos cargados con éxito.">
            </ConfirmModal>
        }
        {
            openConfirmationModalError &&
            <ConfirmModalError
                title="Error"
                label="Ocurrió un error al cargar los cursos, por favor intente de nuevo">
            </ConfirmModalError>
        }
        <div className="main-container">
            <h1>Carga de cursos</h1>
            <p>Por favor suba el archivo conteniendo los cursos para desplegar en los formularios de levantamiento</p>
            <p>Tenga en cuenta que este archivo debe ser de extensión .xlsx para el manejo correcto de los datos.</p>
            <label htmlFor="period">Seleccione el periodo al que pertenecen los cursos</label><br />
            <select className='input' name="periodo" value={periodo} onChange={event => setPeriodo(event.target.value)}>
                <option value="1">I Semestre</option>
                <option value="2">II Semestre</option>
                <option value="3">Verano</option>
            </select><br />
            <input type="file" accept="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" name="archivo" onChange={handleFileUpload} />
            <br />
            <button className="button" onClick={uploadCoursesJson}>Cargar cursos</button>
        </div>
    </>
}