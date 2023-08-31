import Home from "./pages/HomePage"
import Login from './pages/admin/Login'
import Personalinfo from "./pages/student/Personainfo"
import RNForm from "./pages/student/RNform"
import { createBrowserRouter, RouterProvider } from 'react-router-dom'

const router = createBrowserRouter([
  {
    path: '/',
    element: <Home/>
  },
  {
    path: '/login',
    element: <Login/>
  },
  {
    path: '/personalinfo',
    element: <Personalinfo/>
  },
  {
    path: '/levantamientoRn',
    element: <RNForm/>
  },
])

function App() {
  return (
    <div className="App">
      <RouterProvider router={router}></RouterProvider>
    </div>
  );
}

export default App
