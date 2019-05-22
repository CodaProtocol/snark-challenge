# Stage 1 - Challenge 2: Quadratic extension arithmetic

## Table of Contents

<div class="table-of-contents">
<ul>
<li>
<a href="#quick-details">1: Quick details</a>
</li>
<li>
<a href="#definitions-and-review">2: Definitions and review</a>
</li>
<li>
<a href="#the-problem">3: The problem</a>
</li>
<li>
<a href="#problem-specification">4: Problem specification</a>
</li>
<li>
<a href="#input">4.1: Input</a>
</li>
<li>
<a href="#output">4.2: Output</a>
</li>
<li>
<a href="#expected-behavior">4.3: Expected behavior</a>
</li>
<li>
<a href="#submission-guidelines">5: Submission guidelines</a>
</li>
<li>
<a href="#reference-implementation">6: Reference implementation</a>
</li>
<li>
<a href="#further-discussion-and-background">7: Further discussion and background</a>
</li>
<li>
<a href="#starter-code">7.1: Starter code</a>
</li>
<li>
<a href="#efficiency-tricks">7.2: Efficiency tricks</a>
</li>
</ul>
</div>

## Quick details

- **Problem:** Multiply together an array of elements of a quadratic extension field.
- **Prize:**
    - **First 25 submissions:** $25
    - **All submissions:** Swag bag including SNARK challenge T-shirt.

Now that we've implemented arithmetic in a prime-order field
in the [previous challenge](/snark-challenge/problem-01-field-arithmetic.html), we can implement field extension
arithmetic, which we'll need for multi-exponentiation.

## Definitions and review


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
with our prime order field $\mathbb{F}_q$ where $q$ is [MNT4753.q](/snark-challenge/MNT4753.html#cQ==). Then, we'll
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
has $q^2$ elements.

## The problem

In code, you can think of an element of $\mathbb{F}_{q^2}$ as a pair `(a0, a1)` where
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
```

## Problem specification



### Input

- n : <span>uint64</span>
- x : <span>Array(<span>&#x1D53D;<sub><a href="/snark-challenge/MNT4753.html#cQ==">MNT4753.q</a><sup>2</sup></sub></span>, <a href="#bg==">n</a>)</span>

### Output

- y : <span>&#x1D53D;<sub><a href="/snark-challenge/MNT4753.html#cQ==">MNT4753.q</a><sup>2</sup></sub></span>

### Expected behavior

Your implementation should use one or both of the benchmark machine's GPUs to solve this problem. The machine's specifications can be found [here]().

The output should be `x[0] * x[1] * ... * x[n - 1]`
where `*` is multiplication in the field <span>&#x1D53D;<sub><a href="/snark-challenge/MNT4753.html#cQ==">MNT4753.q</a><sup>2</sup></sub></span> as described above.


## Submission guidelines

Your submission will be run and evaluated as follows.


0. The submission runner will generate a random sequence of inputs, saved to a file
   `PATH_TO_INPUTS`.

1. Your binary will be compiled with `./build.sh`. This step should produce a binary `./main`.

3. Your binary will be invoked with

    ```bash
        ./main compute PATH_TO_INPUTS PATH_TO_OUTPUTS
    ```

    and its runtime will be recorded. The file `PATH_TO_INPUTS` will contain
    a sequence of inputs, each of which is of the form specified in the
    ["Input"](#input) section. 

    It should create a file called "outputs" at the path `PATH_TO_OUTPUTS`
    which contains a sequence of outputs, each of which is of the form
    specified in the ["Output"](#output) section.

    
    

## Reference implementation

The output of your submitted program will be checked against 
the reference implementation at this repo [here](https://github.com/CodaProtocol/snark-challenge/tree/master/reference-02-quadratic-extension).
The "main" file is [here](https://github.com/CodaProtocol/snark-challenge/tree/master/reference-02-quadratic-extension/libff/main.cpp).
The core algorithm is implemented [here](https://github.com/CodaProtocol/snark-challenge/blob/master/reference-02-quadratic-extension/libff/algebra/fields/fp2.tcc#L79).


## Further discussion and background

### Starter code

- This [repo](https://github.com/CodaProtocol/snark-challenge-cuda-starter) has some CUDA starter code,
   just to illustrate how to build it on the benchmark machine.
- This [library](https://github.com/data61/cuda-fixnum) implements prime-order field arithmetic in CUDA.
It should be a great place to start.


### Efficiency tricks

The pseduocode above does 4 $\mathbb{F}_q$ multiplications, 1 multiplication
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
