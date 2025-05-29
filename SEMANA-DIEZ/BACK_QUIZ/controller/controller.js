import  jwt from 'jsonwebtoken';
import {findUser} from '../model/model.js';


export  const login = async (req, res) => {
    const {usuario, contrasena} = req.body;
    console.log(usuario, contrasena);
    const ACCES_TOKEN_SECRET = 'dced2aa9805e6db07f47325f00728b0b'
    try{
        const resUser = await findUser(usuario, contrasena);
        if(resUser.length > 0){
            const accessToken = jwt.sign({usuario: usuario}, 
                ACCES_TOKEN_SECRET,
                {expiresIn: '5m'});
            res.status(200).json({
                mensaje: 'Login correcto',
                accessToken: accessToken,
            });  
        }
        else{
            return res.status(401).json({
                mensaje: 'No se pudo iniciar sesión',
            });
        }  
        
    }
    catch(error){
        console.log(error);
        res.status(401).json({
            mensaje: 'An error occured',
        }); 
    }
   
}

export const tokeHuella = async (req, res) => {
    const {usuario, contrasena} = req.body;
    const ACCES_TOKEN_SECRET = 'dced2aa9805e6db07f47325f00728b0b'
    try{
        const resUser = await findUser(usuario, contrasena);
        if(resUser.length > 0){
            const accessToken = jwt.sign({usuario: usuario, contrasena: contrasena}, 
                ACCES_TOKEN_SECRET,
                {expiresIn: '30d'});
            res.status(200).json({
                mensaje: 'Login correcto',
                accessToken: accessToken,
            });
        }
        else{
            return res.status(401).json({
                mensaje: 'Usuario no encontrado',
            });
        }  
        
    }
    catch{
        res.status(401).json({
            mensaje: 'An error occured',
        }); 
    }
}

export const loginHuella = async (req, res) => {
    const ACCES_TOKEN_SECRET = 'dced2aa9805e6db07f47325f00728b0b'
    const header = req.headers['authorization'];
    const  token = header && header.split(' ')[1];
    if(token == null) return res.sendStatus(401);{
        const decoded = jwt.decode(token);
        console.log(decoded);
        if(decoded){
            const {usuario, contrasena} = decoded;
            const resUser = await findUser(usuario, contrasena);
            if(resUser.length > 0){
                const accessToken = jwt.sign({usuario: usuario}, 
                    ACCES_TOKEN_SECRET,
                    {expiresIn: '5m'});
                res.status(200).json({
                    mensaje: 'Login correcto',
                    accessToken: accessToken,
                });
            }
            else{
                return res.status(401).json({
                    mensaje: 'Usuario no encontrado',
                });
            }

        }
    }
}

export const user = async (req, res) => {
    const {nombre, usuario, contrasena} = req.body;
    try{
        const resUsuario = await createUser(nombre, usuario,contrasena );
        if(resUsuario){
            res.status(200).json({
                mensaje: 'Usuario creado',
            });
        }
    }
    catch{
        res.status(401).json({
            mensaje: 'Usuario no creado',
        });
    }   
}
