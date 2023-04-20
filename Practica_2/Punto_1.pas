{ Una empresa posee un archivo con información de los ingresos percibidos por diferentes
empleados en concepto de comisión, de cada uno de ellos se conoce: código de empleado,
nombre y monto de la comisión. La información del archivo se encuentra ordenada por
código de empleado y cada empleado puede aparecer más de una vez en el archivo de
comisiones.
Realice un procedimiento que reciba el archivo anteriormente descripto y lo compacte. En
consecuencia, deberá generar un nuevo archivo en el cual, cada empleado aparezca una
única vez con el valor total de sus comisiones.
NOTA: No se conoce a priori la cantidad de empleados. Además, el archivo debe ser
recorrido una única vez.}
program inicia_el_infierno_1;
type
  empleado = record
    codigo: integer;
    nombre: string;
    monto: Real;
  end;
  archivo = file of empleado;
procedure crearbase(var a: archivo);
  var
    e: empleado;
    nombre: string;
  procedure leer(var e: empleado);
    begin
      writeln('codigo: ');
      readln (e.codigo);
      if e.codigo <> -1 then
        begin
          writeln('nombre: ');
          readln (e.nombre);
          writeln('monto: ');
          readln (e.monto);
          writeln('codigo: ', e.codigo, ' nombre: ', e.nombre, ' monto: ', e.monto:2:2);
        end;
    end;
  begin
    writeln('Nombre del archivo: ');
    readln (nombre);
    assign (a, nombre);
    rewrite(a);
    leer(e);
    while (e.codigo <> -1) do
      begin
        write(a, e);
        leer(e);
      end;
    close(a);
  end;
procedure compactar (var acomp: archivo; var abase: archivo);
  var 
    nombre: string;
    e: empleado;
    max: empleado;
  procedure leerarch (var a: archivo; var e: empleado);
    begin
      if not eof(a) then 
        read(a, e)
      else
        e.codigo := 9999;
    end;
  begin
    writeln('nombre del archivo a compactar');
    readln (nombre);
    assign (abase, nombre);
    reset (abase);
    writeln('nombre del archivo compactado');
    readln (nombre);
    assign (acomp, nombre);
    rewrite (acomp);
    leerarch(abase, e);
    while (e.codigo <> 9999) do
      begin
        max.codigo := e.codigo;
        max.nombre := e.nombre;
        max.monto := 0;
        while (e.codigo = max.codigo) do
          begin
            max.monto := max.monto + e.monto;
            leerarch(abase,e);
          end;
        write(acomp, max);
      end;
    close(abase);
    close(acomp);  
  end;
var
  archbase: archivo;
  archcomp: archivo;
  num: integer;
begin
  writeln('Elegi lo que vas a hacer: (0 o 1 o 2)');
  readln (num);
  while num <> 0 do
    begin
      case num of
        1: begin
		     writeln('crear archivo empleado');
		     crearbase(archbase);
		     writeln('creado');
           end;
        2: begin
             writeln('compactar archivo base en uno nuevo');
             compactar(archcomp, archbase);
             writeln('compactado');
           end;
        end;
      writeln('Elegi lo que vas a hacer: (0 o 1 o 2)');
      readln (num);
    end;
    writeln('terminaste')
end.

