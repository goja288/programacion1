{ 46662595 }

procedure IniciarJuego(var juego: TipoJuego; cuantas_filas: RangoFila; cuantas_columnas: RangoColumna; cuantas_bombas: Integer);

VAR
	i,j,x,y : integer;
        contadorBombas : integer;
        aux : integer;

BEGIN

{ Inicializacion de variable }

        juego.tablero.topefila := cuantas_filas;
        juego.tablero.topecolumna := cuantas_columnas;
        juego.bombas := cuantas_bombas;
        juego.descubiertas := 0;
        juego.marcadas := 0;

        IF ( cuantas_bombas < 0 ) OR ( cuantas_bombas >= cuantas_filas * cuantas_columnas ) THEN { cantidad de bombas menor a cero, e igual o mayor a la cantidad de celdas }
                juego.estado := ganado
        ELSE BEGIN

                FOR i := 1 TO cuantas_filas DO
	                FOR j := 1 TO cuantas_columnas DO
                        BEGIN
        	                juego.tablero.celdas[i,j].tieneBomba := False;
        	                juego.tablero.celdas[i,j].bombasCircundantes := 0;
        	                juego.tablero.celdas[i,j].estado := oculta;
                        END;

                RANDOMIZE; { sorteo de posiciones de las bombas en el tablero }

	        contadorBombas := 0;
                WHILE ( contadorBombas < cuantas_bombas ) DO
                BEGIN
        	        FOR i := 1 TO cuantas_filas DO
                	        FOR j:=1 TO cuantas_columnas DO
                                BEGIN
                                        IF ( contadorbombas < cuantas_bombas ) AND ( juego.tablero.celdas[i,j].tieneBomba = False ) THEN
                                        BEGIN
				                aux := random(50);
                                                IF ( aux = 0 ) THEN
                                                BEGIN
						        juego.tablero.celdas[i,j].tieneBomba := True;
					                contadorbombas := contadorbombas + 1;
					        END
                                        ELSE BEGIN
                                                juego.tablero.celdas[i,j].tieneBomba := False;
                                             END;

                                        IF ( juego.tablero.celdas[i,j].tieneBomba = True ) THEN
                                        BEGIN
                                                IF (( cuantas_filas = 1 ) AND ( cuantas_columnas > 1 )) OR (( cuantas_columnas = 1 ) AND ( cuantas_filas > 1 )) OR (( cuantas_filas = 1 ) AND ( cuantas_columnas = 1 )) THEN
                                                BEGIN

                                                        IF ( cuantas_filas = 1 ) AND ( cuantas_columnas > 1 ) THEN { tablero de una fila }
                                                        BEGIN
                                                                IF ( j = 1 ) THEN { esquina izquierda }
				        	                BEGIN
					                                IF ( juego.tablero.celdas[1,j+1].tieneBomba = False ) THEN
								                juego.tablero.celdas[1,j+1].bombasCircundantes := juego.tablero.celdas[1,j+1].bombasCircundantes + 1;
                                                                END;

						                IF ( j = cuantas_columnas ) THEN { esquina derecha }
				        	                BEGIN
				                	                y := -1;
							                IF ( juego.tablero.celdas[1,j+y].tieneBomba = False ) THEN
						                	        juego.tablero.celdas[1,j+y].bombasCircundantes := juego.tablero.celdas[1,j+y].bombasCircundantes + 1;
				        	                END;

						                IF ( j > 1 ) AND ( j < cuantas_columnas ) THEN {borde sin las esquinas}
				        	                BEGIN
				                                        FOR  y := -1  TO 1 DO
							                        IF ( juego.tablero.celdas[1,j+y].tieneBomba = False ) THEN
						        	                juego.tablero.celdas[1,j+y].bombasCircundantes := juego.tablero.celdas[1,j+y].bombasCircundantes + 1;
                                                                END;
                                                        END;

                                                        IF ( cuantas_columnas = 1 ) AND ( cuantas_filas > 1 ) THEN { tablero de una columna }
					                BEGIN
                                                                IF ( i = 1 ) THEN { esquina superior }
				        	                BEGIN
					        	                IF ( juego.tablero.celdas[i+1,1].tieneBomba = False ) THEN
							                        juego.tablero.celdas[i+1,1].bombasCircundantes := juego.tablero.celdas[i+1,1].bombasCircundantes + 1;
						                END;

						                IF ( i = cuantas_filas ) THEN { esquina inferior }
				        	                BEGIN
				                	                x := -1;
							                IF ( juego.tablero.celdas[i+x,1].tieneBomba = False ) THEN
						                	        juego.tablero.celdas[i+x,1].bombasCircundantes := juego.tablero.celdas[i+x,1].bombasCircundantes + 1;
				        	                END;

						                IF ( i > 1 ) AND ( i < cuantas_filas ) THEN {borde sin las esquinas}
				        	                BEGIN
				                                        FOR  x := -1  TO 1 DO
							                        IF ( juego.tablero.celdas[i+x,1].tieneBomba = False ) THEN
						        	                        juego.tablero.celdas[i+x,1].bombasCircundantes := juego.tablero.celdas[i+x,1].bombasCircundantes + 1;
                                                                END;
                                                        END;
                                                END { final del if que distingue los tableros esperciales }
                                                ELSE BEGIN

                                                        IF ( i = 1 ) AND ( j = 1 ) THEN { esquina superior izquierda }
				                        BEGIN
					                        FOR x := 0 TO 1 DO
						                        FOR y := 0 TO 1 DO
                                                                        IF ( juego.tablero.celdas[i+x,j+y].tieneBomba = False ) THEN
								                juego.tablero.celdas[i+x,j+y].bombasCircundantes := juego.tablero.celdas[i+x,j+y].bombasCircundantes + 1;
					                END;


				                        IF ( i = cuantas_filas ) AND  ( j = 1 ) THEN { esquina inferior izquierda }
				                        BEGIN
                                                                FOR x := -1 TO 0 DO
 					                                FOR y := 0 TO 1 DO
                                                                        IF ( juego.tablero.celdas[i+x,j+y].tieneBomba = False ) THEN
						                                juego.tablero.celdas[i+x,j+y].bombasCircundantes := juego.tablero.celdas[i+x,j+y].bombasCircundantes + 1;
				                        END;

				                        IF ( i = 1 ) AND ( j = cuantas_columnas ) THEN { esquina superior derecha }
				                        BEGIN
				                                FOR x := 0 TO 1 DO
					                                FOR y := -1 TO 0 DO
						                        IF ( juego.tablero.celdas[i+x,j+y].tieneBomba = False ) THEN
						                                juego.tablero.celdas[i+x,j+y].bombasCircundantes := juego.tablero.celdas[i+x,j+y].bombasCircundantes + 1;
				                        END;

                                                        IF ( i = cuantas_filas ) AND ( j = cuantas_columnas ) THEN {esquina inferior derecha}
				                        BEGIN
				                                FOR x := -1 TO 0 DO
					                                FOR y := -1 TO 0 DO
						                        IF ( juego.tablero.celdas[i+x,j+y].tieneBomba = False ) THEN
						                                juego.tablero.celdas[i+x,j+y].bombasCircundantes := juego.tablero.celdas[i+x,j+y].bombasCircundantes + 1;
				                        END;

				                        IF ( i > 1 ) AND ( i < cuantas_filas ) AND ( j = 1 ) THEN { borde izquierdo sin esquinas }
				                        BEGIN
				                                FOR x := -1 TO 1 DO
					                                FOR y := 0 TO 1 DO
						                        IF ( juego.tablero.celdas[i+x,j+y].tieneBomba = False ) THEN
						                                juego.tablero.celdas[i+x,j+y].bombasCircundantes := juego.tablero.celdas[i+x,j+y].bombasCircundantes + 1;
				                        END;

				                        IF ( i > 1 ) AND ( i < cuantas_filas ) AND ( j = cuantas_columnas ) THEN { borde derecho sin esquinas }
				                        BEGIN
				                                FOR x := -1 TO 1 DO
					                                FOR y := -1 TO 0 DO
						                        IF juego.tablero.celdas[i+x,j+y].tieneBomba = False THEN
						                                juego.tablero.celdas[i+x,j+y].bombasCircundantes := juego.tablero.celdas[i+x,j+y].bombasCircundantes + 1;
				                        END;

				                        IF ( i = 1 ) AND ( j > 1 ) AND ( j < cuantas_columnas )THEN {borde superior sin las esquinas}
				                        BEGIN
				                                FOR x := 0 TO 1 DO
					                                FOR y := -1 TO 1 DO
						                        IF ( juego.tablero.celdas[i+x,j+y].tieneBomba = False ) THEN
						                                juego.tablero.celdas[i+x,j+y].bombasCircundantes := juego.tablero.celdas[i+x,j+y].bombasCircundantes + 1;
				                        END;

				                        IF ( i = cuantas_filas ) AND ( j > 1 ) AND ( j < cuantas_columnas ) THEN {borde inferior sin las esquinas}
				                        BEGIN
				                                FOR x := -1 TO 0 DO
					                                FOR y := -1 TO 1 DO
						                        IF ( juego.tablero.celdas[i+x,j+y].tieneBomba = False ) THEN
						                                juego.tablero.celdas[i+x,j+y].bombasCircundantes := juego.tablero.celdas[i+x,j+y].bombasCircundantes + 1;
				                        END;

				                        IF ( i > 1 ) AND ( j > 1) AND ( i < cuantas_filas ) AND ( j < cuantas_columnas) THEN {centro del tablero}
				                        BEGIN
				                                FOR x := -1 TO 1 DO
					                                FOR y := -1 TO 1 DO
						                        IF ( juego.tablero.celdas[i+x,j+y].tieneBomba = False ) THEN
						                                juego.tablero.celdas[i+x,j+y].bombasCircundantes := juego.tablero.celdas[i+x,y+j].bombasCircundantes + 1;
				                        END;

                                                     END; { final del else de tableros especiales }
                                        END;
                                END;
                        END;
                END; { final del while }
              END;
