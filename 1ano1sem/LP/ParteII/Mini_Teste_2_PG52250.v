(* Hugo Rocha, pg52250 *)


Section Questao1.


Lemma ex1: forall m n k l, (m = S n /\ S k = l /\ k=n) -> m=l.
Proof.
intros.
destruct H.
destruct H0.
rewrite H.
rewrite <- H0.
rewrite H1.
reflexivity.
Qed.



End Questao1.




Section Questao2.


Definition c_1:= fun f:nat->nat => fun x: nat=> f x.


(*Alínea a)*)
Check (c_1 S).
(*Podemos observar que o termo (c_1 S) tem como tipo nat -> nat. Isto acontece
devido ao facto de o termo c_1 receber uma função f do tipo nat->nat e um outro
elemento x do tipo nat para aplicar a função f a esse elemento, produzindo f x.
Neste caso, ao aplicarmos o termo c_1 à função S (sucessor nos naturais), a função S
é de facto do tipo nat -> nat pelo que é do mesmo tipo da função f esperada como
argumento. No entanto, o termo espera receber mais um elemento x do tipo nat 
para produzir S x, também do tipo nat. Logo, (c_1 S) é do tipo nat -> nat. *)
Eval compute in (c_1 S).
(* A forma normal deste termo é fun x: nat => S x: nat -> nat, pela mesma lógica dita
anteriormente, não sendo possível aplicar mais beta-reduções a este termo.*)


Check (c_1 S 1).
(* Neste caso observa-se que este termo é do tipo nat. Isto acontece porque aqui,
além de termos a função f esperado como argumento do tipo nat -> nat, que é a função
S de sucessor nos naturais, temos também o elemento x que é esperado como sendo também
um natural, neste caso, 1. Logo, já é possível devolver f x, aqui, em concreto, S 1 que
é do tipo nat devido ao tipo de S ser nat -> nat que neste caso é aplicado a 1.*)
Eval compute in (c_1 S 1).
(* Como explicado anteriormente, temos todos os ingredientes para o termo fornecer um
resultado do tipo nat que é a sua forma normal. Neste caso, a forma normal é 2
proveniente do resultado de S 1, não sendo possível aplicar beta-reduções ao termo 2.*)





(*Alínea b)*)
Lemma ex2_b: forall m n, (c_1 S m) + n = m + 1 + n.
Proof.
induction m.
intro.
compute.
reflexivity.
intro.
compute.
fold plus.
specialize IHm with n.
unfold c_1 in IHm.
inversion IHm.
rewrite H0.
reflexivity.
Qed.


End Questao2.





Section Questao3.


Definition teste_0 := fun n: nat =>
    match n with
      | 0 => 1
      | S m => 0
    end.

Check teste_0.



Lemma ex3: forall n, (exists m, n = S m) -> teste_0 n=0.
Proof.
intros.
compute.
destruct H.
rewrite H.
reflexivity.
Qed.


End Questao3.





Section Questao4.


Inductive par : nat -> Prop:=
  par0: par 0 | parS: forall n:nat, par n -> par (S (S n)).


Inductive impar : nat -> Prop:=
  imp1: impar 1 | impS: forall n, impar n -> impar (S (S n)).




(*Alínea a)*)
Lemma ex4_a: par 4 /\ ~impar 4.
Proof.
split.
apply parS.
apply parS.
exact par0.
intro.
inversion H.
inversion H1.
inversion H3.
Qed.




(*Alínea b)*)
Lemma ex4_b: forall n, par n -> impar (S n).
Proof.
intros.
induction H.
exact imp1.
apply impS.
exact IHpar.
Qed.




(*Alínea c)*)
Lemma ex4_c: forall n, par n \/ impar n.
Proof.
intro.
induction n.
left.
exact par0.
destruct IHn.
right.
induction H.
exact imp1.
apply impS.
exact IHpar.
left.
induction H.
apply parS.
exact par0.
apply parS.
exact IHimpar.
Qed.




End Questao4.






















