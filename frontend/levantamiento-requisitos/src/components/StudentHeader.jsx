import logoTec from '../assets/tec.jpg'
import {useNavigate} from 'react-router-dom';

export default function StudentHeader(){
    const navigate = useNavigate();
    return <>
        <header>
            <div className="headerTitle">
                <img src={logoTec} alt="Logo Instituto Tecnológico de Costa Rica" />
            </div>
            <div className="headerLinks">
                <a href='#' onClick={() => navigate(-1)}>Atrás</a>
            </div>
        </header>
    </>
}