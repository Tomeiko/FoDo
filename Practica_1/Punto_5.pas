{5. Realizar un programa para una tienda de celulares, que presente un menú con
opciones para:
a. Crear un archivo de registros no ordenados de celulares y cargarlo con datos
ingresados desde un archivo de texto denominado “celulares.txt”. Los registros
correspondientes a los celulares, deben contener: código de celular, el nombre,
descripción, marca, precio, stock mínimo y el stock disponible.
b. Listar en pantalla los datos de aquellos celulares que tengan un stock menor al
stock mínimo.
c. Listar en pantalla los celulares del archivo cuya descripción contenga una
cadena de caracteres proporcionada por el usuario.
d. Exportar el archivo creado en el inciso a) a un archivo de texto denominado
“celulares.txt” con todos los celulares del mismo. El archivo de texto generado
podría ser utilizado en un futuro como archivo de carga (ver inciso a), por lo que
debería respetar el formato dado para este tipo de archivos en la NOTA 2.
NOTA 1: El nombre del archivo binario de celulares debe ser proporcionado por el usuario.
NOTA 2: El archivo de carga debe editarse de manera que cada celular se especifique en
tres líneas consecutivas: en la primera se especifica: código de celular, el precio y
marca, en la segunda el stock disponible, stock mínimo y la descripción y en la tercera
nombre en ese orden. Cada celular se carga leyendo tres líneas del archivo
“celulares.txt”.}
program etesetch;
type
  celulares = record
    codigo: integer;
    nombre: String;
    descripcion: String;
    marca: String;
    precio: real;
    stockmin: integer;
    stockdisp: integer;
  end;
  archivo = file of celulares;
procedure creartxt ();
  procedure leer (var c: celulares);
    begin
      c.codigo := Random (10); 
      if c.codigo <> 4 then
        begin
          readln (c.nombre);
          readln (c.descripcion);
          readln (c.marca);
          c.precio:= Random(100);
          c.stockmin:= Random (100);
          c.stockdisp:= Random (100);
        end;
    end;
  var
    txt: text;
    aux: celulares;
  begin
    Randomize ();
    Assign (txt, 'celulares.txt');
    rewrite (txt);
    leer (aux);
    while aux.codigo <> 4 do
      begin
        writeln ('codigo ', aux.codigo, ' precio ', aux.precio:2:2, ' marca ', aux.marca, ' stockdisp ', aux.stockdisp, ' stockmin ', aux.stockmin, ' descripcion ', aux.descripcion, ' nombre ', aux.nombre);
        writeln (txt, aux.codigo, ' ', aux.precio:2:2, ' ', aux.marca);
        writeln (txt, aux.stockdisp, ' ', aux.stockmin, ' ', aux.descripcion);
        writeln (txt, aux.nombre);
        leer (aux);
      end;
    close (txt);
    writeln ('terminado el crear archivo txt base');
  end;
procedure trabajo1 (var arch: archivo);
  var
    txt: text;
    nombre: String;
    aux: celulares;
  begin
    writeln ('nombre del archivo: ');
    readln (nombre);
    Assign (arch, nombre);
    rewrite (arch);
    Assign (txt, 'celulares.txt');
    reset (txt);
    while not (eof(txt)) do
      begin
        readln (txt, aux.codigo, aux.precio, aux.marca);
        readln (txt, aux.stockdisp, aux.stockmin, aux.descripcion);
        readln (txt, aux.nombre);
        write (arch, aux);
      end;
    close (arch);
    close (txt);
    writeln ('terminado el archivo');
  end;
procedure trabajo2 (var arch: archivo);
  var
    aux: celulares;
  begin
    reset (arch);
    while not eof(arch) do
      begin
        read (arch, aux);
        if aux.stockmin > aux.stockdisp then
          writeln ('codigo ', aux.codigo, ' precio ', aux.precio:2:2, ' marca ', aux.marca, ' stockdisp ', aux.stockdisp, ' stockmin ', aux.stockmin, ' descripcion ', aux.descripcion, ' nombre ', aux.nombre);
      end;
    close (arch);
    writeln ('terminado el mostar por debajo del minimo');
  end;
procedure trabajo3 (var arch: archivo);
  var
    cadena: String;
    aux: celulares;
  begin
    reset(arch);
    writeln ('cadeba a buscar: ');
    readln (cadena);
    while not eof(arch) do
      begin
        read (arch, aux);
        if (pos(cadena, aux.descripcion) <> 0) then
          writeln ('codigo ', aux.codigo, ' precio ', aux.precio:2:2, ' marca ', aux.marca, ' stockdisp ', aux.stockdisp, ' stockmin ', aux.stockmin, ' descripcion ', aux.descripcion, ' nombre ', aux.nombre);
      end;
    close (arch);
    writeln ('terminado el mostar por cadena en la descripcion');
  end;
procedure trabajo4 (var arch: archivo);
  var
    txt: text;
    aux: celulares;
  begin
    reset (arch);
    Assign (txt, 'celulares.txt');
    rewrite (txt);
    while not eof(arch) do
      begin
        read (arch, aux);
        writeln (txt, aux.codigo, ' ', aux.precio:2:2, ' ', aux.marca);
        writeln (txt, aux.stockdisp, ' ', aux.stockmin, ' ', aux.descripcion);
        writeln (txt, aux.nombre);
      end;
    close (arch);
    close (txt);
    writeln ('terminado el crear archivo txt en base al archivo');
  end;
var
  num: integer;
  arch: archivo;
begin
  writeln ('elegi que hacer (0, 1, 2, 3, 4, 5): ');
  readln (num);
  while num <> 5 do
    begin
      case num of
        0: begin
             writeln ('elegiste crear un txt base');
             creartxt();
           end;
        1: begin
             writeln ('Elegiste crear archivo de registos');
             trabajo1 (arch);
           end;
        2: begin
             writeln ('Elegiste mostrar los datos de los que tienen stock debajo del minimo');
             trabajo2 (arch);
           end;
        3: begin
             writeln ('Elegiste buscar una cadena de caracteres');
             trabajo3 (arch);
           end;
        4: begin
             writeln ('Elegiste crear un celulares.txt en base al archivo');
             trabajo4 (arch);
           end;
      end;
      writeln ('elegi que hacer (0, 1, 2, 3, 4, 5): ');
      readln (num);
    end;
  writeln ('terminaste de usar el menu');
end.
