
<!-- README.md is generated from README.Rmd. Please edit that file -->

# sirtensor

<!-- badges: start -->
<!-- badges: end -->

The goal of sirtensor is to harness tensorflow for SIR modelling

## Installation

Install the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("njtierney/sirtensor")
```

## Example

This is a basic example

``` r
library(sirtensor)
new_sims <- pop_sim()

plot(new_sims$S, type = "l", col = "blue", ylim = c(0, new_sims$S[1]))
lines(new_sims$I, col = "red")
lines(new_sims$R, col = "green")
```

<img src="man/figures/README-example-1.png" width="100%" />
