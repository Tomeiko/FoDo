{Se desea modelar la información necesaria para un sistema de recuentos de casos de
covid para el ministerio de salud de la provincia de buenos aires.
Diariamente se reciben archivos provenientes de los distintos municipios, la información
contenida en los mismos es la siguiente: código de localidad, código cepa, cantidad casos
activos, cantidad de casos nuevos, cantidad de casos recuperados, cantidad de casos
fallecidos.
El ministerio cuenta con un archivo maestro con la siguiente información: código localidad,
nombre localidad, código cepa, nombre cepa, cantidad casos activos, cantidad casos
nuevos, cantidad recuperados y cantidad de fallecidos.
Se debe realizar el procedimiento que permita actualizar el maestro con los detalles
recibidos, se reciben 10 detalles. Todos los archivos están ordenados por código de
localidad y código de cepa.
Para la actualización se debe proceder de la siguiente manera:
1. Al número de fallecidos se le suman el valor de fallecidos recibido del detalle.
2. Idem anterior para los recuperados.
3. Los casos activos se actualizan con el valor recibido en el detalle.
4. Idem anterior para los casos nuevos hallados.
Realice las declaraciones necesarias, el programa principal y los procedimientos que
requiera para la actualización solicitada e informe cantidad de localidades con más de 50
casos activos (las localidades pueden o no haber sido actualizadas).}
program inicia_el_infierno_6;
const
  valoralto = 9999;
  tamano = 3;
type
  casosdetalle = record
    localidad: integer;
    cepa: integer;
    activos: integer;
    nuevos: integer;
    recuperados: integer;
    fallecidos: integer;
  end;
  casosmaestro = record
    localidad: integer;
    nombrelocalidad: string;
    cepa: integer;
    nombrecepa: string;
    activos: integer;
    nuevos: integer;
    recuperados: integer;
    fallecidos: integer;
  end;
  maestro = file of casosmaestro;
  detalle = file of casosdetalle;
  arraydetalle = array [1..tamano] of detalle;
  arrayaux = array [1..tamano] of casosdetalle;
procedure generardetalles(var ad: arraydetalle);
  procedure leer (var aux: casosdetalle);
    begin
      with aux do
        begin
          writeln('codigo de localidad: ');
          readln(localidad);
          if localidad <> -1 then
            begin
              writeln('codigo de cepa: ');
              readln(cepa);
              activos:= Random(100);
              nuevos:= Random(100);
              recuperados:= Random(100);
              fallecidos:= Random(100);
              writeln('localidad: ', localidad, ' cepa: ', cepa, ' activos: ', activos, ' nuevos: ', nuevos, ' recuperados: ', recuperados, ' fallecidos: ', fallecidos);
            end;
        end;
    end;
  var
    aux: casosdetalle;
    iString:String;
    i:integer;
  begin
    for i:= 1 to tamano do begin
        Str(i, iString);
        assign(ad[i], ('detalle'+istring+''));
        rewrite(ad[i]);
        leer(aux);
        while (aux.localidad <> -1) do
          begin
            write(ad[i], aux);
            leer(aux);
          end;
        close(ad[i]);
    end;
  end;
procedure crearmaestro(var m: maestro);
  procedure leer (var aux: casosmaestro);
    begin
      with aux do
        begin
          writeln('codigo de localidad y luego nombre: ');
          readln(localidad);
          if localidad <> -1 then
            begin
              readln (nombrelocalidad);
              writeln('codigo de cepa y luego nombre: ');
              readln(cepa);
              readln(nombrecepa);
              activos:= Random(100);
              nuevos:= Random(100);
              recuperados:= Random(100);
              fallecidos:= Random(100);
              writeln('localidad: ', localidad, 'nombre de la localidad: ', nombrelocalidad, ' cepa: ', cepa, 'nombre de la cepa: ', nombrecepa, ' activos: ', activos, ' nuevos: ', nuevos, ' recuperados: ', recuperados, ' fallecidos: ', fallecidos);
            end;
        end;
    end;
  var
    aux: casosmaestro;
  begin
      assign(m, 'maestro');
      rewrite(m);
      leer(aux);
      while (aux.localidad <> -1) do
        begin
          write(m, aux);
          leer(aux);
        end;
      close(m);
  end;
procedure actualizarmaestro (var m: maestro; var ad: arraydetalle);
  procedure leer (var ad: detalle; var aux: casosdetalle);
    begin
      if not eof(ad) then
        read(ad, aux)
      else
        begin
          aux.localidad := valoralto;
          aux.cepa := valoralto;
        end;
    end;
  procedure minimo (var ad: arraydetalle; var adaux: arrayaux; var min: casosdetalle);
    var 
      i: integer;
      maxi: integer;
    begin
      min.localidad := valoralto;
      min.cepa := valoralto;
      for i := 1 to tamano do
        if (adaux[i].localidad  < min.localidad) and (adaux[i].cepa  <= min.cepa) then
          begin
            min := adaux[i];
            maxi:= i;
          end;
      if (valoralto <> min.localidad) and (valoralto <> min.cepa) then
        leer (ad[maxi], adaux[maxi]);
    end;
  var
    i: integer;
    istring: string;
    adaux: arrayaux;
    min: casosdetalle;
    aux: casosmaestro;
  begin
    for i:= 1 to tamano do
      begin
        str(i, istring);
        assign(ad[i], 'detalle'+istring+'');
        reset(ad[i]);
        leer(ad[i], adaux[i]);
      end;
    assign (m, 'maestro');
    reset(m);
    minimo(ad, adaux, min);
    read(m, aux);
    while min.localidad <> valoralto do
      begin
        while min.localidad <> aux.localidad do
          read(m, aux);
        while min.localidad = aux.localidad do
          begin
            while min.cepa <> aux.cepa do
              read(m, aux);
            while (min.localidad = aux.localidad) and (min.cepa = aux.cepa) do
              begin
                aux.fallecidos:= aux.fallecidos + min.fallecidos;
                aux.recuperados:= aux.recuperados + min.recuperados;
                aux.activos:= min.activos;
                aux.nuevos:= min.nuevos;
                minimo(ad, adaux, min);
              end;
            seek(m, filePos(m)-1);
            write(m, aux);
          end;
      end;
    close(m);
    for i:= 1 to tamano do
      close(ad[i]);
  end;
var
  ad: arraydetalle;
  m: maestro;
begin
  Randomize();
  generardetalles(ad);
  crearmaestro(m);
  actualizarmaestro(m, ad);
end.
