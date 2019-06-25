open Core
open Stationary
open Util
open Or_name

module Groth16 = struct
  (*
     Parameters:
     A QAP with

     query density like 
      At=184187/239993, Bt=175307/239993
  *)

end

(*
Want a page like 

MNT
p : Integer = ...
q : Integer = ...

a : Field q = ..
b : Field q = ..

G1 : Type = Curve { field: Field q; a = a; b = b }
   representation:
   struct {
    x : [Field q](Link to synthesized page for this field which explains the representation)
    y : Field q
   }

G2 : Type = ..
*)

module QAP_witness_map = struct
  (* Parameters:
     n : UInt64
     m : UInt64

     A : Poly(n, Fr)[m+1]
     B : Poly(n, Fr)[m+1]
     C : Poly(n, Fr)[m+1]

     Input:
     w : Fr[m]

     Output
     H : Poly(n, Fr)

  such that
    H(z) = (A(z)*B(z)-C(z))/Z(z)
  where
    A(z) := A_0(z) + \sum_{k=1}^{m} w_k A_k(z) + d1 * Z(z)
    B(z) := B_0(z) + \sum_{k=1}^{m} w_k B_k(z) + d2 * Z(z)
    C(z) := C_0(z) + \sum_{k=1}^{m} w_k C_k(z) + d3 * Z(z)
    Z(z) := "vanishing polynomial of set S"
 *)

  let interface =
    let open Problem.Interface in
    let%bind [field] =
      let curve_scopes = ["MNT4753"; "MNT6753"] in
      def ["F"]
        (List.map curve_scopes ~f:(fun scope ->
             (Vec.[Type.prime_field (scope ^. "r")], scope) ))
    in
    let%bind n = !Batch_parameter "n" (Literal UInt64) in
    let%bind m = !Batch_parameter "m" (Literal UInt64) in
    let polynomial =
      Literal (Type.Polynomial {degree= Name n; field= Name field})
    in
    let polynomial_array x =
      !Batch_parameter x
        (Literal
           (Array
              { element= polynomial
              ; length=
                  Some
                    (Literal (Integer.Add (Name m, Literal (Value Bigint.one))))
              }))
    in
    let%bind _a = polynomial_array "A"
    and _b = polynomial_array "B"
    and _c = polynomial_array "C" in
    let%bind _w =
      !Input "w" (Literal (Array {element= Name field; length= Some (Name m)}))
    in
    let%bind _h = !Output "h" polynomial in
    return ()
end

let head =
  let open Html in
  [ literal {h|<meta charset="UTF-8">|h}
  ; link ~href:(sprintf "%s/static/main.css" base_url)
  ; literal
      {h|
<link rel="stylesheet"
      href="//cdnjs.cloudflare.com/ajax/libs/highlight.js/9.15.6/styles/default.min.css">
<script src="//cdnjs.cloudflare.com/ajax/libs/highlight.js/9.15.6/highlight.min.js"></script>
<script>hljs.initHighlightingOnLoad();</script>|h}
  ; literal
      {h|<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/katex@0.10.1/dist/katex.min.css" integrity="sha384-dbVIfZGuN1Yq7/1Ocstc1lUEm+AT+/rCkibIcC/OmWo5f0EA48Vf8CytHzGrSwbQ" crossorigin="anonymous">
<script defer src="https://cdn.jsdelivr.net/npm/katex@0.10.1/dist/katex.min.js" integrity="sha384-2BKqo+exmr9su6dir+qCw08N2ZKRucY4PrGQPPWU1A7FtlCGjmEGFqXCv5nyM5Ij" crossorigin="anonymous"></script>
<script defer src="https://cdn.jsdelivr.net/npm/katex@0.10.1/dist/contrib/auto-render.min.js" integrity="sha384-kWPLUVMOks5AQFrykwIup5lo0m3iMkkHrD0uJ4H5cjeGihAutqP0yW0J6dpFiVkI" crossorigin="anonymous"
    onload="renderMathInElement(document.body);"></script>|h}
  ; Html.literal
      {html|<script>
          document.addEventListener("DOMContentLoaded", function() {
            var blocks = document.querySelectorAll(".math.display");
            for (var i = 0; i < blocks.length; i++) {
              var b = blocks[i];
              katex.render(b.innerText, b, {displayMode:true});
            }
            blocks = document.querySelectorAll(".math.inline");
            for (var i = 0; i < blocks.length; i++) {
              var b = blocks[i];
              katex.render(b.innerText, b, {displayMode:false});
            }
          });
        </script>|html}
  ]

let markdown_wrap cs = Html.div [] (head @ cs)

let html_wrap cs =
  let open Html in
  node "html" [] [node "head" [] head; node "body" [] [cs]]

let wrap = if for_coinlist then Fn.id else html_wrap

let problem_url i (p : Problem.t) =
  sprintf "%s/problem-%02d-%s.html" base_url i (Problem.slug p)

