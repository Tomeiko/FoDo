{3. Realizar un programa que presente un menú con opciones para:
a. Crear un archivo de registros no ordenados de empleados y completarlo con
datos ingresados desde teclado. De cada empleado se registra: número de
empleado, apellido, nombre, edad y DNI. Algunos empleados se ingresan con
DNI 00. La carga finaliza cuando se ingresa el String ‘fin’ como apellido.
b. Abrir el archivo anteriormente generado y
i. Listar en pantalla los datos de empleados que tengan un nombre o apellido
determinado.
ii. Listar en pantalla los empleados de a uno por línea.
iii. Listar en pantalla empleados mayores de 70 años, próximos a jubilarse.
NOTA: El nombre del archivo a crear o utilizar debe ser proporcionado por el usuario.}
program pato;
type
  empleados = record
    numero: integer;
    apellido: String;
    nombre: String;
    edad: integer;
    dni: longint;
  end;
  archivo = file of empleados;
procedure inicio (var arch: archivo);
  var
    nombre: String;
  procedure agregar (var arch: archivo);
    var
      e: empleados;
    procedure leer (var e: empleados);
      begin
        writeln ('apellido: ');
        readln (e.apellido);
        if e.apellido <> 'fin' then
          begin
            e.numero:= Random (100);
            writeln ('nombre: ');
            readln (e.nombre);
            e.edad:= Random (2) + 70;
            e.dni:= Random (100);
          end;
      end;
    begin
      Randomize ();
      leer (e);
      while (e.apellido <> 'fin') do
        begin
          write (arch, e);
          leer (e);
        end;
    end;
  begin
    writeln ('nombre del archivo (porfavor bro, uno normal que esto es mi trabajo): ');
    readln (nombre);
    assign (arch, nombre);
    rewrite (arch);
    agregar (arch);
    close (arch);
  end;
procedure akasupa (var arch: archivo);
  var
    num: integer;
  procedure repre (e: empleados);
    begin
      writeln ('numero: ',e.numero,' apellido: ', e.apellido,' nombre: ', e.nombre,' edad: ', e.edad,' dni: ', e.dni);
    end;
  procedure trabajo1 (var arch: archivo);
    var
      aux: empleados;
      nombre, apellido: String;
    begin
      readln (nombre);
      readln (apellido);
      while not eof(arch) do
        begin
          read (arch, aux);
          if (aux.nombre = nombre) or (aux.apellido = apellido) then
            repre (aux);
        end;
    end;
  procedure trabajo2 (var arch: archivo);
    var
      aux: empleados;
    begin
      while not eof(arch) do
        begin
          read (arch, aux);
          repre (aux);
        end;
    end;
  procedure trabajo3 (var arch: archivo);
    var
      aux: empleados;  
    begin
      while not eof(arch) do
        begin
          read (arch, aux);
          if aux.edad > 70 then
            repre(aux);
        end;
    end;
  begin
    writeln ('elegi (1 0 2 o 3 o 4): ');
    readln (num);
    while num <> 4 do
      begin
        reset (arch);
        case num of 
          1: begin
               writeln ('elegiste mostar por nombre/apellido: ');
               trabajo1 (arch);
             end;
          2: begin
               writeln ('elegiste mostar todos: ');
               trabajo2 (arch);
             end;
          3: begin
               writeln ('elegiste mostrar casi jubilados: ');
               trabajo3 (arch);
             end;
        else 
          writeln ('NO EXISTE');
        close (arch);
        end;
      writeln ('elegi (1 0 2 o 3 o 4): ');
      readln (num);
      end;
    writeln ('elegiste irte, gracias por la informacion personal de tus empleados (se donde viven ahora)');
  end;
var
  arch: archivo;
  num: integer;
begin
  writeln ('elegi (1 o 2 o 0): ');
  readln (num);
  while num <> 0 do
    begin
      case num of
        1: begin 
             writeln ('elegiste iniciar: ');
             inicio (arch);
          end;
        2: begin 
             writeln ('elegiste hacer algo (toca elegir algo mas por eso): ');
             akasupa (arch);
          end;
      else 
        writeln ('NO EXISTE');     
      end; 
    writeln ('elegi (1 o 2 o 0): ');
    readln (num);
    end;
  writeln ('elegiste irte, mejor asi no tengo que seguir mirando a tus empleados (se donde vivis ahora)');   
end.