END; { final del procedimiento }

procedure Descubrir(var juego: TipoJuego; posicion: TipoPosicion);

Type
      ListaPendiente = record
        elems : array[1..MAX_FILAS*MAX_COLUMNAS] OF TipoPosicion;
        tope  : 0..MAX_FILAS*MAX_COLUMNAS
        END;

VAR
        a,b,c,d : integer;
        perteneceLista : listaPendiente;
        nuevaposicion : TipoPosicion;

procedure agregaraLista( celda: TipoPosicion; VAR perteneceLista: ListaPendiente ); { procedimiento que agrega las celdas que contienen un cero a una lista }

        BEGIN
	        WITH pertenecelista DO
        	        BEGIN
                	        tope := tope + 1;
                                elems[tope] := celda
                        END;
        END; { final del procedimiento agregaraLista }

procedure Descubrir_Aux( a,b,c,d: integer; posicion: TipoPosicion );

VAR
	x,y: integer;

BEGIN
        FOR x := a TO b DO
	        FOR y := c TO d DO
                BEGIN
                        IF ( juego.tablero.celdas[posicion.fila+x,posicion.columna+y].bombasCircundantes = 0 ) AND ( juego.tablero.celdas[posicion.fila+x, posicion.columna+y].estado = oculta) THEN
                        BEGIN
                                nuevaPosicion.fila := posicion.fila+x;
                                nuevaPosicion.columna := posicion.columna+y;
                                agregaraLista( nuevaPosicion, perteneceLista );
                        END;

                        IF ( juego.tablero.celdas[posicion.fila+x,posicion.columna+y].estado = oculta ) THEN
                        BEGIN
                                juego.tablero.celdas[posicion.fila+x,posicion.columna+y].estado := descubierta;
                                juego.descubiertas := juego.descubiertas + 1;
                                IF (( juego.bombas + juego.descubiertas) = ( juego.tablero.topeFila * juego.tablero.topeColumna)) THEN
                                        juego.estado := ganado;

                        END;
                END;
