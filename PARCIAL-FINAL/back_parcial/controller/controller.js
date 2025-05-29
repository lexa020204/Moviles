import  jwt from 'jsonwebtoken';
import {findUser, createUser, findDispositivo, removeToken} from '../model/model.js';

export const registro = async (req, res) => {
    console.log('si entra')
    const {email, contrasena, imagen, telefono, nombre, cargo, fcm_token} = req.body;
    try {
        const resUser = await createUser(email, contrasena, imagen, telefono, nombre, cargo, fcm_token);
        if(resUser){
            
            res.status(200).json({
                mensaje: 'Usuario creado',
            });
        }
    }
    catch (error){
        console.log(error);
        res.status(401).json({
            mensaje: 'An error occured',
        });
}
}


export  const login = async (req, res) => {
    const {email, contrasena, fcm_token} = req.body;
    console.log(email, contrasena);
    const ACCES_TOKEN_SECRET = 'dced2aa9805e6db07f47325f00728b0b'
    try{
        const resUser = await findUser(email, contrasena);
        if(resUser.length > 0){
            const findToken = await findDispositivo(email, fcm_token);
            if (findToken){
                const accessToken = jwt.sign({usuario: email}, 
                    ACCES_TOKEN_SECRET,
                    {expiresIn: '30d'});
                res.status(200).json({
                    mensaje: 'Login correcto',
                    accessToken: accessToken,
                });  
            }
           
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


export const cerrarSesion = async (req, res) => {
    const {email, fcm_token} = req.body;
    try{
        const findToken = await removeToken(email, fcm_token);
        if(findToken){
            res.status(200).json({
                mensaje: 'Cerrando sesión',
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


