const express = require('express');
const router = express.Router();
const db = require('../db'); 


router.post('/colaborador', (req, res) => {
    const {
        nombre, correo, rfc, domicilioFiscal, curp, nss, fechaInicioLaboral,
        tipoContrato, departamento, puesto, salarioDiario, salario, claveEntidad, estado
    } = req.body;

    if (
        !nombre || !correo || !rfc || !curp || !nss || !fechaInicioLaboral || 
        !tipoContrato || !departamento || !puesto || !salarioDiario || !salario || !claveEntidad || !estado
    ) {
        return res.status(400).json({ error: 'Todos los campos son obligatorios' });
    }

    const checkSql = 'SELECT * FROM colaboradores WHERE correo = ? OR rfc = ?';
    db.query(checkSql, [correo, rfc], (err, results) => {
        if (err){
            return res.status(500).json({ error: 'Error en la base de datos' });
        } 
        if (results.length > 0) {
            return res.status(400).json({ error: 'El correo o RFC ya está registrado' });
        }

        const insertSql = `
            INSERT INTO colaboradores (
                nombre, correo, rfc, domicilio_fiscal, curp, nss, fecha_inicio_laboral,
                tipo_contrato, departamento, puesto, salario_diario, salario, clave_entidad, estado
            ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        `;
        
        db.query(insertSql, [
            nombre, correo, rfc, domicilioFiscal, curp, nss, fechaInicioLaboral,
            tipoContrato, departamento, puesto, salarioDiario, salario, claveEntidad, estado
        ], (err, result) => {
            if (err) {
                return res.status(500).json({ error: 'Error al registrar colaborador' });
            }
            res.json({ mensaje: 'Colaborador registrado con éxito' });
        });
    });
});


router.put('/colaborador/:id', (req, res) => {
    const { id } = req.params; 
    const {
        nombre, correo, rfc, domicilioFiscal, curp, nss, fechaInicioLaboral,
        tipoContrato, departamento, puesto, salarioDiario, salario, claveEntidad, estado
    } = req.body;

    
    if (
        !nombre || !correo || !rfc || !curp || !nss || !fechaInicioLaboral || 
        !tipoContrato || !departamento || !puesto || !salarioDiario || !salario || !claveEntidad || !estado
    ) {
        return res.status(400).json({ error: 'Todos los campos son obligatorios' });
    }

    const checkSql = 'SELECT * FROM colaboradores WHERE id = ?';
    db.query(checkSql, [id], (err, results) => {
        if (err) {
            return res.status(500).json({ error: 'Error en la base de datos' });
        }
        if (results.length === 0) {
            return res.status(404).json({ error: 'Colaborador no encontrado' });
        }

        const updateSql = `
            UPDATE colaboradores SET
                nombre = ?, correo = ?, rfc = ?, domicilio_fiscal = ?, curp = ?, nss = ?, fecha_inicio_laboral = ?,
                tipo_contrato = ?, departamento = ?, puesto = ?, salario_diario = ?, salario = ?, clave_entidad = ?, estado = ?
            WHERE id = ?
        `;

        db.query(updateSql, [
            nombre, correo, rfc, domicilioFiscal, curp, nss, fechaInicioLaboral,
            tipoContrato, departamento, puesto, salarioDiario, salario, claveEntidad, estado, id
        ], (err, result) => {
            if (err) {
                return res.status(500).json({ error: 'Error al actualizar colaborador' });
            }
            res.json({ mensaje: 'Colaborador actualizado con éxito' });
        });
    });
});

router.get('/colaborador', (req, res) => {
    const sql = 'SELECT * FROM colaboradores WHERE eliminado = 0'; 

    db.query(sql, (err, results) => {
        if (err) {
            console.error(' Error al obtener colaboradores:', err);
            return res.status(500).json({ error: 'Error al obtener colaboradores' });
        }
        res.json(results);
    });
});

router.delete('/colaborador/:id', async (req, res) => {
    try {
        const { id } = req.params;
        await db.promise().query('UPDATE colaboradores SET eliminado = 1 WHERE id = ?', [id]);
        res.sendStatus(200);
    } catch (error) {
        console.error('Error al eliminar colaborador:', error);
        res.status(500).json({ error: 'Error del servidor' });
    }
});


module.exports = router;
