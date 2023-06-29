program Proyecto2Sudoku;
uses crt;
type
    Tablero = array[1..9, 1..9] of integer; {Nuestro punto de partida es una matriz bidimensional 9x9 de numeros enteros.}
var
    Sudoku, SudokuResuelto: Tablero; 
    i, j: integer;       {Variables Globales: Creamos a continuacion una variable a partir del tablero, variables i, j (x,y) de tipo Enteros. Y una variable key de tipo Char que es usada en el inicio del programa y que cumple con el rol de iniciar el programa y pasar de la interfaz inicial al juego directamente.}
    key, opcion: Char;
    nombre: string;


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
procedure GeneradorPistas (var Sudoku: Tablero; SudokuResuelto: Tablero; Pistas: integer);
var
    Fila, Columna, PistasGeneradas: Integer;
begin
    Randomize;

    for i := 1 to 9 do
        for j := 1 to 9 do
            Sudoku[i, j] := 0;
    PistasGeneradas := 0;

    while (PistasGeneradas < Pistas) do
    begin
        repeat
            Fila := Random(9) + 1;
            Columna := Random(9) + 1;
        until Sudoku[Fila, Columna] = 0;
        
        Sudoku[Fila, Columna] := SudokuResuelto[Fila, Columna];
        Inc(PistasGeneradas);
    end;
end;
{Fin modulo 2}

{Modulo 3: (ImprimirSudoku) Segundo procedimiento del programa. Este procedimiento es sencillo: imprime el sudoku en la terminal o la consola.}
procedure ImprimirSudoku(Sudoku: Tablero);
var
    i, j: integer;
begin
    ClrScr;
    writeln('    1 2 3    4 5 6    7 8 9');            {Guía de columnas}
    writeln('   -------------------------');
    for i := 1 to 9 do
    begin
        write(i, ' |');                              {Guía de filas}
        for j := 1 to 9 do 
        begin
            TextColor(LightRed);
            if Sudoku[i, j] = 0 then
                write('  ')
            else
                write(Sudoku[i, j]:2);
            TextColor(White);
            if j mod 3 = 0 then write(' | ');
        end;
        writeln;
        if i mod 3 = 0 then writeln('   -------------------------');
    end;
end;
{Fin modulo 3}

{modulo4}
procedure IngresarNumero(var Sudoku: Tablero);
var
  Fila, Columna, Numero: Integer;
begin
  Write('Ingresa la fila (solo puede ser del 1 al 9): ');
  Read(Fila);
  Write('Ingresa la columna (solo puede ser del 1 al 9): ');
  Read(Columna);
  Write('Ingresa el numero (solo puede ser del 1 al 9): ');
  Read(Numero);

  if NumValido(Sudoku, Fila, Columna, Numero) then
  begin
    Sudoku[Fila, Columna] := Numero;
    Writeln('Numero ingresado con exito.');
    ClrScr;
    Writeln('Sudoku actualizado:');
    ImprimirSudoku(Sudoku);
  end
  else
    Writeln('Numero invalido. Intenta nuevamente.');
end;
{Fin modulo4}

{Modulo 4,5: (SudokuCompletado) Esta funcion verifica si el Sudoku se ha completado correctamente.}
function SudokuCompletado(Sudoku, SudokuResuelto: Tablero): boolean;
var
    i, j: integer;
begin
    for i := 1 to 9 do
        for j := 1 to 9 do
            if Sudoku[i, j] <> SudokuResuelto[i, j] then
            begin
                SudokuCompletado := false;
                exit;
            end;
    SudokuCompletado := true;
end;
{Fin modulo 4,5.}

