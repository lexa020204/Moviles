import fetch from 'node-fetch';
import pool from './database.js';

export async function getProducts(){    
    try{
        const conn = await pool.getConnection();
        const products = await conn.query('SELECT * FROM articulos;');
        conn.release();
        return products;
    }
    catch{
        return [];  
    }
 
}

export async function saveProducts(){
    try{
        const response = await fetch('https://api.npoint.io/88abc1f40845fe530fd4');
        const data = await response.json();
        const products = data.articulos;
        console.log(products);
        if(products){
            const conn = await pool.getConnection();
            console.log('iniciando la conexión');
            for (const product of products) {
                const query = 'INSERT INTO articulos (precio, articulo, descuento, urlimagen, valoracion, descripcion, calificaciones) VALUES (?,?,?,?,?,?,?);';
                let values = [product.precio, product.articulo, product.descuento, product.urlimagen, product.valoracion, product.descripcion, product.calificaciones];
                await conn.query(query, values);  
            }
            conn.release();
            return true;
        }
    }
    catch(error){
        console.log(error);
        return false;
    }
}
