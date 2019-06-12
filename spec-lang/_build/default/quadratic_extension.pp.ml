Caml1999M023����            6quadratic_extension.ml����  G+  
9  *�  '������1ocaml.ppx.context��&_none_A@ �A����������)tool_name���-ppxlib_driver@@����,include_dirs����"[]@@����)load_path!����
%@%@����,open_modules*����.@.@����+for_package3����$None8@8@����%debug=����%falseB@B@����+use_threadsG����
K@K@����-use_vmthreadsP����T@T@����'cookiesY����"::^����������/ppx_optcomp.env@i@�������#env��&_none_A@ �A@���-ocaml_version����'Defined�������!4@@����!7@@����!1@@@@@@@@�@�����y�@�@@�@�@@@�@@�@�������$Core��6quadratic_extension.mlA@E�A@I@A��A@@�A@I@@��A@@�A@I@������$Util��BJO�BJS@A��BJJ�BJS@@��BJJ�BJS@���A�    �%curve��!DUZ�"DU_@@@��Р$MNT4��)DUb�*DUf@�@@��-DUb�.DUf@@�Р$MNT6��4DUi�5DUm@�@@��8DUg�9DUm@@@A@@��;DUU�<DUm@@��>DUU�?DUm@���@�����%param��JFos�KFox@��MFos�NFox@@��@@���$name��VFoy�WFo}@��YFoy�ZFo}@@��@@���+curve_scope��bFo~�cFo I@��eFo~�fFo I@@��@�����!s��pG L R�qG L S@��sG L R�tG L S@@������!^��}G L ��~G L �@���G L ���G L �@@��@������+curve_scope���G L ]��G L h@���G L ]��G L h@@������$MNT4���G L n��G L r@@���G L n��G L r@@@���$MNT4@���G L v��G L |@@������$MNT6���G L ��G L �@@���G L ��G L �@@@���$MNT6@���G L ���G L �@@@���G L V��G L �@@��@���#753@���G L ���G L �@@@���G L V��G L �@@@���G L N��G L �@@�������$Name+to_markdown���H � ���H � �@���H � ���H � �@@��@�������$Name(in_scope���H � ���H � �@���H � ���H � �@@��@����!s���H � ���H � �@���H � ���H � �@@��@����$name�� H � ��H � �@��H � ��H � �@@@��H � ��H � �@@@��	H � ��
H � �@@��G L N�H � �@@��Fo~�H � �A@��Foy�H � �A@@��Foo�H � �@@��Foo�H � �@���@�����!q��$J � ��%J � �@��'J � ��(J � �@@������%param��1J � ��2J � �@��4J � ��5J � �@@��@���!q@��=J � ��>J � �@@@��@J � ��AJ � �@@@��CJ � ��DJ � �@@��FJ � ��GJ � �@���@�����!r��RL � ��SL � �@��UL � ��VL � �@@������%param��_L � ��`L � �@��bL � ��cL � �@@��@���!r@��kL � ��lL � �@@@��nL � ��oL � �@@@��qL � ��rL � �@@��tL � ��uL � �@���@�����(preamble���N � ���N � �@���N � ���N � �@@��@@�����%pages���N � ���N � �@���N � ���N � �@@�����%Pages!t���N ���N �	@@���N ���N �	@@���N � ���N �
@@�  !A��.Sectioned_page���O��O&@����"::���P*.�� cfoA����������$leaf���P*.��P*2@���P*.��P*2@@��@������(ksprintf���Q3:��Q3B@���Q3:��Q3B@@��@�����(Markdown)of_string���Q3C��Q3U@���Q3C��Q3U@@��@���	�Now that we've implemented arithmetic in a prime-order field
in a [previous challenge](%s), we can implement field extension
arithmetic, which we'll need for multi-exponentiation.�"md���RV_��T�@@��@������%pages���U$��U)@���U$��U)@@��0field_arithmetic�� U*�U:@��U$�U:@@@��Q39�U;@@@��	P*.�
U;@@�����a��V<@� cfoA����������#sec��V<@� V<C@��"V<@�#V<C@@���%title���6Definitions and review@��-V<K�.V<c@@��@�������6Wdl�7w��A����������$leaf��DWdl�EWdp@��GWdl�HWdp@@��@������(ksprintf��SXq|�TXq�@��VXq|�WXq�@@��@�����(Markdown)of_string��bXq��cXq�@��eXq��fXq�@@��@���
  0
