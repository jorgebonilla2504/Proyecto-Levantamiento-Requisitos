import { createGlobalState } from 'react-hooks-global-state';

const {setGlobalState, useGlobalState} = createGlobalState({
    step1: true,
    step2: false,
    step3: false,
    type: "1",
    personalinfo: {},
    levantamientoinfo: {},
    token: undefined,
    openInputModal: false,
    openConfirmationModalError: false,
    openConfirmationModal: false,
    isLoggedIn: false
});

export {setGlobalState, useGlobalState};