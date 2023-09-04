import StudentHeader from '../../components/StudentHeader';
import { confirmAlert } from 'react-confirm-alert';
import 'react-confirm-alert/src/react-confirm-alert.css';
import { useState } from 'react';
import { useEffect } from 'react';
import { Config } from '../../../config';
import { useGlobalState, setGlobalState } from '../../state/FormState';
export default function LevantamientoForm() {
    const [cursos, setCursos] = useState([]);
    const [cursomatricular, setCursoMatricular] = useState('1');
    const [cursolevantar, setCursoLevantar] = useState('1');
    const [comentario, setComentario] = useState('');
    const [motivo, setMotivo] = useState('');
    const [personalinfo] = useGlobalState('personalinfo');
    function insertRequest() {
        const data = {
            'carnet': personalinfo.carnet,
            'nombreCompleto': personalinfo.nombre,
            'idPlan': personalinfo.plan,
            'email': personalinfo.correo,
            'comentario': comentario,
            'idFormulario': '2',
            'idSede': personalinfo.sede,
            'motivoLevantamiento': motivo,
            'idCursoLevanta': cursolevantar,
            'idCursoMatricular': cursomatricular,
        }
        const requestOptions = {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(data),
        };
        fetch(Config.api_url + `InsertRequest`, requestOptions);
        return true;
    }

    useEffect(() => {
        fetch(Config.api_url + `ListaCursos`)
            .then(async (response) => {
                if (!response.ok) {
                    return 'No se pudo realizar el request';
                }
                else {
                    return await response.json();
                }
            })
            .then((cursosJson) => {
                setCursos(cursosJson[0]);
                setCursoLevantar(cursosJson[0][0].idCurso);
                setCursoMatricular(cursosJson[0][0].idCurso);
            })
    }, []);

    function validateForm() {
        if (cursomatricular != '' && cursolevantar != '' && comentario != '', motivo != '') {
            return true;
        }
        return false;
    }



    function submit(e) {
        e.preventDefault();
        if (!validateForm()) {
            confirmAlert({
                title: 'Error',
                message: 'Llene todos los campos necesarios.',
                buttons: [
                    {
                        label: 'Continuar'
                    },
                ]
            });
        }
        else {
            if (!insertRequest()) {
                confirmAlert({
                    title: 'Error',
                    message: 'No se ha podido guardar la solicitud, intente de nuevo.',
                    buttons: [
                        {
                            label: 'Continuar'
                        },
                    ]
                });
            }
            else {
                // TO DO: place function to handle upload
                confirmAlert({
                    title: 'Éxito',
                    message: 'Se ha enviado su solicitud, esté atento a su correo ya que será contactado',
                    buttons: [
                        {
                            label: 'Continuar',
                            onClick: () => (
                                setGlobalState('step1', true),
                                setGlobalState('step3', false)
                            )
                        },
                    ]
                });
            }
        }
    }

    return <>
        <StudentHeader></StudentHeader>
        <form className="form" onSubmit={submit}>
            <h2>Levantamiento de Requisitos</h2>
            <label htmlFor="cursomatricular">Seleccione el curso a matricular:</label><br />
            <select
                className="input"
                name="cursomatricular"
                id="cursomatricular"
                value={cursomatricular}
                onChange={event => setCursoMatricular(event.target.value)}
                required>
                {cursos.map((curso) => (
                    <option key={curso.idCurso} value={curso.idCurso}>
                        {curso.codigo + " - " + curso.nombre}
                    </option>
                ))}
            </select><br />

            <label htmlFor="cursolevantar">Seleccione el curso que necesita levantar:</label><br />
            <select
                className="input"
                name="cursolevantar"
                id="cursolevantar"
                value={cursolevantar}
                onChange={event => setCursoLevantar(event.target.value)}
                required>
                {cursos.map((curso) => (
                    <option key={curso.idCurso} value={curso.idCurso}>
                        {curso.codigo + " - " + curso.nombre}
                    </option>
                ))}
            </select><br />

            <label htmlFor="comentario">Comentario por el que solicita el levantamiento de requisitos:</label><br />
            <input
                value={comentario}
                className="input"
                type="text"
                name="comentario"
                id="comentario"
                required
                onChange={event => setComentario(event.target.value)}
            ></input><br />

            <label htmlFor="motivo">Cualquier otro detalle que desee ampliar:</label><br />
            <textarea
                value={motivo}
                className="input"
                name="motivo"
                rows="10"
                cols="40"
                onChange={event => setMotivo(event.target.value)}
            ></textarea><br />
            {/* TO DO: function to handle if form info was updloaded */}
            <button className="button" >Enviar</button>
        </form>
    </>
}