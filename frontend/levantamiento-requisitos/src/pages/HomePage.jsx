/* eslint-disable react-hooks/rules-of-hooks */
import logoTec from '../assets/tec.jpg';
import { useState } from 'react';
import { setGlobalState, useGlobalState } from '../state/FormState';
import InputModal from '../components/InputModal';
import { Config } from '../../config';
import ConfirmModal from '../components/ConfirmModal';
import ConfirmModalError from '../components/ConfirmationModalError';
export default function HomePage() {
    const [type, setType] = useState('1');
    const [openInputModal] = useGlobalState("openInputModal");
    const [openConfirmationModal] = useGlobalState("openConfirmationModal");
    const [openConfirmationModalError] = useGlobalState("openConfirmationModalError");
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

    function deleteRequest(carnet, token){
        const data = {
            'carnet': carnet,
            'token': token
        }

        const requestOptions = {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(data),
        };
        fetch(Config.api_url + `DeleteRequest`, requestOptions)
            .then((response) => {
                if(!response.ok){
                    console.log('Es rn')
                    fetch(Config.api_url + `DeleteRequestRn`, requestOptions)
                        .then((response) => {
                            if(!response.ok){
                                setGlobalState('openConfirmationModalError', true);
                            }
                            else{
                                setGlobalState('openConfirmationModal', true);
                            }
                        })
                }
                else{
                    setGlobalState('openConfirmationModal', true);
                }
            })
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
                button="Eliminar"
                function={deleteRequest}
            ></InputModal>
        }
        {
            openConfirmationModal && 
            <ConfirmModal
                title="Éxito" 
                label="Solicitud eliminada">
            </ConfirmModal>
        }
        {
            openConfirmationModalError && 
            <ConfirmModalError
                title="Error" 
                label="Token y/o carnet incorrectos.">
            </ConfirmModalError>
        }
        <div className="mainContent">
            <div className='logoContainer'>
                <img className='logoHomePage' src={logoTec} alt="Logo Instituto Tecnológico de Costa Rica" />
            </div>
            <div className='form'>
                <form onSubmit={handleNextStep}>
                    <label htmlFor="tiposLevantamiento">Seleccione el tipo de levantamiento a solicitar:</label>
                    <br />
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