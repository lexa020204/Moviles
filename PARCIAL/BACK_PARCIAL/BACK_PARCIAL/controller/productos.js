import { getProducts, addFavorite , getFavorites, deleteFavorite} from '../model/modelProdu.js';
export const products = async (req, res) => {  
    try{
        const productos = await getProducts();
        if(productos){
            res.status(200).json({
                productos: productos,
            });
        }
    }
    catch{
        res.status(401).json({
            mensaje: 'Error al obtener productos',
        });
    }
}

export const favoritos = async (req, res) => {
    try{
        const  { idProducto }= req.body;
        const idUsuario = req.user.usuario;
        const resFavorito = await addFavorite(idUsuario, idProducto);
        if(resFavorito){
            res.status(200).json({
                mensaje: 'Producto agregado a favoritos',
            });
        }   
    }
    catch{
        res.status(401).json({
            mensaje: 'Error al agregar producto a favoritos',
        });
    }
}

export const elimFavoritos = async (req, res) => {
    try{
        const {idProducto} = req.body;
        const idUsuario = req.user.usuario;
        const resEliminado = await deleteFavorite(idUsuario, idProducto);
        if(resEliminado){
            console.log('Eliminado');
            res.status(200).json({
                mensaje: 'Producto eliminado de favoritos',
            });
        }   
    }
    catch{
        res.status(401).json({
            mensaje: 'Error al eliminar producto de favoritos',
        });
    }
}

export const favUsuarios = async (req, res) => {
    try{
        const idUsuario = req.user.usuario;
        const resFavoritos = await getFavorites(idUsuario);
        if(resFavoritos){
            console.log('Favoritos');
            res.status(200).json({
                favoritos: resFavoritos,
            });
        }

    }
    catch{
        res.status(401).json({
            mensaje: 'Error al obtener favoritos',
        });
    }

}