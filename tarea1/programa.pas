PROGRAM tarea1;

CONST                                   { declaracion de constantes }
        comienzo = 'C';                 { codigo de comienzo de palabra }
        contiene = 'E';                 { codigo de pertenencia a palabra }
        final    = 'F';                 { codigo de final de palabra }
        largo    = 'L';                 { codigo de largo de palabra }
        A        = 'A';                 { codigo de cumplimiento de todas las condiciones }
        terminar = 'Q';                 { codigo de finalizacion de condiciones }
        espacio  = ' ';                 { espacio en blanco }
        punto    = '.';                 { fin de texto }

VAR

     test_final,                        { test de ultima letra }
     test_comienzo,                     { test de primera letra }
     test_largo,                        { test de largo de palabra }
     test_contiene,                     { test de letra en palabra }
     cond_final,                        { cumplimiento de test de ultima letra }
     cond_comienzo,                     { cumplimiento de test de primera letra }
     cond_largo,                        { cumplimiento de test de largo de palabra }
     cond_contiene,                     { cumplimiento de test de letra en palabra }
     ingreso_a          : boolean;      { ingreso de la constante A }

     largo_palabra,                     { largo requerido }
     count,                             { contador de palabras que cumplen los test pedidos }
     y                  : integer;      { variable de largo de cada palabra }

     letra_final,                       { ultima letra a buscar }
     letra_comienzo,                    { primera letra a buscar }
     letra_contenida,                   { letra a buscar }
     c_ant,                             { variable auxiliar para test de final de palabra }
     c                  : char;         { variable para leer el texto }

BEGIN                                   { principal }

{ inicializacion de variables }

        test_final    := false;
        test_comienzo := false;
        test_largo    := false;
        test_contiene := false;
        ingreso_a     := false;
        count         := 0;

        REPEAT                          { lectura de condiciones }
                read(c);

                CASE c OF
                        final : BEGIN
                                test_final := true;
                                readLn(letra_final)
                                END;
                        largo : BEGIN
                                test_largo := true;
                                readLn(largo_palabra)
                                END;
                        comienzo : BEGIN
                                test_comienzo := true;
                                readLn(letra_comienzo)
                                END;
                        contiene : BEGIN
                                test_contiene := true;
                                readLn(letra_contenida)
                                END;
                        A       : ingreso_a := true;

                END; { case }

        UNTIL c = terminar;
        readln();

        REPEAT                         { saltear espacios iniciales }
                read(c);
        UNTIL c<> espacio;

        WHILE (c<> punto) DO           { iteracion de proceso de texto }
        BEGIN
                cond_comienzo := false;  { inicializacion de cumplimiento de condiciones }
                cond_contiene := false;
                cond_largo    := false;
                cond_final    := false;
                IF c = letra_comienzo
                        THEN cond_comienzo := true;
                IF c = letra_contenida
                        THEN cond_contiene := true;
                y := 0;

                REPEAT
                        c_ant := c;
                        read(c);
                        IF c = letra_contenida
                                THEN cond_contiene := true;
                        y := y + 1;
                UNTIL ( c = espacio );

                IF c_ant = letra_final
                                THEN cond_final    := true;
                IF y = largo_palabra
                        THEN cond_largo := true;
                IF ingreso_a = true
                        THEN
                        BEGIN
                                IF (test_comienzo = false)
                                        THEN cond_comienzo := true;
                                IF (test_contiene = false)
                                        THEN cond_contiene := true;
                                IF (test_largo = false)
                                        THEN cond_largo    := true;
                                IF (test_final = false)
                                        THEN cond_final    := true;
                                IF (cond_comienzo = true) AND (cond_contiene = true) AND (cond_largo = true) AND (cond_final = true)
                                        THEN count := count + 1;
                        END
                        ELSE
                                IF (cond_comienzo = true) OR (cond_contiene = true) OR (cond_largo = true) OR (cond_final = true)
                                THEN count := count + 1;
                REPEAT
                        read(c);
                UNTIL c<> espacio;
        END;
        readln();
        writeln('La cantidad de palabras que cumplen con la condicion es: ',count);
END.