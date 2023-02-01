use EMPLEADOS
SELECT * FROM Empleado ORDER BY nombre;

SELECT nombre, tfno FROM Empleado;

SELECT deptno, nombre, salario FROM Empleado WHERE hijos > 0 AND salario >= 30000 AND SALARIO <= 40000 ORDER BY deptno, salario;

SELECT codDep FROM Departamento WHERE presupuesto < 30000;

SELECT DISTINCT salario FROM Empleado ORDER BY salario ASC;

SELECT CONCAT(codDep,"-",nombre) AS "numero-nombre" FROM Departamento WHERE presupuesto < 10000000;