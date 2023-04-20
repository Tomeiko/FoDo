{Se dispone de un archivo con información de los alumnos de la Facultad de Informática. Por
cada alumno se dispone de su código de alumno, apellido, nombre, cantidad de materias
(cursadas) aprobadas sin final y cantidad de materias con final aprobado. Además, se tiene
un archivo detalle con el código de alumno e información correspondiente a una materia
(esta información indica si aprobó la cursada o aprobó el final).
Todos los archivos están ordenados por código de alumno y en el archivo detalle puede
haber 0, 1 ó más registros por cada alumno del archivo maestro. Se pide realizar un
programa con opciones para:
a. Actualizar el archivo maestro de la siguiente manera:
i.Si aprobó el final se incrementa en uno la cantidad de materias con final aprobado.
ii.Si aprobó la cursada se incrementa en uno la cantidad de materias aprobadas sin
final.
b. Listar en un archivo de texto los alumnos que tengan más de cuatro materias
con cursada aprobada pero no aprobaron el final. Deben listarse todos los campos.
NOTA: Para la actualización del inciso a) los archivos deben ser recorridos sólo una vez.}
program inicia_el_infierno_2;
type
  alumno = record
    codigo: integer;
    apellido: string;
    nombre: string;
    sinfinal: integer;
    confinal: integer;
  end;
  archmaestro = file of alumno;
  alumdetalle = record
    codigo: integer;
    finalapro: integer;
  end;
  archdetalle = file of alumdetalle;
procedure crearmaestro(var a: archmaestro);
  var
    alum: alumno;
    nombre: string;
  procedure leeralum (var a: alumno);
    begin
      writeln('Codigo: ');
      readln(a.codigo);
      if a. codigo <> -1 then
        begin
          writeln('Apellido: ');
          readln(a.apellido);
          writeln('Nombre: ');
          readln(a.nombre);
          a.sinfinal := Random(11);
          a.confinal := Random(11);
          writeln('Codigo: ', a.codigo, ' Apellido: ', a.apellido, ' Nombre: ', a.nombre, ' Sinfinal: ', a.sinfinal, ' Confinal: ', a.confinal);
         end;
    end;
  begin
    writeln('Nombre del archivo maestro: ');
    readln (nombre);
    assign (a, nombre);
    rewrite (a);
    leeralum(alum);
    while alum.codigo <> -1 do
      begin
        write(a, alum);
        leeralum(alum);
      end;
    close(a);
  end;
procedure creardetalle(var a: archdetalle);
  var
    alum: alumdetalle;
    nombre: string;
  procedure leeralumdetalle (var a: alumdetalle);
    begin
      writeln('Codigo: ');
      readln (a.codigo);
      if a. codigo <> -1 then
        begin
          writeln('aprobo final: ');
		  readln (a.finalapro);
          writeln('Codigo: ', a.codigo, ' Final aprobado: ', a.finalapro);
        end;
    end;
  begin
    writeln('Nombre del archivo detalle: ');
    readln (nombre);
    assign (a, nombre);
    rewrite (a);
    leeralumdetalle(alum);
    while alum.codigo <> -1 do
      begin
        write(a, alum);
        leeralumdetalle(alum);
      end;
    close(a);
  end;
procedure actualizarmaestro (var maestro: archmaestro; var detalle: archdetalle);
  var 
    nombre: string;
    a: alumdetalle;
    actualizar: alumno;
  procedure leerdetalle (var a: archdetalle; var alum: alumdetalle);
    begin
      if not eof(a) then
        read(a, alum)
      else
        alum.codigo := 9999;
    end;
  begin
    writeln ('maestro: ');
    readln (nombre);
    assign (maestro, nombre);
    writeln ('detalle: ');
    readln (nombre);
    assign (detalle, nombre);
    reset(maestro);
    reset(detalle);
    leerdetalle(detalle, a);
    while (a.codigo <> 9999) do
      begin
        read(maestro, actualizar);
        while(actualizar.codigo <> a.codigo) do 
          read(maestro, actualizar);
        while a.codigo = actualizar.codigo do
          begin
            if a.finalapro = 1 then
              actualizar.confinal := actualizar.confinal + 1
            else
              actualizar.sinfinal := actualizar.sinfinal + 1;
            leerdetalle(detalle, a);
          end;
        seek(maestro, filepos(maestro)-1);
        write(maestro, actualizar);
      end;
    close(maestro);
    close(detalle);
  end;
procedure creartxt (var maestro: archmaestro);
  var
    txt: text;
    a: alumno;
  begin
    assign (txt, 'alumnosconmasde4');
    rewrite(txt);
    assign (maestro, 'alumnos');
    reset (maestro);
    while not eof(maestro) do
      begin
        read (maestro, a);
        if a.sinfinal > 4 then
          begin
            write (txt, 'Codigo: ', a.codigo, ' Apellido: ', a.apellido, ' Nombre: ', a.nombre, ' Sinfinal: ', a.sinfinal, ' Confinal: ', a.confinal, ' ||| ');
          end;
      end;
      close(txt);
      close(maestro);
  end;
var
  maestro: archmaestro;
  detalle: archdetalle;
begin
  crearmaestro(maestro);
  creardetalle(detalle);
  actualizarmaestro(maestro, detalle);
  creartxt (maestro);
end.
