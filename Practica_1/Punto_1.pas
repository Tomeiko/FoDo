{1. Realizar un algoritmo que cree un archivo de números enteros no ordenados y
permita
incorporar datos al archivo. Los números son ingresados desde teclado. El
nombre del
archivo debe ser proporcionado por el usuario desde teclado. La carga finaliza cuando
se ingrese el número 30000, que no debe incorporarse al archivo.}
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
var
  arch: archivo;
  nombre: String;
begin
  read (nombre);
  assign (arch, nombre);
  rewrite (arch);
  agregar (arch);
  close (arch);
end.
