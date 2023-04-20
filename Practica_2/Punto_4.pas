{. Suponga que trabaja en una oficina donde está montada una LAN (red local). La misma
fue construida sobre una topología de red que conecta 5 máquinas entre sí y todas las
máquinas se conectan con un servidor central. Semanalmente cada máquina genera un
archivo de logs informando las sesiones abiertas por cada usuario en cada terminal y por
cuánto tiempo estuvo abierta. Cada archivo detalle contiene los siguientes campos:
cod_usuario, fecha, tiempo_sesion. Debe realizar un procedimiento que reciba los archivos
detalle y genere un archivo maestro con los siguientes datos: cod_usuario, fecha,
tiempo_total_de_sesiones_abiertas.
Notas:
- Cada archivo detalle está ordenado por cod_usuario y fecha.
- Un usuario puede iniciar más de una sesión el mismo día en la misma o en diferentes
máquinas.
- El archivo maestro debe crearse en la siguiente ubicación física: /var/log.}
program inicia_el_infierno_4;
const
  valoralto = 9999;
type
  datos = record
    cod: integer;
    fecha: integer;
    tiempototal: integer;  
  end;
  datosdetalle = record
    cod: integer;
    fecha: integer;
    tiempo: integer;
  end;
  maestro = file of datos;
  detalle = file of datosdetalle;
  computadoras = array [6..10] of detalle;
  computadorasaux = array [6..10] of datosdetalle;
procedure creardetalle (var ad: detalle);
  var
    dd: datosdetalle;
    i: integer;
    istring: string;
  procedure leerproducto (var dd: datosdetalle);
    begin
      writeln('codigo:');
      readln(dd.cod);
      if dd.cod <> -1 then
        begin  
          readln (dd.fecha);
          dd.tiempo:= Random(11);
          writeln ('Codigo: ', dd.cod, ' fecha: ', dd.fecha, ' tiempo: ', dd.tiempo);
        end;
    end;
  begin
    for i:= 6 to 10 do
      begin
        str (i, istring);
	    assign (ad, 'detalles'+istring+'');
    	rewrite(ad);
	    leerproducto(dd);
	    while dd.cod <> -1 do
	      begin
	        write(ad, dd);
	        leerproducto(dd);
	      end;
	    close(ad);
	  end;
  end;
procedure crearmaestro (var m: maestro; var c: computadoras);
  var
    istring: string;
    i: integer;
    min: datosdetalle;
    acum: datos;
    caux: computadorasaux;
  procedure leer (var ad: detalle; var d: datosdetalle);
    begin
      if not eof(ad) then
        read(ad, d)
      else
        d.cod := valoralto;
    end;
  procedure minimo (var c: computadoras; var caux: computadorasaux; var min: datosdetalle);
    var
      i: integer;
      maxi: integer;
    begin
      min.cod:= valoralto;
      min.fecha:= valoralto;	
      for i:= 6 to 10 do
        if (caux[i].cod < min.cod) and (caux[i].fecha < min.fecha) then
          begin
            min:= caux[i];
            maxi:= i;
          end;
      if min.cod <> valoralto then
        leer(c[maxi], caux[maxi]);
    end;
  begin
    for i := 6 to 10 do
      begin
        str(i, istring);
        assign (c[i], 'detalles'+istring+'');
        reset(c[i]);
        leer(c[i], caux[i]);
      end;
    assign (m, 'maestro');
    rewrite(m);
    minimo (c, caux, min);
    while min.cod <> valoralto do
      begin
        acum.cod:= min.cod;
        while min.cod = acum.cod do
          begin
            acum.fecha:= min.fecha;
            acum.tiempototal:= 0;
            while (min.cod = acum.cod) and (min.fecha = acum.fecha) do
              begin
                acum.tiempototal := acum.tiempototal + min.tiempo;
                minimo(c, caux, min);
              end;	
            write(m, acum);
          end;     
      end;
    close(m);
    for i:= 6 to 10 do
      begin
        close(c[i]);
      end;
  end;
var
  am: maestro;
  ad: detalle;
  compus: computadoras;
begin
  creardetalle(ad);
  crearmaestro(am, compus);
end.
