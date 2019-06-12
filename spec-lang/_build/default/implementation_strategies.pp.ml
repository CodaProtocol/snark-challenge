Caml1999M023����         	   <implementation_strategies.ml����  8�  �  M  ܠ����1ocaml.ppx.context��&_none_A@ �A����������)tool_name���-ppxlib_driver@@����,include_dirs����"[]@@����)load_path!����
%@%@����,open_modules*����.@.@����+for_package3����$None8@8@����%debug=����%falseB@B@����+use_threadsG����
K@K@����-use_vmthreadsP����T@T@����'cookiesY����"::^����������/ppx_optcomp.env@i@�������#env��&_none_A@ �A@���-ocaml_version����'Defined�������!4@@����!7@@����!1@@@@@@@@�@�����y�@�@@�@�@@@�@@�@�������$Core��<implementation_strategies.mlA@E�A@I@A��A@@�A@I@@��A@@�A@I@������$Util��BJO�BJS@A��BJJ�BJS@@��BJJ�BJS@������.Sectioned_page��!CTY�"CTg@A��$CTT�%CTg@@��'CTT�(CTg@���@�����#url��3Eim�4Eip@��6Eim�7Eip@@������'sprintf��@Eis�AEiz@��CEis�DEiz@@��@���2%s/strategies.html@��LEi{�MEi O@@��@����(base_url��VEi P�WEi X@��YEi P�ZEi X@@@��\Eis�]Ei X@@@��_Eii�`Ei X@@��bEii�cEi X@���@�����&page_t��nG Z ^�oG Z d@��qG Z ^�rG Z d@@��@@�����%pages��|G Z f�}G Z k@��G Z f��G Z k@@�����%Pages!t���G Z n��G Z u@@���G Z n��G Z u@@���G Z e��G Z v@@����"::���H y }�� Gu�A����������(ksprintf���H y }��H y �@���H y }��H y �@@��@����$text���H y ���H y �@���H y ���H y �@@��@���	�This page has suggestions for how to implement the best Groth16 SNARK
prover ([described here](%s)) to take home up to $75,000 in prizes.�"md���I � ���J �"@@��@������%pages���K#)��K#.@���K#)��K#.@@��'groth16���K#/��K#6@���K#)��K#6@@@���H y }��K#6@@�����M���L7;�� Gu�A����������#sec���L7;��L7>@���L7;��L7>@@���%title���	-Splitting computation between the CPU and GPU@���L7F� L7u@@��@����r��Mv~�	Y��A����������(ksprintf��Mv~�Mv�@��Mv~�Mv�@@��@����$text��#Mv��$Mv�@��&Mv��'Mv�@@��@���
  �The Groth16 prover consists of 4 $G_1$ multiexponentiations, 1 $G_2$ multiexponentiation,
and 7 FFTs, as described [here](%s).

1 of the $G_1$ multiexponentiations cannot be computed until all of the FFTs.
The other 3 $G_1$ multiexponentiations and the $G_2$ multiexponentiation however
don't have any dependencies between each other or on any other computation.