Let's review what exactly a field extension is. The actual operations
needed are actually pretty simple, so if you just want to get started coding,
you can safely skip this section.

A field extension of a field $\mathbb{F}$ is another field $\mathbb{F}'$
which contains $\mathbb{F}$. To use a familiar example, $\mathbb{R}$,
the field of real numbers is a field extension of the field $\mathbb{Q}$
of rational numbers.

In the SNARK challenge and in cryptography in general, we work with finite
fields, and the extension fields we'll consider will be finite fields as
well.

The simplest kind of field extension and the one we'll implement here is
called a quadratic extension. The idea is the following. First we'll start
with our prime order field $\mathbb{F}_q$ where $q$ is %s. Then, we'll
pick a number in $\mathbb{F}_q$ which does not have a square root in
$\mathbb{F}_q$. In our case, we'll use $13$.

Now we can define the field we call $\mathbb{F}_q[x] / (x^2 = 13)$. This is the field
obtained by adding an "imaginary" square root $x$ for $13$ to $\mathbb{F}_q$. It's a lot like how
the complex numbers are constructed from the real numbers by adding an "imaginary" square root
$i$ for $-1$ to $\mathbb{R}$.

Like the complex numbers, the elements of $\mathbb{F}_q[x] / (x^2 = 13)$ are sums
of the form $a_0 + a_1 x$ where $a_0$ and $a_1$ are elements of $\mathbb{F}_q$. This is a
field extension of $\mathbb{F}_q$ since $\mathbb{F}_q$ is contained in this field as
the elements with $a_1 = 0$. For short, we call this field $\mathbb{F}_{q^2}$ since it
has $q^2$ elements.�"md��pY���qv��@@��@������!q��|w���}w��@��w����w��@@��@����$MNT4���w����w��@@���w����w��@@@���w����w��@@@���Xq{��w��@@@���Wdl��w��@@�����"[]���w����w��A@���w����w��A@@���Wdl��w��A@���Wdj��w��@@@���V<@��w��@@��������x���� cfoA����������#sec���x����x��@���x����x��@@���%title���+The problem@���x�	��x�	@@��@����'���y		�� cfmA����������$leaf���y		��y		 @���y		��y		 @@��@�������(Markdown)of_string���z	!	,��z	!	>@���z	!	,��z	!	>@@��@���
  In code, you can think of an element of $\mathbb{F}_{q^2}$ as a pair `(a0, a1)` where
each of $a_0, a_1$ is an element of $\mathbb{F}_q$ or a struct `{ a0 : Fq, a1 : Fq }`.

This problem will have you implement addition and multiplication for $\mathbb{F}_{q^2}$.
Addition and multiplication are defined how you might expect:

$$
\begin{aligned}
(a_0 + a_1 x) + (b_0 + b_1 x)
&= (a_0 + b_0 ) + (a_1 + b_1 )x \\
(a_0 + a_1 x) (b_0 + b_1  x)
&= a_0 b_0 + a_1 b_0 x + a_0 b_1  x + a_1 b_1  x^2 \\
&= a_0 b_0 + a_1 b_0 x + a_0 b_1  x + 13 a_1 b_1  \\
&= (a_0 b_0 + 13 a_1 b_1 ) + (a_1 b_0  + a_0 b_1 ) x
\end{aligned}
$$

