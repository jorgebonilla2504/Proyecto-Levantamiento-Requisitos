import AdminHeader from '../../components/AdminHeader';
import { useGlobalState } from '../../state/FormState';
import ConfirmModal from '../../components/ConfirmModal';
export default function AdminHomepage() {
    const [isLoggedIn] = useGlobalState("isLoggedIn");
    const [openConfirmationModal] = useGlobalState('openConfirmationModal');
    return <>
        {
            isLoggedIn &&
            <>
                <AdminHeader></AdminHeader>
                {
                    openConfirmationModal &&
                    <ConfirmModal
                        title="Éxito"
                        label="Usuario creado">
                    </ConfirmModal>
                }
            </>
        }
        {
            !isLoggedIn &&
            <>
                <h1>Access denied!</h1>
            </>
        }
    </>
}