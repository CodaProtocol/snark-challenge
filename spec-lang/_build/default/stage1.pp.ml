Caml1999M023����   
         )stage1.ml����  >  	�  'v  %�����1ocaml.ppx.context��&_none_A@ �A����������)tool_name���-ppxlib_driver@@����,include_dirs����"[]@@����)load_path!����
%@%@����,open_modules*����.@.@����+for_package3����$None8@8@����%debug=����%falseB@B@����+use_threadsG����
K@K@����-use_vmthreadsP����T@T@����'cookiesY����"::^����������/ppx_optcomp.env@i@�������#env��&_none_A@ �A@���-ocaml_version����'Defined�������!4@@����!7@@����!1@@@@@@@@�@�����y�@�@@�@�@@@�@@�@�������$Core��)stage1.mlA@E�A@I@A��A@@�A@I@@��A@@�A@I@������$Util��BJO�BJS@A��BJJ�BJS@@��BJJ�BJS@���@�����%_page��#DUY�$DU^@��&DUY�'DU^@@��@@�����%pages��1DU`�2DUe@��4DU`�5DUe@@�����%Pages!t��>DUh�?DUo@@��ADUh�BDUo@@��DDU_�EDUp@@�  !A��.Sectioned_page��LEs~�MEs L@����"::��TF P T�U W��A����������#sec��bF P T�cF P W@��eF P T�fF P W@@���%title���'Stage 1@��pF P _�qF P h@@��@����&��yG i q�zq	"	VA����������$leaf���a5��a9@���a5��a9@@��@�������(Markdown)of_string���a��a1@���a��a1@@��@���
  �Want to learn cutting edge cryptography, GPU programming and get
paid to do it? Then you're in the right place.

In this stage, you'll implement the sub-algorithms you need to
implement the full SNARK prover and you'll get paid to do so.
The first 10 participants who complete the four challenges in this stage
will receive $200 and a *SNARK Challenge* swag-bag.
They'll also be very well positioned to apply their solutions to
create submissions for $55,000 of the $75,000 in prizes up for grabs in the second stage.

Let's dive into it and give a quick overview of the SNARK prover so
we have an idea of where we're going. The SNARK prover itself
consists of two sub-algorithms: 

1. Multi-exponentiation on an elliptic curve.
2. Fast fourier transform (FFT) over a finite field.

