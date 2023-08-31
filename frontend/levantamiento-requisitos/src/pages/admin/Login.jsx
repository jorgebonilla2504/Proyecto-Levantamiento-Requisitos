import logoTec from '../../assets/tec.jpg';
export default function Login(){
    return <>
        <header>
            <div className="headerTitle">
                <h2>Administrador</h2>
            </div>
            <div className="headerLinks">
                <a href="/">Inicio</a>
            </div>
        </header>
        <div className="mainContent">
            <div className='logoContainer'>
                <img className='logoHomePage' src={logoTec} alt="Logo Instituto Tecnológico de Costa Rica" />
            </div>
            <div className='form'>
                <form action="">
                    <label htmlFor="correo">Correo:</label>
                    <br />
                    <input className='input' type="text" name='correo' />
                    <br />
                    <label htmlFor="pass">Contraseña:</label>
                    <br />
                    <input className='input' type='password' name='pass' />
                    <br />
                    <button className='button' type="submit">Iniciar sesión</button>
                </form>
            </div>
        </div>
    </>
}