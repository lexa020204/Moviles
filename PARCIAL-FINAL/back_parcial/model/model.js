import pool from '../database/database.js';

export async function createUser(email, contrasena, imagen, telefono, nombre, cargo, fcm_token){
    try{
        const conn = await pool.getConnection();
        await conn.query('INSERT INTO usuario (email, contraseña, imagen, telefono, nombre, cargo) VALUES (?, ?, ?, ?, ?, ?);', [email, contrasena, imagen, telefono, nombre, cargo]);
        await conn.query('INSERT INTO dispositivo (usuario_email, fcm_token) VALUES (?, ?);', [email, fcm_token]);
        conn.release();
        return true;
    }
    catch(error){
        console.log(error);
        return false;
    }
}


export async function findUser(email, contrasena){
    try{
        const conn = await pool.getConnection();
        const user = await conn.query('SELECT * FROM usuario WHERE email = ?;', [email]);
        if(user.length > 0){
            if(user[0].contraseña !== contrasena){
                return [];
            }
        }
        conn.release();
        return user;
    }
    catch(error){
        console.log(error);
        return [];
    }
}

export async function findDispositivo(email, fcm_token){
    try{
        const conn = await pool.getConnection();
        const dispositivo = await conn.query('SELECT * FROM dispositivo WHERE usuario_email = ? AND fcm_token = ?;', [email, fcm_token]);
        if (dispositivo.length === 0){
            await conn.query('INSERT INTO dispositivo (usuario_email, fcm_token) VALUES (?, ?);', [email, fcm_token]);
            return true;
        }
        conn.release();
        return true;
        
    }
    catch(error){
        console.log(error); 
        return false;
    }
}


export async function compareCredentials(email,contrasena){
    const users = [
        {
            usuario: 'alexa',
            contrasena: 'admin',
        },
        {
            usuario: 'admin2',
            contrasena: 'admin2',}
    ];
    if (users.find(user => user.usuario === email && 
        user.contrasena === contrasena)){
            return true;
    }
    else{
        return false;
        
}

}

export async function removeToken(email, fcm_token){
    try{
        const conn = await pool.getConnection();
        console.log(email, fcm_token);
        await conn.query('DELETE FROM dispositivo WHERE usuario_email = ? AND fcm_token = ?;', [email, fcm_token]);
        conn.release();
        return true;
    }
    catch(error){
        console.log(error);
        return false;
    }
}

