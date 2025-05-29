import mariadb from 'mariadb';

export const pool = mariadb.createPool({
    host: process.env.DB_HOST || 'localhost',
    port: process.env.DB_PORT || '3306',
    user: process.env.DB_USER || 'root',
    password: process.env.BD_USER || 'alexandra',
    database: process.env.DB_NAME ||'parcial'
});


export default pool;