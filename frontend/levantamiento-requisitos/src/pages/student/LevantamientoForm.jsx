import StudentHeader from '../../components/StudentHeader';
import { confirmAlert } from 'react-confirm-alert';
import 'react-confirm-alert/src/react-confirm-alert.css';
import { useNavigate } from 'react-router-dom';
import { useState } from 'react';
export default function LevantamientoForm() {
    const navigate = useNavigate();
    const [cursomatricular, setCursoMatricular] = useState('');
    const [cursolevantar, setCursoLevantar] = useState('');
    const [comentario, setComentario] = useState('');
    const [motivo, setMotivo] = useState('');

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
            <h2>Levantamiento de Requisitos</h2>
            <label htmlFor="cursomatricular">Seleccione el curso a matricular:</label><br />
            <select
                value={cursomatricular}
                className="input"
                type="text" name="cursomatricular"
                id="cursomatricular" required
                onChange={event => setCursoMatricular(event.target.value)}
            >
                <option value="1">IC6200 INTELIGENCIA ARTIFICIAL</option>
            </select><br />

            <label htmlFor="cursolevantar">Seleccione el curso que necesita levantar:</label><br />
            <select
                value={cursolevantar}
                className="input"
                type="text" name="cursolevantar"
                id="cursolevantar" required
                onChange={event => setCursoLevantar(event.target.value)}
            >
                <option value="1">IC6200 INTELIGENCIA ARTIFICIAL</option>
            </select><br />

            <label htmlFor="comentario">Comentario por el que solicita el levantamiento de requisitos:</label><br />
            <select
                value={comentario}
                className="input"
                type="text" name="comentario"
                id="comentario" 
                required
                onChange={event => setComentario(event.target.value)}
            >
                <option value="1">Para poder llevar otro curso.</option>
            </select><br />

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