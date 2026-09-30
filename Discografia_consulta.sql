select count (cancion.id) as canciones_de_juanes
from compositor
inner join cancioncompositor on compositor.id = cancioncompositor.idcompositor
inner join cancion on cancioncompositor.idcancion  = cancion.id
where charindex(upper ('Juanes'),(upper (compositor.nombre))) > 0  ;

select  interprete.nombre as interprete, ritmo.ritmo as ritmo
from cancion
inner join interpretacion on interpretacion.idcancion = cancion.id
inner join ritmo on interpretacion.idritmo = ritmo.id
inner join interprete on interpretacion.idinterprete = interprete.id
where cancion.titulo = 'lluvia';

select cancion.titulo as Cancion
from cancion
inner join interpretacion on interpretacion.idcancion = cancion.id
inner join ritmo on interpretacion.idritmo = ritmo.id
inner join interprete on interpretacion.idinterprete = interprete.id
inner join tipo on interprete.idtipo = tipo.id
inner join cancioncompositor on cancioncompositor.idcancion = cancion.id
inner join compositor on cancioncompositor.idcompositor = compositor.id
where ritmo.ritmo = 'balada'
and tipo.tipo = 'solista'
and charindex (upper ( interprete.nombre) , (upper ( compositor.nombre))) > 0;

select pais.nombre as pais
from pais
inner join interprete on pais.id = interprete.idpais
inner join tipo on interprete.idtipo = tipo.id
inner join interpretacion on interprete.id = interpretacion.idinterprete
inner join ritmo on interpretacion.idritmo = ritmo.id
where ritmo.ritmo = 'salsa'
and tipo.tipo = 'grupo'
group by pais.nombre;

--como la pregunta no especifica, entonces: interprete que canta las dos canciones (y)--

select distinct interprete.nombre as interprete
from interprete
inner join interpretacion on interprete.id = interpretacion.idinterprete
inner join cancion on interpretacion.idcancion = cancion.id
where cancion.titulo in ( 'Candilejas' , 'Malaguena')
group by interprete.id , interprete.nombre
having count(distinct cancion.titulo) = 2;

--interprete que canta aunque sea una sola cancion (o)--

select distinct interprete.nombre as interprete
from interprete
inner join interpretacion on interprete.id = interpretacion.idinterprete
inner join cancion on interpretacion.idcancion = cancion.id
where cancion.titulo in ( 'Candilejas' , 'Malaguena');


select interprete.nombre as artista,
(select count ( cancioncompositor.idcancion)
from cancioncompositor
   inner join compositor on cancioncompositor.idcompositor = compositor.id
   where charindex ( upper ( interprete.nombre ), upper ( compositor.nombre)) > 0 ) as compuestas,
   (select count ( interpretacion.idcancion)
   from interpretacion
   where interpretacion.idinterprete = interprete.id ) as interpretadas
from interprete 
where exists (select 1
from compositor 
where charindex ( upper ( interprete.nombre ), upper ( compositor.nombre)) > 0 );