So, some of them can be computed on the CPU while at the same time others are computed on the GPU.
For example, you could first the FFTs first on the CPU, while simultaneously performing 2 of
the $G_1$ multi-exponentiations on the GPU. After those completed, you could then compute the
final $G_1$ multi-exponentiation on the CPU and the $G_2$ multi-exponentiation on the GPU.�"md��1N���2X$�@@��@������%pages��=Y���>Y��@��@Y���AY��@@��'groth16��FY���GY��@��IY���JY��@@@��LMv~�MY��@@�����"[]��UY���VY��A@��XY���YY��A@@��[Mv~�\Y��A@��^Mv|�_Y��@@@��aL7;�bY��@@�����Ӱ�iZ���j Gu�A����������#sec��wZ���xZ��@��zZ���{Z��@@���%title���+Parallelism@���Z����Z��@@��@��������[����l�	A����������$text���[����[��@���[����[��@@��@���	�Both the FFT and the multiexponentiations are massively parallelizable.
        The multiexponentiation in particular is an instance of a reduction: combining
        an array of values together using a binary operation.�"md���\����^t�@@@���[����^t�@@��������_����l�	A����������#sec���_����_��@���_����_��@@���%title���6Parallelism on the CPU@���_����_��@@��@����D���`����g��A����������$text���`����`��@���`����`��@@��@���
  �[libsnark](https://github.com/scipr-lab/libsnark)'s "sub-libraries"
[libff](https://github.com/scipr-lab/libff/) and
[libfqfft](https://github.com/scipr-lab/libfqfft) implement parallelized
multiexponentiation (code [here](https://github.com/scipr-lab/libff/blob/master/libff/algebra/scalar_multiplication/multiexp.tcc#L402)) and
FFT (code [here](https://github.com/scipr-lab/libfqfft/blob/master/libfqfft/evaluation_domain/domains/basic_radix2_domain_aux.tcc#L81))
respectively.�"md���a���f��@@@���`����f��@@��������g���g��A@��g���g��A@@��`���g��A@��
`���g��@@@��_���g��@@�������h���l�	A����������#sec��#h���$h� @��&h���'h� @@���%title���6Parallelism on the GPU@��1h��2h� @@��@�������:i!-�;l�	A����������$text��Hi!-�Ii!1@��Ki!-�Li!1@@��@���	�Check out [this CUDA code](https://github.com/NVIDIA/cuda-samples/tree/master/Samples/reduction)
which implements a parallel reduction in CUDA to sum up an array of 32-bit ints.�"md��Vj2@�Wk��@@@��Yi!-�Zk��@@�������al�	�bl�	A@��dl�	�el�	A@@��gi!-�hl�	A@��ji!+�kl�	@@@��mh���nl�	@@�����!��ul�	�vl�	A@��xl�	�yl�	A@@��{h���|l�	A@��~h���l�	A@@���_����l�	A@���_����l�	A@@���[����l�	A@���[����l�	@@@���Z����l�	@@���������m		�� Gu�A����������#sec���m		��m		@���m		��m		@@���%title���0Field arithmetic@���m		��m		)@@��@����$���n	*	2��t
�
�A����������$text���n	*	2��n	*	6@���n	*	2��n	*	6@@��@���
  ~There is an excellent CUDA implementation of modular-multiplication using Montgomery representation
[here](https://github.com/data61/cuda-fixnum). Using that library to implement the field extension 
multiplication and curve-additions
and then building a parallel reduction for curve-addition is likely an excellent path to
creating a winning implementation of multi-exponentiation.�"md���o	7	A��s
�
�@@@���n	*	2��s
�
�@@���������t
�
���t
�
�A@���t
�
���t
�
�A@@���n	*	2��t
�
�A@���n	*	0��t
�
�@@@���m		��t
�
�@@�����_���u
�
��� Gu�A����������#sec��u
�
��u
�
�@��u
�
��u
�
�@@���%title���;Optimizing curve arithmetic@��u
�
��u
�
�@@��@�������v
�� Gu�A����������#sec��(v
��)v
�@��+v
��,v
�@@���%title���8Representation of points@��6v
��7v
�*@@��@�������?w+7�@ C��A����������$text��Mw+7�Nw+;@��Pw+7�Qw+;@@��@���
  mThere are many ways of representing curve points which yield efficiency improvements.
Probably the best is [Jacobian coordinates]() which allow for doubling points with
$4$ multiplications and adding points with 12 multiplications.

If some of the points
are statically known, as in the case of an exponentiation, they can be represented in
affine coordinates and one can take advantage of "mixed-addition". Mixed-addition allows you
to add a point in affine cordinates to a point in Jacobian coordinates to obtain a point in
Jacobian coordinates at a cost of 8 multiplications.

There are likely many other optimizations�"md��[x<J�\ B��@@@��^w+7�_ B��@@�������f C���g C��A@��i C���j C��A@@��lw+7�m C��A@��ow+5�p C��@@@��rv
��s C��@@�������z D���{ Gu�A����������#sec��� D���� D��@��� D���� D��@@���%title���9Exponentiation algorithms@��� D���� D��@@��@����	��� E��� Gu�A����������$text��� E��� E�@��� E��� E�@@��@���	RThere are many techniques for speeding up exponentiation and multi-exponentiation.�"md��� F�� Ft@@@��� E��� Ft@@�����r��� Gu�� Gu�A@��� Gu�� Gu�A@@��� E��� Gu�A@��� E��� Gu�@@@��� D���� Gu�@@��������� Gu��� Gu�A@��� Gu��� Gu�A@@��� D���� Gu�A@��� D���� Gu�A@@���v
��� Gu�A@���v
��� Gu�@@@���u
�
��� Gu�@@��������� Gu��� Gu�A@��� Gu��� Gu�A@@���u
�
��� Gu�A@���u
�
��� Gu�A@@�� m		� Gu�A@��m		� Gu�A@@��Z��� Gu�A@��	Z���
 Gu�A@@��L7;� Gu�A@��L7;� Gu�A@@��H y }� Gu�A@��H y {� Gu�@@��G Z e� Gu�A@@��G Z Z� Gu�@@��G Z Z� Gu�@���@�����%_page��* I���+ I��@��- I���. I��@@��@@�����%pages��8 I���9 I��@��; I���< I��@@�����%Pages!t��E I���F I��@@��H I���I I��@@��K I���L I��@@�  ������(ksprintf��W J���X J��@��Z J���[ J��@@��@�����$Html(markdown��f J���g J��@��i J���j J��@@��@���
  # Implementation suggestions

This page has suggestions for how to implement the best Groth16 SNARK
prover ([described here](%s)) to take home up to $75,000 in prizes.

## Splitting computation between the CPU and GPU
The Groth16 prover consists of 4 $G_1$ multiexponentiations, 1 $G_2$ multiexponentiation,
and 7 FFTs, as described [here](%s).

1 of the $G_1$ multiexponentiations cannot be computed until all of the FFTs.
The other 3 $G_1$ multiexponentiations and the $G_2$ multiexponentiation however
don't have any dependencies between each other or on any other computation.

So, some of them can be computed on the CPU while at the same time others are computed on the GPU.
For example, you could first the FFTs first on the CPU, while simultaneously performing 2 of
the $G_1$ multi-exponentiations on the GPU. After those completed, you could then compute the
final $G_1$ multi-exponentiation on the CPU and the $G_2$ multi-exponentiation on the GPU.

## Parallelism
Both the FFT and the multiexponentiations are massively parallelizable.
The multiexponentiation in particular is an instance of a reduction: combining
an array of values together using a binary operation. 

### Parallelism on the CPU
[libsnark](https://github.com/scipr-lab/libsnark)'s "sub-libraries"
[libff](https://github.com/scipr-lab/libff/) and
[libfqfft](https://github.com/scipr-lab/libfqfft) implement parallelized
multiexponentiation (code [here](https://github.com/scipr-lab/libff/blob/master/libff/algebra/scalar_multiplication/multiexp.tcc#L402)) and
FFT (code [here](https://github.com/scipr-lab/libfqfft/blob/master/libfqfft/evaluation_domain/domains/basic_radix2_domain_aux.tcc#L81))
respectively.


### Parallelism on the GPU
Check out [this CUDA code](https://github.com/NVIDIA/cuda-samples/tree/master/Samples/reduction)
which implements a parallel reduction in CUDA to sum up an array of 32-bit ints.

## Field arithmetic
There is an excellent CUDA implementation of modular-multiplication using Montgomery representation
[here](https://github.com/data61/cuda-fixnum). Using that library to implement the field extension 
multiplication and curve-additions
and then building a parallel reduction for curve-addition is likely an excellent path to
creating a winning implementation of multi-exponentiation.

## Optimizing curve arithmetic
### Representation of points

There are many ways of representing curve points which yield efficiency improvements.
Probably the best is [Jacobian coordinates]() which allow for doubling points with
$4$ multiplications and adding points with 12 multiplications.

If some of the points
are statically known, as in the case of an exponentiation, they can be represented in
affine coordinates and one can take advantage of "mixed-addition". Mixed-addition allows you
to add a point in affine cordinates to a point in Jacobian coordinates to obtain a point in
Jacobian coordinates at a cost of 8 multiplications.

There are likely many other optimizations 

### Exponentiation algorithms
There are many techniques for speeding up exponentiation and multi-exponentiation.
�"md��t K���u ���@@��@������%pages��� ����� ���@��� ����� ���@@��'groth16��� ����� ���@��� ����� ���@@��@������%pages��� �� �� ��@��� �� �� ��@@��'groth16��� ���� ��@��� �� �� ��@@@��� J���� ��@@�����$Html!t��� I���� I��@@��� I���� I��@@��� I���� ��A@��� I���� ��A@@��� I���� ��@@��� I���� ��@���@�����$page��� ��� �@��� ��� �@@��@@���%pages��� ��� �@��� ��� �@@��@�����!t��� � &�� � '@��� � &�� � '@@������&page_t��� � *�� � 0@��� � *�� � 0@@��@����%pages��  � 1� � 6@�� � 1� � 6@@@�� � *� � 6@@@��	 � "�
 � 6@@��@�����#toc�� �:@� �:C@�� �:@� �:C@@������1table_of_contents��! �:F�" �:W@��$ �:F�% �:W@@��@����!t��. �:X�/ �:Y@��1 �:X�2 �:Y@@@��4 �:F�5 �:Y@@@��7 �:<�8 �:Y@@��@�����'content��B �]c�C �]j@��E �]c�F �]j@@������2render_to_markdown��O �]m�P �]@��R �]m�S �]@@��@����!t��\ �]��] �]�@��_ �]��` �]�@@@��b �]m�c �]�@@@��e �]_�f �]�@@������(ksprintf��o ����p ���@��r ����s ���@@��@�����(Markdown)of_string��~ ���� ���@��� ����� ���@@��@�  ����&Format��� ����� ���@��������.String_literal�������<# Implementation strategies
@@�����&Custom��������+Custom_succ#�����+Custom_zero)@)@)@���@@����"()1@1@��@@���4_custom_printf__001_77@�������$Html)to_string@@@��@����FF@@F@F@F@�����@K�������"

@S@�����&StringY��������*No_paddingb@b@�����-End_of_formath@h@@h@h@@h@h@@h@h@@h@h@����	'# Implementation strategies
%{Html}

%s@m@@m@m@�����8CamlinternalFormatBasics'format6t��@v@��@x@��@z@��@|@��@~@��@�@@�@�@��@����#toc�� ���� ���@�� ���� ���@@��@����'content��! ����" ���@��$ ����% ���@@@��' ����( ���@@��* �]_�+ ���@@��- �:<�. ���@@��0 � "�1 ���@@��3 ��4 ���A@@��6 ��7 ���@@��9 ��: ���@@