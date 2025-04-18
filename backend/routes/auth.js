const express = require('express');
const router = express.Router();
const db = require('../db');

router.post('/register', (req, res) => {
    const { nombre, correo, rfc, password } = req.body;

    if (!nombre || !correo || !rfc || !password) {
        return res.status(400).json({ error: 'Todos los campos son obligatorios' });
    }

// Validar duplicados
const checkSql = 'SELECT * FROM usuarios WHERE correo = ? OR rfc = ?';
db.query(checkSql, [correo, rfc], (err, results) => {
    if (err) return res.status(500).json({ error: 'Error en la base de datos' });
    if (results.length > 0) {
        return res.status(400).json({ error: 'El correo o RFC ya está registrado' });
    }


// Insertar usuario
const insertSql = 'INSERT INTO usuarios (nombre, correo, rfc, password) VALUES (?, ?, ?, ?)';
db.query(insertSql, [nombre, correo, rfc, password], (err, result) => {
    if (err) return res.status(500).json({ error: 'Error al registrar usuario' });
        res.json({ mensaje: 'Usuario registrado con éxito' });
});
});
});

router.post('/login', (req, res) => {
    const { correo, password } = req.body;

    if (!correo || !password) {
        return res.status(400).json({ error: 'Todos los campos son obligatorios' });
    }

    const sql = 'SELECT * FROM usuarios WHERE correo = ? AND password = ?';
    db.query(sql, [correo, password], (err, results) => {
        if (err) return res.status(500).json({ error: 'Error en la base de datos' });

        if (results.length === 0) {
            return res.status(401).json({ error: 'Correo o contraseña incorrectos' });
        }

        res.json({ mensaje: 'Inicio de sesión exitoso', usuario: results[0] });
    });
});


router.put('/reset-password', (req, res) => {
    const { correo, rfc, newPassword } = req.body;

    if (!correo || !rfc || !newPassword) {
        return res.status(400).json({ error: 'Todos los campos son obligatorios' });
    }

    const checkSql = 'SELECT * FROM usuarios WHERE correo = ? AND rfc = ?';
    db.query(checkSql, [correo, rfc], (err, results) => {
        if (err) return res.status(500).json({ error: 'Error en la base de datos' });

    if (results.length === 0) {
        return res.status(404).json({ error: 'Usuario no encontrado' });
    }

      // Actualizar la contraseña
        const updateSql = 'UPDATE usuarios SET password = ? WHERE correo = ? AND rfc = ?';
        db.query(updateSql, [newPassword, correo, rfc], (err) => {
        if (err) return res.status(500).json({ error: 'Error al actualizar la contraseña' });
            res.json({ mensaje: 'Contraseña actualizada con éxito' });
        });
    });
});


module.exports = router;
