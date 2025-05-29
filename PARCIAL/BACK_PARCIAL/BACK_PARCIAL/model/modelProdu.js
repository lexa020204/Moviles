import pool from './database.js';

export async function getProducts(){
    const conn = await pool.getConnection();
    const products = await conn.query("SELECT * FROM producto");
    return products;
}

export async function addFavorite(idUsuario, idProducto){
    try{
        const conn = await pool.getConnection();
        const favoritos = await conn.query("SELECT * FROM productos_favoritos WHERE Usuario_correo = ? AND Producto_idProducto = ?",[idUsuario, idProducto]);
        if(favoritos.length > 0){
            return false;
        }
        await conn.query("INSERT INTO productos_favoritos (Usuario_correo, Producto_idProducto) VALUES (?,?)",[idUsuario, idProducto]);
        return true;
    }
    catch{
        return false;
    }
}

export async function deleteFavorite(idUsuario, idProducto){
    try{
        const conn = await pool.getConnection();
        await conn.query("DELETE FROM productos_favoritos WHERE Usuario_correo = ? AND Producto_idProducto = ?",[idUsuario, idProducto]);
        return true;
    }
    catch{
        return false;
    }
}

export async function getFavorites(idUsuario){
    const conn = await pool.getConnection();
    const products = await conn.query("SELECT * FROM productos_favoritos WHERE Usuario_correo = ?",[idUsuario]);
    const idProductos = products.map((product) => product.Producto_idProducto);
    const productosFav = await conn.query("SELECT * FROM producto WHERE idProducto IN (?)",[idProductos]);
    return productosFav;
}