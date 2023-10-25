import AdminForm from './pages/admin/AdminForm';
import AdminHomepage from './pages/admin/AdminHomePage';
import CarnetSearch from './pages/admin/CarnetSearch';
import FormResults from './pages/admin/FormResults';
import Login from './pages/admin/Login'
import NewAdmin from './pages/admin/NewAdmin';
import NewForm from './pages/admin/NewForm';
import UploadCourses from './pages/admin/UploadCourses';
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
  },
  {
    path: '/adminform/:id',
    element: <AdminForm/>
  },
  {
    path: '/carnetSearch',
    element: <CarnetSearch/>
  },
  {
    path: '/uploadCourses',
    element: <UploadCourses/>
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
