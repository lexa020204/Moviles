import { Router } from "express";
import { login, user } from "../controller/controller.js";
import { products, favoritos, favUsuarios, elimFavoritos } from "../controller/productos.js";
import { authenticateToken } from "../autheticate.js";

export const router = Router();
router.post('/login', login);
router.post('/createUser', user);
router.get('/products', authenticateToken, products);
router.post('/addFav', authenticateToken, favoritos);
router.get('/getFav', authenticateToken, favUsuarios);
router.post('/deleteFav', authenticateToken, elimFavoritos);