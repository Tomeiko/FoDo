{Se cuenta con un archivo de productos de una cadena de venta de alimentos congelados.
De cada producto se almacena: código del producto, nombre, descripción, stock disponible,
stock mínimo y precio del producto.
Se recibe diariamente un archivo detalle de cada una de las 30 sucursales de la cadena. Se
debe realizar el procedimiento que recibe los 30 detalles y actualiza el stock del archivo
maestro. La información que se recibe en los detalles es: código de producto y cantidad
vendida. Además, se deberá informar en un archivo de texto: nombre de producto,
descripción, stock disponible y precio de aquellos productos que tengan stock disponible por
debajo del stock mínimo.
Nota: todos los archivos se encuentran ordenados por código de productos. En cada detalle
puede venir 0 o N registros de un determinado producto}
program inicia_el_infierno_3;
const
  valoralto = 9999;
type
  producto = record
    codigo: integer;
    nombre: string;
    descripcion: string;
    disponible: integer;
    minimo: integer;
    precio: real;
  end;
  productodetalle = record
    codigo: integer;
    vendidos: integer;
  end;
  maestro = file of producto;
  detalle = file of productodetalle;
  sucursales = array [1..30] of detalle;
  sucuaux = array [1..30] of productodetalle;
procedure crearmaestro (var a: maestro);
  var
    p: producto;
  procedure leerproducto (var p: producto);
    begin
      readln(p.codigo);
      if p.codigo <> -1 then
        begin  
          readln(p.nombre);
          readln(p.descripcion);
          p.minimo:= Random(100);
          p.disponible:= Random(100) + p.minimo;
          p.precio:= Random(100);
          writeln ('Codigo: ', p.codigo, ' Nombre: ', p.nombre, ' Descripcion: ', p.descripcion, ' Disponible: ', p.disponible, ' Minimo: ', p.minimo, ' Precio: ', p.precio:2:2);
        end;
    end;
  begin
	assign (a, 'productos');
	rewrite(a);
	leerproducto(p);
	while p.codigo <> -1 do
	  begin
	    write(a, p);
	    leerproducto(p);
	  end;
	close(a);
  end;
procedure creardetalle (var a: detalle);
  var
    p: productodetalle;
  procedure leerproducto (var p: productodetalle);
    begin
      readln(p.codigo);
      if p.codigo <> -1 then
        begin  
          p.vendidos:= Random(3);
          writeln ('Codigo: ', p.codigo, ' Vendidos: ', p.vendidos);
        end;
    end;
  begin
	assign (a, 'detalles1');
	rewrite(a);
	leerproducto(p);
	while p.codigo <> -1 do
	  begin
	    write(a, p);
	    leerproducto(p);
	  end;
	close(a);
  end;
procedure actualizar (var m: maestro; var s: sucursales);
  var
    i: integer;
    p: productodetalle;
    istring: string;
    actualizar: producto;
    saux: sucuaux;
  procedure leerdetalle (var a: detalle; var p: productodetalle);
    begin
      if not eof(a) then
        read(a, p)
      else
        p.codigo := valoralto;
    end;
  procedure minimo (var s: sucursales; var saux: sucuaux; var p: productodetalle);
    var 
      i: integer;
      maxi: integer;
    begin
      p.codigo := valoralto;
      for i := 1 to 30 do
        if saux[i].codigo  < p.codigo then
          begin
            p := saux[i];
            maxi:= i;
          end;
      if p.codigo <> valoralto then
        leerdetalle (s[maxi], saux[maxi]);
    end;
  begin 
    for i := 1 to 30 do
      begin
        str(i, istring);
        assign (s[i], 'detalles'+istring+'');
        reset(s[i]);
        leerdetalle (s[i], saux[i]);
      end;
    assign (m, 'productos');
    reset (m);
    minimo(s, saux, p);
    while (p.codigo <> valoralto) do
      begin
        read (m, actualizar);
        while(actualizar.codigo <> p.codigo) do 
          read(m, actualizar);
        while p.codigo = actualizar.codigo do
          begin
            actualizar.disponible:= actualizar.disponible - p.vendidos;
            minimo(s, saux, p);
          end;
        seek(m, filepos(m)-1);
        write(m, actualizar);
      end;
    close(m);
    for i := 1 to 30 do
      begin
        close(s[i]);
      end;
  end;
procedure creartxt (var m: maestro);
var
  aux: producto;
  txt: text;
begin
  assign (m, 'productos');
  reset(m);
  assign (txt, 'texto');
  rewrite(txt);
    while not eof(m) do
      begin
        read (m, aux);
        if aux.disponible < aux.minimo then
          begin
            write (txt, 'Codigo: ', aux.codigo, ' Nombre: ', aux.nombre, ' Descripcion: ', aux.descripcion, ' Disponible: ', aux.disponible, ' Minimo: ', aux.minimo, ' Precio: ', aux.precio:2:2, ' ||| ');
          end;
      end;
      close(txt);
      close(m);
  end;
var
  archm: maestro;
  //archd: detalle;
  sucu: sucursales;
begin
  //crearmaestro(archm);
  //creardetalle(archd);   
  actualizar (archm, sucu);
  creartxt (archm);
end.
