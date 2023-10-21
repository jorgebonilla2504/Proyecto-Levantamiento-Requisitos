// Purpose: request routes to call request controllers
import { Router } from 'express';

import {
  InsertRequest,
  InsertRequestRN,
  DeleteRequestRN,
  DeleteRequest,
  GetRequests,
  GetRequestsNormal,
  GetRequestsRN,
  UpdateSolicitud,
  UpdateSolicitudNotificacion,
  ObtenerSolicitudesRNPorId,
  GetHistoryUser,
  GetInforme,
  GenerarInforme,
  SendResultRequest,
  ObtenerCursosMXSolicitudRN,
  ObtenerCursosXSolicitudRN,
} from '../controllers/request.controller';

const router = Router();

router.get('/GetRequests', GetRequests);
router.get('/InformationDar', GenerarInforme);
router.get('/SendResultRequest', SendResultRequest);
router.post('/InsertRequest', InsertRequest);
router.post('/InsertRequestRn', InsertRequestRN);
router.post('/DeleteRequest', DeleteRequest);
router.post('/DeleteRequestRn', DeleteRequestRN);
router.post('/UpdateSolicitud', UpdateSolicitud);
router.post('/UpdateSolicitudRN', UpdateSolicitudNotificacion);
router.post('/GetRequests', GetRequestsNormal);
router.post('/GetRequestsRN', GetRequestsRN);
router.post('/ObtenerSolicitudesRNPorId', ObtenerSolicitudesRNPorId);
router.post('/DownloadInformation', GetInforme);
router.post('/GetUserHistory', GetHistoryUser);
router.post('/ObtenerCursosMXSolicitudRN', ObtenerCursosMXSolicitudRN);
router.post('/ObtenerCursosXSolicitudRN', ObtenerCursosXSolicitudRN);

export default router;
