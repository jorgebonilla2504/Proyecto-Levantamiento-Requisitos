import { useState } from "react";
import { setGlobalState } from "../state/FormState"

/* eslint-disable react/prop-types */
export default function InputModal(props) {
    const [carnet, setCarnet] = useState('');
    const [token, setToken] = useState('');
    function handleCloseModal() {
        setGlobalState("openInputModal", false);
    }

    function handleFunction(){
        props.function(carnet, token);
    }

    return <>
        <div className="overlay">
            <div className="modal">
                <h3>{props.title}</h3>
                <label htmlFor="carnet">Ingrese su número de carnet:</label>
                <input 
                    type="text" 
                    className="input"
                    name="carnet"
                    value={carnet}
                    onChange={event => setCarnet(event.target.value)}
                />
                <label htmlFor="token">Ingrese el token:</label>
                <input 
                    type="text" 
                    className="input"
                    name="token"
                    value={token}
                    onChange={event => setToken(event.target.value)}
                />
                <div className="modalbuttons">
                    <button onClick={handleFunction} className="button">{props.button}</button>
                    <button onClick={handleCloseModal} className="button">Cancelar</button>
                </div>
            </div>
        </div>
    </>
}