END; { final del procedimiento Descubir_Aux }

BEGIN { comienzo del procedimiento principal }

perteneceLista.tope := 0;

        IF ( juego.tablero.celdas[posicion.fila,posicion.columna].tieneBomba = False ) THEN { caso donde en la celda a descubir no hay bomba }
	BEGIN
                IF ( juego.tablero.celdas[posicion.fila,posicion.columna].estado = oculta ) THEN
                BEGIN
                        IF ( juego.tablero.celdas[posicion.fila,posicion.columna].bombasCircundantes <> 0 ) THEN { caso en el que no es cero la celda a descubrir }
	                BEGIN
        		        juego.tablero.celdas[posicion.fila,posicion.columna].estado := descubierta;
                	        juego.descubiertas := juego.descubiertas + 1;
                                IF (( juego.bombas + juego.descubiertas) = ( juego.tablero.topeFila * juego.tablero.topeColumna)) THEN
                                        juego.estado := ganado;

                        END
                        ELSE BEGIN
                                juego.tablero.celdas[posicion.fila,posicion.columna].estado := descubierta;
                                juego.descubiertas := juego.descubiertas + 1;
                                IF (( juego.bombas + juego.descubiertas) = ( juego.tablero.topeFila * juego.tablero.topeColumna)) THEN
                                        juego.estado := ganado;
                                        agregaraLista( posicion, perteneceLista );                                         { se agrega a la lista la celda que contine cero }

                                        WHILE perteneceLista.tope > 0 DO
                                        BEGIN
                                                posicion  := perteneceLista.elems[perteneceLista.tope];
	                                        perteneceLista.tope := perteneceLista.tope - 1;

                                                IF (( juego.tablero.topeFila = 1 ) AND ( juego.tablero.topeColumna > 1 )) OR (( juego.tablero.topeColumna = 1 ) AND ( juego.tablero.topeFila > 1 )) OR (( juego.tablero.topeFila = 1 ) AND
( juego.tablero.topeColumna = 1 )) THEN { verificacion de tableros particulares }
                                                BEGIN
                                                        IF ( juego.tablero.topeFila = 1 ) AND ( juego.tablero.topeColumna = 1 ) THEN { tablero de 1 celda }
                                                        BEGIN
                                                                juego.tablero.celdas[posicion.fila,posicion.columna].estado := descubierta;
                                                                juego.descubiertas := juego.descubiertas + 1;
                                                                IF (( juego.bombas + juego.descubiertas) = ( juego.tablero.topeFila * juego.tablero.topeColumna)) THEN
                                                                juego.estado := ganado;
                                                        END;

                                                        IF ( posicion.fila = 1 ) AND ( juego.tablero.topeColumna > 1 ) THEN {tablero de una fila }
                                                        BEGIN
                                                                IF ( posicion.columna = 1 ) THEN { esquina izquierda }
				        	                BEGIN
                                                                        a := 0;
		                                                        b := 0;
	                                                                c := 0;
		                                                        d := 1;

		                                                        Descubrir_Aux ( a,b,c,d,posicion );
                                                                END;

                                                                IF ( posicion.columna = juego.tablero.topeColumna ) THEN { esquina derecha }
				        	                BEGIN
                                                                        a := 0;
		                                                        b := 0;
	                                                                c := -1;
		                                                        d := 0;

		                                                        Descubrir_Aux ( a,b,c,d,posicion )
                                                                END;

                                                                IF ( posicion.columna > 1 ) AND ( posicion.columna < juego.tablero.topeColumna ) THEN {borde sin las esquinas}
				        	                BEGIN
                                                                        a := 0;
		                                                        b := 0;
	                                                                c := -1;
		                                                        d := 1;

		                                                        Descubrir_Aux ( a,b,c,d,posicion )
                                                                END;

                                                        END;

                                                        IF ( juego.tablero.topeColumna = 1 ) AND ( juego.tablero.topeFila > 1 ) THEN {tablero de una columna }
					                BEGIN
                                                                IF ( posicion.fila = 1 ) THEN { esquina superior }
				        	                BEGIN
                                                                        a := 0;
                                                                        b := 1;
                                                                        c := 0;
                                                                        d := 0;

                                                                        Descubrir_Aux ( a,b,c,d,posicion )
                                                                END;

						                IF ( posicion.fila = juego.tablero.topeFila ) THEN { esquina inferior }
				        	                BEGIN
                                                                        a := -1;
                                                                        b := 0;
                                                                        c := 0;
                                                                        d := 0;

                                                                        Descubrir_Aux ( a,b,c,d,posicion )
                                                                end;
						                IF ( posicion.fila > 1 ) AND ( posicion.fila < juego.tablero.topeFila ) THEN { borde sin las esquinas }
				        	                BEGIN
                                                                        a := -1;
                                                                        b := 1;
                                                                        c := 0;
                                                                        d := 0;

                                                                        Descubrir_Aux ( a,b,c,d,posicion )
                                                                END;
                                                        END;
                                                END
                                                ELSE BEGIN

                                                        IF ( posicion.fila = 1 )  AND ( posicion.columna = 1 ) THEN { esquina superior izquierda }
	                                                BEGIN
                                                                a := 0;
		                                                b := 1;
	                                                        c := 0;
		                                                d := 1;

		                                                Descubrir_Aux ( a,b,c,d,posicion );
	                                                END;

	                                                IF ( posicion.fila = juego.tablero.topeFila )  AND ( posicion.columna = 1 ) THEN { esquina inferior izquierda }
	                                                BEGIN
		                                                a := -1;
		                                                b := 0;
		                                                c := 0;
		                                                d := 1;

		                                                Descubrir_Aux ( a,b,c,d,posicion );
	                                                END;

	                                                IF ( posicion.fila = 1 )  AND ( posicion.columna = juego.tablero.topeColumna ) THEN { esquina superior derecha }
	                                                BEGIN
		                                                a := 0;
		                                                b := 1;
		                                                c := -1;
		                                                d := 0;

		                                                Descubrir_Aux ( a,b,c,d,posicion );
	                                                END;

	                                                IF ( posicion.fila = juego.tablero.topeFila )  AND ( posicion.columna = juego.tablero.topeColumna ) THEN { esquina inferior derecha }
	                                                BEGIN
		                                                a := -1;
	                                                        b := 0;
		                                                c := -1;
		                                                d := 0;

		                                                Descubrir_Aux ( a,b,c,d,posicion );
	                                                END;

	                                                IF ( posicion.fila > 1 ) AND ( posicion.fila < juego.tablero.topeFila ) AND ( posicion.columna = 1 ) THEN { borde izquierdo sin esquinas }
	                                                BEGIN
		                                                a := -1;
		                                                b := 1;
		                                                c := 0;
		                                                d := 1;

		                                                Descubrir_Aux ( a,b,c,d,posicion );
	                                                END;


	                                                IF ( posicion.fila > 1 ) AND ( posicion.fila < juego.tablero.topeFila ) AND ( posicion.columna = juego.tablero.topeColumna ) THEN { borde derecho sin esquinas }
	                                                BEGIN
		                                                a := -1;
		                                                b := 1;
		                                                c := -1;
		                                                d := 0;

		                                                Descubrir_Aux ( a,b,c,d,posicion );
	                                                END;

	                                                IF ( posicion.fila = 1 ) AND ( posicion.columna > 1 ) AND ( posicion.columna < juego.tablero.topeColumna )THEN {borde superior sin las esquinas}
	                                                BEGIN
	                                                        a := 0;
                                                                b := 1;
                                                                c := -1;
                                                                d := 1;

                                                        Descubrir_aux ( a,b,c,d,posicion );
                                                        END;

	                                                IF ( posicion.fila = juego.tablero.topeFila ) AND ( posicion.columna > 1 ) AND ( posicion.columna < juego.tablero.topeColumna ) THEN {borde inferior sin las esquinas}
	                                                BEGIN
	                                                        a := -1;
	                                                        b := 0;
	                                                        c := -1;
	                                                        d := 1;

	                                                        Descubrir_Aux ( a,b,c,d,posicion );
                                                        END;


	                                                IF ( posicion.fila > 1 ) AND ( posicion.columna > 1 ) AND ( posicion.fila < juego.tablero.topeFila ) AND ( posicion.columna < juego.tablero.topeColumna ) THEN { centro del tablero }
	                                                BEGIN
		                                                a := -1;
		                                                b := 1;
		                                                c := -1;
		                                                d := 1;

		                                                Descubrir_Aux ( a,b,c,d,posicion );
                                                        END;
                                                END; { final del else que estudia los tableros no particulares }
                                        END; { final del While }
                                END; { final del else }
                END; { final del if que verifica si la celda esta oculta }
        END { final del if que verifica si la celda tiene bomba }
        ELSE BEGIN
                IF ( juego.tablero.celdas[posicion.fila, posicion.columna].estado = oculta ) THEN
                        juego.estado := perdido;
             END;
