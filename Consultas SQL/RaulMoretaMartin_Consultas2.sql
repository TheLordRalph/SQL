SELECT nombre, salario AS salarioBase, salario*1.02 AS salarioAño1, salario*1.02*1.02 AS salarioAño2 FROM Empleado WHERE hijos > 0 ORDER BY nombre;

SELECT nombre, (salario + 60) FROM Empleado WHERE hijos >=4 ORDER BY nombre;

SELECT Empleado.nombre, salario FROM Departamento, Empleado WHERE Empleado.codEmp = direc ORDER BY Empleado.nombre;

SELECT nombre FROM Departamento WHERE depSup IS NULL;

SELECT nombre, salario FROM Empleado WHERE salario > (SELECT SALARIO FROM EMPLEADO WHERE NOMBRE = "SUSANA");