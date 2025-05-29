import  jwt from 'jsonwebtoken';

export  const obtenerDatos = async (req, res) => {
    console.log('Ingresando a obtener datos');
    const {usuario, contrasena} = req.body;
    const ACCES_TOKEN_SECRET = 'dced2aa9805e6db07f47325f00728b0b'
    const users = [
        {
            usuario: 'admin',
            contrasena: 'admin',
        },
        {
            usuario: 'admin2',
            contrasena: 'admin2',}
    ];

    if (users.find(user => user.usuario === usuario && 
        user.contrasena === contrasena)){
            console.log('Si se encontro');
            const accessToken = jwt.sign({usuario: usuario}, 
                ACCES_TOKEN_SECRET,
                {expiresIn: '1h'});
            res.status(200).json({
                mensaje: 'Login correcto',
                accessToken: accessToken,
            });
            console.log('Si se envio');
    }
    else{
        res.status(401).json({
            mensaje: 'Login incorrecto',
        });
        
    
}
}