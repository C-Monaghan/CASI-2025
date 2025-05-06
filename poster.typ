// Setting page dimensions (A0 size) and font -----------------------------------------------------------
#set page(
  width: 84.1cm,
  height: 118.9cm ,
  margin: 2.5cm,
  footer: [
    #set align(center)
    #set text(32pt)
    #block(
      fill: rgb("#ebcfb2"),
      width: 100%,
      inset: 15pt,
      radius: 15pt,
      [
        #text(font: "New Computer Modern", size: 30pt, "cormacmonaghan@protonmail.com")
        #h(1fr)
        #text(size: 30pt, smallcaps("Conference on Applied Statistics in Ireland (2025)"))
        #h(1fr)
        #text(font: "New Computer Modern", size: 30pt, "Check out my website")
      ]
    )
  ],
  columns: 2
)

// Rules ------------------------------------------------------------------------------------------------
#set text(font: "New Computer Modern", size: 37pt)  // Font size
#show heading.where(level: 1): set text(size: 50pt) // Heading size
#show heading.where(level: 1): set align(center)    // Center headings
#show list: set par(leading: 1em)                   // Line spacing between lists items
#show list: set block(spacing: 1em)                 // Line spacing between heading and initial list item


#show math.equation.where(block: true): eq => {
    block(width: 100%, inset: 0em, align(center, eq))
  }

#let column-gap = 2cm

// Placing figure
#place(
  top + left,
  scope: "parent",
  float: true,
  clearance: 1em,
  grid(
    columns: 2, 
    grid.cell(colspan: 1, image("figures/CRT Logo 1.png", width: 70%), align: left),
    grid.cell(colspan: 1, image("figures/CRT Logo 2.jpg", width: 45%), align: right)
  ))

// Placing heading and author information
#place(
  top + center,
  scope: "parent",
  float: true,
  clearance: 1.25em,
  text(size: 75pt, weight: "bold", fill: rgb("#002060"))[The Statistical Power of Alcohol Consumption Measures]
)

#place(
  top + center,
  scope: "parent",
  float: true,
  clearance: 1.25em,
  text(size: 42pt)[Cormac Monaghan#super[1,3], Dr. Rafael de Andrade Moral#super[2], Dr. Joanna McHugh Power#super[3]]
)

#place(
  top + center,
  scope: "parent",
  float: true,
  text(size: 42pt)[#super[1]Hamilton Institute, Maynooth University\
    #super[2]Department of Mathematics and Statistics, Maynooth University\
    #super[3]Department of Psychology, Maynooth University]
)

= Background
- Understanding alcohol use epidemiology is essential for public health surveillance, policy, and intervention design. 
- However, while self-report surveys remain the primary tool for measuring consumption, their reliability depends heavily on methodological precision.
- Using simulated data, we systematically evaluate the statistical power of three widely used alcohol consumption measures to determine which best detects associations in epidemiological research.
  
#table(
  columns: (1fr, 1fr),
  inset: 10.5pt,
  align: center + horizon,
  table.header([*Measure*], [*Response*]),
  "Quantity frequency", "Count data",
  "Graduated frequency", "Ordinal data",
  "Binary classification", "Binary data"
)

#v(1cm)

= Methods
We conducted a simulation study to compare the statistical power of different alcohol measurement approaches:
- *Data Simulation*
  - Generated a large-scale dataset reflecting real-world alcohol consumption distributions.
  - Simulated *7000 random samples* across varying sample sizes $n in {100, 250, 500, 1000, 5000, 10000}$
- *Modelling Approach*
 - Fitted four generalized linear models based on response variable type:
  - #text(size: 35pt, weight: "bold", "Negative binomial (quantity-frequency)")

  $
    Y_i ~ "NB"(mu_i, theta) \
    log(mu_i) =  bold(beta)^top X_i
  $

  #v(1cm)
  
  - #text(size: 35pt, weight: "bold", "Zero-inflated negative binomial (quantity-frequency)")
  $
    Y_i ~ cases(
      pi + (1 - pi) dot "NB"(0 | mu_i, k) #h(1.25em) "if" y = 0, #v(2.5cm)
      (1 - pi) dot "NB"(y | mu_i, k) #h(2.75em) "if" y gt 0) \

    log(mu_i) = bold(beta)^top X_i \

    log(pi / (1 - pi)) = bold(gamma)^top z_i
  $

  #v(1cm)
  
  - #text(size: 35pt, weight: "bold", "Ordinal logistic regression (graduated frequency)")

  $
    log(P(Y_i lt.eq ell) / (P(Y_i gt ell))) = zeta_ell - bold(beta)^top X_i
  $

  #v(1cm)
  
  - #text(size: 35pt, weight: "bold", "Binary logistic regression (binary classification)")

  $
    Y_i ~ "Bernoulli"(pi_i) \
    log(pi_i / (1 - pi_i)) =  bold(beta)^top X_i
  $
  

#colbreak()

= Results

#figure(
  image("figures/Figure 1.png", width: 100%),
  caption: [Proportion of Significant Wald Values]
)

#figure(
  image("figures/Figure 2.png", width: 100%),
  caption: [Proportion of 95% CI Coverage]
)

// #figure(image("figures/Figure 3.png", width: 100%))

= Conclusion
- With small sample sizes, binary data is the most robust approach for measuring alcohol consumption. However, with larger sample sizes, count data performs equivalently.
- Given these findings, we recommend the use of binary classifications when working with small sample sizes due to their robust performance. 
- For large sample sizes, count data can offer greater precision by capturing more detailed variations in consumption levels.
- These findings have important implications for public health research and policy, where accurate measurement is critical. Future studies should explore how these methods perform in broader populations, including high-risk groups and cross-cultural settings, to ensure generalizability.

#v(0.5cm) #h(6em) *Acknowledgements*

#set text(size: 30pt)
#set align(center)

#v(-0.5cm)
#h(-10em)
This work has emanated from research conducted \  #h(-10em)
with the financial support of Taighde Éireann – \ #h(-10em)
Research Ireland under Grant number 18/CRT/6049

#place(
  bottom + right,
  dx: -20pt,
  image("figures/QR Code.svg", width: 25%)
)

