import { sendMessage, saveMessage , getAllMessages} from "../model/modelMensaje.js";



export const enviarMensaje = async (req, res) => {
    const {titulo, contenido, email_destinatario, email_origen} = req.body;
    try{
        const mensaje = await saveMessage(titulo, contenido, email_destinatario, email_origen);
        res.status(200).json({
            mensaje: 'Mensaje enviado',
            respuesta: mensaje,
        });
    }
    catch(error){
        console.log(error);
        res.status(500).json({
            mensaje: 'Error al enviar mensaje',
            error: error.message,
        });
    }

}

export const getMensajes = async (req, res) => {
    const {email} = req.body;
    try{
        const mensajes = await getAllMessages(email);
        res.status(200).json({
            mensaje: 'Mensajes obtenidos',
            respuesta: mensajes,
        });
    }
    catch(error){
        console.log(error);
        res.status(500).json({
            mensaje: 'Error al obtener mensajes',
            error: error.message,
        });
    }
}

