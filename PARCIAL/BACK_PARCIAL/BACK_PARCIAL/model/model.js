import bcrypt from 'bcrypt';    
import pool from './database.js';

export async function findUsuario(email) {
    const conn = await pool.getConnection();
    const user = await conn.query("SELECT * FROM usuario WHERE correo = ?", [email]);
    return user;
}

export async function  comparedPassword(contrasena, hashedPassword) {
    const match = await bcrypt.compare(contrasena, hashedPassword);
    return match;
}

export async function createUser(nombre, usuario, contrasena) {
    try {
        const conn = await pool.getConnection();
        console.log('iniciando la conexión');
        const hashedPassword = await bcrypt.hash(contrasena, 10);
        const query = "INSERT INTO usuario (correo,nombre,contraseña_hash) VALUES (?, ?, ?);";
        let values = [usuario,nombre, hashedPassword];
        console.log(values);
        conn.query(query, values);
        console.log('Usuario creado');
        return true;
    }
    catch {
        return false;
    }
}

