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

    function toHome(){
        setGlobalState('isLoggedIn', true);
        navigate('/home');
    }

    function toCarnetSearch(){
        setGlobalState('isLoggedIn', true);
        navigate('/carnetSearch');
    }
    return <>
        <header>
            <div className="headerTitle">
                <h2>Administrador</h2>
            </div>
            <div className="headerLinks">
                <a onClick={toHome} href='#'>Inicio</a>
                <a onClick={toCarnetSearch} href="#">Búsqueda por carnet</a>
                <a onClick={toNewAdmin} href="#">Nuevo Administrador</a>
                <a onClick={close} href="#">Cerrar sesión</a>
            </div>
        </header>
    </>
}