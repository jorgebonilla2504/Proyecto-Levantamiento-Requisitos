import StudentHeader from "../../components/StudentHeader"
export default function Personalinfo(){
    let type = 1;
    let action = '';
    if(type == 1){
        action = '/levantamientoRn'
    }
    else{
        action = '/levantamientoRequisitos'
    }

    return <>
        <StudentHeader></StudentHeader>
        <form className="form" action={action}>
            <h1>Datos Personales</h1>
            <label htmlFor="carnet">Ingrese el número de carnet:</label><br />
            <input className="input" type="text" name="carnet" id="carnet" required/><br />

            <label htmlFor="nombre">Ingrese su nombre completo (Primer Apellido - Segundo Apellido - Nombre)</label><br />
            <input className="input" type="text" name="nombre" id="nombre" required/><br />

            <label htmlFor="correo">Ingrese su correo electrónico:</label><br />
            <input className="input" type="text" name="correo" id="correo" required /><br />

            <label htmlFor="plan">Seleccione su plan de estudios:</label><br />
            <select className="input" name="plan" id="plan" required>
                <option value="1">410</option>
            </select><br />

            <button className='button' type="submit">Continuar</button>
        </form>
    </>
}