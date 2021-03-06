    /* iniciar com ?- inicio.     */

inicio :- hipotese(Animal),
      write('Eu acho que o seu animal é: '),
      write(Animal),
      nl,
      write('Eu acertei?'),
      read(Resposta),
      ( (Resposta = sim ; Resposta =s)
        ->
         write('Eu Sabia!');
         write('Que pena...'), 
         nl, 
         write('Qual seria o nome deste animal?'),
         read(Nome),
         write('Qual caracteristica nao dita que o animal tem?'),
         read(Caracteristica),
         adiciona(Nome, Caracteristica), 
         write('Da proxima vez, saberei!')),
      nl,
      undo.

/* hipoteses a serem testadas */
hipotese(leao)     :- leao, !.
hipotese(tigre)     :- tigre, !.
hipotese(girafa)   :- girafa, !.
hipotese(zebra)     :- zebra, !.
hipotese(avestruz)   :- avestruz, !.
hipotese(pinguim)   :- pinguim, !.
hipotese(desconhecido).             /* sem conhecimento */

/* parte não funcional
adiciona(Animal, Caracteristica):-
  sims([], Clausulas),
  listaPraTupla(Clausulas, ListaDeClausulas),
  head = hipotese(Animal),
  dynamic(head),
  body = (ListaDeClausulas, Caracteristica),
  asserta(head :- (Animal, !)),
  assert(Animal:- body).


sims(Lista, Final):-
  sim(Clausula),
  retract(sim(Clausula)),
  sims([Lista|verifica(Clausula)], Final).

sims(Lista, Lista).

listaPraTupla([X], X).
listaPraTupla([H|T], (H, Resto)) :-
  listaPraTupla(T, Resto). 
 */

/* regras de identificação */
leao :- mamifero,
        carnivoro,
        verifica("vive nas savanas").
tigre :- mamifero,
         carnivoro,
         listrado.
girafa :- ruminante,
          verifica("tem pescoço longo").
zebra :- ruminante,
         listrado.
avestruz :- ave,
            verifica("tem pescoço longo").
pinguim :- ave,
           verifica("não sabe voar"),
           verifica("sabe nadar").

mamifero :- verifica("é um mamífero").
ruminante :- verifica("é um ruminante").
ave :- verifica("é uma ave").
carnivoro :- verifica("é carnivoro").
listrado :- verifica("tem listras").

/* como se pergunta algo */
pergunta(Questao) :-
    write('O seu animal tem a seguinte caracteristica: '),
    write(Questao),
    write('? '),
    read(Resposta),
    nl,
    ( (Resposta == sim ; Resposta == s)
      ->
       assert(sim(Questao));
       assert(nao(Questao)), fail).

:- dynamic sim/1,nao/1.

/* Como se verifica algo */
verifica(S) :-
   (sim(S)
    ->
    true ;
    (nao(S)
     ->
     fail ;
     pergunta(S))).

/* disfaz sim/nao */
undo :- retract(sim(_)),fail.
undo :- retract(nao(_)),fail.
undo.
