import { useNavigate } from "react-router-dom";
import { setGlobalState } from "../state/FormState";
export default function AdminHeader(){
    const navigate = useNavigate();
    function close() {
        setGlobalState('isLoggedIn', false);
        navigate('/');
    }

    function toNewAdmin(){
        setGlobalState('isLoggedIn', true);
        navigate('/newadmin');
    }
    return <>
        <header>
            <div className="headerTitle">
                <h2>Administrador</h2>
            </div>
            <div className="headerLinks">
                <a href='/home'>Inicio</a>
                <a href="#">Búsqueda por carnet</a>
                <a onClick={toNewAdmin} href="#">Nuevo Administrador</a>
                <a onClick={close} href="#">Cerrar sesión</a>
            </div>
        </header>
    </>
}