% Dictionnaire 
% ========================

dictionnaire('ajuster', verbe(singulier)).
dictionnaire('melanger', verbe(singulier)).
dictionnaire('remplir', verbe(singulier)).
dictionnaire('saupoudrer', verbe(singulier)).
dictionnaire('selectionner', verbe(singulier)).

dictionnaire('legerement', adverbe(invariable)).
dictionnaire('juste', adverbe(invariable)).
dictionnaire('bien', adverbe(invariable)).

dictionnaire('et', conjonction(invariable)).

dictionnaire('les', article(pluriel)).
dictionnaire('l', article(singulier)).
dictionnaire('la', article(singulier)).


dictionnaire('a', preposition(invariable)).
dictionnaire('de', preposition(invariable)).
dictionnaire('pour', preposition(invariable)).

dictionnaire('muffins', nom_commun(pluriel)).
dictionnaire('moules', nom_commun(pluriel)).
dictionnaire('assaisonnement', nom_commun(singulier)).
dictionnaire('persil', nom_commun(singulier)).
dictionnaire('pommes', nom_commun(pluriel)).

dictionnaire('frise', adjectif(singulier)).
dictionnaire('mures', adjectif(pluriel)).

% Instruction ( Analyse sémantique)
% =====================

% melanger legerement et remplir les moules a muffins
p([SEM1, SEM2]) --> gv(VERBE1,ADVERBE, _), con(_), gv(VERBE2, _), gc(SUJET1,SUJET2,_),
                    { SEM1 =.. [VERBE1, 'Aucun', ADVERBE, 'Aucun'],
                      SEM2 =.. [VERBE2, (SUJET1,SUJET2), 'Aucun', 'Aucun'] }.

% ajuster l assaisonnement et saupoudrer de persil frise
p([SEM1, SEM2]) --> gv(VERBE1, _), 
  gn(SUJET1, _), con(_),gv(VERBE2, _),gc(SUJET2,ADJECTIF,_),
    { SEM1 =.. [VERBE1, SUJET1, 'Aucun', 'Aucun'],
      SEM2 =.. [VERBE2, SUJET2, 'Aucun', ADJECTIF] }.

% selectionner les pommes bien mures 
p([SEM]) --> gv(VERBE, _),gn(SUJET,ADJECTIF,ADVERBE,_),
    { SEM =.. [VERBE, SUJET, ADVERBE, ADJECTIF] }.

% Synthaxe
% =============

% Groupe complément (gc)
gc(SUJET,ADJECTIF,N) --> pre(_),gn(SUJET,ADJECTIF,N). 
gc(SUJET1,SUJET2,N) --> gn(SUJET1, N), pre(_), gn(SUJET2, N).
% Groupe nominal (gn)
gn(SUJET, N) --> art(N), nc(SUJET, N).
gn(SUJET, N) --> nc(SUJET, N).
gn(SUJET,ADJECTIF,ADVERBE,N) --> art(N), nc(SUJET, N),ga(ADJECTIF,ADVERBE,N).
gn(SUJET,ADJECTIF,N) --> nc(SUJET, N),adj(ADJECTIF,N).
% Groupe verbal (gv)
gv(VERBE,ADVERBE, N) --> v(VERBE, N),adv(ADVERBE).
gv(VERBE, N) --> v(VERBE, N).
% Groupe adjectival
ga(ADJECTIF,ADVERBE,N) --> adv(ADVERBE),adj(ADJECTIF,N).  

% Article
art(N) --> [X], {dictionnaire(X, article(N))}.
% Nom commun
nc(X, N) --> [X], {dictionnaire(X, nom_commun(N))}.
% Verbe
v(X, N) --> [X], {dictionnaire(X, verbe(N))}.
% Adverbe
adv(X) --> [X], {dictionnaire(X, adverbe(_))}.
% Conjonction
con(X) --> [X], {dictionnaire(X, conjonction(_))}.
% Preposition
pre(X) --> [X], {dictionnaire(X, preposition(_))}.
% Adjectif
adj(X,N) --> [X], {dictionnaire(X, adjectif(N))}.

% Fonction
% ==========

% Analyser l'instruction
analyse_phrase :-
    write('Entrez votre phrase sans accent ni ponctuation : '), nl,
    read_line_to_string(user_input, Phrase),
    atomic_list_concat(ListeMots, ' ', Phrase),
    p(A, ListeMots,[]),
    write('Voici l analyse sémentique de la phrase: ' ),write(A),nl.




