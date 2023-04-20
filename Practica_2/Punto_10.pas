{Se tiene información en un archivo de las horas extras realizadas por los empleados de
una empresa en un mes. Para cada empleado se tiene la siguiente información:
departamento, división, número de empleado, categoría y cantidad de horas extras
realizadas por el empleado. Se sabe que el archivo se encuentra ordenado por
departamento, luego por división, y por último, por número de empleados. Presentar en
pantalla un listado con el siguiente formato:
Departamento
División
Número de Empleado Total de Hs. Importe a cobrar
...... .......... .........
...... .......... .........
Total de horas división: ____
Monto total por división: ____
División
.................
Total horas departamento: ____
Monto total departamento: ____
Para obtener el valor de la hora se debe cargar un arreglo desde un archivo de texto al
iniciar el programa con el valor de la hora extra para cada categoría. La categoría varía
de 1 a 15. En el archivo de texto debe haber una línea para cada categoría con el número
de categoría y el valor de la hora, pero el arreglo debe ser de valores de horas, con la
posición del valor coincidente con el número de categoría.}
program inicia_el_infierno_10;
const
  valoralto = 'ZZZZ';
type
  empleado = record
    departamento: string;
    division: integer;
    numero: integer;
    categoria: integer;
    horas: integer;
  end;
  maestro = file of empleado;
  valorhora = array [1..15] of real;
procedure cargararreglo(var arreglo: valorhora);
  var
    txt: text;
    i: integer;
    precio: real;
  begin
    assign (txt, 'texto');
    reset(txt);
    while not eof(txt) do
      begin
       read(txt, i, precio);
       arreglo[i]:= precio; 
      end;
  end;
procedure mostar (var m: maestro; var a: valorhora);
  procedure leer(var m: maestro; var aux: empleado);
    begin
      if not eof(m) then
        read(m, aux)
      else
         aux.departamento:= valoralto;
    end; 
  var
    aux: empleado;
    departamento: string;
    division: integer;
    numero: integer;
    precio: real;
    empleadohoras: integer;
    empleadomonto: real;
    divisionhoras: integer;
    divisionmonto: real;
    departamentohoras: integer;
    departamentomonto: real;
  begin
    assign (m, 'maestro');
    reset(m);
    leer(m, aux);
    while aux.departamento <> valoralto do
      begin
        departamento:= aux.departamento;
        writeln('departamento: ', departamento);
        departamentohoras:= 0;
        departamentomonto:= 0;
        while aux.departamento = departamento do
          begin
            division:= aux.division;
            writeln('division: ', division);
            divisionhoras:= 0;
            divisionmonto:= 0;
            while (aux.departamento = departamento) and (aux.division = division) do
              begin
                numero:= aux.numero;
                precio:= a[aux.categoria];
                empleadohoras:= 0;
                empleadomonto:= 0;
                while (aux.departamento = departamento) and (aux.division = division) and (aux.numero = numero) do
                  begin
                    empleadohoras:= empleadohoras + aux.horas;
                    leer(m, aux);
                  end;
                empleadomonto:= empleadohoras * precio;
                writeln('numero de empleado: ', numero, ' total de horas: ', empleadohoras, ' importe a cobrar: ', empleadomonto);
                divisionhoras:= divisionhoras + empleadohoras;
                divisionmonto:= divisionmonto + empleadomonto;
              end;
            writeln('total de horas division: ', divisionhoras);
            writeln('monto total por division: 	', divisionmonto);
            departamentohoras:= departamentohoras + divisionhoras;
            departamentomonto:= departamentomonto + divisionmonto;
          end;
        writeln('total de horas departamento: ', departamentohoras);
        writeln('monto total departamento: ', departamentomonto);
      end;
    close(m);
  end;
var
  arreglo: valorhora;
  m: maestro;
begin
  cargararreglo(arreglo);
  mostar(m, arreglo);
end.
