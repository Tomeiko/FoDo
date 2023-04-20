{7. Realizar un programa que permita:
a. Crear un archivo binario a partir de la información almacenada en un archivo de texto.
El nombre del archivo de texto es: “novelas.txt”
b. Abrir el archivo binario y permitir la actualización del mismo. Se debe poder agregar
una novela y modificar una existente. Las búsquedas se realizan por código de novela.
NOTA: La información en el archivo de texto consiste en: código de novela, nombre,
género y precio de diferentes novelas argentinas. De cada novela se almacena la
información en dos líneas en el archivo de texto. La primera línea contendrá la siguiente
información: código novela, precio, y género, y la segunda línea almacenará el nombre
de la novela.}
program etesetch;
type
  novelas = record
    codigo: integer;
    nombre: String;
    genero: String;
    precio: real;
  end;
  archivo = file of novelas;
procedure leer (var aux: novelas);
  begin
    Randomize ();
    aux.codigo:= Random (10);
    readln (aux.nombre);
    readln (aux.genero);
    aux.precio:= Random (100);
  end;
procedure creartxt ();
  procedure leertxt (var aux: novelas);
    begin
      Randomize ();
      aux.codigo:= Random (10);
      if aux.codigo <> 4 then
        begin
          readln (aux.nombre);
          readln (aux.genero);
          aux.precio:= Random (100);
        end;
    end;
  var
    txt: text;
    aux: novelas;
  begin
    Assign (txt, 'novelas.txt');
    rewrite (txt);
    leertxt (aux);
    while aux.codigo <> 4 do
      begin
        writeln ('codigo ', aux.codigo, ' nombre ', aux.nombre, ' genero ', aux.genero, ' precio ', aux.precio:2:2);
        writeln (txt, aux.codigo, ' ', aux.precio:2:2, ' ', aux.genero); 
        writeln (txt, aux.nombre);
        leertxt (aux);
      end;
    close (txt);
    writeln ('terminado el crear archivo txt base');
  end;
procedure trabajo1 (var arch: archivo);
  var
    aux: novelas;
    txt: text;
    nombre: String;
  begin
    writeln ('nombre del archivo: ');
    readln (nombre);
    Assign (arch, nombre);
    rewrite (arch);
    Assign (txt, 'novelas.txt');
    reset (txt);
    while not eof(txt) do
      begin
        readln (txt, aux.codigo, aux.precio, aux.genero); 
        readln (txt, aux.nombre);
        write (arch, aux);
      end;
    close (arch);
    close (txt);
    writeln ('termino el crear un archivo binario');
  end;
procedure trabajo2 (var arch: archivo);
  var
    aux: novelas;
  begin
    reset (arch);
    seek (arch, FileSize(arch));
    leer (aux);
    write (arch, aux);
    close (arch);
    writeln ('termino el agregar una novela');
  end;
procedure trabajo3 (var arch: archivo);
  var
    aux: novelas;
    num: integer;
  begin
    reset (arch);
    writeln ('codigo de novela a modificar: ');
    readln (num);
    aux.codigo:= -1;
    while (not eof (arch)) and (aux.codigo <> num) do
      read (arch, aux);
    if aux.codigo = num then
      begin
        seek (arch, FilePos(arch)-1);
        writeln ('modificaciones: ');
        leer(aux);
        write (arch, aux);
      end;
    close (arch);
    writeln ('termino el modificar una novela');
  end;
var
  num: integer;
  arch: archivo;
begin
  writeln ('elegi que hacer (0, 1, 2, 3, 4): ');
  readln (num);
  while num <> 4 do
    begin
      case num of
        0: begin
             writeln ('elegiste crear un txt base');
             creartxt();
           end;
        1: begin
             writeln ('elegiste crear un archivo binario');
             trabajo1 (arch);
           end;
        2: begin
             writeln ('elegiste agregar una novela');
             trabajo2 (arch);
           end;
        3: begin
             writeln ('elegiste modificar una novela');
             trabajo3 (arch);
           end;
      end;
      writeln ('elegi que hacer (0, 1, 2, 3, 4): ');
      readln (num);
    end;
  writeln ('terminaste de usar el menu');
end.
