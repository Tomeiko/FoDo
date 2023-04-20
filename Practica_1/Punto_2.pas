{2. Realizar un algoritmo, que utilizando el archivo de números enteros no
ordenados
creados en el ejercicio 1, informe por pantalla cantidad de números menores a
1500 y el
promedio de los números ingresados. El nombre del archivo a procesar debe ser
proporcionado por el usuario una única vez. Además, el algoritmo deberá
listar el
contenido del archivo en pantalla.}
program pato;
type
  archivo = file of integer;
procedure agregar (var arch: archivo);
  var
    n: integer;
  begin
    read (n);
    while (n <> 3000) do
      begin
        write (arch, n);
        read (n);
      end;
  end;
procedure analizar (var arch: archivo);
  var
    num, total, aux: integer;
  begin
    total:= 0;
    aux:= 0;
    while not eof(arch) do
      begin
        read (arch, num); 
        write (num);
        if num < 1500 then
           total:= total + 1;
         aux:= aux + num;
      end;
    writeln (total);
    writeln (aux / filesize(arch):2:2);
  end;
var
  arch: archivo;
  nombre: String;
begin
  read (nombre);
  assign (arch, nombre);
  rewrite (arch);
  agregar (arch);
  close (arch);
  reset (arch);
  analizar (arch);
  close (arch);
end.