END; { final del procedimiento principal }


procedure Marcar(var juego: TipoJuego; posicion: TipoPosicion);

BEGIN

   IF juego.tablero.celdas[posicion.fila, posicion.columna].estado = oculta THEN
   BEGIN
        juego.tablero.celdas[posicion.fila, posicion.columna].estado := marcada;
        juego.marcadas := juego.marcadas + 1;
   END;

END;

procedure DesMarcar(var juego: TipoJuego; posicion: TipoPosicion);

BEGIN

   IF juego.tablero.celdas[posicion.fila, posicion.columna].estado = marcada THEN
   BEGIN
        juego.tablero.celdas[posicion.fila, posicion.columna].estado := oculta;
        juego.marcadas := juego.marcadas - 1;
   END;

END;

procedure DespejarCircundantes(var juego: TipoJuego; posicion: TipoPosicion);

VAR
        a,b,c,d : integer;

procedure DespejarCircundantes_Aux (a,b,c,d: integer; posicion: TipoPosicion);

VAR
        x,y,cont_marcadas : integer;
        posicion_aux : TipoPosicion;

BEGIN

cont_marcadas := 0;

	FOR  x := a  TO  b DO
		FOR  y := c  TO  d DO
                BEGIN
                	IF ( juego.tablero.celdas[posicion.fila+x, posicion.columna+y].estado = marcada ) THEN
                        	cont_marcadas := cont_marcadas + 1
                END;
	FOR x := a TO b DO
		FOR y := c TO d DO
		BEGIN
			IF ( juego.tablero.celdas[posicion.fila+x, posicion.columna+y].estado = oculta ) AND ( cont_marcadas = juego.tablero.celdas[posicion.fila, posicion.columna].bombasCircundantes ) AND
