import { router } from './routes.js';
import express, { json } from "express";
import http from "http";
import cors from "cors";

export const app = express();
app.use(json());
app.disable("x-powered-by"); // --> Deshabilitar el header x-powered-by
app.use(cors());



app.use("/",router);


http.createServer(app).listen(3000);
