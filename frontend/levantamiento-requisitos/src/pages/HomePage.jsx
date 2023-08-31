import logoTec from '../assets/tec.jpg';

export default function HomePage() {
    return <>
        <header>
            <div className="headerTitle">
                <h2>Escuela de computación</h2>
            </div>
            <div className="headerLinks">
                <a href="login">Iniciar Sesión</a>
            </div>
        </header>
        <div className="mainContent">
            <div className='logoContainer'>
                <img className='logoHomePage' src={logoTec} alt="Logo Instituto Tecnológico de Costa Rica" />
            </div>
            <div className='form'>
                <form action="/personalinfo">
                    <label htmlFor="tiposLevantamiento">Seleccione el tipo de levantamiento a solicitar:</label>
                    <br />
                    {/* TO DO: fill options with DB values */}
                    <select className='input' id="tiposLevantamiento" name="tipoLevantamiento">
                        <option value="1">Levantamiento de requisitos</option>
                        <option value="2">Condición RN</option>
                    </select>
                    <br />
                    <button className='button' type="submit">Continuar</button>
                </form>
            </div>
        </div>
    </>
}