## ----options, include = FALSE-----------------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>", fig.width = 6.5,
                      fig.height = 4.5, fig.align = "center", dpi = 72)
old_options <- options(digits = 3, width = 90)

## ----fit--------------------------------------------------------------------------------
library(lagdynamics)
fit <- lsa(engagement)
transitions(fit, significant = TRUE, sort = "strength")

## ----certainty--------------------------------------------------------------------------
cert <- certainty_lsa(fit)
cert
transitions(cert)

## ----bootstrap--------------------------------------------------------------------------
set.seed(2026)
boot <- bootstrap_lsa(fit, R = 500)
boot
transitions(boot, significant = TRUE) |> head(4)

## ----forest, fig.height = 5-------------------------------------------------------------
plot(boot)

## ----stability--------------------------------------------------------------------------
stab <- stability_lsa(fit, R = 200)
stab
transitions(stab)

## ----reliability------------------------------------------------------------------------
rel <- reliability_lsa(fit, R = 100)
rel
as.data.frame(rel, what = "summary")

## ----permute----------------------------------------------------------------------------
perm <- permute_lsa(fit, R = 500)
perm
transitions(perm)

## ----cleanup, include = FALSE-------------------------------------------------
options(old_options)

