/* eslint-disable react/prop-types */
import { setGlobalState } from "../state/FormState";
export default function ConfirmModal(props) {

    function handleCloseModal() {
        setGlobalState('openConfirmationModal', false);
        setGlobalState('openInputModal', false);
    }

    return <>
        <div className="overlay">
            <div className="modal">
                <h2>{props.title}</h2>
                <p>{props.label}</p>
                <button onClick={handleCloseModal} className="button">Continuar</button>
            </div>
        </div>
    </>
}