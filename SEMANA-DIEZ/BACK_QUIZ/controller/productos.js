import { getProducts, saveProducts} from '../model/modelProdu.js';
export const products = async (_req, res) => {  
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

export const save = async (_req, res) => {
    try{
        const productos = await saveProducts();
        if(productos){
            res.status(200).json({
                mensaje: 'Producto guardado',
            });
        }
    }
    catch{
        res.status(401).json({
            mensaje: 'Error al guardar producto',
        });
    }
}

