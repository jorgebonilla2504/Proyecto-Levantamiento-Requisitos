import AdminHeader from '../../components/AdminHeader';
import { useGlobalState } from '../../state/FormState';
import ConfirmModal from '../../components/ConfirmModal';
import { useState, useEffect } from 'react';
import { Config } from '../../../config';
import { useNavigate } from "react-router-dom";
import { setGlobalState } from "../../state/FormState";

export default function AdminHomepage() {
    const navigate = useNavigate();

    const [forms, setForms] = useState([]);
    const [isLoggedIn] = useGlobalState("isLoggedIn");
    const [openConfirmationModal] = useGlobalState('openConfirmationModal');

    useEffect(() => {
        fetch(Config.api_url + `GetFormularios`)
            .then(async (response) => {
                if (!response.ok) {
                    return 'No se pudo realizar el request';
                }
                else {
                    return await response.json();
                }
            })
            .then((cursosJson) => {
                setForms(cursosJson[0]);
            })
    }, []);

    function toFormResults(id) {
        setGlobalState('isLoggedIn', true);
        navigate('/form/' + id);
    }

    function toNewForm(){
        setGlobalState('isLoggedIn', true);
        navigate('/newform');
    }

    return <>
        {
            isLoggedIn &&
            <>
                <AdminHeader></AdminHeader>
                <div className='main-container'>
                    <h1>Formularios</h1>
                    <ul>
                        {forms.map((form) => (
                            <>
                                <li><a onClick={() => { toFormResults(form.FormularioID) }} href="#">{form.nombre}</a></li>
                            </>
                        ))}
                    </ul>

                    <a onClick={() => { toNewForm() }} href="#">Crear nuevo formulario</a>
                </div>
                {
                    openConfirmationModal &&
                    <ConfirmModal
                        title="Éxito"
                        label="Acción ejecutada con éxito">
                    </ConfirmModal>
                }
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