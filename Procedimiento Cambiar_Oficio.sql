--------------------------------------------------------
--  DDL for Procedure CAMBIAR_OFICIO
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "HR"."CAMBIAR_OFICIO" (
    numero  IN  employees.employee_id%TYPE, --Implementamos el procedimiento el cual debe de recibir dos parametros, el numero de empleado
        oficio  IN  employees.job_id%TYPE--y el tipo de oficio, definimos que esas variables son del tipo de los datos de la base de datos correspondientes
) IS
BEGIN --Comenzamos el bloque
/*con una sentencia if analizamos mediante una llamada a la funcion existe_oficio el resultado que nos da pasandole el parametro oficio*/
        IF ( existe_oficio(oficio) = true ) THEN
    /*Si el resultado es verdadero, es decir existe el oficio, actualizmos el oficio del empleado con numero de empleado el pasado por
    parametro en el procedimiento*/
                UPDATE employees
        SET
            job_id = oficio
        WHERE
            employee_id = numero;
--Si no existe, escribimos un mensaje de que no existe el oficio que queremos introducir.
        ELSE
        dbms_output.put_line('No existe el oficio que quiere introducir');
    END IF;--final de la sentencia if
END;--final del procedimiento

/