( juego.tablero.celdas[posicion.fila+x, posicion.columna+y].tieneBomba = True ) THEN
        	      		juego.estado := perdido;
		END;

        IF ( juego.estado = jugando ) AND ( cont_marcadas = juego.tablero.celdas[posicion.fila, posicion.columna].bombasCircundantes ) THEN
	BEGIN
               	FOR x := a TO b DO
                       	FOR y := c TO d DO
                        BEGIN
                            	IF ( juego.tablero.celdas[posicion.fila+x, posicion.columna+y].estado = oculta ) THEN
                                BEGIN
                                       	IF ( juego.tablero.celdas[posicion.fila+x, posicion.columna+y].bombasCircundantes <> 0 ) THEN
                                        BEGIN
                                              	juego.tablero.celdas[posicion.fila+x, posicion.columna+y].estado := descubierta;
                                                juego.descubiertas := juego.descubiertas +1;
                                                IF (( juego.bombas + juego.descubiertas) = ( juego.tablero.topeFila * juego.tablero.topeColumna)) THEN
                                                        juego.estado := ganado;
                                        END
                                        ELSE    BEGIN
                                                        posicion_aux.fila := posicion.fila + x;
                                                        posicion_aux.columna := posicion.columna + y;
                                                        Descubrir ( juego, posicion_aux );
                                                END;
                			END;
				END;
        	END;
END; { final del procedimiento auxiliar }

