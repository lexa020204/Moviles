import admin from 'firebase-admin';
import serviceAccount from '../keys/parcial-4355c-firebase-adminsdk-5mikg-947804db24.json' assert { type: "json" };
import pool from '../database/database.js';

function initFirebase(){ 
    admin.initializeApp({
        credential: admin.credential.cert(serviceAccount),
    }
    )
}
initFirebase();


export async function sendMessage(token, titulo, cuerpo) {
    try {
        const message = {
            notification: {
              title: titulo,
              body: cuerpo,
            },
            token: token,
          };
        const response = await admin.messaging().send(message);
        console.log('Mensaje enviado', response);
        return response; 
    } catch (error) {
        console.error('Error al enviar mensaje', error);
        throw error; 
    }
}

export async function saveMessage(titulo, contenido, email_destinatario, email_origen) {
    try{
        let conn = await pool.getConnection();
        const query = 'INSERT INTO mensaje (titulo, contenido, tiempo ,email_destinatario, email_origen) VALUES (?,?,CURRENT_TIMESTAMP,?,?);';
        const values = [titulo, contenido, email_destinatario, email_origen];
        await conn.query(query, values);

        const dispositivo = await getDispositivo(email_destinatario);
        const token = dispositivo.map((index) => index.fcm_token);
        let idMensaje = await getMensajeID();

        idMensaje = idMensaje[0].idMensaje;

        for (const index of dispositivo){
            const query = 'INSERT INTO dispositivo_has_mensaje (mensaje_idmensaje, fcm_token) VALUES (?,?);';
            const values = [ idMensaje, index.fcm_token];
            await conn.query(query, values);
        }

        conn.release();

        for (const index of token){
            await sendMessage(index, titulo, contenido);
        }
        return true;

    }
    catch(error){
        console.log(error);
        throw error;
    }   
    
}


async function getDispositivo (email_destinatario){
    try{
        const conn = await pool.getConnection();
        const query = 'SELECT idDispositivo , fcm_token FROM dispositivo where usuario_email = ?;';
        const values = [email_destinatario];
        const dispositivo = await conn.query(query, values);
        return dispositivo;
    }catch(error){
        console.log(error);
        throw error;
    }
}

async function getMensajeID (){
    try{
        const conn = await pool.getConnection();
        const query = 'SELECT idMensaje FROM mensaje where idMensaje = (SELECT MAX(idMensaje) FROM mensaje);';
        const mensajeID = await conn.query(query);
        return mensajeID;
    }
    catch(error){
        console.log(error);
        throw error;
    }
}

export async function getAllMessages(email){    
    try{
        const conn = await pool.getConnection();
        const mensajes = await conn.query('SELECT * FROM mensaje where email_destinatario = ?;', [email]);
        conn.release();
        return mensajes;
    }
    catch{
        console.log(error);
        return [];  
    }
}


