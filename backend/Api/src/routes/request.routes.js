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
  ObtenerCursosMXSolicitudRN,
  ObtenerCursosXSolicitudRN,
  SendResultRequest,
} from '../controllers/request.controller';

const router = Router();

router.get('/GetRequests', GetRequests);
router.post('/InsertRequest', InsertRequest);
router.post('/InsertRequestRn', InsertRequestRN);
router.post('/DeleteRequest', DeleteRequest);
router.post('/DeleteRequestRn', DeleteRequestRN);
router.post('/UpdateSolicitud', UpdateSolicitud);
router.post('/UpdateSolicitudRN', UpdateSolicitudNotificacion);
router.post('/GetRequestsNormal', GetRequestsNormal);
router.post('/GetRequestsRN', GetRequestsRN);
router.post('/ObtenerSolicitudesRNPorId', ObtenerSolicitudesRNPorId);
router.post('/ObtenerCursosMXSolicitudRN', ObtenerCursosMXSolicitudRN);
router.post('/ObtenerCursosXSolicitudRN', ObtenerCursosXSolicitudRN);
router.get('/SendEmail', SendResultRequest);

export default router;
