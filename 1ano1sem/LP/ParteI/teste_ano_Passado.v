Section Questao1.

Variables p0 p1 p2: Prop.

Lemma alinea_a: (p0 -> ( p1-> p2)) -> (p1->(p0->p2)).
Proof.
intros.

apply H.
exact H1.
trivial.
Qed.


Print alinea_a.


Lemma alinea_b: (p0 -> ( p1-> p2)) -> (p0 -> (p1->(p0->p2))).
Proof.
intros.

apply H.
exact H2.
trivial.
Qed.



Lemma alinea_b1: (p0 \/ ( p1 /\ p2)) -> ((p0\/p1) /\ (p0 \/ p2)).
Proof.
intros.
split.
destruct H.
left;assumption.
destruct H.           (*elim H.   intros.  Permite nao deitar fora o H anterior*)
right;assumption.
destruct H.
left;assumption.
destruct H.
right;assumption.

Qed.





Lemma alinea_c: (~p0 /\ p1)  -> ~ (p0 \/ ~p1).
Proof.
intros.
intro.
destruct H0.
destruct H.
apply H.
assumption.
destruct H.
contradiction.
Qed.



Variables D: Set.
Variable f: D -> D.
Variable P Q: D -> Prop.
Variable c: D.



Lemma exer2: (forall x, ((P x) -> Q (f x)))  -> (P c -> exists x, (P x /\ Q (f x))).
Proof.
intro.
intro.
exists c.
split.
assumption.
apply H.
assumption.
Qed.



Require Import Classical.
Check NNPP.

Lemma exer3: (forall x, (P x -> Q  x))  -> forall x, ~ P x \/ Q x.
Proof.
intro.
intro.
apply NNPP.
intro.


assert (H1: P x).
apply NNPP.
intro.
apply H0.
left;assumption.
assert (H2: ~Q x).
intro.
apply H0.
right;assumption.

apply H2.
apply H.
assumption.

Qed.





Lemma exer3v2: (forall x, (P x -> Q  x))  -> forall x, ~ P x \/ Q x.
Proof.
intro.
intro.
apply NNPP.
intro.


assert (H1: P x).
apply NNPP.
intro.
apply H0.
left;assumption.
assert (H2: ~Q x).
intro.
apply H0.
right;assumption.

apply H2.
apply H.
assumption.

Qed.

























