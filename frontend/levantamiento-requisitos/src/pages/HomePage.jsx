/* eslint-disable react-hooks/rules-of-hooks */
import logoTec from '../assets/tec.jpg';
import { useState } from 'react';
import { setGlobalState, useGlobalState } from '../state/FormState';
import InputModal from '../components/InputModal';
export default function HomePage() {
    const [type, setType] = useState('1');
    const [openInputModal] = useGlobalState("openInputModal");
    const handleChange = (e) => {
        setType(e.target.value);
        setGlobalState("type", e.target.value);
    };

    function handleNextStep(e){
        e.preventDefault();
        setGlobalState("step1", false);
        setGlobalState("step2", true);
    }

    function handleOpenModal(){
        setGlobalState("openInputModal", true);
    }

    return <>
        <header>
            <div className="headerTitle">
                <h2>Escuela de computación</h2>
            </div>
            <div className="headerLinks">
                <a href="login">Iniciar Sesión</a>
                <a onClick={handleOpenModal} href="#">Cancelar una solicitud</a>
            </div>
        </header>
        {openInputModal && 
            <InputModal 
                title="Cancelar Solicitud" 
                label="Ingrese el token de la solicitud a eliminar:"
                button="Eliminar"
            ></InputModal>
        }
        <div className="mainContent">
            <div className='logoContainer'>
                <img className='logoHomePage' src={logoTec} alt="Logo Instituto Tecnológico de Costa Rica" />
            </div>
            <div className='form'>
                <form onSubmit={handleNextStep}>
                    <label htmlFor="tiposLevantamiento">Seleccione el tipo de levantamiento a solicitar:</label>
                    <br />
                    {/* TO DO: fill options with DB values */}
                    <select onChange={handleChange} className='input' id="tiposLevantamiento" name="type" value={type}>
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