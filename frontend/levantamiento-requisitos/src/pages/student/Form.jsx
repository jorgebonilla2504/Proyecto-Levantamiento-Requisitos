import { useGlobalState } from "../../state/FormState"
import HomePage from "../HomePage";
import LevantamientoForm from "./LevantamientoForm";
import Personalinfo from "./Personainfo";
import RNForm from "./RNform";

export default function Form(){
    const [step1] = useGlobalState("step1");
    const [step2] = useGlobalState("step2");
    const [step3] = useGlobalState("step3");
    const [type] = useGlobalState("type");
    return <>
        {step1 && 
            <HomePage></HomePage>
        }
        {step2 &&
            <>
                <Personalinfo></Personalinfo>
            </>
        }
        {(step3 && (type == "1")) &&
            <>
                <LevantamientoForm></LevantamientoForm>
            </>
        }
        {(step3 && (type == "2")) &&
            <>
                <RNForm></RNForm>
            </>
        }
    </>
}