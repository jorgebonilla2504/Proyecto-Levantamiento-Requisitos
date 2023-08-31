import StudentHeader from "../../components/StudentHeader";

export default function RNForm() {
    return <>
        <StudentHeader></StudentHeader>
        <form className="form" action="/">
            <h2>Levantamiento por RN</h2>
            <p>El levantamiento de la condición RN debe tramitarse para aquel curso que el estudiante haya reprobado dos o más veces.
                La condición RN puede ser levantada tanto para cursos de la carrera como para cursos de servicio
                (Matemática, Ciencias del Lenguaje, Ciencias Sociales, Cultura y Deporte, Administración)
            </p>
            <p>Si lo ha perdido una única vez NO es necesario tramitar este tipo de levantamiento.</p>

            <label htmlFor="cursoRn">Indique el curso(s) en el que tiene una condición RN mayor o igual a 2:</label><br />
            <input className="input" type="text" name="cursoRn" id="cursoRn" required /><br />

            <label htmlFor="rn">Indique el RN del curso:</label><br />
            <input className="input" type="number" name="rn" id="rn" required /><br />

            <label htmlFor="">Seleccione el o los cursos que desea matricular pero su RN le impide:</label><br />
            <div className="listacheckbox">
                <input type="checkbox" /> MA0101 MATEMATICA GENERAL <br />
                <input type="checkbox" /> IC6200 INTELIGENCIA ARTIFICIAL <br />
                <input type="checkbox" /> MA0101 MATEMATICA GENERAL <br />
                <input type="checkbox" /> IC6200 INTELIGENCIA ARTIFICIAL <br />
            </div>

            <label htmlFor="motivo">Motivo por el cual solicita el levantamiento de la condición RN:</label><br />
            <textarea className="input" name="motivo" rows="10" cols="40"></textarea><br />

            <button className='button' type="submit">Enviar</button>

        </form>
    </>
}