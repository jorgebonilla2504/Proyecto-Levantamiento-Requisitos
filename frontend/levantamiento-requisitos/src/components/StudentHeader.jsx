import logoTec from '../assets/tec.jpg'
import { setGlobalState, useGlobalState } from '../state/FormState'

export default function StudentHeader(){
    const [step2] = useGlobalState('step2');
    const [step3] = useGlobalState('step3');
    function resetSteps(){
        if(step2){
            setGlobalState('step2', false);
            setGlobalState('step1', true);
        }
        else if(step3){
            setGlobalState('step2', true);
            setGlobalState('step3', false);
        }
    }
    return <>
        <header>
            <div className="headerTitle">
                <img src={logoTec} alt="Logo Instituto Tecnológico de Costa Rica" />
            </div>
            <div className="headerLinks">
                <a href='#' onClick={resetSteps}>Atrás</a>
            </div>
        </header>
    </>
}