The cool thing about both of these algorithms is that they're massively
parallel and ideally suited to implementation on GPU, which we expect to
help take the top prize in the challenge. The multi-exponentiation in
particular is just a big [reduction](https://developer.download.nvidia.com/assets/cuda/files/reduction.pdf),
although the reduction function requires some work to describe.

These 2 algorithms themselves have sub-algorithms which you'll need to implement first.
In total, the first stage has 4 challenges. After implementing these challenges you'll
be well on your way to having a complete GPU implementation of the SNARK prover itself.�"md���G i q��`�@@@���G i q��a1@@@���G i q��a9@@�����a���b:B��q	"	VA����������#sec���b:B��b:E@���b:B��b:E@@���%title���6The stage 1 challenges@���b:M��b:e@@��@��������cfr��q	"	TA����������(ksprintf���cfr��cfz@���cfr��cfz@@��@�������"Fn'compose���d{���d{�@���d{���d{�@@��@����$leaf��d{��d{�@��d{��	d{�@@��@�����(Markdown)of_string��d{��d{�@��d{��d{�@@@��d{��d{�@@��@���
  �The stage 1 challenges are

1. [Finite field arithmetic](%s). Reward of $50.
2. [Quadratic extension arithmetic](%s). Reward of $25.
3. [Cubic extension arithmetic](%s). Reward of $25.
4. [Elliptic curve operations](%s). Reward of $100.

You'll want to get started with the first challenge, [finite field arithmetic](%s),
and work your way through the others. If you want to get a sense for how all these
algorithms come together to build the whole prover, check out [this page](%s).�"md��%e���&nU�@@��@������%pages��1o���2o��@��4o���5o��@@��0field_arithmetic��:o���;o��@��=o���>o��@@��@������%pages��Io���Jo��@��Lo���Mo��@@��3quadratic_extension��Ro���So��@��Uo���Vo��@@��@������%pages��ap���bp��@��dp���ep��@@��/cubic_extension��jp���kp�	
@��mp���np�	
@@��@������%pages��yp�	�zp�	@��|p�	�}p�	@@��0curve_operations���p�	��p�	!@���p�	��p�	!@@��@������%pages���q	"	0��q	"	5@���q	"	0��q	"	5@@��0field_arithmetic���q	"	6��q	"	F@���q	"	0��q	"	F@@��@������%pages���q	"	G��q	"	L@���q	"	G��q	"	L@@��%intro���q	"	M��q	"	R@���q	"	G��q	"	R@@@���cfr��q	"	R@@�����"[]���q	"	S��q	"	TA@���q	"	S��q	"	TA@@���cfr��q	"	TA@���cfp��q	"	T@@@���b:B��q	"	T@@��������q	"	U��q	"	VA@���q	"	U��q	"	VA@@���b:B��q	"	VA@���b:B��q	"	VA@@���G i q��q	"	VA@���G i o��q	"	V@@@���F P T��q	"	V@@���������r	W	[�� W��A����������#sec���r	W	[��r	W	^@�� r	W	[�r	W	^@@���%title���'Stage 2@��r	W	f�r	W	o@@��@�������s	p	x� W��A����������$leaf��"v
4
U�#v
4
Y@��%v
4
U�&v
4
Y@@��@�������(Markdown)of_string��3v
4
?�4v
4
Q@��6v
4
?�7v
4
Q@@��@���	�Stage 2 is the main stage of the challenge with a total of $95,000 in prizes.
The challenges break into two categories: implementation and theory. Let's
start with implementation.�"md��As	p	x�Bu

3@@@��Ds	p	x�Ev
4
Q@@@��Gs	p	x�Hv
4
Y@@��������Ow
Z
b�P W��A����������#sec��]w
Z
b�^w
Z
e@��`w
Z
b�aw
Z
e@@���%title���9Implementation challenges@��kw
Z
m�lw
Z
�@@��@����!��tx
�
��u N+A����������(ksprintf���x
�
���x
�
�@���x
�
���x
�
�@@��@�������"Fn'compose���y
�
���y
�
�@���y
�
���y
�
�@@��@����$leaf���y
�
���y
�
�@���y
�
���y
�
�@@��@�����(Markdown)of_string���y
�
���y
�
�@���y
�
���y
�
�@@@���y
�
���y
�
�@@��@���
  &These challenges all build on the challenges of stage 1. Stage 2 officially starts on
June 3, but we will add information regarding these challenges as they are 
finalized in case you want to get a head start.

The challenges are

1. [Writing the fastest Groth16 SNARK prover](%s) on a machine with these [specs](https://github.com/CodaProtocol/snark-challenge/blob/master/descriptions/testing_platform.markdown)
    The prizes here total $55,000.
    
2. Writing the fastest in-browser implementation of the Groth16 SNARK verifier.
    Acceptable submissions would compile to WebAssembly or JavaScript.
    The fastest entry will receive $10,000.

3. Fastest Groth16 SNARK prover for CPU.

4. The code golf prize: Shortest Groth16 prover.

5. Most creative Groth16 prover.

5. Most elegant Groth16 prover.�"md���z
�
��� M�@@��@������%pages��� N�� N!@��� N�� N!@@��'groth16��� N"�� N)@��� N�� N)@@@���x
�
��� N)@@�����#��� N*�� N+A@��� N*�� N+A@@���x
�
��� N+A@���x
�
��� N+@@@���w
Z
b�� N+@@��������� O,4�� W��A����������#sec�� O,4� O,7@�� O,4�	 O,7@@���%title���4The theory challenge@�� O,?� O,U@@��@����ɰ� PVb� W��A����������(ksprintf��* PVb�+ PVj@��- PVb�. PVj@@��@�������"Fn'compose��; Qkz�< Qk�@��> Qkz�? Qk�@@��@����$leaf��H Qk��I Qk�@��K Qk��L Qk�@@��@�����(Markdown)of_string��W Qk��X Qk�@��Z Qk��[ Qk�@@@��] Qky�^ Qk�@@��@���
  The theory challenge asks participants to
find a collection of elliptic curves which enable extremely efficient recursive
composition. The prize is $20,000 for the best construction. You can find a problem
description, along with more background and resources [here](%s).
�"md��h R���i V��@@��@������%pages��t W���u W��@��w W���x W��@@��&theory��} W���~ W��@��� W���� W��@@@��� PVb�� W��@@�����˰�� W���� W��A@��� W���� W��A@@��� PVb�� W��A@��� PV`�� W��@@@��� O,4�� W��@@�����߰�� W���� W��A@��� W���� W��A@@��� O,4�� W��A@��� O,4�� W��A@@���w
Z
b�� W��A@���w
Z
b�� W��A@@���s	p	x�� W��A@���s	p	v�� W��@@@���r	W	[�� W��@@��������� W���� W��A@��� W���� W��A@@���r	W	[�� W��A@���r	W	[�� W��A@@���F P T�� W��A@���F P R�� W��@@���Esu�� W��@@���DU_�� W��A@@���DUU�� W��@@���DUU�� W��@���@�����%_page��� Y���� Y��@��� Y���� Y��@@��@@�����%pages��� Y���� Y��@��� Y���� Y��@@�����%Pages!t�� Y��� Y�@@�� Y��� Y�@@�� Y��� Y�@@��@�����$main�� Z� Z@�� Z� Z@@�  !A��)Challenge�� [� [(@��@�������5programmer_challenges��* \,4�+ \,I@��- \,4�. \,I@@��@����$list��7 \,X�8 \,\@������)Challenge!t��B \,L�C \,W@@��E \,L�F \,W@@@��H \,L�I \,\@@��K \,4�L f��A@��N \,4�O f��A@�  ������W ]_g�X f��A����������)challenge��e ]_g�f ]_p@��h ]_g�i ]_p@@��@���	7SNARK prover challenges (performance, mobile, creative)@��q ]_q�r ]_�@@���#url������%pages�� ^���� ^��@��� ^���� ^��@@��'groth16��� ^���� ^��@��� ^���� ^��@@���%short���&prover@��� ^���� ^��@@���'dollars���&70_000@��� ^���� ^��@@��@����"[]��� _���� d7;@@��� _���� d7;@@@��� ]_g�� d7;@@�����f��� e<D�� f��A����������)challenge��� e<D�� e<M@��� e<D�� e<M@@��@���8SNARK verifier challenge@��� e<N�� e<h@@���%short���(verifier@��� e<p�� e<z@@���'dollars���&10_000@��� e<��� e<�@@��@����H��� f���� f��@@��� f���� f��@@@��� e<D�� f��@@�����@��  f��� f��A@�� f��� f��A@@�� e<D� f��A@��	 e<D�
 f��A@@�� ]_g� f��A@�� ]_e� f��@@������ \,X� \,\@�������ް� \,L�  \,W@@��" \,L�# \,W@@@��% \,L�& \,\@@��( \,4�) f��A@@��+ \,0�, f��@@��@�������1stage1_challenges��8 h���9 h��@��; h���< h��@@��@����$list��E h���F h��@������)Challenge!t��P h���Q h��@@��S h���T h��@@@��V h���W h��@@��Y h���Z j6A@��\ h���] j6A@�  ������e i���f j6A����������)challenge��s i���t i��@��v i���w i��@@���*per_person����$true��� i���� i��@@��� i���� i��@@��@���3Tutorial challenges@��� i���� i�@@���%short���(tutorial@��� i��� i�@@���'dollars���#500@��� j.�� j1@@��@������� j2�� j4@@��� j2�� j4@@@��� i���� j4@@��������� j5�� j6A@��� j5�� j6A@@��� i���� j6A@��� i���� j6@@�������� h���� h��@����������� h���� h��@@��� h���� h��@@@��� h���� h��@@��� h���� j6A@@��� h���� j6@@��@�������1theory_challenges��� t�� t(@��� t�� t(@@��@����$list��� t7�� t;@������)Challenge!t�� t+� t6@@�� t+�	 t6@@@�� t+� t;@@�� t� v��A@�� t� v��A@�  ����ǰ� u>F� v��A����������)challenge��( u>F�) u>O@��+ u>F�, u>O@@��@���	5Construct an optimal graph of pairing-friendly curves@��4 u>P�5 u>�@@���%short���&theory@��? v���@ v��@@���'dollars���&20_000@��J v���K v��@@��@�������S v���T v��@@��V v���W v��@@@��Y u>F�Z v��@@��������a v���b v��A@��d v���e v��A@@��g u>F�h v��A@��j u>D�k v��@@����x��q t7�r t;@������wv��z t+�{ t6@@��} t+�~ t6@@@��� t+�� t;@@��� t�� v��A@@��� t�� v��@@��@�����*challenges��� x���� x��@��� x���� x��@@��@@���!c��� x���� x��@��� x���� x��@@������'unlines��� x���� x��@��� x���� x��@@��@�������$List#map��� x���� x��@��� x���� x��@@��@����!c��� x���� x��@��� x���� x��@@���!f�����)Challenge&render��� x���� x��@��� x���� x��@@@��� x���� x��@@@��� x���� x��@@��� x���� x��A@@��� x���� x��@@������(ksprintf��� y�� y@��� y�� y@@��@�����(Markdown)of_string�� y� y @�� y� y @@��@���	F## For programmers and cryptographers
