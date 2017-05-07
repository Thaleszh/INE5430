    /* iniciar com ?- inicio.     */

inicio :- hipotese(Animal),
      write('Eu acho que o seu animal é: '),
      write(Animal),
      nl,
      undo.

/* hipoteses a serem testadas */
hipotese(leao)     :- leao, !.
hipotese(tigre)     :- tigre, !.
hipotese(girafa)   :- girafa, !.
hipotese(zebra)     :- zebra, !.
hipotese(avestruz)   :- avestruz, !.
hipotese(pinguim)   :- penguin, !.
hipotese(desconhecido).             /* no diagnosis */

adiciona(Animal):-
  sims([], Clausulas),
  listaPraTupla(Clausulas, ListaDeClausulas),
  asserta(hipotese(Animal):- Animal, !),
  assert(Animal:- ListaDeClausulas).


sims(Lista, Final):-
  sim(Clausula),
  retract(sim(Clausula)),
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
         carnivoro,
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
carnivoro :- verifica("é carnivoro").

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
       assert(sim(Questao)), fail).

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
