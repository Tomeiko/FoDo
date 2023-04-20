{4. Agregar al menú del programa del ejercicio 3, opciones para:
a. Añadir uno o más empleados al final del archivo con sus datos ingresados por
teclado. Tener en cuenta que no se debe agregar al archivo un empleado con
un número de empleado ya registrado (control de unicidad).
b. Modificar edad a uno o más empleados.
c. Exportar el contenido del archivo a un archivo de texto llamado
“todos_empleados.txt”.
d. Exportar a un archivo de texto llamado: “faltaDNIEmpleado.txt”, los empleados
que no tengan cargado el DNI (DNI en 00).
NOTA: Las búsquedas deben realizarse por número de empleado.}
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
procedure inicio (var arch: archivo);
  var
    nombre: String;
  procedure agregar (var arch: archivo);
    var
      e: empleados;
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
  procedure trabajo4 (var arch: archivo);
    var
      ok: boolean;
      aux, nuevo: empleados;
    begin
      leer(nuevo);
      while nuevo.apellido <> 'fin' do
        begin
          ok:= true;
          seek (arch, 0);
          while not eof(arch) do
            begin
              read (arch, aux);
              if aux.numero = nuevo.numero then
                ok:= false;
            end;
          if ok = true then
            write(arch, nuevo)
          else
            writeln ('ya estaba bro');
          leer (nuevo);
        end;
      writeln ('gracias por parar de poner nuevos empleados, BRO!');
    end;
  procedure trabajo5 (var arch: archivo);
    var
      ok: boolean;
      num, edad: integer;
      aux: empleados;
    begin
      writeln ('numero de empleado:');
      readln (num);
      while num <> -1 do
        begin
          ok:= false;
          seek (arch, 0);
          while (not eof(arch)) and (ok = false) do
            begin
              read (arch, aux);
              if aux.numero = num then
                begin
                  ok:= true;
                  writeln ('edad a poner:');
                  read (edad);
                  aux.edad:= edad;
                  seek (arch, FilePos(arch)-1);
                  write (arch, aux);
                end;
            end;
          if ok = false then
            writeln ('no esta ese numero');
          writeln ('numero de empleado:');
          readln (num);
        end;
      writeln ('gracias por dejar de hacerlos viejos');
    end;
  procedure trabajo6 (var arch: archivo);
    var
      nuevo: text;
      aux: empleados;
    begin
      assign (nuevo, 'todos_empleados.txt');
      rewrite (nuevo);
      reset (arch);
      while not eof(arch) do
        begin
          read (arch, aux);
          with aux do
            writeln (nuevo, 'numero: ', numero, ' apellido: ', apellido, ' nombre: ', nombre, ' edad: ', edad, ' dni: ', dni);
        end;
      close (arch);
      close (nuevo);
      writeln ('convertido');
    end;
  procedure trabajo7 (var arch: archivo);
    var
      nuevo: text;
      aux: empleados;
    begin
      assign (nuevo, 'todos_empleados.txt');
      rewrite (nuevo);
      reset (arch);
      while not eof(arch) do
        begin
          read (arch, aux);
          if aux.dni = 00 then
            with aux do
              writeln (nuevo, 'numero: ', numero, ' apellido: ', apellido, ' nombre: ', nombre, ' edad: ', edad, ' dni: ', dni);
        end;
      close (arch);
      close (nuevo);
      writeln ('convertido');
    end;
  begin
    writeln ('elegi (1 o 2 o 3 o 4 o 5 o 6 o 7 o 0): ');
    readln (num);
    while num <> 0 do
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
          4: begin
               writeln ('elegiste anadir empleados');
               trabajo4 (arch);
             end; 
          5: begin
               writeln ('elegiste volver mas viejo a los empleados');
               trabajo5 (arch);
             end;
          6: begin
               writeln ('elegiste pasar todos a .txt');
               trabajo6 (arch);
             end;
          7: begin
               writeln ('elegiste pasar a los sin dni a .txt');
               trabajo7 (arch);
             end;
        else 
          writeln ('NO EXISTE');
        close (arch);
        end;
      writeln ('elegi (1 o 2 o 3 o 4 o 5 o 6 o 7 o 0):: ');
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