BEGIN { comienzo del procedimiento DespejarCircundantes }

        IF ( juego.tablero.celdas[posicion.fila, posicion.columna].estado = descubierta ) THEN
        BEGIN

                IF (( juego.tablero.topeFila = 1 ) AND ( juego.tablero.topeColumna > 1 )) OR (( juego.tablero.topeColumna = 1 ) AND ( juego.tablero.topeFila > 1 )) OR (( juego.tablero.topeFila = 1 ) AND
( juego.tablero.topeColumna = 1 )) THEN { verificacion de tableros particulares }
                BEGIN
                        IF ( posicion.fila = 1 ) AND ( juego.tablero.topeColumna > 1 ) THEN {tablero de una fila }
                        BEGIN
                                IF ( posicion.columna = 1 ) THEN { esquina izquierda }
			        BEGIN
                                        a := 0;
		                        b := 0;
	                                c := 0;
		                        d := 1;

                                        DespejarCircundantes_Aux ( a,b,c,d,posicion );
                                END;

                                IF ( posicion.columna = juego.tablero.topeColumna ) THEN { esquina derecha }
			        BEGIN
                                        a := 0;
		                        b := 0;
	                                c := -1;
		                        d := 0;

		                        DespejarCircundantes_Aux ( a,b,c,d,posicion )
                                END;

                                IF ( posicion.columna > 1 ) AND ( posicion.columna < juego.tablero.topeColumna ) THEN {borde sin las esquinas}
			        BEGIN
                                        a := 0;
		                        b := 0;
	                                c := -1;
		                        d := 1;

                                        DespejarCircundantes_Aux ( a,b,c,d,posicion )
                                END;

                        END;

                        IF ( juego.tablero.topeColumna = 1 ) AND ( juego.tablero.topeFila > 1 ) THEN {tablero de una columna }
		        BEGIN
                                IF ( posicion.fila = 1 ) THEN { esquina superior }
			        BEGIN
                                        a := 0;
                                        b := 1;
                                        c := 0;
                                        d := 0;

                                        DespejarCircundantes_Aux ( a,b,c,d,posicion )
                                END;

			        IF ( posicion.fila = juego.tablero.topeFila ) THEN { esquina inferior }
			        BEGIN
                                        a := -1;
                                        b := 0;
                                        c := 0;
                                        d := 0;

                                        DespejarCircundantes_Aux ( a,b,c,d,posicion )
                                        END;

                                IF ( posicion.fila > 1 ) AND ( posicion.fila < juego.tablero.topeFila ) THEN { borde sin las esquinas }
			        BEGIN
                                        a := -1;
                                        b := 1;
                                        c := 0;
                                        d := 0;

                                        DespejarCircundantes_Aux ( a,b,c,d,posicion )
                                END;
                        END;
                END
                ELSE BEGIN

                        IF ( posicion.fila = 1 )  AND ( posicion.columna = 1 ) THEN { esquina superior izquierda }
                        BEGIN
                                a := 0;
                                b := 1;
                                c := 0;
                                d := 1;

                                DespejarCircundantes_Aux ( a,b,c,d,posicion );
                        END;

	                IF ( posicion.fila = juego.tablero.topeFila )  AND ( posicion.columna = 1 ) THEN { esquina inferior izquierda }
	                BEGIN
		                a := -1;
		                b := 0;
		                c := 0;
		                d := 1;

		                DespejarCircundantes_Aux ( a,b,c,d,posicion );
	                END;

	                IF ( posicion.fila = 1 )  AND ( posicion.columna = juego.tablero.topeColumna ) THEN { esquina superior derecha }
	                BEGIN
		                a := 0;
		                b := 1;
		                c := -1;
		                d := 0;

		                DespejarCircundantes_Aux ( a,b,c,d,posicion );
	                END;

	                IF ( posicion.fila = juego.tablero.topeFila )  AND ( posicion.columna = juego.tablero.topeColumna ) THEN { esquina inferior derecha }
	                BEGIN
		                a := -1;
		                b := 0;
		                c := -1;
		                d := 0;

		                DespejarCircundantes_Aux ( a,b,c,d,posicion );
	                END;

	                IF ( posicion.fila > 1 ) AND ( posicion.fila < juego.tablero.topeFila ) AND ( posicion.columna = 1 ) THEN { borde izquierdo sin esquinas }
	                BEGIN
		                a := -1;
		                b := 1;
		                c := 0;
		                d := 1;

		                DespejarCircundantes_Aux ( a,b,c,d,posicion );
	                END;


	                IF ( posicion.fila > 1 ) AND ( posicion.fila < juego.tablero.topeFila ) AND ( posicion.columna = juego.tablero.topeColumna ) THEN { borde derecho sin esquinas }
	                BEGIN
		                a := -1;
		                b := 1;
		                c := -1;
		                d := 0;

		                DespejarCircundantes_Aux ( a,b,c,d,posicion );
	                END;

	                IF ( posicion.fila = 1 ) AND ( posicion.columna > 1 ) AND ( posicion.columna < juego.tablero.topeColumna )THEN {borde superior sin las esquinas}
	                BEGIN
		                a := 0;
		                b := 1;
		                c := -1;
		                d := 1;

		                DespejarCircundantes_Aux ( a,b,c,d,posicion );
	                END;

	                IF ( posicion.fila = juego.tablero.topeFila ) AND ( posicion.columna > 1 ) AND ( posicion.columna < juego.tablero.topeColumna ) THEN {borde inferior sin las esquinas}
	                BEGIN
		                a := -1;
		                b := 0;
		                c := -1;
		                d := 1;

		                DespejarCircundantes_Aux ( a,b,c,d,posicion );
	                END;


	                IF ( posicion.fila > 1 ) AND ( posicion.columna > 1 ) AND ( posicion.fila < juego.tablero.topeFila ) AND ( posicion.columna < juego.tablero.topeColumna ) THEN { centro del tablero }
	                BEGIN
		                a := -1;
		                b := 1;
		                c := -1;
		                d := 1;

		                DespejarCircundantes_Aux ( a,b,c,d,posicion );
	                END;
                     END; { final del else que estudia los tableros no particulares }
        END; { final del if que verifica si la celda a despejar sus celdas circundantes, esta descubierta }
