Section ex1.


Lemma ex1: forall n m, (n=0 /\ 0=m) -> S n= S m.
Proof.
intros.
destruct H.
rewrite H.
rewrite <- H0.
reflexivity.
Qed.


End ex1.





Section ex2.

(*a)*)
Definition c_2:= fun f:nat->nat=> fun x:nat=> f (f x).
Check c_2.


Eval compute in (c_2 S 0).



(*b)*)
Lemma dois_b: forall n, c_2 S n= S (S n).
Proof.
intros.
compute.
reflexivity.
Qed.


(*c)*)
Lemma dois_c: forall m n, c_2 S (m+n)= m+(S (S n)).
Proof.
induction m.
intros.
compute.
reflexivity.
intros.
specialize IHm with n.
compute.
fold plus.
unfold c_2 in IHm.
rewrite IHm.
reflexivity.
Qed.



End ex2.




Section ex3.



Inductive impar : nat->Prop :=
imp_1: impar 1| imp_n: forall n, impar n -> impar (S (S n)).




Lemma tres_a: impar 3 /\ ~ impar 4.
Proof.
split.
apply imp_n.
apply imp_1.
intro.
inversion H.
inversion H1.
inversion H3.
Qed.





Lemma tres_b: forall n, impar n <-> impar (S (S n)).
Proof.
intros.
split.
intro.
apply imp_n.
assumption.
intro.
inversion H.
exact H1.
Qed.





Lemma tres_c: forall n, impar n -> ~impar (S n).
Proof.
induction n.
intros.
inversion H.
intro.
intro.
destruct IHn.
inversion H0.
apply H2.
apply H.
Qed.












