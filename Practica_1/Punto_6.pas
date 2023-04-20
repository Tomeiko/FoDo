{6. Agregar al menú del programa del ejercicio 5, opciones para:
a. Añadir uno o más celulares al final del archivo con sus datos ingresados por
teclado.
b. Modificar el stock de un celular dado.
c. Exportar el contenido del archivo binario a un archivo de texto denominado:
”SinStock.txt”, con aquellos celulares que tengan stock 0.
NOTA: Las búsquedas deben realizarse por nombre de celular.}
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
procedure leer (var c: celulares);
  begin
    Randomize ();
    c.codigo := Random (5); 
    if c.codigo <> 4 then
      begin
        readln (c.nombre);
        readln (c.descripcion);
        readln (c.marca);
        c.precio:= Random(100);
        c.stockmin:= Random (100);
        c.stockdisp:= Random (100);
      end
    else
      writeln ('ya no');
  end;
procedure creartxt ();
  var
    txt: text;
    aux: celulares;
  begin
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
    writeln ('cadena a buscar: ');
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
procedure trabajo5 (var arch: archivo);
  var
    aux: celulares;
  begin
    reset (arch);
    seek (arch, filesize(arch));
    writeln ('celular: ');
    leer (aux);
    while aux.codigo <> 4 do
      begin
        writeln ('codigo ', aux.codigo, ' precio ', aux.precio:2:2, ' marca ', aux.marca, ' stockdisp ', aux.stockdisp, ' stockmin ', aux.stockmin, ' descripcion ', aux.descripcion, ' nombre ', aux.nombre);
        write (arch, aux);
        writeln ('celular: ');
        leer (aux);        
      end;
    close (arch);
    writeln ('terminado el agregar celulares al final del archivo');
  end;
procedure trabajo6 (var arch: archivo);
  var
    nombre: String;
    num: integer;
    aux: celulares;
  begin
    reset (arch);
    writeln ('celular a modificar: ');
    readln (nombre);
    aux.nombre:= '-1';
    while (not eof(arch)) and (aux.nombre <> nombre) do
      read (arch, aux);
    if aux.nombre = nombre then
      begin
        writeln ('modificar stock: ');
        readln (num);
        aux.stockdisp:= num;
        seek (arch, FilePos(arch)-1);
        write (arch, aux);
      end;
    close (arch);
    writeln ('terminado el modificar el stock de un celular');
  end;
procedure trabajo7 (var arch: archivo);
  var
    txt: text;
    aux: celulares;
  begin
    reset (arch);
    Assign (txt, 'SinStock.txt');
    Rewrite (txt);
    while not eof (arch) do
      begin
        read (arch, aux);
        if aux.stockdisp = 0 then
          begin
            writeln ('codigo ', aux.codigo, ' precio ', aux.precio:2:2, ' marca ', aux.marca, ' stockdisp ', aux.stockdisp, ' stockmin ', aux.stockmin, ' descripcion ', aux.descripcion, ' nombre ', aux.nombre);
            writeln (txt, aux.codigo, ' ', aux.precio:2:2, ' ', aux.marca);
            writeln (txt, aux.stockdisp, ' ', aux.stockmin, ' ', aux.descripcion);
            writeln (txt, aux.nombre);
          end;
      end;
    close (arch);
    close (txt);
    writeln ('terminado el crear el txt de sinstock');
  end;
var
  num: integer;
  arch: archivo;
begin
  writeln ('elegi que hacer (0, 1, 2, 3, 4, 5, 6, 7, 8): ');
  readln (num);
  while num <> 8 do
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
        5: begin
             writeln ('Elegiste agregar celulares al final del archivo');
             trabajo5 (arch);
           end;
        6: begin
             writeln ('Elegiste modificar el stock de un celular');
             trabajo6 (arch);
           end;
        7: begin
             writeln ('Elegiste crear el txt de sinstock');
             trabajo7 (arch);
           end;
      end;
      writeln ('elegi que hacer (0, 1, 2, 3, 4, 5, 6, 7, 8): ');
      readln (num);
    end;
  writeln ('terminaste de usar el menu');
end.
