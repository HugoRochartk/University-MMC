Section Questao1.


(*mini teste do tiago*)
Variable A B C : Prop.



Lemma exercicio1_a: (A -> C) -> (A ->(B ->C)).
Proof.
intros.
apply H.
exact H0.
Qed.


Lemma exercicio1_b: ((A -> C) /\ (B -> C)) -> ((A\/B)-> C).
Proof.
intros.
destruct H.
destruct H0.
apply H.
exact H0.
apply H1.
exact H0.
Qed.



Lemma exercicio_c:(~A \/ B) -> (A -> ( ~~A /\B)).
Proof.
intros.
split.
destruct H.
elim H.
exact H0.
intro.
contradiction.
destruct H.
elim H.
exact H0.
exact H.
Qed.


(*mini teste do stor*)

Variable p0 p1 p2 : Prop.

Theorem a: (p0 -> (p1 -> p2)) -> (p1 -> (p0 -> p2)).
Proof.
intros.
apply H.
exact H1.
exact H0.
Qed.


Theorem b: (p0 /\ (p1 \/ p2)) -> ((p0 \/ p1) /\ (p0 \/ p2)).
Proof.
intros.
destruct H.
split.
left.
exact H.
left.
exact H.
Qed.


Theorem c: (~p0 /\ p1) -> ~(p0 \/ ~p1).
Proof.
intros.
destruct H.
intro.
destruct H1.
contradiction.
contradiction.
Qed.




(* exs extra tiago 


Require Import Classical.




Require Import Classical.
Variables P Q: Prop.
Theorem prop_2: (P -> Q) <-> (~P  \/ Q).
Proof.
split.
intros.
apply NNPP.
intro.
assert(H1: P).
apply NNPP.
intro.
apply H0.
left.
trivial.
assert(H2: ~Q).
intro.
apply H0.
right.
trivial.
elim H2.
apply H.
trivial.
intro.
intro.
destruct H.
elim H.
trivial.
trivial.
Qed.
*)




End Questao1.


(* mini teste stor *)
Section Questao2.

Variable D: Set.

Variable c: D.

Variable f: D -> D.

Variable P Q: D -> Prop.


Theorem q2: (forall x, ((P x) -> Q (f x))) -> (P c -> exists x, (P x /\ Q (f x))).
Proof.
intros.
exists c.
split.
exact H0.
apply H.
exact H0.
Qed.


(*mini teste tiago*)
Theorem exercicio2: (forall x0, (P x0) -> (P(f x0))) -> ( (exists x1, P x1)) -> (exists x2,( (P x2) /\ (P(f x2)))).
Proof.
intro.
intro.
destruct H0.
specialize H with x.
exists x.
split.
exact H0.
apply H.
assumption.
Qed.




End Questao2.



Section Questao3.
Require Import Classical.


Variable D: Set.

Variable c: D.

Variable f: D -> D.

Variable P Q: D -> Prop.


(* miniteste stor *)
Theorem q3: (forall x, (P x -> Q  x)) -> (forall x, (~(P x) \/ Q x)).
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



(* miniteste tiago *)
Theorem exercicio3: (forall x0,(~(P x0 ) -> ~( Q x0))) -> ( forall x0, ((Q x0) -> ( P x0))).
Proof.
intros.
specialize H with x0.
apply NNPP.
intro.
apply H.
trivial.
trivial.
Qed.








End Questao3.




