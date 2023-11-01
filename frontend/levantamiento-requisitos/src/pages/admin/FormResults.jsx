import { useParams } from 'react-router-dom';
import AdminHeader from '../../components/AdminHeader';
import { useState } from 'react';
import LevantamientosTable from '../../components/LevantamientosTable';
import RNTable from '../../components/RNTable';
import { setGlobalState, useGlobalState } from '../../state/FormState';
import { useNavigate } from "react-router-dom";
import { Config } from '../../../config';
import ConfirmModalError from '../../components/ConfirmationModalError';

function FormResults() {
    const navigate = useNavigate();
    const { id } = useParams();
    const userEmail = useGlobalState("loggedEmail");
    const [tipo, setTipo] = useState(1);
    const [levChecked, setLevChecked] = useState(1);
    const [rnChecked, setRnChecked] = useState(0);
    const [openConfirmationModalError] = useGlobalState('openConfirmationModalError');
    const downloadSuccessMsg = "Se ha generado el archivo CSV para la descarga, ingrese a su correo para descargar los resultados.";
    const darSuccessMsg = "Se ha generado el reporte DAR de manera correcta y ha sido enviado mediante un correo."
    const [actMsg, setActMsg] = useState("");
    const [actTitle, setActTitle] = useState("");
    function toAdminForm() {
        setGlobalState('isLoggedIn', true);
        navigate('/adminform/' + id);
    }

    function downloadResults() {
        const data = {
            'email': userEmail[0],
            'idFormulario': id
        }

        const requestOptions = {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(data),
        };

        fetch(Config.api_url + 'DownloadInformation', requestOptions)
            .then((response) => {
                if (!response.ok) {
                    setActTitle("Error")
                    setActMsg("Ocurrió un error al generar el reporte, por favor intente de nuevo.")
                    setGlobalState('openConfirmationModalError', true);
                }
                else {
                    setActTitle("Éxito")
                    setActMsg(downloadSuccessMsg)
                    setGlobalState("openConfirmationModalError", true);
                }
            })
    }

    function generateDar() {
        const data = {
            'idFormulario': id
        }

        const requestOptions = {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(data),
        };

        fetch(Config.api_url + 'InformationDar', requestOptions)
            .then((response) => {
                if (!response.ok) {
                    setActTitle("Error")
                    setActMsg("Ocurrió un error al generar el reporte, por favor intente de nuevo.")
                    setGlobalState('openConfirmationModalError', true);
                }
                else {
                    setActTitle("Éxito")
                    setActMsg(darSuccessMsg)
                    setGlobalState("openConfirmationModalError", true);
                }
            })
    }

    function sendResults() {
        fetch(Config.api_url + `SendResultRequest`)
            .then(async (response) => {
                if (!response.ok) {
                    setActTitle("Error")
                    setActMsg("Ocurrió un error al enviar los resultados, por favor intente de nuevo.")
                    setGlobalState('openConfirmationModalError', true);
                }
                else {
                    setActTitle("Éxito")
                    setActMsg("Se enviaron los resultados de manera correcta.")
                    setGlobalState("openConfirmationModalError", true);
                }
            })
    }

    function handleChecked() {
        if (levChecked) {
            setLevChecked(0);
            setRnChecked(1);
            setTipo(2);
        }
        else {
            setLevChecked(1);
            setRnChecked(0);
            setTipo(1);
        }
    }

    return (
        <>
            <AdminHeader></AdminHeader>
            {
                openConfirmationModalError &&
                <ConfirmModalError
                    title={actTitle}
                    label={actMsg}>
                </ConfirmModalError>
            }
            <div className='main-container'>
                <h2>Mostrar resultados de: </h2>
                <label htmlFor="">Levantamiento de requisitos</label>
                <input className='checkbox' checked={levChecked} onChange={handleChecked} type="checkbox" />
                <label htmlFor="">Condición RN</label>
                <input className='checkbox' checked={rnChecked} onChange={handleChecked} type="checkbox" /><br />
                <div className='modalbuttons'>
                    <button className='button' onClick={() => { toAdminForm() }}>Nueva solicitud</button>
                    <button className='button' onClick={() => { downloadResults() }}>Descargar resultados</button>
                    <button className='button' onClick={() => { generateDar() }}>Generar reporte DAR</button>
                    <button className='button' onClick={() => { sendResults() }}>Enviar resultados</button>
                </div>
            </div>
            {tipo == 1 && <LevantamientosTable id={id}></LevantamientosTable>}
            {tipo == 2 && <RNTable id={id} ></RNTable>}
        </>
    );
}

export default FormResults;