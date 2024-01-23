Section Questao1.


Variables p0 p1 p2 : Prop.

Theorem a : (p0 -> (p1 -> p2)) -> ((p0 -> p1) -> (p0 -> p2)).
Proof.
intros.
apply H.
exact H1.
apply H0.
exact H1.
Qed.



Theorem b : ((p0 \/ p1) /\ (~p1 \/ p2)) -> (p0 \/ p2).
Proof.
intros.
destruct H.
destruct H.
left.
exact H.
destruct H0.
elim H0.
exact H.
right.
exact H0.
Qed.


(* também fiz a alínea c) embora não fosse necessário *)
Theorem c : (~p0 /\ p1) <-> (~~~p0 /\ p1).
Proof.
split.
intros.
split.
destruct H.
intro.
elim H1.
exact H.
destruct H.
exact H0.
intro.
split.
destruct H.
intro.
assert(H2: ~~ p0).
intro.
contradiction.
contradiction.
destruct H.
exact H0.
Qed.




End Questao1.





Section Questao2.

Variable D : Set.

Variable f: D -> D.

Variable P: D -> Prop.



Theorem q2: ((exists x, P x) /\ (forall x, (P x -> (P (f (f x)) /\ (~ P (f x)))))) -> ((exists y, ~(P (f y))) /\ (exists y, P (f y))).
Proof.
intros.
split.
destruct H.
destruct H.
exists x.
apply H0.
exact H.
destruct H.
destruct H.
exists (f x).
apply H0.
exact H.
Qed.





End Questao2.



Section Questao3.

Require Import Classical.

Variable D: Set.

Variable R: D -> D -> Prop.


Theorem q3: (forall x, ~ (forall y, R x y)) -> (forall x, exists y, ~ (R x y)).
Proof.
intros.
specialize H with x.
apply NNPP.
intro.
apply H.
intro.
apply NNPP.
intro.
apply H0.
exists y.
exact H1.
Qed.


End Questao3.















