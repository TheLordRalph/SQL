DELIMITER $$

DROP FUNCTION IF EXISTS mediaProveedor$$

CREATE FUNCTION mediaProveedor(p VARCHAR(50))
returns DECIMAL(15.2) DETERMINISTIC
BEGIN
DECLARE resultado DECIMAL(15.2);

SELECT AVG(precio_venta)
INTO resultado
FROM producto
WHERE proveedor = p;

return resultado;
END $$

DELIMITER ;

SET @proveedor = mediaProveedor('Frutales Talavera S.A');
SELECT @proveedor;