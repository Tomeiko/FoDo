{Se cuenta con un archivo que posee información de las ventas que realiza una empresa a
los diferentes clientes. Se necesita obtener un reporte con las ventas organizadas por
cliente. Para ello, se deberá informar por pantalla: los datos personales del cliente, el total
mensual (mes por mes cuánto compró) y finalmente el monto total comprado en el año por el
cliente.
Además, al finalizar el reporte, se debe informar el monto total de ventas obtenido por la
empresa.
El formato del archivo maestro está dado por: cliente (cod cliente, nombre y apellido), año,
mes, día y monto de la venta.
El orden del archivo está dado por: cod cliente, año y mes.
Nota: tenga en cuenta que puede haber meses en los que los clientes no realizaron
compras.}
program inicia_el_infierno_8;
type
  datocliente = record
    codigo: integer;
    nombre: string;
    apellido: string;
  end;
  informacion = record
    cliente: datocliente;
    anio: integer;
    mes: string;
    dia: integer;
    monto: real;
  end;
  maestro = file of informacion;
procedure informar (var m: maestro);
  var
    dato: informacion;
    aux: informacion;
    total: real;
    anual: real;
  begin
    assign(m, 'maestro');
    reset(m);
    read(m, dato);
    total:= 0;
    while not eof(m) do
      begin
        writeln('codigo del cliente: ', dato.cliente.codigo, 'nombre del cliente: ', dato.cliente.nombre, 'apellido del cliente: ',dato.cliente.apellido);
        aux.cliente.codigo:= dato.cliente.codigo;
        while aux.cliente.codigo = dato.cliente.codigo do
          begin
            anual:= 0;
            aux.anio:= dato.anio;
            while (aux.cliente.codigo = dato.cliente.codigo) and (aux.anio = dato.anio) do
              begin
                aux.monto:= 0;
                aux.mes:= dato.mes;
                while (aux.cliente.codigo = dato.cliente.codigo) and (aux.anio = dato.anio) and (aux.mes = dato.mes) do
                  begin
                    aux.monto:= aux.monto + dato.monto;
                    read(m, dato);
                  end;
                anual:= anual + aux.monto;
                writeln('monto del cliente este mes: ', aux.monto:2:2);
              end;
            total:= total + anual;
            writeln('monto del cliente este anio: ', anual:2:2);
          end;      
      end;
    close(m);
    writeln('monto total de la empresa: ', total:2:2);
  end;
var
  m: maestro;
begin
  informar(m);
end.