END; { final del procedimiento principal }

procedure MarcarCircundantes(var juego: TipoJuego; posicion: TipoPosicion);

VAR
       a, b, c, d, cont_nodes: integer;


procedure MarcarCircundantes_Aux( a,b,c,d: integer; posicion: TipoPosicion);

VAR
        x,y : integer;

BEGIN

cont_nodes := 0;

	FOR x := a TO b DO
        	FOR y := c TO d DO
        	BEGIN
        	        IF ( juego.tablero.celdas[posicion.fila+x, posicion.columna+y].estado <> descubierta ) THEN
                                cont_nodes := cont_nodes + 1
        	END;

	FOR x := a TO b DO
        	FOR y := c TO d DO
        	BEGIN
                	IF ( cont_nodes = juego.tablero.celdas[posicion.fila, posicion.columna].bombasCircundantes ) THEN
                	BEGIN
                      		IF ( juego.tablero.celdas[posicion.fila+x, posicion.columna+y].estado = oculta ) THEN
                                BEGIN
                                	juego.tablero.celdas[posicion.fila+x, posicion.columna+y].estado := marcada;
                                        juego.marcadas := juego.marcadas +1;
                                END;
                    	END;
                END;
END; { final del procedimiento auxiliar }


BEGIN { comienzo del procedimiento MarcarCircundantes }

        IF ( juego.tablero.celdas[posicion.fila, posicion.columna].estado = descubierta ) THEN
        BEGIN

        IF (( juego.tablero.topeFila = 1 ) AND ( juego.tablero.topeColumna > 1 )) OR (( juego.tablero.topeColumna = 1 ) AND ( juego.tablero.topeFila > 1 )) OR (( juego.tablero.topeFila = 1 ) AND
( juego.tablero.topeColumna = 1 )) THEN { verificacion de tableros particulares }
        BEGIN
                IF ( posicion.fila = 1 ) AND ( juego.tablero.topeColumna > 1 ) THEN {tablero de una fila }
                BEGIN
                        IF ( posicion.columna = 1 ) THEN { esquina izquierda }
			BEGIN
                                a := 0;
		                b := 0;
	                        c := 0;
		                d := 1;

                                MarcarCircundantes_Aux ( a,b,c,d,posicion );
                        END;

                        IF ( posicion.columna = juego.tablero.topeColumna ) THEN { esquina derecha }
			BEGIN
                                a := 0;
		                b := 0;
	                        c := -1;
		                d := 0;

		                MarcarCircundantes_Aux ( a,b,c,d,posicion )
                         END;

                        IF ( posicion.columna > 1 ) AND ( posicion.columna < juego.tablero.topeColumna ) THEN {borde sin las esquinas}
			BEGIN
                                a := 0;
		                b := 0;
	                        c := -1;
		                d := 1;

                                MarcarCircundantes_Aux ( a,b,c,d,posicion )
                        END;

                END;

                IF ( juego.tablero.topeColumna = 1 ) AND ( juego.tablero.topeFila > 1 ) THEN {tablero de una columna }
		BEGIN
                        IF ( posicion.fila = 1 ) THEN { esquina superior }
			BEGIN
                                a := 0;
                                b := 1;
                                c := 0;
                                d := 0;

                                MarcarCircundantes_Aux( a,b,c,d,posicion )
                        END;

			IF ( posicion.fila = juego.tablero.topeFila ) THEN { esquina inferior }
			BEGIN
                                a := -1;
                                b := 0;
                                c := 0;
                                d := 0;

                                MarcarCircundantes_Aux ( a,b,c,d,posicion )
                        END;

                        IF ( posicion.fila > 1 ) AND ( posicion.fila < juego.tablero.topeFila ) THEN { borde sin las esquinas }
			BEGIN
                                a := -1;
                                b := 1;
                                c := 0;
                                d := 0;

                                MarcarCircundantes_Aux ( a,b,c,d,posicion )
                        END;
                END;
        END
        ELSE BEGIN

                        IF ( posicion.fila = 1 )  AND ( posicion.columna = 1 ) THEN { esquina superior izquierda }
                        BEGIN
                                a := 0;
                                b := 1;
                                c := 0;
                                d := 1;

                                MarcarCircundantes_Aux ( a,b,c,d,posicion );
                        END;

	                IF ( posicion.fila = juego.tablero.topeFila )  AND ( posicion.columna = 1 ) THEN { esquina inferior izquierda }
	                BEGIN
		                a := -1;
		                b := 0;
		                c := 0;
		                d := 1;

		                MarcarCircundantes_Aux ( a,b,c,d,posicion );
	                END;

	                IF ( posicion.fila = 1 )  AND ( posicion.columna = juego.tablero.topeColumna ) THEN { esquina superior derecha }
	                BEGIN
		                a := 0;
		                b := 1;
		                c := -1;
		                d := 0;

		                MarcarCircundantes_Aux ( a,b,c,d,posicion );
	                END;

	                IF ( posicion.fila = juego.tablero.topeFila )  AND ( posicion.columna = juego.tablero.topeColumna ) THEN { esquina inferior derecha }
	                BEGIN
		                a := -1;
		                b := 0;
		                c := -1;
		                d := 0;

		                MarcarCircundantes_Aux ( a,b,c,d,posicion );
	                END;

	                IF ( posicion.fila > 1 ) AND ( posicion.fila < juego.tablero.topeFila ) AND ( posicion.columna = 1 ) THEN { borde izquierdo sin esquinas }
	                BEGIN
		                a := -1;
		                b := 1;
		                c := 0;
		                d := 1;

		                MarcarCircundantes_Aux ( a,b,c,d,posicion );
	                END;


	                IF ( posicion.fila > 1 ) AND ( posicion.fila < juego.tablero.topeFila ) AND ( posicion.columna = juego.tablero.topeColumna ) THEN { borde derecho sin esquinas }
	                BEGIN
		                a := -1;
		                b := 1;
		                c := -1;
		                d := 0;

		                MarcarCircundantes_Aux ( a,b,c,d,posicion );
	                END;

	                IF ( posicion.fila = 1 ) AND ( posicion.columna > 1 ) AND ( posicion.columna < juego.tablero.topeColumna )THEN {borde superior sin las esquinas}
	                BEGIN
		                a := 0;
		                b := 1;
		                c := -1;
		                d := 1;

		                MarcarCircundantes_Aux ( a,b,c,d,posicion );
	                END;

	                IF ( posicion.fila = juego.tablero.topeFila ) AND ( posicion.columna > 1 ) AND ( posicion.columna < juego.tablero.topeColumna ) THEN {borde inferior sin las esquinas}
	                BEGIN
		                a := -1;
		                b := 0;
		                c := -1;
		                d := 1;

		                MarcarCircundantes_Aux ( a,b,c,d,posicion );
	                END;


	                IF ( posicion.fila > 1 ) AND ( posicion.columna > 1 ) AND ( posicion.fila < juego.tablero.topeFila ) AND ( posicion.columna < juego.tablero.topeColumna ) THEN { centro del tablero }
	                BEGIN
		                a := -1;
		                b := 1;
		                c := -1;
		                d := 1;

		                MarcarCircundantes_Aux ( a,b,c,d,posicion );
	                END;

                END; { final del else que estudia los tableros no particulares }
        END; { final del if que verifica si la celda a marcar sus celdas circundantes, esta descubierta }
END; { final del procedimiento principal }


procedure DescubrirSegura(var juego: TipoJuego);

VAR

	i,j : integer;
	esSegura : boolean;
	posicion : TipoPosicion;

BEGIN
	esSegura := False;

	i := 1;
        WHILE ( i <= ( juego.tablero.TopeFila )) AND ( esSegura = False ) DO
	BEGIN
		j := 1;

		WHILE ( j <= ( juego.tablero.TopeColumna )) AND ( esSegura = False ) DO
		BEGIN
			IF (juego.tablero.celdas[i,j].tieneBomba = False) AND ( juego.tablero.celdas[i,j].estado = oculta ) THEN
			BEGIN
				esSegura := True;
			END;
                        IF ( esSegura = False ) THEN
                        j :=j+1;
		END;

                IF ( esSegura = False ) THEN
	       	        i := i+1;
        END;

	IF ( esSegura = True ) AND ( juego.tablero.celdas[i,j].estado = oculta ) THEN
	        BEGIN
		        posicion.fila := i;
			posicion.columna := j;
			Descubrir ( juego, posicion );
		END;


END;
