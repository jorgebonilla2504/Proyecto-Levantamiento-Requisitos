import { setGlobalState, useGlobalState } from "../../state/FormState";
import AdminHeader from "../../components/AdminHeader";
import { useState } from "react";
import { Config } from "../../../config";
import { useNavigate } from "react-router-dom";
import ConfirmModal from "../../components/ConfirmModal";
import ConfirmModalError from "../../components/ConfirmationModalError";
export default function NewAdmin() {
    const [isLoggedIn] = useGlobalState("isLoggedIn");
    const [nombre, setNombre] = useState('');
    const [email, setEmail] = useState('');
    const [pass, setPass] = useState('');
    const [openConfirmationModal] = useGlobalState('openConfirmationModal');
    const [openConfirmationModalError] = useGlobalState('openConfirmationModalError');
    const navigate = useNavigate();
    function postAdmin(e) {
        e.preventDefault();
        const data = {
            'nombre': nombre,
            'email': email,
            'clave': pass
        }

        const requestOptions = {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(data),
        };

        fetch(Config.api_url + 'InsertarAdministrador', requestOptions)
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
                        label="Solicitud eliminada">
                        function={navigate('/home')}
                    </ConfirmModal>
                }
                {
                    openConfirmationModalError &&
                    <ConfirmModalError
                        title="Error"
                        label="Token y/o carnet incorrectos.">
                    </ConfirmModalError>
                }
                <div className='form'>
                    <h1>Nuevo Administrador</h1>
                    <form onSubmit={postAdmin}>
                        <label htmlFor="nombre">Nombre:</label>
                        <br />
                        <input className='input' type="text" name='nombre' value={nombre} onChange={event => setNombre(event.target.value)} />
                        <br />
                        <label htmlFor="correo">Correo:</label>
                        <br />
                        <input className='input' type="text" name='correo' value={email} onChange={event => setEmail(event.target.value)} />
                        <br />
                        <label htmlFor="pass">Contraseña:</label>
                        <br />
                        <input className='input' type='password' name='pass' value={pass} onChange={event => setPass(event.target.value)} />
                        <br />
                        <button className='button' type="submit">Crear Usuario</button>
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