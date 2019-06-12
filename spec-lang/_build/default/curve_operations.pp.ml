Caml1999M023����            3curve_operations.ml����  _�  �  ?4  <٠����1ocaml.ppx.context��&_none_A@ �A����������)tool_name���-ppxlib_driver@@����,include_dirs����"[]@@����)load_path!����
%@%@����,open_modules*����.@.@����+for_package3����$None8@8@����%debug=����%falseB@B@����+use_threadsG����
K@K@����-use_vmthreadsP����T@T@����'cookiesY����"::^����������/ppx_optcomp.env@i@�������#env��&_none_A@ �A@���-ocaml_version����'Defined�������!4@@����!7@@����!1@@@@@@@@�@�����y�@�@@�@�@@@�@@�@�������$Core��3curve_operations.mlA@E�A@I@A��A@@�A@I@@��A@@�A@I@������$Util��BJO�BJS@A��BJJ�BJS@@��BJJ�BJS@���A�    �%curve��!DUZ�"DU_@@@��Р$MNT4��)DUb�*DUf@�@@��-DUb�.DUf@@�Р$MNT6��4DUi�5DUm@�@@��8DUg�9DUm@@@A@@��;DUU�<DUm@@��>DUU�?DUm@���@�����+curve_scope��JFos�KFo~@��MFos�NFo~@@��@@���!c��VFo�WFo @@��YFo�ZFo @@@������!^��cFo r�dFo s@��fFo r�gFo s@@��@������!c��rFo J�sFo K@��uFo J�vFo K@@������$MNT4��Fo Q��Fo U@@���Fo Q��Fo U@@@���$MNT4@���Fo Y��Fo _@@������$MNT6���Fo b��Fo f@@���Fo b��Fo f@@@���$MNT6@���Fo j��Fo p@@@���Fo C��Fo q@@��@���#753@���Fo t��Fo y@@@���Fo C��Fo y@@���Fo��Fo yA@@���Foo��Fo y@@���Foo��Fo y@���@�����!p���H { ��H { �@���H { ��H { �@@��@@���!c���H { ���H { �@���H { ���H { �@@�������$Name+to_markdown���H { ���H { �@���H { ���H { �@@��@�������$Name(in_scope���H { ���H { �@���H { ���H { �@@��@������+curve_scope���H { ���H { �@���H { �� H { �@@��@����!c��	H { ��
H { �@��H { ��H { �@@@��H { ��H { �@@��@���!q@��H { ��H { �@@@��H { ��H { �@@@��H { ��H { �@@��!H { ��"H { �A@@��$H { {�%H { �@@��'H { {�(H { �@���@�����(preamble��3J � ��4J � �@��6J � ��7J � �@@��@@�����%pages��AJ � ��BJ � �@��DJ � ��EJ � �@@�����%Pages!t��NJ � ��OJ � �@@��QJ � ��RJ � �@@��TJ � ��UJ � �@@�  !A��.Sectioned_page��\K � ��]K � �@��@�����"md��gL � �hL �@��jL � �kL �@@��@@���#fmt��sL ��tL �@��vL ��wL �@@������(ksprintf���L �	��L �@���L �	��L �@@��@��@@���!s���L ���L �@���L ���L �@@������$leaf���L ���L � @���L ���L � @@��@�������(Markdown)of_string���L �"��L �4@���L �"��L �4@@��@����!s���L �5��L �6@���L �5��L �6@@@���L �!��L �7@@@���L ���L �7@@���L ���L �8@@��@����#fmt���L �9��L �<@���L �9��L �<@@@���L �	��L �<@@���L ���L �<A@@���L � ���L �<@@����"::���M@D��s?bA����������"md���M@D��M@F@���M@D��M@F@@��@���	�In this challenge you'll use the field arithmetic built up 
in [this](%s), [this](%s) and [this challenge](%s)
to implement the group operation for several elliptic curves.�"md���NGM� P�@@��@������%pages��Q�Q@��Q�Q@@��0field_arithmetic��Q�Q@��Q�Q@@��@������%pages��#Q�$Q$@��&Q�'Q$@@��3quadratic_extension��,Q%�-Q8@��/Q�0Q8@@��@������%pages��;Q9�<Q>@��>Q9�?Q>@@��/cubic_extension��DQ?�EQN@��GQ9�HQN@@@��JM@D�KQN@@�����p��RROS�Ss?bA����������#sec��`ROS�aROV@��cROS�dROV@@���%title���<Definition of curve addition@��nRO^�oRO|@@��@�������wS}��xs?`A����������"md���S}���S}�@���S}���S}�@@��@���
  �
Fix a field $\mathbb{F}$. For example, one of the fields described
on the parameter pages for [MNT4-753](%s) and [MNT6-753](%s).
Then fix numbers $a, b$ in $\mathbb{F}$. The set of points $(x, y)$ such that
$y^2 = x^3 + a x + b$ is called an elliptic curve over the field $\mathbb{F}$.

Elliptic curves are the essential tool powering SNARKs. They're useful because
we can define a kind of "addition" of points on a given curve. This is also
called the "group operation" for the curve.
Let's define this "addition" as follows using pseudocode, where `+, *, /` are
all taking place in the field $\mathbb{F}$.

```javascript

var curve_add = (p, q) => {
  var s = (p.y - q.y) / (p.x - q.x);
  var x = s*s - p.x - q.x;
  return {
    x: x,
    y: s*(p.x - x) - p.y
  };
};
```
Note that this definition doesn't work in the case that `p.x = q.x`. This case
splits into the case `p.y = q.y` (in which case its called "doubling" and
there is a separate formula) and the case `p.y = -q.y` in which case a special
"identity" value should be returned.

For efficiency, one uses a different, more complicated
formula for adding curve points. This will be discussed in
the techniques section below.�"md���T����r>@@��@������%pages���s?I��s?N@���s?I��s?N@@��$mnt4���s?O��s?S@���s?I��s?S@@��@������%pages���s?T��s?Y@���s?T��s?Y@@��$mnt6���s?Z��s?^@���s?T��s?^@@@���S}���s?^@@�����"[]���s?_��s?`A@���s?_��s?`A@@���S}���s?`A@���S}���s?`@@@���ROS��s?`@@��������s?a��s?bA@���s?a��s?bA@@���ROS��s?bA@���ROS��s?bA@@���M@D��s?bA@���M@B��s?b@@���L � ���s?b@@���K � ���s?b@@���J � ���s?bA@@���J � ���s?b@@��J � ��s?b@���A�    �#two�� `W\� `W_@@@��Р#One�� `Wb� `We@�@@�� `Wb� `We@@�Р#Two�� `Wh� `Wk@�@@��" `Wf�# `Wk@@@A@@��% `WW�& `Wk@@��( `WW�) `Wk@���@�����*int_of_two��4 bmq�5 bm{@��7 bmq�8 bm{@@��������#One��C bm��D bm�@@��F bm��G bm�@@@���!1@��M bm��N bm�@@������#Two��W bm��X bm�@@��Z bm��[ bm�@@@���!2@��a bm��b bm�@@@��d bm~�e bm�@@@��g bmm�h bm�@@��j bmm�k bm�@���@�����0embedding_degree��v d���w d��@��y d���z d��@@��������$MNT4��� d���� d��@@��� d���� d��@@@���!4@��� d���� d��@@������$MNT6��� d���� d��@@��� d���� d��@@@���!6@��� d���� d��@@@��� d���� d��@@@��� d���� d��@@��� d���� d��@���@�����&group'��� f���� f��@��� f���� f��@@��@@���!f��� f���� f��@��� f���� f��@@��@@���%curve��� f���� f��@��� f���� f��@@��@@���!i��� f���� f��@��� f���� f��@@��@�����!i��� g���� g��@��� g���� g��@@������*int_of_two��� g���� g��@��� g���� g��@@��@����!i�� g��� g� @�� g��� g� @@@��
 g��� g� @@@�� g��� g� @@�������$Name(in_scope�� h� h@�� h� h@@��@������+curve_scope��( h�) h @��+ h�, h @@��@����%curve��5 h!�6 h&@��8 h!�9 h&@@@��; h�< h'@@��@������(ksprintf��G h)�H h1@��J h)�K h1@@��@����!f��T h2�U h3@��W h2�X h3@@��@���$G_%d@��` h4�a h:@@��@����!i��j h;�k h<@��m h;�n h<@@@��p h(�q h=@@@��s h�t h=@@��v g���w h=@@��y f���z h=A@��| f���} h=A@�� f���� h=A@@��� f���� h=@@��� f���� h=@���@�����%group��� j?C�� j?H@��� j?C�� j?H@@������&group'��� j?K�� j?Q@��� j?K�� j?Q@@��@����%latex��� j?R�� j?W@��� j?R�� j?W@@@��� j?K�� j?W@@@��� j??�� j?W@@��� j??�� j?W@���@�����(group_md��� lY]�� lYe@��� lY]�� lYe@@������&group'��� lYh�� lYn@��� lYh�� lYn@@��@������'sprintf��� lYp�� lYw@��� lYp�� lYw@@��@���$$%s$@��� lYx�� lY~@@@��� lYo�� lY@@@��� lYh�� lY@@@��� lYY�� lY@@��� lYY�� lY@���@�������)interface�� n��� n��@�� n���	 n��@@��@������'Problem)Interface!t�� n��� n��@��@�� n��� n��@@@�� n��� n��@@��! n���" ���A@��$ n���% ���A@�  �  !A���'Problem)Interface��0 o���1 o��@�  !A��*Let_syntax��8 p���9 p��@�������*Let_syntax$bind��D q���E ���@@��@��������!!��R q���S q��@��U q���V q��@@��@����%Input��_ q���` q��@@��b q���c q��@@@��e q���f q��@@��@���!n@��n q���o q��@@��@����'Literal��x q���y q�@�����&UInt64��� q��� q�@@��� q��� q�@@��� q���� q�@@@��� q���� q�@@���!f��@@���!n��� q���� q��@��� q���� q��@@��@�����%input��� r�� r@��� r�� r@@��@@������!c��� r�� r@��� r�� r@@����!i��� r �� r!@��� r �� r!@@@��� r�� r"@@��@�����#arr��� s%-�� s%0@��� s%-�� s%0@@����'Literal��� t39�� t3@@������$Type%Array��� uAJ�� uAT@�������'element��� uAV�� uA]@����$Name��� uA_�� uAc@�������(group_md�� uAe� uAm@�� uAe� uAm@@��@����!c�� uAn� uAo@�� uAn� uAo@@��@����!i�� uAp� uAq@��! uAp�" uAq@@@��$ uAd�% uAr@@��' uA_�( uAr@@����&length��/ uAt�0 uAz@����$Some��7 uA|�8 uA�@�����$Name��@ uA��A uA�@�����!n��I uA��J uA�@��L uA��M uA�@@��O uA��P uA�@@��R uA|�S uA�@@@@��U uAU�V uA�@@��X uAI�Y uA�@@��[ t39�\ uA�@@@��^ s%)�_ uA�@@����������i w���j w��@��l w���m w��@@��@����%Input��v w���w w��@@��y w���z w��@@@��| w���} w��@@��@������'sprintf��� w���� w��@��� w���� w��@@��@���&g%d_%d@��� w���� w��@@��@������0embedding_degree��� w���� w��@��� w���� w��@@��@����!c��� w���� w��@��� w���� w��@@@��� w���� w��@@��@������*int_of_two��� w���� w��@��� w���� w��@@��@����!i��� w���� w��@��� w���� w��@@@��� w���� w��@@@��� w���� w��@@��@����#arr��� w���� w��@��� w���� w��@@@��� w���� w��@@��� s%)�� w��@@��� r�� w��A@@��� r�� w��@@��@�����&output��� y���� y��@��� y���� y��@@��@@������!c�� y���	 y��@�� y��� y��@@����!i�� y��� y��@�� y��� y��@@@�� y��� y��@@��������Ӱ�$ z���% z��@��' z���( z��@@��@����&Output��1 z���2 z��@@��4 z���5 z��@@@��7 z���8 z��@@��@������'sprintf��C { �D { @��F { �G { @@��@���&h%d_%d@��O { �P { @@��@������0embedding_degree��[ { �\ { )@��^ { �_ { )@@��@����!c��h { *�i { +@��k { *�l { +@@@��n { �o { ,@@��@������*int_of_two��z { .�{ { 8@��} { .�~ { 8@@��@����!i��� { 9�� { :@��� { 9�� { :@@@��� { -�� { ;@@@��� { �� { <@@��@����$Name��� |=D�� |=H@�������(group_md��� |=J�� |=R@��� |=J�� |=R@@��@����!c��� |=S�� |=T@��� |=S�� |=T@@��@����!i��� |=U�� |=V@��� |=U�� |=V@@@��� |=I�� |=W@@��� |=C�� |=X@@@��� z���� |=X@@��� y���� |=XA@@��� y���� |=X@@��@�����&params��� ~^d�� ~^j@��� ~^d�� ~^j@@������� ~^n�� ~^�A�����������$MNT4��� ~^o�� ~^s@@��� ~^o�� ~^s@@�����#One�� ~^u� ~^x@@�� ~^u� ~^x@@@�� ~^n� ~^y@@�����-�� ~^{� ~^�A�����������$MNT4�� ~^|� ~^�@@��! ~^|�" ~^�@@�����#Two��* ~^��+ ~^�@@��- ~^��. ~^�@@@��0 ~^{�1 ~^�@@�����V��8 ~^��9 ~^�A�����������$MNT6��G ~^��H ~^�@@��J ~^��K ~^�@@�����#One��S ~^��T ~^�@@��V ~^��W ~^�@@@��Y ~^��Z ~^�@@�������a ~^��b ~^�A�����������$MNT6��p ~^��q ~^�@@��s ~^��t ~^�@@�����#Two��| ~^��} ~^�@@�� ~^��� ~^�@@@��� ~^��� ~^�@@��������� ~^��� ~^�A@��� ~^��� ~^�A@@��� ~^��� ~^�A@��� ~^��� ~^�A@@��� ~^��� ~^�A@��� ~^��� ~^�A@@��� ~^{�� ~^�A@��� ~^{�� ~^�A@@��� ~^n�� ~^�A@��� ~^m�� ~^�@@@��� ~^`�� ~^�@@��@�����2__let_syntax__001_��� ���� ��@@������#all��� ���� ��@��� ���� ��@@��@�������$List#map��� ���� ��@��� ���� ��@@���!f����%input��� ���� ��@��� ���� ��@@��@����&params��� ���� ��@��� ���� ��@@@��� ���� ��@@@��� ���� ��@@@��� ���� ��@�����2__let_syntax__002_��� ����	  ���@@������#all��		 ����	
 ���@��	 ����	 ���@@��@�������$List#map��	 ����	 ���@��	 ����	 ���@@���!f����&output��	) ����	* ���@��	, ����	- ���@@��@����&params��	6 ����	7 ��@��	9 ����	: ��@@@��	< ����	= ��@@@��	? ����	@ ��@@@��	B ����	C ��@@������
#map��	L ���	M ���@@��@������$bothee@��@�����kk@��@����f%%@@q@��װ�@@������&_input��	o ���	p ��@�@����'_output��	w ����	x ���@{@@�@��@�����$desc��	� �
�	� �
@��	� �
�	� �
@@��@@������!g��	� �
�	� �
@��	� �
�	� �
@@����!i��	� �
�	� �
@��	� �
�	� �
@@@��	� �
�	� �
@@��@�����!k��	� �&�	� �'@��	� �&�	� �'@@������0embedding_degree��	� �*�	� �:@��	� �*�	� �:@@��@����!g��	� �;�	� �<@��	� �;�	� �<@@@��	� �*�	� �<@@@��	� �"�	� �<@@��@�����!j��	� �@H�	� �@I@��	� �@H�	� �@I@@������*int_of_two��	� �@L�	� �@V@��	� �@L�	� �@V@@��@����!i��	� �@W�	� �@X@��	� �@W�	� �@X@@@��	� �@L�	� �@X@@@��	� �@D�	� �@X@@������'sprintf��
 �\`�
	 �\g@��
 �\`�
 �\g@@��@���	s`h%d_%d` should be `g%d_%d[0] + g%d_%d[1] + ... + g%d_%d[n - 1]` where `+` is the group operation for the curve %s.@��
 �hn�
 ���@@��@����!k��
 ����
 ���@��
! ����
" ���@@��@����!j��
+ ����
, ���@��
. ����
/ ���@@��@����!k��
8 ����
9 ���@��
; ����
< ���@@��@����!j��
E ����
F ���@��
H ����
I ���@@��@����!k��
R ����
S ���@��
U ����
V ���@@��@����!j��
_ ����
` ���@��
b ����
c ���@@��@����!k��
l ����
m �� @��
o ����
p �� @@��@����!j��
y ���
z ��@��
| ���
} ��@@��@�������$Name+to_markdown��
� ��
� �*@��
� ��
� �*@@��@������(group_md��
� �
�
� �@��
� �
�
� �@@��@����!g��
� ��
� �@��
� ��
� �@@��@����!i��
� ��
� �@��
� ��
� �@@@��
� �
�
� �@@@��
� �	�
� �+@@@��
� �\`�
� �+@@��
� �@D�
� �+@@��
� �"�
� �+@@��
� �
�
� �+A@@��
� �
�
� �+@@�������(Markdown)of_string��
� ����
� ���@��
� ����
� ���@@��@������'sprintf��
� �13�
� �1:@��
� �13�
� �1:@@��@���&%s

%s@��
� �1;�
� �1E@@��@�����+Gpu_message!t��
� �1F�
� �1S@�� �1F� �1S@@��@�������&String&concat�� �TY� �Tf@�� �TY� �Tf@@���#sep���"

@�� �Tl� �Tr@@��@�������$List#map��+ �Tt�, �T|@��. �Tt�/ �T|@@���!f����$desc��: �T��; �T�@��= �T��> �T�@@��@����&params��G �T��H �T�@��J �T��K �T�@@@��M �Ts�N �T�@@@��P �TX�Q �T�@@@��S �13�T �T�@@@��V �13�W ���@@��Y �
�Z ���@@@@@@��\ ~^`�] ���@@��_ y���` ���@@��b r�c ���@@!@@!@��e p���f ���@@��h o���i ���@@������^]\��q n���r n��@��@��v n���w n��@@@��y n���z n��@@��| n���} ���A@@�� n���� ���@@��� n���� ���@���@�����)postamble��� ����� ���@��� ����� ���@@��@@�����%pages��� ����� ���@��� ����� ���@@�����%Pages!t��� ����� ���@@��� ����� ���@@��� ����� ���@@�  !A��.Sectioned_page��� ����� ���@��@�����"md��� ����� ���@��� ����� ���@@��@@���#fmt��� ����� ���@��� ����� ���@@������(ksprintf��� ����� ���@��� ����� ���@@��@��@@���!s��� ���� ��@��� ���� ��@@������$leaf��� ���� ��@��� ���� ��@@��@�������(Markdown)of_string�� ��� �� @��
 ��� �� @@��@����!s�� ��!� ��"@�� ��!� ��"@@@�� ��� ��#@@@�� ��� ��#@@��  ����! ��$@@��@����#fmt��* ��%�+ ��(@��- ��%�. ��(@@@��0 ����1 ��(@@��3 ����4 ��(A@@��6 ����7 ��(@@����
[��= �,0�> �XaA����������#sec��K �,0�L �,3@��N �,0�O �,3@@���%title���,Starter code@��Y �,;�Z �,I@@��@����
���b �JR�c �.PA����������"md��p �JR�q �JT@��s �JR�t �JT@@��@���	�- This [repo](https://github.com/codaprotocol/cuda-fixnum) has a CUDA solution for the [first challenge](%s),
          which is somewhat similar to this one. You can clone that repo to get started.�"md��~ �U_� ��-@@��@������%pages��� �.8�� �.=@��� �.8�� �.=@@��0field_arithmetic��� �.>�� �.N@��� �.8�� �.N@@@��� �JR�� �.N@@�����	Ӱ�� �.O�� �.PA@��� �.O�� �.PA@@��� �JR�� �.PA@��� �JP�� �.P@@@��� �,0�� �.P@@�����
Ӱ�� �QU�� �XaA����������"md��� �QU�� �QW@��� �QU�� �QW@@��@���	MPlease see [this page](%s) for a more full list of implementation techniques.�"md��� �X^�� �X�@@��@������%pages��� ����� ���@��� ����� ���@@��9implementation_strategies��� ����� ���@��� ����� ���@@@��� �QU�� ���@@�������� ����� �XaA����������#sec�� ���� ���@�� ���� ���@@���%title���*Techniques@�� ���� ���@@��@����7�� ���� ���A����������#sec��' ����( ��@��* ����+ ��@@���%title���2Coordinate systems@��5 ��	�6 ��@@��@����\��> �*�? ���A����������"md��L �*�M �,@��O �*�P �,@@��@���
  �Points in the form $(x, y)$ as above are said to be
represented using *affine coordinates*
and the above definition is *affine* curve addition.

There are more efficient ways of adding
curve points which use different coordinate systems.
The most efficient of these is called
*Jacobian coordinates*. Formulas for addition and doubling in Jacobian
coordinates can be found [here](https://www.hyperelliptic.org/EFD/g1p/auto-shortw-jacobian.html#doubling-dbl-2007-bl)
and a Rust implementation [here](https://github.com/CodaProtocol/pairing/blob/mnt46-753/src/mnt4_753/ec.rs#L374).

There is a further technique called "mixed addition" which allows one to add
a point in Jacobian coordinates to a point in affine coordinates even more efficiently than adding
two points in Jacobian coordinates. This technique can yield large efficiency
gains but makes taking advantage of parallelism more complicated.�"md��Z �-;�[ ���@@@��] �*�^ ���@@�����
���e ����f ���A@��h ����i ���A@@��k �*�l ���A@��n �(�o ���@@@��q ����r ���@@�����
���y ����z ���A@��| ����} ���A@@�� ����� ���A@��� ����� ���@@@��� ����� ���@@��������� ����� �XaA����������#sec��� ����� ���@��� ����� ���@@���%title���+Parallelism@��� ����� ���@@��@����а�� ����� �X_A����������"md��� ����� ���@��� ����� ���@@��@���	HThis problem is an instance of a *reduction* and is inherently parallel.�"md��� ���� ��W@@@��� ����� ��W@@�������� �X^�� �X_A@��� �X^�� �X_A@@��� ����� �X_A@��� ����� �X_@@@��� ����� �X_@@�������� �X`�� �XaA@��� �X`�� �XaA@@��� ����� �XaA@��� ����� �XaA@@��� ����� �XaA@��� ����� �XaA@@��� �QU�  �XaA@�� �QU� �XaA@@�� �,0� �XaA@�� �,.�	 �Xa@@�� ���� �Xa@@�� ���� �Xa@@�� ���� �XaA@@�� ���� �Xa@@�� ���� �Xa@���@�������'problem��% ����& ���@��( ����) ���@@��@�����'Problem!t��4 ����5 ���@@��7 ����8 ���@@��: ����; �  �A@��= ����> �  �A@�  ������%title��I ����J ���@���0Curve operations@��P ����Q ���@@����-quick_details��X ����Y ���@������+description��b ����c ���@�������(Markdown)of_string��n ����o ��@��q ����r ��@@��@���	OAdd together an array of elements of each of the four relevant elliptic curves.@��z ��{ �Zx@@@��} ����~ �Zx@@����%prize��� �y��� �y�@�������%Prize&stage1��� �y��� �y�@��� �y��� �y�@@��@���#200@��� �y��� �y�@@@��� �y��� �y�@@@@��� ����� �y�@@����(preamble��� ����� ���@������� ����� ���@��� ����� ���@@����)interface��� ����� ���@������� ����� ���@��� ����� ���@@����8reference_implementation��� ����� ���@������$repo��� ����� ���@���	Yhttps://github.com/CodaProtocol/snark-challenge/tree/master/reference-04-curve-operations@��� ����� ��G@@����$main��� �HP�� �HT@���	hhttps://github.com/CodaProtocol/snark-challenge/tree/master/reference-04-curve-operations/libff/main.cpp@��� �V`�� �V�@@����$core��� ����� ���@���	�https://github.com/CodaProtocol/snark-challenge/blob/master/reference-04-curve-operations/libff/algebra/curves/mnt753/mnt4753/mnt4753_g1.cpp#L135@��� ����� �� v@@@@�� ���� � w ~@@����)postamble��	 �  ��
 �  �@������ �  �� �  �@�� �  �� �  �@@@@�� ���� �  �@@�������� ���� ���@@��! ����" ���@@��$ ����% �  �A@@��' ����( �  �@@��* ����+ �  �@@