%s
%s

## For cryptographers
%s
�"md�� z!'� �qu@@��@������*challenges�� �v}� �v�@�� �v}� �v�@@��@����5programmer_challenges��( �v��) �v�@��+ �v��, �v�@@@��. �v|�/ �v�@@��@������*challenges��: ����; ���@��= ����> ���@@��@����1stage1_challenges��G ����H ���@��J ����K ���@@@��M ����N ���@@��@������*challenges��Y ����Z ���@��\ ����] ���@@��@����1theory_challenges��f ����g ���@��i ����j ���@@@��l ����m ���@@@��o y�p ���@@��r x���s ���@@��u t�v ���@@��x h���y ���@@��{ \,0�| ���@@��~ [� ���@@@��� Z�� ���@@��@�����%intro��� ����� ���@��� ����� ���@@������(ksprintf��� ����� ��@��� ����� ��@@��@�����(Markdown)of_string��� ���� ��@��� ���� ��@@��@���'
      �"md��� ���� �'@@@��� ����� �'@@@��� ����� �'@@������(ksprintf��� �+-�� �+5@��� �+-�� �+5@@��@�����(Markdown)of_string��� �+6�� �+H@��� �+6�� �+H@@��@�  ����&Format��� �+J�� �[j@��������&Custom��������+Custom_succ�����+Custom_zero@@@���@@����"()#@#@��@@���4_custom_printf__002_))@�������(Markdown)to_string22@��@����88@@8@8@8@�����.String_literal>�������"