In pseduo-code, this would be
```javascript

var alpha = fq(13);

var fq2_add = (a, b) => {
  return {
    a: fq_add(a.a0, b.a0),
    b: fq_add(a.a0, b.a0)
  };
};

var fq2_mul = (a, b) => {
  var a0_b0 = fq_mul(a.a0, b.a0);
  var a1_b1 = fq_mul(a.a1, b.a1);
  var a1_b0 = fq_mul(a.a1, b.a0);
  var a0_b1 = fq_mul(a.a0, b.a1);
  return {
    a0: fq_add(a0_b0, fq_mul(a1_b1, alpha)),
    a1: fq_add(a1_b0, a0_b1)
  };
};
```�"md��{	?	L� b]d@@@��z	!	+� b]e@@@��
y		� b]e@@�����u�� cfl� cfmA@�� cfl� cfmA@@��y		� cfmA@��y		� cfm@@@��x��� cfm@@��������& cfn�' cfoA@��) cfn�* cfoA@@��,x���- cfoA@��/x���0 cfoA@@��2V<@�3 cfoA@��5V<@�6 cfoA@@��8P*.�9 cfoA@��;P*,�< cfo@@��>O�? cfo@@��AN � ��B cfoA@@��DN � ��E cfo@@��GN � ��H cfo@���@�������)interface��U ����V ���@��X ����Y ���@@��@������'Problem)Interface!t��f ����g ��@������(Markdown!t��q ����r ���@@��t ����u ���@@@��w ����x ��@@��z ����{ ��A@��} ����~ ��A@�  �  !A���'Problem)Interface��� ��� �0@�  !A��*Let_syntax��� �4?�� �4I@��@�����"fq��� �MS�� �MU@��� �MS�� �MU@@������$Type%Field%Prime��� �MX�� �Mh@�������%order��� �Mj�� �Mo@����$Name��� �Mq�� �Mu@��������$Name(in_scope��� �Mw�� �M�@��� �Mw�� �M�@@��@���'MNT4753@��� �M��� �M�@@��@���!q@��� �M��� �M�@@@��� �Mv�� �M�@@��� �Mq�� �M�@@@@��� �Mi�� �M�@@��� �MX�� �M�@@@��� �MO�� �M�@@��@�����#fqe��� ����� ���@��� ����� ���@@������$Type%Field)Extension��	 ����
 ���@�������$base�� ���� ���@����'Literal�� ���� ���@�����"fq��% ����& ���@��( ����) ���@@��+ ����, ���@@����&degree��3 ����4 ���@���!2@��: ����; ���@@����+non_residue��B ����C ���@����'Literal��J ����K ��@�����'Integer��S ���T ��@�����%Value��\ ���] ��@��������&Bigint&of_int��i ���j ��#@��l ���m ��#@@��@���"13@��u ��$�v ��&@@@��x ���y ��'@@��{ ���| ��(@@��~ ��� ��)@@��� ����� ��)@@@@��� ����� ��+@@��� ����� ��+@@@��� ����� ��+@@�������*Let_syntax$bind��� �13�� ��@@��@��������!!��� �1@�� �1A@��� �1@�� �1A@@��@����%Input��� �1A�� �1F@@��� �1A�� �1F@@@��� �1@�� �1F@@��@���!n@��� �1G�� �1J@@��@����'Literal��� �1L�� �1S@�����&UInt64��� �1T�� �1Z@@��� �1T�� �1Z@@��� �1K�� �1[@@@��� �1@�� �1[@@���!f��@@���!n��� �1<�� �1=@��� �1<�� �1=@@��@�����#arr��� �_e�� �_h@��� �_e�� �_h@@����'Literal�� �ko� �kv@������$Type%Array�� �w~� �w�@�������'element�� �w�� �w�@�������$Type%field��$ �w��% �w�@��' �w��( �w�@@��@����'Literal��1 �w��2 �w�@�����#fqe��: �w��; �w�@��= �w��> �w�@@��@ �w��A �w�@@@��C �w��D �w�@@����&length��K �w��L �w�@����$Some��S �w��T �w�@�����$Name��\ �w��] �w�@�����!n��e �w��f �w�@��h �w��i �w�@@��k �w��l �w�@@��n �w��o �w�@@@@��q �w��r �w�@@��t �w}�u �w�@@��w �ko�x �w�@@@��z �_a�{ �w�@@��@�����2__let_syntax__001_��� ����� ���@@������������ ����� ���@��� ����� ���@@��@����%Input��� ����� ���@@��� ����� ���@@@��� ����� ���@@��@���!x@��� ����� ���@@��@����#arr��� ����� ���@��� ����� ���@@@��� ����� ���@@@��� ����� ���@�����2__let_syntax__002_��� ����� ���@@��������0��� ����� ���@��� ����� ���@@��@����%Input��� ����� ���@@��� ����� ���@@@��� ����� ���@@��@���!y@��� ����� ���@@��@����#arr��� ����� ��@��� ����� ��@@@��� ����  ��@@@�� ���� ��@�����2__let_syntax__003_�� �� �@@��������s�� �� �@�� �� �@@��@����&Output��# ��$ �@@��& ��' �@@@��) ��* �@@��@���!z@��2 ��3 �@@��@����#arr��< ��= �!@��? ��@ �!@@@��B ��C �!@@@��E ��F �!@@�������#map��O ����P ��@@��@�������$both��@��@�������@��@�������jj@��@�����pp@��@����k33@@v@@�@�����@@������"_x��� ����� ���@�@�������"_y��� ����� ���@�@����'_output��� ��� �@�@@�@@@������(ksprintf��� �%'�� �%/@��� �%'�� �%/@@��@�����(Markdown)of_string��� �%0�� �%B@��� �%0�� �%B@@��@���	s%s

The output should be have `z[i] = x[i] * y[i]`
where `*` is multiplication in the field %s as described above.
�"md��� �CG�� ���@@��@�����+Gpu_message!t��� ����� ���@��� ����� ���@@��@�������$Html)to_string��� ����� ��@��� ����� ��@@��@��������$Type%Field&render��� ����� ���@��� ����� ���@@��@����'Literal��� ����� ���@�����#fqe��  ���� ���@�� ���� ���@@�� ���� ���@@@��	 ����
 ���@@@�� ���� ��@@@�� �%'� ��@@�@@�@�@�� �_a� ��@@@@@�� ���� ��@@�� �MO� ��@@�� �46� ��@@�� �� ��@@��������°�' ����( ��@����������0 ����1 ���@@��3 ����4 ���@@@��6 ����7 ��@@��9 ����: ��A@@��< ����= ��@@��? ����@ ��@���@�����)postamble��K ��L �@��N ��O �@@��@@�����%pages��Y ��Z �"@��\ ��] �"@@�����%Pages!t��f �%�g �,@@��i �%�j �,@@��l ��m �-@@�  !A��.Sectioned_page��t �0;�u �0I@����˰�{ �MQ�| �"%".A����������#sec��� �MQ�� �MT@��� �MQ�� �MT@@���%title���,Starter code@��� �M\�� �Mj@@��@������� �ks�� �KmA����������"md��� �ks�� �ku@��� �ks�� �ku@@��@���	�- This [repo](https://github.com/codaprotocol/cuda-fixnum) has a CUDA solution for the [first challenge](%s),
          which is very similar to this one. You can clone that repo to get started.�"md��� �v��� ��J@@��@������%pages��� �KU�� �KZ@��� �KU�� �KZ@@��0field_arithmetic��� �K[�� �Kk@��� �KU�� �Kk@@@��� �ks�� �Kk@@�����B��� �Kl�� �KmA@��� �Kl�� �KmA@@��� �ks�� �KmA@��� �kq�� �Km@@@��� �MQ�� �Km@@�����C��� �nr�� �"%".A����������#sec�� �nr� �nu@�� �nr� �nu@@���%title���1Efficiency tricks@�� �n}� �n�@@��@����h�� ���� �"%",A����������$leaf��& ����' ���@��) ����* ���@@��@�������(Markdown)of_string��7 ����8 ���@��: ����; ���@@��@���
  RThe pseduocode above does 4 $\mathbb{F}_q$ multiplications, 1 multiplication
by $13$ (which can be made much cheaper than a general multiplication if it is
special-cased), and 2 additions.

If you want to get the most efficiency, it's good to reduce the number of
multiplications, as they are much more costly than additions. There is a trick
to do so, described in [section 3 of this paper](https://pdfs.semanticscholar.org/3e01/de88d7428076b2547b60072088507d881bf1.pdf)
but let's go through it here. The net result of the trick is that we'll get down
to 3 multiplications, 1 multiplication by $13$, and 5 additions/subtractions. So we need to
do more additions and subtractions, but we do one less multiplication, which is a big win.

In pseudo-code, the trick is
```javascript

var fq2_mul = (a, b) => {
  var a0_b0 = fq_mul(a.a0, b.a0);
  var a1_b1 = fq_mul(a.a1, b.a1);

  var a0_plus_a1 = fq_add(a.a0, a.a1);
  var b0_plus_b1 = fq_add(b.a0, b.a1);

  var c = fq_mul(a0_plus_a1, b0_plus_b1);

  return {
    a0: fq_add(a0_b0, fq_mul(a1_b1, alpha)),
    a1: fq_sub(fq_sub(c, a0_b0), a1_b1)
  };
};
```
�"md��E ����F �""#@@@��H ����I �""$@@@��K ����L �""$@@��������S �"%"+�T �"%",A@��V �"%"+�W �"%",A@@��Y ����Z �"%",A@��\ ����] �"%",@@@��_ �nr�` �"%",@@�����ʰ�g �"%"-�h �"%".A@��j �"%"-�k �"%".A@@��m �nr�n �"%".A@��p �nr�q �"%".A@@��s �MQ�t �"%".A@��v �MO�w �"%".@@��y �02�z �"%".@@��| ��} �"%".A@@�� ��� �"%".@@��� ��� �"%".@���@�������'problem��� �"0"4�� �"0";@��� �"0"4�� �"0";@@��@�����'Problem!t��� �"0">�� �"0"G@@��� �"0">�� �"0"G@@��� �"0"4��%%&A@��� �"0"4��%%&A@�  ������%title��� �"J"N�� �"J"S@���>Quadratic extension arithmetic@��� �"J"U�� �"J"u@@����-quick_details��� �"v"z�� �"v"�@������+description��� "�"��� "�"�@�������(Markdown)of_string���"�"���"�"�@���"�"���"�"�@@��@���	FMultiply together an array of elements of a quadratic extension field.@���"�"���#
#@@@���"�"���#
#@@����%prize���##'��##,@�������%Prize&stage1���##.��##:@���##.�	 ##:@@��@���#150@��	##;�		##>@@@��	##.�	##>@@@@��	 "�"��	##@@@����(preamble��	#A#E�	#A#M@������	#A#E�	#A#M@��	 #A#E�	!#A#M@@����)interface��	(#N#R�	)#N#[@������	/#N#R�	0#N#[@��	2#N#R�	3#N#[@@����8reference_implementation��	:#\#`�	;#\#x@������$repo��	D#z#��	E#z#�@���	\https://github.com/CodaProtocol/snark-challenge/tree/master/reference-02-quadratic-extension@��	K	#�#��	L	#�#�@@����$main��	S
#�#��	T
#�#�@���	khttps://github.com/CodaProtocol/snark-challenge/tree/master/reference-02-quadratic-extension/libff/main.cpp@��	Z#�$	�	[#�$v@@����$core��	b$w$�	c$w$�@���	}https://github.com/CodaProtocol/snark-challenge/blob/master/reference-02-quadratic-extension/libff/algebra/fields/fp2.tcc#L79@��	i$�$��	j$�%@@@@��	l#z#��	m%%@@����)postamble��	t%%�	u%%$@������	{%%�	|%%$@��	~%%�	%%$@@@@��	� �"J"L�	�%%&@@��������	� �"0">�	� �"0"G@@��	� �"0">�	� �"0"G@@��	� �"0"4�	�%%&A@@��	� �"0"0�	�%%&@@��	� �"0"0�	�%%&@@