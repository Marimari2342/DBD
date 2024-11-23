/**
Localidad = (codigoPostal, nombreL, descripcion, #habitantes)
Arbol = (nroArbol, especie, años, calle, nro, codigoPostal(fk))
Podador = (DNI, nombre, apellido, telefono, fnac, codigoPostalVive(fk))
Poda = (codPoda, fecha, DNI(fk), nroArbol(fk))
*/

/** 1. Listar especie, años, calle, nro y localidad de árboles podados por el podador ‘Juan Perez’ y 
por el podador ‘Jose Garcia’.*/
SELECT a.especie, a.años, a.calle, a.nro, l.nombreL
FROM Localidad l 
INNER JOIN Arbol a ON (l.codigoPostal = a.codigoPostal)
INNER JOIN Poda p ON (a.nroArbol = p.nroArbol)
INNER JOIN Podador pr ON (p.DNI = pr.DNI)
WHERE (pr.nombre = 'Juan') AND (pr.apellido = 'Perez')
OR (pr.nombre = 'Jose') AND (pr.apellido = 'Garcia')  

/** 2. Reportar DNI, nombre, apellido, fecha de nacimiento y localidad donde viven de aquellos
podadores que tengan podas realizadas durante 2023.*/
SELECT pr.DNI, pr.nombre, pr.apellido, pr.fnac, l.nombre
FROM Podador pr
INNER JOIN Poda p ON (pr.DNI = p.DNI)
INNER JOIN Localidad l ON (pr.codigoPostalVive = l.codigoPostal)
WHERE (p.fecha BETWEEN '01/01/2023' AND '31/12/2023')

/** 3. Listar especie, años, calle, nro y localidad de árboles que no fueron podados nunca.*/
SELECT a.especie, a.años, a.calle, a.nro, l.nombreL
FROM Localidad l
INNER JOIN Arbol a ON (l.codigoPostal = a.codigoPostal)
WHERE a.nroArbol NOT IN 
    (SELECT ar.nroArbol
    FROM Arbol ar
    INNER JOIN Poda p ON (ar.nroArbol = p.nroArbol))
  
/** 4. Reportar especie, años,calle, nro y localidad de árboles que fueron podados durante 2022 y no
fueron podados durante 2023.*/
SELECT a.especie, a.años, a.calle, a.nro, l.nombreL
FROM Localidad l 
INNER JOIN Arbol a ON (l.codigoPostal = a.codigoPostal)  
INNER JOIN Poda p ON (a.nroArbol = p.nroArbol)
WHERE (p.fecha BETWEEN '01/01/2022' AND '31/12/2022')
AND a.nroArbol NOT IN  
    (SELECT ar.nroArbol
    FROM Arbol ar
    INNER JOIN Poda p ON (ar.nroArbol = p.nroArbol)
    WHERE (p.fecha BETWEEN '01/01/2023' AND '31/12/2023'))

/** 5. Reportar DNI, nombre, apellido, fecha de nacimiento y localidad donde viven de aquellos
podadores con apellido terminado con el string ‘ata’ y que tengan al menos una poda durante
2024. Ordenar por apellido y nombre.*/
SELECT pr.DNI, pr.nombre, pr.apellido, pr.fnac, l.nombreL
FROM Podador pr 
INNER JOIN Localidad l (pr.codigoPostalVive = l.codigoPostal)
WHERE (pr.apellido LIKE '%ata') 
AND pr.DNI ON
    (SELECT p.DNI
    FROM Poda p
    WHERE (p.fecha BETWEEN '01/01/2024' AND '31/12/2024'))
ORDER BY pr.apellido, pr.nombre

/** 6. Listar DNI, apellido, nombre, teléfono y fecha de nacimiento de podadores que solo podaron
árboles de especie ‘Coníferas’.*/

/** 7. Listar especies de árboles que se encuentren en la localidad de ‘La Plata’ y también en la
localidad de ‘Salta’.*/

/** 8. Eliminar el podador con DNI 22234566.*/

/** 9. Reportar nombre, descripción y cantidad de habitantes de localidades que tengan menos de 100
árboles.*/