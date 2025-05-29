import { Router } from "express";
import { login,  registro, cerrarSesion } from "../controller/controller.js";
import { obtUsuarios } from "../controller/usuarios.js";
import { enviarMensaje, getMensajes} from "../controller/mensaje.js";


export const router = Router();
router.post('/register', registro);
router.post('/login', login);
router.get('/usuarios', obtUsuarios);
router.post('/enviarMensaje', enviarMensaje);
router.post('/getMensajes', getMensajes);
router.post('/eliminarToken',cerrarSesion);

