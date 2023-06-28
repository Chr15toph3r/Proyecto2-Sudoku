program Proyecto2Sudoku;
uses crt;
type
    Tablero = array[1..9, 1..9] of integer; {Nuestro punto de partida es una matriz bidimensional 9x9 de numeros enteros.}
var
    Sudoku: Tablero; 
    i, j: integer;       {Variables Globales: Creamos a continuacion una variable a partir del tablero, variables i, j (x,y) de tipo Enteros. Y una variable key de tipo Char que es usada en el inicio del programa y que cumple con el rol de iniciar el programa y pasar de la interfaz inicial al juego directamente.}
    key: Char;

{Modulo 1: (NumValido) Esta funcion verifica si un numero es valido para colocarlo en el tablero a partir de tres reglas. }
    function NumValido(Sudoku: Tablero; Fila, Columna, Numero: integer): boolean;
    var
        Fila3x3, Columna3x3, i: integer;
    begin
        for i := 1 to 9 do
            if Sudoku[Fila, i] = Numero then          {regla 1: Comprueba que el numero no esta ya en la misma fila.}
            begin
                NumValido := false;            
                exit;
            end;
        for i := 1 to 9 do
            if Sudoku[i, Columna] = Numero then       {regla 2: Comprueba que el numero no esta ya en la misma columna.}
            begin
                NumValido := false;
                exit;
            end;

        Fila3x3 := Fila - Fila mod 3 + 1;             {regla 3: Comprueba que el numero no esta en el cuadrado 3x3.}
        Columna3x3 := Columna - Columna mod 3 + 1;
        for i := Fila3x3 to Fila3x3 + 2 do
            for j := Columna3x3 to Columna3x3 + 2 do
                if Sudoku[i, j] = Numero then
                begin
                    NumValido := false;
                    exit;
                end;
        NumValido := true; {Si el numero ingresado no se encuentra el número en la fila, columna o cuadrado 3x3, es valido (NumValido := true;)}
    end;
{Fin modulo 1.}

{Modulo 2: (GeneradorPistas) Primer procedimiento del programa. Este procedimiento general el tablero, junto con un cierto numero de pistas, dichas pistas se colocan aleatoriamente en el tablero siguiendo las reglas  . }
procedure GeneradorPistas(var Sudoku: Tablero; Pistas: integer);
var
  Fila, Columna, Numero, PistasGeneradas: Integer; {Primero definimos variables locales}
begin
  Randomize;  {Comenzamos con un generador de pistas aleatorio}

  PistasGeneradas := 0;  {Esta variable lleva el control de cuantas pistas han sido generadas}
  while PistasGeneradas < Pistas do  {A continuacion entramos en un bucle, que no parara hasta que se cumpla con las pistas deseadas.}
  begin
    Fila := Random(9) + 1; 
    Columna := Random(9) + 1;  {Dentro del bucle se genera tres numeros aleatorios, que determinar, en que fila, columna y que numero aleatorio como pista se generara en el tablero.}
    Numero := Random(9) + 1;  
    
    if (Sudoku[Fila, Columna] = 0) and NumValido(Sudoku, Fila, Columna, Numero) then {Con este If nos aseguramos de que, basicamente, la celda en donde se colocara el numero pista este vacio.}
    begin
      Sudoku[Fila, Columna] := Numero;  {Se coloca la pista en la celda}
      Inc(PistasGeneradas);  {Y por ultimo, incrementa el numero de pistas generadas, para que el bucle termine con el: (while PistasGeneradas < Pistas do). }
    end;
  end;
end;
{Fin modulo 2}

{Modulo 3: (ImprimirSudoku) Segundo procedimiento del programa. Este procedimiento es sencillo: imprime el sudoku en la terminal o la consola.}
procedure ImprimirSudoku(Sudoku: Tablero);
begin
    ClrScr;                                     {Limpiamos la terminal, por que este sudoku, viene despues de apretar ENTER para usar el programa.}
    writeln('----------------------------');    {Esta es la primera linea Horizontal superior para delimitar el tablero.}
    for i := 1 to 9 do
    begin
        write('| ');                            {Iteraciones entre i y j (comunas y filas) y el write('| '); para delimitar el tablero a la izquierda.}
        for j := 1 to 9 do 
        begin
            if Sudoku[i, j] = 0 then            {Esto se encarga de imprimir un espacio vacio en vez de 0 en el sudoku, cuando en efecto, si hay un espacio vacio.}
                write('  ')
            else
                write(Sudoku[i, j]:2);          {Si no esta vacio, este imprime el numero en la celda, y el :2 es para que no se descuadre el sudoku}
            if j mod 3 = 0 then write(' | ');   {Esto se encarga de mostrar un | cada tres lineas}
        end;
        writeln;                                                        {Este writeln garantiza un salto de linea despues de mostrar o imprimir cada fila.}
        if i mod 3 = 0 then writeln('----------------------------');    {Asi como el ( if j mod 3 = 0 then write(' | ');) que imprime las lineas verticales cada 3 espacios, este sirve para escribir las lineas horizontales igual que la superior cada tres espacios.}
    end;
end;
{Fin modulo 3}

{modulo4}
procedure IngresarNumero(var Sudoku: Tablero);
var
  Fila, Columna, Numero: Integer;
begin
  Write('Ingresa la fila (1-9): ');
  ReadLn(Fila);
  Write('Ingresa la columna (1-9): ');
  ReadLn(Columna);
  Write('Ingresa el numero (1-9): ');
  ReadLn(Numero);

  if NumValido(Sudoku, Fila, Columna, Numero) then
  begin
    Sudoku[Fila, Columna] := Numero;
    Writeln('Numero ingresado con exito.');
    Writeln('Sudoku actualizado:');
    ImprimirSudoku(Sudoku);
  end
  else
    Writeln('Numero invalido. Intenta nuevamente.');
end;
{Fin modulo4}

{modulo 5}
begin
    Clrscr;
    Gotoxy(30,3);
    WriteLn(' ----------------');
    Gotoxy(30,4);
    WriteLn('|     SUDOKU     |');
    Gotoxy(30,5);
    WriteLn(' ----------------');
    Gotoxy(30,11);
    WriteLn('   Realizado por:');
    Gotoxy(30,12);
    WriteLn('  Cristopher Avila     ');
    Gotoxy(30,13);
    WriteLn('   Robert Rosario');

    while key <> #13 do 
    begin
        Gotoxy(24,8);
        WriteLn('Presione ENTER para continuar.');
        delay(500);
        Gotoxy(24,8);
        WriteLn('                              '); 
        delay(500);

        if KeyPressed then 
        begin
            key := ReadKey; 
        end;
    end;
    for i := 1 to 9 do
        for j := 1 to 9 do
            Sudoku[i, j] := 0;
    GeneradorPistas(Sudoku, 20);  
    Writeln('Sudoku inicial:');
    ImprimirSudoku(Sudoku);


    while true do
    begin
        IngresarNumero(Sudoku);
    end;
    Clrscr; 
end.
{fin modulo 5}