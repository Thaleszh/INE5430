    /* iniciar com ?- inicio.     */

inicio :- hipotese(Animal),
      write('Eu acho que o seu animal é: '),
      write(Animal),
      nl,
      undo.

/* hipoteses a serem testadas */
hipotese(tigre)     :- tigre, !.
hipotese(girafa)   :- girafa, !.
hipotese(zebra)     :- zebra, !.
hipotese(avestruz)   :- avestruz, !.
hipotese(penguin)   :- penguin, !.
hipotese(unknown).             /* no diagnosis */

adiciona(Animal):-
  sims([], Clausulas),
  listaPraTupla(Clausulas, ListaDeClausulas),
  assert(hipotese(Animal):- Animal, !),
  assert(Animal:- ListaDeClausulas).


sims(Lista, Final):-
  sim(Clausula),
  retract(sim(Clausula))
  sims([Lista|verifica(Clausula)], Final).

sims(Lista, Lista).

listaPraTupla([X], X).
listaPraTupla([H|T], (H, Resto)) :-
  listaPraTupla(T, Resto).

/* regras de identificação */
leao :- mamifero,
        carnivoro,
        verifica("vive nas savanas").
tigre :- mamifero,
         carnivoro.
         verifica("tem listras").
girafa :- ruminante,
          verifica("tem pescoço longo").
zebra :- ruminante,
         verifica("tem listras").
avestruz :- ave,
            verifica("tem pescoço longo").
pinguim :- ave,
           verifica("não sabe voar"),
           verifica("sabe nadar").

mamifero :- verifica("é um mamífero").
ruminante :- verifica("é um ruminante").
ave :- verifica("é uma ave").
carnivoro :- verifica("é carnivoro")

/* como se pergunta algo */
pergunta(Questão) :-
    write('O seu animal tem a seguinte caracteristica: '),
    write(Questão,
    write('? '),
    read(Resposta),
    nl,
    ( (Resposta == yes ; Resposta == y)
      ->
       assert(yes(Question)) ;
       assert(no(Question)), fail).

:- dynamic yes/1,no/1.

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
