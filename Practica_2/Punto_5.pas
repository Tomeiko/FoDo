{A partir de un siniestro ocurrido se perdieron las actas de nacimiento y fallecimientos de
toda la provincia de buenos aires de los últimos diez años. En pos de recuperar dicha
información, se deberá procesar 2 archivos por cada una de las 50 delegaciones distribuidas
en la provincia, un archivo de nacimientos y otro de fallecimientos y crear el archivo maestro
reuniendo dicha información.
Los archivos detalles con nacimientos, contendrán la siguiente información: nro partida
nacimiento, nombre, apellido, dirección detallada (calle,nro, piso, depto, ciudad), matrícula
del médico, nombre y apellido de la madre, DNI madre, nombre y apellido del padre, DNI del
padre.
En cambio, los 50 archivos de fallecimientos tendrán: nro partida nacimiento, DNI, nombre y
apellido del fallecido, matrícula del médico que firma el deceso, fecha y hora del deceso y
lugar.
Realizar un programa que cree el archivo maestro a partir de toda la información de los
archivos detalles. Se debe almacenar en el maestro: nro partida nacimiento, nombre,
apellido, dirección detallada (calle,nro, piso, depto, ciudad), matrícula del médico, nombre y
apellido de la madre, DNI madre, nombre y apellido del padre, DNI del padre y si falleció,
además matrícula del médico que firma el deceso, fecha y hora del deceso y lugar. Se
deberá, además, listar en un archivo de texto la información recolectada de cada persona.}
program inicia_el_infierno_5;
const
  valoralto = 32767;
  tamano = 3;
type
  dirdetallada = record
      calle: string;
      numero: integer;
      piso: integer;
      dpto: string;
      ciudad: string;
  end; 
  nacimientos = record
    partida: integer;
    nombre: string;
    apellido: string;
    direccion: dirdetallada;
    matriculavivo: string;
    madre: string;
    dnimadre: string;
    padre: string;
    dnipadre: string;
  end; 
  fallecimientos = record
    partida: integer;
    dni: string;
    nombre: string;
    apellido: string;
    matriculamuerto: string;
    fecha: string;
    hora: double;
    lugar: string;
  end; 
  persona = record
    nacer: nacimientos;
    fallecido: boolean;
    matriculamuerto: string;
    fecha: string;
    hora: real;
    lugar: string; 
  end;
  maestro = file of persona;
  detallen = file of nacimientos;
  detallef = file of fallecimientos;
  vectorn = array [1..tamano] of detallen;
  vectorf = array [1..tamano] of detallef;
  vectornaux = array [1..tamano] of nacimientos;
  vectorfaux = array [1..tamano] of fallecimientos;
procedure generarNacimientos(var n:vectorn);
var
    aux: nacimientos;
    txt:Text;
    iString:String;
    i:integer;
begin
    for i:= 1 to tamano do begin
        Str(i, iString);
        assign(txt, 'nacimientos'+iString+'.txt');
        reset(txt);
        assign(n[i], ('nacimientos'+istring+''));
        rewrite(n[i]);
        while(not eof(txt)) do begin
            readln(txt, aux.partida, aux.nombre);
            readln(txt, aux.apellido);
            readln(txt, aux.direccion.calle);
            readln(txt, aux.direccion.numero, aux.direccion.piso, aux.direccion.dpto);   
            readln(txt, aux.direccion.ciudad);
            readln(txt, aux.matriculavivo);
            readln(txt, aux.madre);
            readln(txt, aux.dnimadre);
            readln(txt, aux.padre);
            readln(txt, aux.dnipadre);
            write(n[i], aux);
        end;
        close(n[i]);
        close(txt);
    end;
end;
procedure generarFallecimientos(var f:vectorf);
var
    aux: fallecimientos;
    txt:Text;
    iString:String;
    i:integer;
begin
    for i:= 1 to tamano do begin
        Str(i, iString);
        assign(txt, ('fallecimientos'+iString+'.txt'));
        reset(txt);
        assign(f[i], ('fallecimientos'+istring+''));
        rewrite(f[i]);
        while(not eof(txt)) do begin
            readln(txt, aux.partida, aux.dni);
            readln(txt, aux.nombre);
            readln(txt, aux.apellido);
            readln(txt, aux.matriculamuerto);
            readln(txt, aux.fecha);
            readln(txt, aux.hora);
            readln(txt, aux.lugar);
            write(f[i], aux);
        end;
        close(f[i]);
        close(txt);
    end;
