import { Router } from "express";
import { login, tokeHuella, loginHuella } from "../controller/controller.js";
import { products, save } from "../controller/productos.js";
import { authenticateToken } from "../autheticate.js";

export const router = Router();
router.post('/login', login);
router.post('/regHuella', tokeHuella);
router.post('/logHuella',authenticateToken,  loginHuella )
router.get('/products', authenticateToken, products);
router.get('/save', save);
