import { useState } from "react";
import AdminHeader from "../../components/AdminHeader";
import StudentRecord from "../../components/StudentRecord";
import StudentRecordRn from "../../components/StudentRecordRn";
export default function CarnetSearch() {
    const [carnet, setCarnet] = useState("");
    const [levChecked, setLevChecked] = useState(1);
    const [rnChecked, setRnChecked] = useState(0);
    const [tipo, setTipo] = useState(1);
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

    return <>
        <AdminHeader></AdminHeader>
        <div className="form">
            <h2>Ingrese el carnet del estudiante a solicitar</h2>
            <input className="input" type="text" value={carnet} onChange={event => setCarnet(event.target.value)} /><br></br>
        </div>
        <div className='main-container'>
            <h2>Mostrar resultados de: </h2>
            <label htmlFor="">Levantamiento de requisitos</label>
            <input className='checkbox' checked={levChecked} onChange={handleChecked} type="checkbox" />
            <label htmlFor="">Condición RN</label>
            <input className='checkbox' checked={rnChecked} onChange={handleChecked} type="checkbox" /><br />
        </div>
        {tipo == 1 && <StudentRecord carnet={carnet}></StudentRecord>}
        {tipo == 2 && <StudentRecordRn carnet={carnet}></StudentRecordRn>}
    </>
}