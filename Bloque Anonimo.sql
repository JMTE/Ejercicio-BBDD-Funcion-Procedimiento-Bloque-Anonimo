SET SERVEROUTPUT ON;
/*Este es nuestro bloque anonimo para cambiar el oficio de un trabajador mediante un procedimiento*/
DECLARE--Declaramos nuestras variables que tienen que tener el tipo de dato de los datos correspondientes en la base de datos
                                numero_trabajador  employees.employee_id%TYPE;
    oficio             employees.job_id%TYPE;
    oficio_viejo       employees.job_id%TYPE;--Vamos a guardar en una variable su oficio antiguo para visualizarlo al final
    /*Declaramos unas variables minimo y maximo para utilizarlas como limites en el bucle que implementamos a continuacion*/
                            minimo             NUMBER(4);
    maximo             NUMBER(4);
BEGIN 
    /*Introducimos en las variables minimo y maximo los limites de los valores de numero de empleado para la sentencia if que implementamos a continuacion.*/
                            SELECT
        MIN(employee_id),
        MAX(employee_id)
    INTO
        minimo,
        maximo
    FROM
        employees;
       
    /*Los valores de los argumentos tienen que ser recogidos en variables, pero en variables de sustitucion*/
                                numero_trabajador := &dame_numero_de_empleado;
    
    /*Hacemos esta sentencia if por si al usuario se le ocurre introducir un numero de empleado que no existe. Podriamos
    haber hecho otra funcion para comprobarlo*/
                                IF ( numero_trabajador < minimo OR numero_trabajador > maximo )
    THEN--Si el trabajador no existe sacamos un mensaje por pantalla.
                                                                dbms_output.put_line('El numero de trabajador '||numero_trabajador||' no existe.FIN DE PROGRAMA');
    ELSE--si el numero del trabajador existe , cuando el compilador analiza los datos introducidos ejecuta el procedimiento
                                    SELECT
            job_id
        INTO oficio_viejo
        FROM
            employees
        WHERE
            employee_id = numero_trabajador;--guardamos el oficio antiguo del empleado en la variable
                                                                oficio := '&Dame_oficio_nuevo_del_empleado';
        --Se ejecuta el procedimiento con los valores pasados mediante las variables de sustitucion.
                                                                cambiar_oficio(numero_trabajador,
        oficio);
        IF ( existe_oficio(oficio) = true ) THEN /*Para presentar los cambios en consola, como quiero hacer una comparacion entre oficio nuevo y oficio viejo,
            utilizo la funcion existe_oficio para ver si existe el oficio que he introducido en la variable de sustitucion. El procedimiento ya lo comprueba,
            pero para esta presentación me hace falta.
                        /*Vemos por consola los cambios*/
                                                                            dbms_output.put_line('El trabajador numero '
                                 || numero_trabajador
                                 || ' ha cambiado su oficio de '
                                 || oficio_viejo
                                 || '  a '
                                 || oficio);

            dbms_output.put_line('FIN'); --Fin del programa
                                    ELSE --Si el oficio no existe, informamos de que el trabajador sigue con el mismo oficio
                                                    dbms_output.put_line('El trabajador '||numero_trabajador||' continua con el mismo oficio');
            dbms_output.put_line('FIN');
        END IF;--Fin de la sentencia para la presentacion de los datos
                END IF;--final de la sentencia if
        EXCEPTION
    WHEN OTHERS THEN --Introducimos el mensaje de error para cualquier excepcion que se produzca
                dbms_output.put_line('ERROR GENERAL');
END;