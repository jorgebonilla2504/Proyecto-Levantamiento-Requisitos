import AdminHomepage from './pages/admin/AdminHomePage';
import FormResults from './pages/admin/FormResults';
import Login from './pages/admin/Login'
import NewAdmin from './pages/admin/NewAdmin';
import NewForm from './pages/admin/NewForm';
import Form from "./pages/student/Form"
import { createBrowserRouter, RouterProvider } from 'react-router-dom'

const router = createBrowserRouter([
  {
    path: '/',
    element: <Form/>
  },
  {
    path: '/login',
    element: <Login/>
  },
  {
    path: '/home',
    element: <AdminHomepage/>
  },
  {
    path: '/newadmin',
    element: <NewAdmin/>
  },
  {
    path: '/form/:id',
    element: <FormResults/>
  },
  {
    path: '/newform',
    element: <NewForm/>
  }
]);

function App() {
  return (
    <div className="App">
      <RouterProvider router={router}></RouterProvider>
    </div>
  );
}

export default App
