import { getUsuarios} from '../model/modelUsuarios.js';
export const obtUsuarios = async (_req, res) => {  
    try{
        const usuarios = await getUsuarios();
        if(usuarios){
            res.status(200).json({
                usuarios: usuarios,
            });
        }
    }
    catch(error){
        console.log(error);
        res.status(401).json({
            mensaje: 'Error al obtener productos',
        });
    }
}




