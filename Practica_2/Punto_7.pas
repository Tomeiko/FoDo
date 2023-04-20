{El encargado de ventas de un negocio de productos de limpieza desea administrar el
stock de los productos que vende. Para ello, genera un archivo maestro donde figuran todos
los productos que comercializa. De cada producto se maneja la siguiente información:
código de producto, nombre comercial, precio de venta, stock actual y stock mínimo.
Diariamente se genera un archivo detalle donde se registran todas las ventas de productos
realizadas. De cada venta se registran: código de producto y cantidad de unidades vendidas.
Se pide realizar un programa con opciones para:
a. Actualizar el archivo maestro con el archivo detalle, sabiendo que:
● Ambos archivos están ordenados por código de producto.
● Cada registro del maestro puede ser actualizado por 0, 1 ó más registros del
archivo detalle.
● El archivo detalle sólo contiene registros que están en el archivo maestro.
b. Listar en un archivo de texto llamado “stock_minimo.txt” aquellos productos cuyo
stock actual esté por debajo del stock mínimo permitido.}
program inicia_el_infierno_7;
const
  valoralto = 9999;
type
  producto = record
    codigo: integer;
    nombre: string;
    precio: integer;
    actual: integer;
    minimo: integer;
  end;
  venta = record
    codigo: integer;
    vendidos: integer;
  end;
  maestro = file of producto;
  detalle = file of venta;
procedure actualizar (var m: maestro; var d: detalle);
  procedure leer (var d: detalle; var aux: venta);
    begin
      if not eof(d) then
        read(d, aux)
      else
        aux.codigo:= valoralto;
    end;
  var
    acumulador: producto;
    aux: venta;
  begin
    assign (m, 'maestro');
    assign (d, 'detalle');
    reset(m);
    reset(d);
    leer(d, aux);
    read(m, acumulador);
    while aux.codigo <> valoralto do
      begin
        while acumulador.codigo <> aux.codigo do
          read(m, acumulador);
        while acumulador.codigo = aux.codigo do
          begin
            acumulador.actual:= acumulador.actual - aux.vendidos;
            leer(d, aux);
          end;
        seek(m, filepos(m)-1);
        write (m, acumulador);
      end;
    close(m);
    close(d);
  end;
procedure creartxt (var m: maestro);
  var
    txt: text;
    aux: producto;
  begin
    assign(txt, 'texto');
    rewrite(txt);
    assign(m, 'maestro');
    reset(m);
    while not eof(m) do
      begin
        read(m, aux);
        with aux do
          if actual < minimo then
            write(txt, ' codigo: ', codigo, ' nombre: ', nombre, ' precio: ', precio, ' actual: ', actual, ' minimo: ', minimo);
      end;
    close(m);
    close(txt);
  end;
var
  m: maestro;
  d: detalle;
begin
  actualizar (m, d);
  creartxt(m);
end.