end;
procedure crearmaestro (var m: maestro; var n: vectorn; var f: vectorf );
  procedure leern (var n: detallen; var nmin: nacimientos);
    begin
      if not eof(n) then
        read(n, nmin)
      else
        nmin.partida:= valoralto;
    end;
  procedure minimon (var n: vectorn; var naux: vectornaux; var nmin: nacimientos);
    var 
      i: integer;
      maxi: integer;
    begin
      nmin.partida := valoralto;
      for i := 1 to tamano do
        if naux[i].partida  < nmin.partida then
          begin
            nmin := naux[i];
            maxi:= i;
          end;
      if nmin.partida <> valoralto then
        leern (n[maxi], naux[maxi]);
    end;
  procedure leerf (var f: detallef; var fmin: fallecimientos);
    begin
      if not eof(f) then
        read(f, fmin)
      else
        fmin.partida := valoralto;
    end;
  procedure minimof (var f: vectorf; var faux: vectorfaux; var fmin: fallecimientos);
    var 
      i: integer;
      maxi: integer;
    begin
      fmin.partida := valoralto;
      for i := 1 to tamano do
        if faux[i].partida  < fmin.partida then
          begin
            fmin := faux[i];
            maxi:= i;
          end;
      if fmin.partida <> valoralto then
        leerf (f[maxi], faux[maxi]);
    end;
  var
    i: integer;
    istring: string;
    naux: vectornaux;
    faux: vectorfaux;
    nmin: nacimientos;
    fmin: fallecimientos;
    aux: persona;
  begin
    for i := 1 to tamano do
      begin
        str(i, istring);
        assign (n[i], 'nacimientos'+istring+'');
        assign (f[i], 'fallecimientos'+istring+'');
        reset(n[i]);
        reset(f[i]);
        leern(n[i], naux[i]);
        leerf(f[i], faux[i]);
      end;
    assign (m, 'maestro');
    rewrite (m);
    minimon (n, naux, nmin);
    minimof (f, faux, fmin);
    while nmin.partida <> valoralto do
      begin
        if nmin.partida <> fmin.partida then
          begin
            aux.nacer:= nmin;
            aux.fallecido:= false;
          end;
        if nmin.partida = fmin.partida then
          begin
            aux.nacer:= nmin;
            aux.fallecido:= true;
            aux.matriculamuerto:= fmin.matriculamuerto;
            aux.fecha:= fmin.fecha;
            aux.hora:= fmin.hora;
            aux.lugar:= fmin.lugar;
            minimof(f, faux, fmin);
          end;
        minimon (n, naux, nmin);
        write(m, aux);
      end;
  end;
procedure creartxt (var m: maestro);
var
  aux: persona;
  txt: text;
begin
  assign (m, 'maestro');
  reset(m);
  assign (txt, 'texto');
  rewrite(txt);
    while not eof(m) do
      begin
        read (m, aux);
        with aux do
          if aux.fallecido = true then
            writeln(txt, ' ', nacer.partida, ' ', nacer.nombre, ' ', nacer.apellido, ' ', nacer.direccion.ciudad, ' ', nacer.matriculavivo, ' ', nacer.madre, ' ', nacer.dnimadre, ' ', nacer.padre, ' ', nacer.dnipadre, ' ', fallecido, ' ', matriculamuerto, ' ', fecha, ' ', hora:2:2, ' ', lugar)
          else // (txt, ' ', nacer.partida, ' ', nacer.nombre, ' ', nacer.apellido, ' ', nacer.direccion.ciudad, ' ', nacer.matriculavivo, ' ', nacer.madre, ' ', nacer.dnimadre, ' ', nacer.padre, ' ', nacer.dnipadre, ' ', fallecido, ' ', matriculamuerto, ' ', fecha, ' ', hora, ' ', lugar);
            writeln (txt, ' ', nacer.partida, ' ', nacer.nombre, ' ', nacer.apellido, ' ', nacer.direccion.ciudad, ' ', nacer.matriculavivo, ' ', nacer.madre, ' ', nacer.dnimadre, ' ', nacer.padre, ' ', nacer.dnipadre, ' ', fallecido, ' ');
      end;
      close(txt);
      close(m);
  end;
var
  fallecidos: vectorf;
  nacidos: vectorn;
  humanos: maestro;
begin
  generarNacimientos(nacidos);
  generarFallecimientos(fallecidos);
  crearmaestro(humanos, nacidos, fallecidos);
  creartxt(humanos);
end.
