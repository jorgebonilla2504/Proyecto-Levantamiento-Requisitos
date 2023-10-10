import { useParams } from 'react-router-dom';
import AdminHeader from '../../components/AdminHeader';
import { useState } from 'react';
import LevantamientosTable from '../../components/LevantamientosTable';
import RNTable from '../../components/RNTable';
import { setGlobalState } from '../../state/FormState';
import { useNavigate } from "react-router-dom";
function FormResults() {
    const navigate = useNavigate();
    const { id } = useParams();
    const [tipo, setTipo] = useState(1);
    const [levChecked, setLevChecked] = useState(1);
    const [rnChecked, setRnChecked] = useState(0);

    function toAdminForm() {
        setGlobalState('isLoggedIn', true);
        navigate('/adminform/' + id);
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
            <div className='main-container'>
                <h2>Mostrar resultados de: </h2>
                <label htmlFor="">Levantamiento de requisitos</label>
                <input className='checkbox' checked={levChecked} onChange={handleChecked} type="checkbox" />
                <label htmlFor="">Condición RN</label>
                <input className='checkbox' checked={rnChecked} onChange={handleChecked} type="checkbox" /><br />
                <div className='modalbuttons'>
                    <button className='button' onClick={() => { toAdminForm() }}>Nueva solicitud</button>
                </div>
            </div>
            {tipo == 1 && <LevantamientosTable id={id}></LevantamientosTable>}
            {tipo == 2 && <RNTable id={id} ></RNTable>}
        </>
    );
}

export default FormResults;