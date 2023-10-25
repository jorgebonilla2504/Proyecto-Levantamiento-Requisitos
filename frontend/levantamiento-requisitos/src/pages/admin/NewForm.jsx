import { setGlobalState, useGlobalState } from "../../state/FormState"; import AdminHeader from "../../components/AdminHeader";
import { useState } from "react";
import { Config } from "../../../config";
import { useNavigate } from "react-router-dom";
import ConfirmModal from "../../components/ConfirmModal";
import ConfirmModalError from "../../components/ConfirmationModalError";

export default function NewForm() {
    const [isLoggedIn] = useGlobalState("isLoggedIn");
    const [fecha, setFecha] = useState('');
    const [nombre, setNombre] = useState('');
    const [periodo, setPeriodo] = useState('1');
    const [openConfirmationModal] = useGlobalState('openConfirmationModal');
    const [openConfirmationModalError] = useGlobalState('openConfirmationModalError');
    const navigate = useNavigate();
    function postForm(e) {
        e.preventDefault();
        console.log(periodo);
        const data = {
            'fechaVencimiento': fecha,
            'nombre': nombre,
            'semestre': periodo,
            'periodo': periodo
        }

        const requestOptions = {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(data),
        };

        fetch(Config.api_url + 'InsertarFormulario', requestOptions)
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
        {
            isLoggedIn &&
            <>
                <AdminHeader></AdminHeader>
                {
                    openConfirmationModal &&
                    <ConfirmModal
                        title="Éxito"
                        label="Formulario creado.">
                        function={navigate('/home')}
                    </ConfirmModal>
                }
                {
                    openConfirmationModalError &&
                    <ConfirmModalError
                        title="Error"
                        label="Ocurrió un error al crear el formulario, intente de nuevo.">
                    </ConfirmModalError>
                }
                <div className='form'>
                    <h1>Nuevo Formulario</h1>
                    <form onSubmit={postForm}>
                        <label htmlFor="fecha">Fecha de vencimiento:</label>
                        <br />
                        <input className='input' type="date" name='fecha' value={fecha} onChange={event => setFecha(event.target.value)} />
                        <br />
                        <label htmlFor="nombre">Nombre:</label>
                        <br />
                        <input className='input' type="text" name='nombre' value={nombre} onChange={event => setNombre(event.target.value)} />
                        <br />

                        <label htmlFor="periodo">Seleccione un periodo:</label><br />

                        <select className='input' name="periodo" value={periodo} onChange={event => setPeriodo(event.target.value)}>
                            <option value="1">I Semestre</option>
                            <option value="2">II Semestre</option>
                            <option value="3">Verano</option>
                        </select><br/>

                        <button className='button' type="submit">Crear Formulario</button>
                    </form>
                </div>
            </>
        }
        {
            !isLoggedIn &&
            <>
                <h1>Access denied!</h1>
            </>
        }
    </>
}