let problem_md_name i (p : Problem.t) =
  sprintf "problem-%02d-%s.markdown" i (Problem.slug p)

let site =
  let open Stationary in
  let modules = [Module.mnt4753; Module.mnt6753] in
  let env = List.fold modules ~init:Env.empty ~f:Module.update_env in
  let problems =
    [ Field_arithmetic.problem
    ; Quadratic_extension.problem
    ; Cubic_extension.problem
    ; Curve_operations.problem
    ; Multiexp.problem
    ; Fft.problem
    ; Simple_groth16_prove.problem ]
  in
  let process_url =
    if for_coinlist then String.chop_suffix_exn ~suffix:".html" else Fn.id
  in
  let pages : Pages.t =
    { intro= Intro.url |> process_url
    ; theory= Theory.url |> process_url
    ; implementation_strategies= Implementation_strategies.url |> process_url
    ; prover= Prover.url |> process_url
    ; field_arithmetic= problem_url 1 Field_arithmetic.problem |> process_url
    ; quadratic_extension=
        problem_url 2 Quadratic_extension.problem |> process_url
    ; cubic_extension= problem_url 3 Cubic_extension.problem |> process_url
    ; curve_operations= problem_url 4 Curve_operations.problem |> process_url
    ; multi_exponentiation= problem_url 5 Multiexp.problem |> process_url
    ; fft= problem_url 6 Fft.problem |> process_url
    ; groth16= problem_url 7 Simple_groth16_prove.problem |> process_url
    ; mnt4= Name.module_url Module.mnt4753.name |> process_url
    ; mnt6= Name.module_url Module.mnt6753.name |> process_url }
  in
  let page name md =
    let md = Markdown.to_string md in
    [ File_system.file
        (File.of_html ~name:(sprintf "%s.html" name) (wrap (Html.markdown md)))
    ; File_system.file (File.of_text ~name:(sprintf "%s.markdown" name) md) ]
  in
  Site.create
    [ File_system.directory "snark-challenge"
        ( page "intro" (Intro.page pages)
        @ page "tutorial" (Tutorial.page pages)
        @ page "prover" (Prover.page pages)
        @ page "verifier" (Verifier.page pages)
        @ page "index" (Stage1.page pages)
        @ page "theory" (Theory.page pages)
        @ page "strategies" (Implementation_strategies.page pages)
        @ [ File_system.file (File.of_text ~name:".nojekyll" "")
          ; File_system.copy_directory "static" ]
        @ List.map modules ~f:(fun m ->
              File_system.file
                (File.of_html
                   ~name:(Filename.basename (Name.module_url m.name))
                   (wrap Module.(Page.render (to_page env m)))) )
        @ List.map modules ~f:(fun m ->
              File_system.file
                (File.of_text
                   ~name:(sprintf "%s.markdown" m.name)
                   (Module.(Page.render (to_page env m)) |> Util.Html.to_string))
          )
        @ List.mapi problems ~f:(fun i p ->
              File_system.file
                (File.of_text
                   ~name:(problem_md_name (i + 1) p)
                   (Problem.render ~pages p |> Markdown.to_string)) )
        @ List.mapi problems ~f:(fun i p ->
              File_system.file
                (File.of_html
                   ~name:(Filename.basename (problem_url (i + 1) p))
                   (wrap
                      (Html.markdown
                         (Problem.render ~pages p |> Markdown.to_string)))) )
        ) ]

let () =
  let open Async in
  Command.async ~summary:""
    (Command.Param.return (fun () -> Site.build ~dst:"_site" site))
  |> Command.run

(* Description:
   For a group G \in { MNT6753.G1, MNT6753.G2, MNT4753.G1, MNT4753.G2 }, implement
   fixed-based multiexponentiation over G.

   Parameters: 
    - n : UInt32
    - g : Array(G) of length n

   Input:
   - s : Array(Integer) of length n

   Output :
   - y : G

    The output should be the multiexponentiation with the scalars `s`
    on the bases `g`. In other words, the group element
    `s[0] * g[0] + s[1] * g[1] + ... + s[n - 1] * g[n - 1]`.

   # Expected interface for your submission.

   Parameters will be generated randomly and saved to a file `PATH_TO_PARAMETERS`

   Your binary `main` will be run with 
   ```bash
   ./main preprocess PATH_TO_PARAMETERS
   ```
   where `PATH_TO_PARAMETERS` will be replaced by the acutal path.

   Your binary can at this point, if you like, do some preprocessing of the parameters and
   save any state it would like to a file `./preprocessed`.

   Our program will then be run to generate a random sequence of inputs, saved to a file
   `PATH_TO_INPUTS`.

   Your binary will then be invoked with
   ```bash
   ./main compute PATH_TO_INPUTS
   ```
   where `PATH_TO_INPUTS` will be replaced by the actual path. It can, if it likes, read
   the file "./preprocessed" in order to help it solve the problem.
*)
