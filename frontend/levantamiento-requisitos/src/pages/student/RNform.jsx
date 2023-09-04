import StudentHeader from '../../components/StudentHeader';
import { confirmAlert } from 'react-confirm-alert';
import 'react-confirm-alert/src/react-confirm-alert.css';
import { useNavigate } from 'react-router-dom';
import { useState } from 'react';
export default function RNForm() {
    const navigate = useNavigate();
    const [cursoRn, setCursoRn] = useState('');
    const [rn, setRn] = useState('');
    const [motivo, setMotivo] = useState('');

    function validateForm() {
        if (cursoRn != '' && rn != '' && motivo != '') {
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
            // TO DO: place function to handle upload
            confirmAlert({
                title: 'Éxito',
                message: 'Se ha enviado su solicitud, esté atento a su correo ya que será contactado',
                buttons: [
                    {
                        label: 'Continuar',
                        onClick: () => (navigate('/'))
                    },
                ]
            });
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
            <input
                value={cursoRn}
                className="input"
                type="text" name="cursoRn"
                id="cursoRn" required
                onChange={event => setCursoRn(event.target.value)}
            /><br />

            <label htmlFor="rn">Indique el RN del curso:</label><br />
            <input
                value={rn}
                className="input"
                type="number"
                name="rn"
                id="rn"
                required
                onChange={event => setRn(event.target.value)}
            /><br />

            <label htmlFor="">Seleccione el o los cursos que desea matricular pero su RN le impide:</label><br />
            {/* TO DO: fill with db values */}
            <div className="listacheckbox">
                <input type="checkbox" /> MA0101 MATEMATICA GENERAL <br />
                <input type="checkbox" /> IC6200 INTELIGENCIA ARTIFICIAL <br />
                <input type="checkbox" /> MA0101 MATEMATICA GENERAL <br />
                <input type="checkbox" /> IC6200 INTELIGENCIA ARTIFICIAL <br />
            </div>

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