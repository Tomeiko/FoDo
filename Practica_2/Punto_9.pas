{Se necesita contabilizar los votos de las diferentes mesas electorales registradas por
provincia y localidad. Para ello, se posee un archivo con la siguiente información: código de
provincia, código de localidad, número de mesa y cantidad de votos en dicha mesa.
Presentar en pantalla un listado como se muestra a continuación:
Código de Provincia
Código de Localidad Total de Votos
................................ ......................
................................ ......................
Total de Votos Provincia: ____
Código de Provincia
Código de Localidad Total de Votos
................................ ......................
Total de Votos Provincia: ___
…………………………………………………………..
Total General de Votos: ___
NOTA: La información se encuentra ordenada por código de provincia y código de
localidad.}
program inicia_el_infierno_9;
const
  valoralto = 'ZZZZ';
type
  votos = record
    provincia: string;
    localidad: string;
    numeromesa: integer;
    cantmesa: integer;
  end;
  maestro = file of votos;
procedure presentacion(var m: maestro);
  procedure leer(var m: maestro; var aux: votos);
    begin
      if not eof(m) then
        read(m, aux)
      else
        aux.provincia:= 'ZZZZ';
    end;
  var
    aux: votos;
    provincia: string;
    localidad: string;
    totallocalidad: integer;
    totalprovincia: integer;
    totaltotal: integer;
  begin
    assign(m, 'maestro');
    reset(m);
    leer(m, aux);
    totaltotal:= 0;
    while aux.provincia <> 'ZZZZ' do
      begin
        provincia:= aux.provincia;
        writeln('codigo de provincia', provincia);
        totalprovincia:= 0;
        while aux.provincia = provincia do
          begin
            localidad:= aux.localidad;
            writeln('codigo de localidad', localidad);
            totallocalidad:= 0;
            while (aux.provincia = provincia) and (aux.localidad = localidad) do
              begin
                totallocalidad:= totallocalidad + aux.cantmesa;
                leer(m, aux);
              end;
            writeln('total de votos: ', totallocalidad);
            totalprovincia:= totalprovincia + totallocalidad;
          end;
        writeln('total de votos provincia: ', totalprovincia);
        totaltotal:= totaltotal + totalprovincia;
      end;
    writeln('total general de votos: ', totaltotal);
    close(m);
  end;
var
  m: maestro;
begin
  presentacion(m);
end.
