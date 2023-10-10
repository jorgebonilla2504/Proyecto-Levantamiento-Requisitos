import AdminHeader from "../../components/AdminHeader";
import { useGlobalState, setGlobalState } from "../../state/FormState"
import LevantamientoForm from "../student/LevantamientoForm";
import Personalinfo from "../student/Personainfo";
import RNForm from "../student/RNform";
import { useState } from "react";
import logoTec from '../../assets/tec.jpg';
import { useParams } from 'react-router-dom';
export default function Form() {
    const [step1] = useGlobalState("step1");
    const [step2] = useGlobalState("step2");
    const [step3] = useGlobalState("step3");
    const [type] = useGlobalState("type");
    const { id } = useParams();
    const [type1, setType] = useState('1');
    const handleChange = (e) => {
        setType(e.target.value);
        setGlobalState("type", e.target.value);
    };

    function handleNextStep(e){
        e.preventDefault();
        console.log("Hola");
        setGlobalState("step1", false);
        setGlobalState("step2", true);
    }

    return <>
        {step1 &&
            <>
                <AdminHeader></AdminHeader>
                <div className="mainContent">
                    <div className='logoContainer'>
                        <img className='logoHomePage' src={logoTec} alt="Logo Instituto Tecnológico de Costa Rica" />
                    </div>
                    <div className='form'>
                        <form onSubmit={handleNextStep}>
                            <label htmlFor="tiposLevantamiento">Seleccione el tipo de levantamiento a solicitar:</label>
                            <br />
                            <select onChange={handleChange} className='input' id="tiposLevantamiento" name="type" value={type1}>
                                <option value="1">Levantamiento de requisitos</option>
                                <option value="2">Condición RN</option>
                            </select>
                            <br />
                            <button type="submit" className='button'>Continuar</button>
                        </form>
                    </div>
                </div>
            </>
        }
        {step2 &&
            <>
                <Personalinfo></Personalinfo>
            </>
        }
        {(step3 && (type == "1")) &&
            <>
                <LevantamientoForm id={id}></LevantamientoForm>
            </>
        }
        {(step3 && (type == "2")) &&
            <>
                <RNForm id={id}></RNForm>
            </>
        }
    </>
}