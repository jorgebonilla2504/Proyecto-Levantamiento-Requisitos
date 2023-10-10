/* eslint-disable no-unused-vars */
import StudentHeader from '../../components/StudentHeader';
import { confirmAlert } from 'react-confirm-alert';
import 'react-confirm-alert/src/react-confirm-alert.css';
import { useNavigate } from 'react-router-dom';
import { useState } from 'react';
import { useEffect } from 'react';
import { Config } from '../../../config';
import { setGlobalState, useGlobalState } from '../../state/FormState';
export default function RNForm() {
    const navigate = useNavigate();
    const [personalinfo] = useGlobalState('personalinfo');
    const [cursos, setCursos] = useState('');
    const [cursosRn, setCursosRn] = useState([]);
    const [rn, setRn] = useState('');
    const [motivo, setMotivo] = useState('');
    const [cursosMatricula, setCursosMatricula] = useState([]);
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
            })
    }, []);

    function validateForm() {
        console.log()
        if (cursosMatricula.length > 0 && cursosRn.length > 0 && rn != '' && rn > 0) {
            return true;
        }
        return false;
    }

    function validateCursos(){
        for (let i = 0; i < cursosRn.length; i++) {
            if (cursosMatricula.includes(cursosRn[i])) {
              return false; 
            }
          }
          return true;
    }

    function handleCursosRn(idCurso) {
        const index = cursosRn.indexOf(idCurso); // Busca el índice del valor en el array
        let arr = cursosRn;
        if (index === -1) {
            arr.push(idCurso);
        } else {
            arr.splice(index, 1);
        }
        setCursosRn(arr);
    }

    function handleCursosMatricula(idCurso) {
        const index = cursosMatricula.indexOf(idCurso); // Busca el índice del valor en el array
        let arr = cursosMatricula;
        if (index === -1) {
            arr.push(idCurso);
        } else {
            arr.splice(index, 1);
        }
        setCursosMatricula(arr);
    }

    function insertRequest() {
        let cursosMXRNString = "";
        let cursosRNSrign = "";
        for (let i = 0; i < cursosMatricula.length; i++) {
            cursosMXRNString += cursosMatricula[i].toString();

            if (i + 1 == cursosMatricula.length) {
                break;
            }

            cursosMXRNString += ",";
        }

        for (let i = 0; i < cursosRn.length; i++) {
            cursosRNSrign += cursosRn[i].toString();

            if (i + 1 == cursosRn.length) {
                break;
            }

            cursosRNSrign += ",";
        }
        const data = {
            'carnet': personalinfo.carnet,
            'nombreCompleto': personalinfo.nombre,
            'idPlan': personalinfo.plan,
            'email': personalinfo.correo,
            'comentario': motivo,
            'idFormulario': '1',
            'idSede': personalinfo.sede,
            'motivoLevantamiento': motivo,
            'nivelRn': rn,
            'cursosMXRNString': cursosMXRNString,
            'cursosRNSrign': cursosRNSrign,
        }
        const requestOptions = {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(data),
        };
        fetch(Config.api_url + `InsertRequestRn`, requestOptions);
        return true;
    }

    function submit(e) {
        e.preventDefault();
        if (!validateForm()) {
            confirmAlert({
                title: 'Error',
                message: 'Llene todos los campos necesarios y asegúrese de no ingresar valores negativos.',
                buttons: [
                    {
                        label: 'Continuar'
                    },
                ]
            });
        }
        else if (!validateCursos()) {
            confirmAlert({
                title: 'Error',
                message: 'La lista de cursos de matrícula no puede contener cursos de la lista de cursos RN',
                buttons: [
                    {
                        label: 'Continuar'
                    },
                ]
            });
        }
        else {
            if (insertRequest()) {
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
            <h2>Levantamiento por RN</h2>
            <p>El levantamiento de la condición RN debe tramitarse para aquel curso que el estudiante haya reprobado dos o más veces.
                La condición RN puede ser levantada tanto para cursos de la carrera como para cursos de servicio
                (Matemática, Ciencias del Lenguaje, Ciencias Sociales, Cultura y Deporte, Administración)
            </p>
            <p>Si lo ha perdido una única vez NO es necesario tramitar este tipo de levantamiento.</p>

            <label htmlFor="cursoRn">Indique el curso(s) en el que tiene una condición RN mayor o igual a 2:</label><br />
            {
                cursos.length > 0 &&
                <div className="listacheckbox">

                    {cursos.map((curso) => (
                        <>
                            {
                                <>
                                    <label>{curso.codigo + " - " + curso.nombre}</label>
                                    <input onChange={() => (handleCursosRn(curso.idCurso))} key={curso.idCurso} type='checkbox'></input><br />
                                </>
                            }
                        </>
                    ))}
                </div>
            }

            <label htmlFor="rn">Indique el RN del curso:</label><br />
            <input
                value={rn}
                className="input"
                type="number"
                name="rn"
                id="rn"
                required
                min="0"
                onChange={event => setRn(event.target.value)}
            /><br />

            <label htmlFor="">Seleccione el o los cursos que desea matricular pero su RN le impide:</label><br />
            {
                cursos.length > 0 &&
                <div className="listacheckbox">

                    {cursos.map((curso) => (
                        <>
                            {
                                <>
                                    <label>{curso.codigo + " - " + curso.nombre}</label>
                                    <input onChange={() => (handleCursosMatricula(curso.idCurso))} key={curso.idCurso} type='checkbox'></input><br />
                                </>
                            }
                        </>
                    ))}
                </div>
            }

            <label htmlFor="motivo">Motivo por el cual solicita el levantamiento de la condición RN:</label><br />
            <textarea
                value={motivo}
                className="input"
                name="motivo"
                rows="10"
                cols="40"
                onChange={event => setMotivo(event.target.value)}
            ></textarea><br />
            {/* TO DO: function to handle if form info was updloaded */}
            <button className="button">Enviar</button>
        </form>
    </>
}