{modulo 5}
begin
 SudokuResuelto[1,1] := 7; SudokuResuelto[1,2] := 8; SudokuResuelto[1,3] := 5; SudokuResuelto[1,4] := 4; SudokuResuelto[1,5] := 3; SudokuResuelto[1,6] := 9; SudokuResuelto[1,7] := 1; SudokuResuelto[1,8] := 2; SudokuResuelto[1,9] := 6;
    SudokuResuelto[2,1] := 6; SudokuResuelto[2,2] := 1; SudokuResuelto[2,3] := 2; SudokuResuelto[2,4] := 8; SudokuResuelto[2,5] := 7; SudokuResuelto[2,6] := 5; SudokuResuelto[2,7] := 3; SudokuResuelto[2,8] := 4; SudokuResuelto[2,9] := 9;
    SudokuResuelto[3,1] := 4; SudokuResuelto[3,2] := 9; SudokuResuelto[3,3] := 3; SudokuResuelto[3,4] := 6; SudokuResuelto[3,5] := 2; SudokuResuelto[3,6] := 1; SudokuResuelto[3,7] := 5; SudokuResuelto[3,8] := 7; SudokuResuelto[3,9] := 8;
    SudokuResuelto[4,1] := 8; SudokuResuelto[4,2] := 5; SudokuResuelto[4,3] := 1; SudokuResuelto[4,4] := 7; SudokuResuelto[4,5] := 4; SudokuResuelto[4,6] := 3; SudokuResuelto[4,7] := 9; SudokuResuelto[4,8] := 6; SudokuResuelto[4,9] := 2;
    SudokuResuelto[5,1] := 2; SudokuResuelto[5,2] := 7; SudokuResuelto[5,3] := 4; SudokuResuelto[5,4] := 9; SudokuResuelto[5,5] := 6; SudokuResuelto[5,6] := 8; SudokuResuelto[5,7] := 7; SudokuResuelto[5,8] := 1; SudokuResuelto[5,9] := 5;
    SudokuResuelto[6,1] := 3; SudokuResuelto[6,2] := 6; SudokuResuelto[6,3] := 9; SudokuResuelto[6,4] := 2; SudokuResuelto[6,5] := 5; SudokuResuelto[6,6] := 1; SudokuResuelto[6,7] := 4; SudokuResuelto[6,8] := 8; SudokuResuelto[6,9] := 7;
    SudokuResuelto[7,1] := 9; SudokuResuelto[7,2] := 3; SudokuResuelto[7,3] := 6; SudokuResuelto[7,4] := 1; SudokuResuelto[7,5] := 8; SudokuResuelto[7,6] := 7; SudokuResuelto[7,7] := 2; SudokuResuelto[7,8] := 5; SudokuResuelto[7,9] := 4;
    SudokuResuelto[8,1] := 5; SudokuResuelto[8,2] := 4; SudokuResuelto[8,3] := 7; SudokuResuelto[8,4] := 3; SudokuResuelto[8,5] := 9; SudokuResuelto[8,6] := 2; SudokuResuelto[8,7] := 6; SudokuResuelto[8,8] := 8; SudokuResuelto[8,9] := 1;
    SudokuResuelto[9,1] := 1; SudokuResuelto[9,2] := 2; SudokuResuelto[9,3] := 8; SudokuResuelto[9,4] := 5; SudokuResuelto[9,5] := 4; SudokuResuelto[9,6] := 6; SudokuResuelto[9,7] := 7; SudokuResuelto[9,8] := 9; SudokuResuelto[9,9] := 3;
    Clrscr;
    Write('Por favor escribe tu nombre de usuario: ');
    Read(nombre);
    ReadLn;  
    gotoxy(1,3); writeln('Bienvenido: ', nombre);
    gotoxy(1,4); writeln('REGLAS PARA JUGAR SUDOKU'); 
    gotoxy(1,5); writeln('1. Cada fila debe contener los numeros del 1 al 9 sin repetir.'); 
    gotoxy(1,6); writeln('2. Cada columna debe contener los numeros del 1 al 9 sin repetir.'); 
    gotoxy(1,7); writeln('3. Cada seccion de 3x3 debe contener los numeros del 1 al 9 sin repetir.'); 
    gotoxy(1,8); writeln('4. Diviertete.');
    gotoxy(1,10); writeln('Presione ENTER para continuar.');
    ReadLn;
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
    key := #0;
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
    
    SudokuResuelto[1, 1] := 7; SudokuResuelto[1, 2] := 8; SudokuResuelto[1, 3] := 5; 
    GeneradorPistas(Sudoku, SudokuResuelto, 20);  {20 pistas pero puedes añadir mas.}
    Writeln('Sudoku inicial:');
    ImprimirSudoku(Sudoku);


    while true do
    begin
    gotoxy(31, 12); writeln('  /|_/|');
    gotoxy(31, 13); writeln('=(- - =7');
    gotoxy(31, 14); writeln('  |    \  /');
    gotoxy(31, 15); writeln('  |/|/,,)/');  
        Writeln(' ------------| Menu de juego |---------------- '); 
        WriteLn('|                                             |');
        Writeln('|  1. >Ingresar un numero<                    |');
        Writeln('|  0. >Rendirse<                              | ');     
        Writeln('|                                             |');         
        Writeln(' --------------------------------------------- '); 
        ReadLn(opcion); 
        if opcion = '1' then
            IngresarNumero(Sudoku)
        else if opcion = '0' then
        begin
            ImprimirSudoku(SudokuResuelto);
            Writeln('Este es el sudoku resuelto.');
            Writeln('Mejor suerte la proxima vez ', nombre, '!');
            break;
        end
        else
            Writeln('Opcion invalida. Intenta nuevamente.');
            readLn;
        if SudokuCompletado(Sudoku, SudokuResuelto) then
        begin
            ClrScr;
            ImprimirSudoku(SudokuResuelto); WriteLn;
            Writeln('Has ganado, ', nombre, ' eres el/la mejor!!!!!');
            ReadLn;
            break;
        end;
    end;
end.
{fin modulo 5}
