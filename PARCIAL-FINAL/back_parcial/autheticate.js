import jwt from 'jsonwebtoken';
const ACCES_TOKEN_SECRET = 'dced2aa9805e6db07f47325f00728b0b'


export function authenticateToken(req, res, next){
    const header = req.headers['authorization'];
    const  token = header && header.split(' ')[1];
    console.log(req.headers);
    if(token == null) return res.sendStatus(401);

    jwt.verify(token, ACCES_TOKEN_SECRET, (err, user) => {
        if(err) return  res.status(401).json({
            mensaje: 'Token no valido',
        });;
        req.user = user;
        next();
    }
    );
}


