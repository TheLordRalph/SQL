-- 1
SELECT nombre, salario FROM Empleado WHERE nombre = m* ORDER BY nombre;

-- 2
SELECT nombre FROM Empleado WHEN (SELECT depNo FROM Empleado WHEN 'NURIA' AND 'PALOMA');

-- 3
SELECT nombre, salario FROM Empleado WHERE deptno = 'D0228' AND salario > 40000;

-- 4
SELECT nombre, fec_nac FROM Empleado WHERE salario '-11-';

-- 5
SELECT nombre, fec_nac, fec_alt FROM Empleado WHERE fec_dif < (SELECT fec_dif FROM Empleado WHERE ((EXTRACT(year FROM fec_alt)) - (EXTRACT(year FROM fec_nac))) AS fec_dif)

-- 6
SELECT CONCAT(CODDEP,'-',NOMBRE) AS "Numero-Nombre" FROM Departamento  where Presupuesto <10000000;

-- 7
SELECT nombre, salario, salario*1.02 AS SAL_A1, salario*1.02*1.02 AS SALARIO_A2
FROM Empleado 
WHERE hijos >0 ORDER BY nombre;

-- 8
select nombre, (CASE WHEN hijos>3 
	THEN salario+(60*(hijos-3)*12) 
	ELSE salario 
	END) AS Salario_Final 
FROM Empleado;

-- 9	
SELECT nombre, salario 
FROM Empleado 
WHERE codEmp IN (SELECT direc FROM Departamento);

-- 10
SELECT nombre
FROM Departamento
WHERE depSup IS NULL;

-- 11
SELECT nombre, salario
FROM Empleado
WHERE salario > (SELECT MAX(salario) FROM Empleado WHERE nombre = 'SUSANA');
 
-- 12
SELECT nombre, salario
FROM Empleado
WHERE nombre LIKE 'M%'
ORDER BY nombre;
  
-- 13
SELECT nombre
FROM Empleado
WHERE deptno IN (SELECT DISTINCT deptno FROM Empleado WHERE nombre = 'NURIA' OR nombre = 'PALOMA');

-- 14
SELECT nombre, salario
FROM Empleado
WHERE deptno = 'D0228' AND salario > 40000;
  
-- 15
SELECT nombre, fec_nac
FROM Empleado
WHERE EXTRACT(MONTH FROM fec_nac) = 11;
  
-- 16
SELECT nombre, fec_alta, fec_nac
FROM Empleado
WHERE DATEDIFF(fec_alta, fec_nac)/365 <30; 

-- 17
SELECT AVG(salario), MIN(salario), MAX(salario)
FROM Empleado;

-- 18
SELECT ROUND(MAX(DATEDIFF(SYSDATE(), fec_nac)/365),0)
FROM Empleado
WHERE deptno = 'D0228';
	
-- 19
SELECT deptno, count(*)
FROM Empleado
GROUP BY deptno;

-- 20
SELECT D.nombre, sum(E.salario)
FROM Empleado E, Departamento D
WHERE E.deptno = D.coddep 
GROUP BY D.nombre;

-- 21
SELECT nombre, sum(E.salario)
FROM Departamento D INSER JOIN Empleado E ON E.deptno = D.codDep
group by D.nombrehaving sum(E.salario) > 100000;

-- 22
SELECT E.nombre, E.hijos
FROM Empleado E, Departamento D
WHERE E.codEmp = D.director;

-- 23
SELECT D.nombre, count(E.codEmp)
FROM Empleado E, Departamento D
WHERE E.depNo = D.codDep
GROUP BY D.nombre
HAVING count(E.codEmp)>2;

-- 24
SELECT DL.nombre, sum(E.hijos) totalhijos
FROM Empleado E, Departamento D, Delegaciones DL
WHERE E.deptno = D.codDep
AND D.delg=DL.codDg
GROUP BY DL.nombre;

-- 25
CREATE VIEW VISTAEMP AS SELECT DL.nombre NOMBREDL, D.nombre NOMBREDP, E.nombre NOMBREEMP, E.hijos, E.salario
FROM Empleado E, Departamento D, Delegaciones DL
WHERE E.deptno=D.codDep
AND D.deleg=DL.codDg;
/**/
SELECT NOMBREDL, SUM(hijos)
FROM VISTAEMP
GROUP BY NOMBREDL;