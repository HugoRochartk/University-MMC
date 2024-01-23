(* Aula 1 Coq *)


Check Prop.
Check Type.

Section Logica_Proposicional_Intuicionista.


Variables p1 p2 : Prop.


Check (p1 -> p2).
Check (p1 /\ p2).
Check (p1 \/ p2).
Check (p1 <-> p2).
Check (~p1).
Check False.


(* algumas provas *)

Theorem enfraquecimento : p1 -> (p2 -> p1).
Proof.
intro x.
intro y.
apply x.
Qed.


Print enfraquecimento.


Theorem modus_ponens : (p1->p2) -> p1 -> p2.
Proof.
intros x y.
apply x.
assumption.
Qed.


Print modus_ponens.


Lemma intro_conj : p1 -> p2 -> (p1 /\ p2).
Proof.
intros.
split.
assumption.
assumption.
Qed.



Print intro_conj.
Check conj.



Lemma comutatividade : p1 /\ p2 -> p2 /\ p1.
Proof.
intro.
split.
(*
elim H.
intros.
auto.
elim H;intros;trivial.
*)
destruct H.
trivial.
destruct H.
trivial.
Qed.


Lemma neg_contrad: ~(p1 /\ ~p1).
Proof.
intro.
destruct H.
apply H0.
trivial.
Qed.


Lemma dinj_comut: p1\/p2 -> p2 \/ p1.
Proof.
intro.
destruct H.
right.
trivial.
left;trivial.
Qed.



Lemma equiv_commut: p1 <-> p2 -> p2 <-> p1.
Proof.
intros.
split.
intro.
apply H.
trivial.
intro;apply H;trivial.
Qed.




Lemma absurdo: False -> p1.
Proof.
intro H.
elim H.
Qed.




Print False.



End Logica_Proposicional_Intuicionista.






(* --------------------------------------------------- *)


Section Logica_Classica.


Require Import Classical.


Check NNPP.



Lemma red_ao_abs: forall p:Prop, (~p -> False) -> p.
Proof.
intro.
intro.
apply NNPP.
intro.
apply H.
assumption.
Qed.



Lemma terceiro_excluido: forall p:Prop, p \/ ~p.
Proof.
intro.
apply NNPP.
intro.
assert (H0:~p).
intro.
apply H.
left.
trivial.
apply H.
right.
trivial.
Qed.



End Logica_Classica.











