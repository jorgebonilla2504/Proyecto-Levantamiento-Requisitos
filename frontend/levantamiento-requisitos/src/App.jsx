import AdminHomepage from './pages/admin/AdminHomePage';
import Login from './pages/admin/Login'
import NewAdmin from './pages/admin/NewAdmin';
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
    path: 'newadmin',
    element: <NewAdmin/>
  },
]);

function App() {
  return (
    <div className="App">
      <RouterProvider router={router}></RouterProvider>
    </div>
  );
}

export default App
