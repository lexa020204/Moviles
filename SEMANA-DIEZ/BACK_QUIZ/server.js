import { router } from './router/routes.js';
import express, { json } from "express";
import { fileURLToPath } from 'url';
import http from "http";
import cors from "cors";
import path from 'path';


export const app = express();
app.use(json());
app.disable("x-powered-by"); // --> Deshabilitar el header x-powered-by
app.use(cors());
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);


app.use("/",router);
app.use("/images",
    express.static(path.join(__dirname, './images'))
)

const port = process.env.PORT || 3000;
http.createServer(app).listen(port);
