--------------------------------------------------------
--  DDL for Function EXISTE_OFICIO
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "HR"."EXISTE_OFICIO" (
        oficio employees.job_id%TYPE--Creamos la funcion y le pasamos por parametro una variable que es del mismo tipo que job_id
    )
    /*El enunciado nos pide que la funcion retorne un booleano, Oracle SQL no es compatible con el tipo de datos 
    booleanos pero el lenguaje de programacion PL/SQL si que es*/ 
    RETURN BOOLEAN IS 
    --Creamos la variable booleana existe que es la que nos retornará el programa, se podria hacer directamente con TRUE o FALSE
        existe    BOOLEAN;
    /*Creo una variable contador, en donde almacenaré el numero de oficios que coinciden con el parametro, esta explicado abajo*/
        contador  NUMBER(2);
    --Empieza el bloque 
    BEGIN
    /*Con este select cuento las coincidencias en donde el job_id coincida con el oficio , ese valor lo introduzco en la variable contador*/
        SELECT
            COUNT(*)
        INTO contador
        FROM
            jobs
        WHERE
            job_id = oficio;
    /*Con una sentencia if, analizamos, si el contador=0, es decir no hemos encontrado ninguna coincidencia, la variable existe la ponemos a false*/
        IF ( contador = 0 ) THEN
            existe := false;
    --Si el contador es distino de cero, entonces el oficio existe
        ELSE
            existe := true;
        END IF;--Termina la sentencia if
        RETURN existe;--Devolvemos el valor existe cuando llamamos a la funcion.
    END;

/
