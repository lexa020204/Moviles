import  jwt from 'jsonwebtoken';
import {findUsuario, createUser, comparedPassword} from '../model/model.js';


export  const login = async (req, res) => {
    const {usuario, contrasena} = req.body;
    const ACCES_TOKEN_SECRET = 'dced2aa9805e6db07f47325f00728b0b'
    try{
        const resUser = await findUsuario(usuario);
        if(resUser.length > 0){
            const validPassword =await comparedPassword(contrasena, resUser[0]['contraseña_hash']);
            
            if(!validPassword){
                return res.status(401).json({
                    mensaje: 'Contraseña incorrecta',
                });
            }
            else{
                const accessToken = jwt.sign({usuario: usuario}, 
                    ACCES_TOKEN_SECRET,
                    {expiresIn: '7d'});
                res.status(200).json({
                    mensaje: 'Login correcto',
                    accessToken: accessToken,
                });
            } 
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
