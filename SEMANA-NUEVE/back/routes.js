import { Router } from "express";
import { obtenerDatos } from "./controller.js";

export const router = Router();
router.post('/login', obtenerDatos);
