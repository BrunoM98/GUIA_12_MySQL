-- 1. Obtener los datos completos de los empleados.
SELECT * FROM empleado;
-- 2. Obtener los datos completos de los departamentos.
SELECT * FROM departamento;
-- 3. Listar el nombre de los departamentos.
SELECT distinct nombre_depto FROM departamento;
-- Obtener el nombre y salario de todos los empleados.
SELECT nombre , salario FROM empleado;
-- 5. Listar todas las comisiones.
SELECT nombre , comision FROM empleado;
-- 6. Obtener los datos de los empleados cuyo cargo sea ‘Secretaria’.
SELECT * FROM empleado WHERE cargo = 'Secretaria';
--
SELECT * FROM empleado WHERE cargo = 'Vendedor' order by nombre asc;
-- 7. Obtener los datos de los empleados vendedores, ordenados por nombre alfabéticamente.
SELECT nombre , cargo , salario FROM empleado ORDER BY salario asc;
-- Obtener el nombre y cargo de todos los empleados, ordenados por salario de menor a mayor.
SELECT nombre AS 'nombre_pato' , cargo AS 'cargo_patos' FROM empleado;
-- 9. Elabore un listado donde para cada fila, figure el alias ‘Nombre’ y ‘Cargo’ para las respectivas tablas de empleados.
SELECT id_depto , nombre , salario , comision FROM empleado WHERE id_depto = 2000 ORDER BY comision asc;
-- 10. Listar los salarios y comisiones de los empleados del departamento 2000, ordenado por comisión de menor a mayor.
SELECT nombre , salario + comision + 500 AS 'TOTAL' FROM empleado WHERE id_depto = 3000 ORDER BY nombre asc; 
-- 11. Obtener el valor total a pagar que resulta de sumar el salario y la comisión de los empleados del departamento 3000 una bonificación de 500, en orden alfabético del empleado.
SELECT nombre FROM empleado WHERE nombre like 'J%'; 
-- 12. Muestra los empleados cuyo nombre empiece con la letra J.
SELECT nombre , salario, comision , salario + comision AS 'TOTAL' FROM empleado WHERE comision > 1000;
-- 13. Listar el salario, la comisión, el salario total (salario + comisión) y nombre, de aquellos empleados que tienen comisión superior a 1000.
SELECT nombre , salario, comision , salario + comision AS 'TOTAL' FROM empleado WHERE comision = 0;
-- 14. Obtener un listado similar al anterior, pero de aquellos empleados que NO tienen
SELECT * FROM empleado WHERE comision > salario;
-- 15. Obtener la lista de los empleados que ganan una comisión superior a su sueldo.
SELECT * FROM empleado WHERE comision <= salario * 0.3;
-- 16. Listar los empleados cuya comisión es menor o igual que el 30% de su sueldo.
SELECT nombre FROM empleado WHERE nombre not like '%MA%';
-- 17. Hallar los empleados cuyo nombre no contiene la cadena “MA”
SELECT * FROM departamento WHERE nombre_depto not in ('Ventas' , 'Mantenimiento', 'Investigacion');
-- 18. Obtener los nombres de los departamentos que sean “Ventas” ni “Investigación” ni ‘Mantenimiento.
SELECT * FROM departamento WHERE nombre_depto in ('Ventas' , 'Mantenimiento', 'Investigacion');
-- 19. Ahora obtener los nombres de los departamentos que no sean “Ventas” ni “Investigación” ni ‘Mantenimiento.
SELECT max(salario) , nombre FROM empleado;
-- 20. Mostrar el salario más alto de la empresa.
SELECT nombre FROM empleado order by nombre desc limit 1;
-- 21. Mostrar el nombre del último empleado de la lista por orden alfabético.
SELECT max(salario) , min(salario) , max(salario) - min(salario) AS 'DIFERENCIA' FROM empleado;
-- 22. Hallar el salario más alto, el más bajo y la diferencia entre ellos.
SELECT id_depto, ROUND( AVG (salario), 0 ) as  ' Salario promedio '  FROM empleado GROUP BY id_depto;
-- 23. Hallar el salario promedio por departamento.
SELECT COUNT(id_depto),nombre_depto from departamento group by nombre_depto HAVING COUNT(id_depto) > 3;
-- 24. Hallar los departamentos que tienen más de tres empleados. Mostrar el número de empleados de esos departamentos.
SELECT *, COUNT(*) as 'Cantidad'FROM empleado GROUP BY id_depto HAVING Cantidad >= 2 AND cargo LIKE 'Jefe%';
-- 25. Mostrar el código y nombre de cada jefe, junto al número de empleados que dirige. Solo los que tengan más de dos empleados (2 incluido).
SELECT COUNT(id_depto),nombre_depto from departamento group by nombre_depto HAVING COUNT(id_depto) = 0;
-- 26. Hallar los departamentos que no tienen empleados
Select * from empleado where salario >= (select avg(salario) from empleado) order by id_depto;
-- 27. Mostrar la lista de los empleados cuyo salario es mayor o igual que el promedio de la empresa. Ordenarlo por departamento.
select round(avg (salario),0) as "salario" from empleado;