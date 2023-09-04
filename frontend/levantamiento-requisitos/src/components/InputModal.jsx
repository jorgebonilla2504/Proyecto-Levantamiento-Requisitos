import { setGlobalState } from "../state/FormState"

/* eslint-disable react/prop-types */
export default function InputModal(props) {

    function handleCloseModal() {
        setGlobalState("openInputModal", false);
    }

    function deleteForm() {
        handleCloseModal();
    }
    return <>
        <div className="overlay">
            <div className="modal">
                <h3>{props.title}</h3>
                <p>{props.label}</p>
                <input type="text" className="input" />
                <div className="modalbuttons">
                    <button onClick={deleteForm} className="button">{props.button}</button>
                    <button onClick={handleCloseModal} className="button">Cancelar</button>
                </div>
            </div>
        </div>
    </>
}