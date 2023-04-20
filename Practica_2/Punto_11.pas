{A partir de información sobre la alfabetización en la Argentina, se necesita actualizar un
archivo que contiene los siguientes datos: nombre de provincia, cantidad de personas
alfabetizadas y total de encuestados. Se reciben dos archivos detalle provenientes de dos
agencias de censo diferentes, dichos archivos contienen: nombre de la provincia, código de
localidad, cantidad de alfabetizados y cantidad de encuestados. Se pide realizar los módulos
necesarios para actualizar el archivo maestro a partir de los dos archivos detalle.
NOTA: Los archivos están ordenados por nombre de provincia y en los archivos detalle
pueden venir 0, 1 ó más registros por cada provincia.}
program inicia_el_infierno_11;
const
  valoralto = 'ZZZZ';
type
  encuesta = record
    provincia: string;
    alfabeta: integer;
    encuestados: integer;
  end;
  encuestadetalle = record
    provincia: string;
    localidad: integer;
    alfabeta: integer;
    encuestados: integer;
  end;
  maestro = file of encuesta;
  detalle = file of encuestadetalle;
procedure actualizar(var m: maestro; var d1: detalle; var d2: detalle);
  procedure leer(var d: detalle; var aux: encuestadetalle);
    begin
      if not eof(d) then
        read(d, aux)
      else
        aux.provincia:= valoralto;
    end;
  procedure minimo (var d1: detalle; var d2: detalle; var aux1: encuestadetalle; var aux2: encuestadetalle; var min: encuestadetalle);
    begin
      if aux1.provincia < aux2.provincia then
        begin
          min:= aux1;
          leer(d1, aux1);
        end
      else
        begin
          min:= aux2;
          leer(d2, aux2);
        end;
    end;
  var
    acumulador: encuesta;
    aux1: encuestadetalle;
    aux2: encuestadetalle;
    min: encuestadetalle;
  begin
    assign(m, 'maestro');
    assign(d1, 'detalle1');
    assign(d2, 'detalle2');
    leer(d1, aux1);
    leer(d2, aux2);
    read(m, acumulador);
    minimo(d1, d2, aux1, aux2, min);
    while min.provincia <> valoralto do
      begin
        while min.provincia <> acumulador.provincia do
          read(m, acumulador);
        while min.provincia = acumulador.provincia do
          begin
            acumulador.alfabeta:= acumulador.alfabeta + min.alfabeta;
            acumulador.encuestados:= acumulador.encuestados + min.encuestados;
            minimo(d1, d2, aux1, aux2, min);
          end;
        seek(m, filepos(m)-1);
        write(m, acumulador);
      end;
    close(m);
    close(d1);
    close(d2);
  end;
var
  m: maestro;
  d1: detalle;
  d2: detalle;
begin
  actualizar(m, d1, d2);
end.
