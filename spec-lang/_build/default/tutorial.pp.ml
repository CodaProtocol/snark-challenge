Caml1999M023����            +tutorial.ml����  �  �  Q  
M�����1ocaml.ppx.context��&_none_A@ �A����������)tool_name���-ppxlib_driver@@����,include_dirs����"[]@@����)load_path!����
%@%@����,open_modules*����.@.@����+for_package3����$None8@8@����%debug=����%falseB@B@����+use_threadsG����
K@K@����-use_vmthreadsP����T@T@����'cookiesY����"::^����������/ppx_optcomp.env@i@�������#env��&_none_A@ �A@���-ocaml_version����'Defined�������!4@@����!7@@����!1@@@@@@@@�@�����y�@�@@�@�@@@�@@�@�������$Core��+tutorial.mlA@E�A@I@A��A@@�A@I@@��A@@�A@I@������$Util��BJO�BJS@A��BJJ�BJS@@��BJJ�BJS@���@�����$page��#DUY�$DU]@��&DUY�'DU]@@��@@�����%pages��1DU_�2DUd@��4DU_�5DUd@@�����%Pages!t��>DUg�?DUn@@��ADUg�BDUn@@��DDU^�EDUo@@�  !A��)Challenge��LEr}�MEr F@������(ksprintf��VF J L�WF J T@��YF J L�ZF J T@@��@�����(Markdown)of_string��eF J U�fF J g@��hF J U�iF J g@@��@���
  +Want to learn cutting edge cryptography, GPU programming and get
paid to do it? Then you're in the right place.

In the tutorial challenges, you'll implement the sub-algorithms you need to
implement the full SNARK prover and you'll get paid to do so.
The first 10 participants who complete the four challenges in this stage
will receive $500 and a *SNARK Challenge* swag-bag.
They'll also be very well positioned to apply their solutions to
create submissions for $70,000 of the $105,000 in prizes up for grabs in the other challenges.

The challenges in this stage are

%s


## Broader context
Let's give a quick overview of the SNARK prover so
we have an idea of where these challenges lead. The SNARK prover itself
consists of two sub-algorithms: 

1. Multi-exponentiation on an elliptic curve.
2. Fast fourier transform (FFT) over a finite field.

The cool thing about both of these algorithms is that they're massively
parallel and ideally suited to implementation on GPU, which we expect to
help take the top prize in the challenge. The multi-exponentiation in
particular is just a big [reduction](https://developer.download.nvidia.com/assets/cuda/files/reduction.pdf),
although the reduction function requires some work to describe.

These 2 algorithms themselves have sub-algorithms which you'll need to implement first.
In total, this stage has 4 challenges. After implementing these challenges you'll
be well on your way to having a complete GPU implementation of the SNARK prover itself.

Click through to each of the challenge pages for starter code and more details.�"md��sG h l�thL�@@��@������'unlines��i����i��@���i����i��@@��@�������$List#map���j����j��@���j����j��@@���!f��@@������!p���k����k��@���k����k��@@����#url���k����k��@���k����k��@@@���k����k��@@������&render���k����k��@���k����k��@@��@������'problem���k����k��@���k����k��@@��@����!p���k����k��@���k����k��@@���#url�������k����k��@���k����k��@@@���k����k��@@@���k����k��@@���k����k��@@��@����"::���l���o��A������������0Field_arithmetic'problem��l��l�@��l��l�@@�������%pages��l��l�!@�� l��!l�!@@��0field_arithmetic��&l�"�'l�2@��)l��*l�2@@@��,l��-l�3@@�����7��4m4@�5o��A������������3Quadratic_extension'problem��Em4A�Fm4\@��Hm4A�Im4\@@�������%pages��Sm4^�Tm4c@��Vm4^�Wm4c@@��3quadratic_extension��\m4d�]m4w@��_m4^�`m4w@@@��bm4@�cm4x@@�����m��jny��ko��A������������/Cubic_extension'problem��{ny��|ny�@��~ny��ny�@@�������%pages���ny���ny�@���ny���ny�@@��/cubic_extension���ny���ny�@���ny���ny�@@@���ny���ny�@@���������o����o��A������������0Curve_operations'problem���o����o��@���o����o��@@�������%pages���o����o��@���o����o��@@��0curve_operations���o����o��@���o����o��@@@���o����o��@@�����"[]���o����o��A@���o����o��A@@���o����o��A@���o����o��A@@���ny���o��A@���ny���o��A@@���m4@��o��A@���m4@��o��A@@���l���o��A@���l����o��@@@���j����o��@@@���i����o��@@@���F J L��o��@@���Ert��o��@@��DU^�o��A@@��DUU�o��@@��DUU�o��@@