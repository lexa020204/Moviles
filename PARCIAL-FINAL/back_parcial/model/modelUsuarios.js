
import pool from '../database/database.js';

export async function getUsuarios(){    
    try{
        const conn = await pool.getConnection();
        const products = await conn.query('SELECT email, imagen, telefono, nombre, cargo FROM usuario;');
        conn.release();
        return products;
    }
    catch{
        return [];  
    }
 
}

