import { useParams } from 'react-router-dom';
import AdminHeader from '../../components/AdminHeader';
import { useEffect, useState } from 'react';
import { Config } from '../../../config';
import LevantamientosTable from '../../components/LevantamientosTable';
import RNTable from '../../components/RNTable';
function FormResults() {
    const { id } = useParams();
    const [tipo, setTipo] = useState(1);
    const [levChecked, setLevChecked] = useState(1);
    const [rnChecked, setRnChecked] = useState(0);
    const [rnResults, setRnResults] = useState([]);
    const [levResults, setLevResults] = useState([]);
    useEffect(() => {
        updateData();
    }, []);

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

    function updateData() {
        const data = {
            'id': id
        }

        const requestOptions = {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(data),
        };

        fetch(Config.api_url + 'GetRequestsNormal', requestOptions)
            .then(async (response) => {
                if (!response.ok) {
                    return 'No se pudo realizar el request';
                }
                else {
                    return await response.json();
                }
            })
            .then((solicitudes) => {
                setLevResults(solicitudes);
            })

        fetch(Config.api_url + 'GetRequestsRN', requestOptions)
            .then(async (response) => {
                if (!response.ok) {
                    return 'No se pudo realizar el request';
                }
                else {
                    return await response.json();
                }
            })
            .then((solicitudes) => {
                setRnResults(solicitudes);
            })
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
                <button className='button' onClick={() => {updateData()}}>Actualizar resultados</button>
            </div>
            {tipo == 1 && <LevantamientosTable data={levResults}></LevantamientosTable>}
            {tipo == 2 && <RNTable data={rnResults} ></RNTable>}
        </>
    );
}

export default FormResults;