@F@�����@K��������?S�����>X@X@X@���@@����=_@_@��@@���4_custom_printf__001_ee@�������(Markdown<mm@��@����ss@@s@s@s@�����-End_of_formaty@y@@y@y@@y@y@@y@y@����8%{Markdown}

%{Markdown}@~@@~@~@�����8CamlinternalFormatBasics'format6���@�@��@�@��@�@��@�@��@�@��@�@@�@�@��@����%intro��| �[k�} �[p@�� �[k�� �[p@@��@����$main��� �[q�� �[u@��� �[q�� �[u@@@��� �+-�� �[u@@��� ����� �[u@@��� Z�� �[u@@��� Y���� �[uA@@��� Y���� �[u@@��� Y���� �[u@���@�����$page��� �w{�� �w@��� �w{�� �w@@��@@�����&_pages��� �w��� �w�@��� �w��� �w�@@�����%Pages!t��� �w��� �w�@@��� �w��� �w�@@��� �w��� �w�@@�������(Markdown)of_string��� ����� ���@��� ����� ���@@��@�������*In_channel(read_all��� ����� ���@��� ����� ���@@��@���.intro.markdown@��� ����� ���@@@��� ����� ���@@@��� ����� ���@@��� �w��� ���A@@��	  �ww�	 ���@@��	 �ww�	 ���@@