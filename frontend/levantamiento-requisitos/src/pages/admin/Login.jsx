import logoTec from '../../assets/tec.jpg';
import { Config } from '../../../config';
import { useState } from 'react';
import { setGlobalState, useGlobalState } from '../../state/FormState';
import ConfirmModalError from '../../components/ConfirmationModalError';
import { useNavigate } from 'react-router-dom';
export default function Login() {
    const navigate = useNavigate();
    const [email, setEmail] = useState("");
    const [pass, setPass] = useState("");
    const [openConfirmationModal] = useGlobalState('openConfirmationModalError');
    function login(e) {
        e.preventDefault();
        const data = {
            'email': email,
            'clave': pass
        }

        const requestOptions = {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(data),
        };

        fetch(Config.api_url + 'VerificarCredenciales', requestOptions)
            .then((response) => {
                if(!response.ok){
                    setGlobalState('openConfirmationModalError', true);
                }
                else{
                    setGlobalState("isLoggedIn", true);
                    navigate('/home');
                }
            })
    }

    return <>
        <header>
            <div className="headerTitle">
                <h2>Administrador</h2>
            </div>
            <div className="headerLinks">
                <a href="/">Inicio</a>
            </div>
        </header>
        {
            openConfirmationModal && 
            <ConfirmModalError title="Error" label="Usuario y/o contraseña incorrectos, intente de nuevo." ></ConfirmModalError>
        }
        <div className="mainContent">
            <div className='logoContainer'>
                <img className='logoHomePage' src={logoTec} alt="Logo Instituto Tecnológico de Costa Rica" />
            </div>
            <div className='form'>
                <form onSubmit={login}>
                    <label htmlFor="correo">Correo:</label>
                    <br />
                    <input className='input' type="text" name='correo' value={email} onChange={event => setEmail(event.target.value)} />
                    <br />
                    <label htmlFor="pass">Contraseña:</label>
                    <br />
                    <input className='input' type='password' name='pass' value={pass} onChange={event => setPass(event.target.value)} />
                    <br />
                    <button className='button' type="submit">Iniciar sesión</button>
                </form>
            </div>
        </div>
    </>
}