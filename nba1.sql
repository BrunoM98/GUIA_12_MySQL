-- 1. Mostrar el nombre de todos los jugadores ordenados alfabéticamente.
SELECT nombre FROM jugador ORDER BY nombre ASC;
-- 2. Mostrar el nombre de los jugadores que sean pivots (‘C’) y que pesen más de 200 libras, ordenados por nombre alfabéticamente.
SELECT nombre, posicion , peso FROM jugador WHERE posicion = 'C' AND peso > 200 ORDER BY nombre ASC;
-- 3. Mostrar el nombre de todos los equipos ordenados alfabéticamente.
SELECT nombre FROM equipo ORDER BY nombre ASC;
-- 4. Mostrar el nombre de los equipos del este (East).
SELECT nombre , conferencia FROM equipo WHERE conferencia = 'EAST';
-- 5. Mostrar los equipos donde su ciudad empieza con la letra ‘c’, ordenados por nombre.
SELECT * FROM equipo WHERE ciudad LIKE 'c%';
-- 6. Mostrar todos los jugadores y su equipo ordenados por nombre del equipo.
SELECT * FROM jugador ORDER BY nombre_equipo ASC;
-- 7. Mostrar todos los jugadores del equipo “Raptors” ordenados por nombre.
SELECT * FROM jugador WHERE nombre_equipo = 'Raptors'ORDER BY nombre ASC;
-- 8. Mostrar los puntos por partido del jugador ‘Pau Gasol’.
SELECT Puntos_por_partido AS 'puntos pau Gasol' FROM estadistica INNER JOIN jugador WHERE jugador.nombre = 'Pau Gasol';
-- 9. Mostrar los puntos por partido del jugador ‘Pau Gasol’ en la temporada ’04/05′.
SELECT Puntos_por_partido AS 'puntos pau Gasol' FROM estadistica INNER JOIN jugador WHERE jugador.nombre = 'Pau Gasol'AND temporada = '04/05';
-- 10. Mostrar el número de puntos de cada jugador en toda su carrera.
SELECT jugador.nombre, ROUND(SUM(estadistica.puntos_por_partido)) AS puntos 
FROM jugador jugador, estadistica estadistica 
WHERE jugador.CODIGO = estadistica.jugador 
GROUP BY jugador.nombre 
ORDER BY jugador.nombre ASC;
-- 11. Mostrar el número de jugadores de cada equipo.
SELECT j.nombre_equipo, COUNT(*) 
FROM jugador j 
GROUP BY j.nombre_equipo;
-- 12. Mostrar el jugador que más puntos ha realizado en toda su carrera.
SELECT jugador.nombre, ROUND(SUM(estadistica.puntos_por_partido)) AS puntos 
FROM jugador jugador, estadistica estadistica 
WHERE jugador.CODIGO = estadistica.jugador 
GROUP BY jugador.nombre 
ORDER BY SUM(estadistica.puntos_por_partido) DESC LIMIT 1;
-- 13. Mostrar el nombre del equipo, conferencia y división del jugador más alto de la NBA.
select j.nombre, e.conferencia, e.division , j.altura
 from jugador j, equipo e where j.nombre_equipo = e.nombre 
 group by j.nombre 
 order by j.altura desc limit 1;
-- 14. Mostrar la media de puntos en partidos de los equipos de la división Pacific.
SELECT e.nombre, e.division, AVG(p.puntos_local+p.puntos_visitante)
FROM partido AS p
INNER JOIN equipo AS e
ON equipo_local AND equipo_visitante = nombre
WHERE e.division = 'Pacific'
GROUP BY e.nombre;
-- 15. Mostrar el partido o partidos (equipo_local, equipo_visitante y diferencia) con mayor diferencia de puntos.
SELECT equipo_local, equipo_visitante, abs(puntos_local - puntos_visitante) AS diferencia
FROM partido
WHERE abs(puntos_local - puntos_visitante) = (
	SELECT MAX(abs(puntos_local - puntos_visitante))
    FROM partido);
-- 16. Mostrar los puntos de cada equipo en los partidos, tanto de local como de visitante.
SELECT t.equipo, SUM(t.puntos)
FROM(
	SELECT equipo_local AS equipo, SUM(puntos_local) AS puntos
	FROM partido	
	GROUP BY equipo_local
	UNION
	SELECT equipo_visitante AS equipo , SUM(puntos_visitante) AS puntos
	FROM partido	
	GROUP BY equipo_visitante) AS t
GROUP BY t.equipo;
-- 17. Mostrar quien gana en cada partido (codigo, equipo_local, equipo_visitante,equipo_ganador), en caso de empate sera null.
SELECT *, CASE
WHEN puntos_local > puntos_visitante THEN equipo_local 
WHEN puntos_local < puntos_visitante THEN equipo_visitante 
ELSE NULL END AS equipo_ganador
FROM partido;


