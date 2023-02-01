DELIMITER $$

DROP FUNCTION IF EXISTS totalFacturado$$

CREATE FUNCTION totalFacturado(cli VARCHAR(50))
returns DECIMAL(15.2) DETERMINISTIC
BEGIN
DECLARE resultado DECIMAL(15.2);

SELECT sum(P.total)
INTO resultado
FROM pago P, cliente C
WHERE C.codigo_cliente = P.codigo_cliente AND nombre_cliente = cli;

return resultado;
END $$

DELIMITER ;

SET @cliente = totalFacturado('Jardinerías Matías SL');
SELECT @cliente;