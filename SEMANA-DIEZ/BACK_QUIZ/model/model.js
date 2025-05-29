import pool from './database.js';
export async function findUser(email, contrasena){
    try{
        const conn = await pool.getConnection();
        const user = await conn.query('SELECT * FROM usuarios WHERE correo = ?;', [email]);
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

