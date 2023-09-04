/* eslint-disable react/prop-types */
import StudentHeader from '../../components/StudentHeader';
import { setGlobalState } from '../../state/FormState';
import { Config } from '../../../config';
import { useState } from 'react';
import { useEffect } from 'react';
export default function Personalinfo() {
    const [planes, setPlanes] = useState([]);
    const [sedes, setSedes] = useState([]);
    const [carnet, setCarnet] = useState('');
    const [nombre, setNombre] = useState('');
    const [correo, setCorreo] = useState('');
    const [sede, setSede] = useState('');
    const [plan, setPlan] = useState('');

    useEffect(() => {
        fetch(Config.api_url + `ListaPlanesEstudio`)
            .then(async (response) => {
                if (!response.ok) {
                    return 'No se pudo realizar el request';
                }
                else {
                    return await response.json();
                }
            })
            .then((planesJson) => {
                setPlanes(planesJson[0]);
                setPlan(planesJson[0][0].idPlanEstudios);
            })

        fetch(Config.api_url + `ListaSedes`)
            .then(async (response) => {
                if (!response.ok) {
                    return 'No se pudo realizar el request';
                }
                else {
                    return await response.json();
                }
            })
            .then((sedesJson) => {
                setSedes(sedesJson[0]);
                setSede(sedesJson[0][0].idSede);
            })
    }, []);

    function handleNextStep(e) {
        e.preventDefault();
        const personalinfo = {
            carnet: carnet,
            nombre: nombre,
            correo: correo,
            sede: sede,
            plan: plan
        }
        setGlobalState('personalinfo', personalinfo);
        setGlobalState('step2', false);
        setGlobalState('step3', true);
    }

    return <>
        <StudentHeader></StudentHeader>
        <form className="form" onSubmit={handleNextStep}>
            <h1>Datos Personales</h1>
            <label htmlFor="carnet">Ingrese el número de carnet:</label><br />
            <input
                className="input"
                type="text"
                name="carnet"
                id="carnet"
                required
                value={carnet}
                onChange={event => setCarnet(event.target.value)}
            /><br />

            <label htmlFor="nombre">Ingrese su nombre completo (Primer Apellido - Segundo Apellido - Nombre)</label><br />
            <input
                className="input"
                type="text"
                name="nombre"
                id="nombre"
                required
                value={nombre}
                onChange={event => setNombre(event.target.value)}
            /><br />

            <label htmlFor="correo">Ingrese su correo electrónico:</label><br />
            <input
                className="input"
                type="text"
                name="correo"
                id="correo"
                required
                value={correo}
                onChange={event => setCorreo(event.target.value)}
            /><br />

            <label htmlFor="sede">Ingrese la sede donde se encuetra: </label><br />
            <select
                className="input"
                name="sede"
                id="sede"
                value={sede}
                onChange={event => setSede(event.target.value)}
                required>
                {sedes.map((sede) => (
                    <option key={sede.idSede} value={sede.idSede}>
                        {sede.nombre}
                    </option>
                ))}
            </select><br />

            <label htmlFor="plan">Seleccione su plan de estudios:</label><br />
            <select
                className="input"
                name="plan"
                id="plan"
                value={plan}
                onChange={event => setPlan(event.target.value)}
                required>
                {planes.map((plan) => (
                    <option key={plan.idPlanEstudios} value={plan.idPlanEstudios}>
                        {plan.nombre}
                    </option>
                ))}
            </select><br />

            <button className='button' type="submit">Continuar</button>
        </form>
    </>
}