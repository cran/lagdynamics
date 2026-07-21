## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>", message = FALSE,
                      warning = FALSE, dpi = 150, fig.width = 7,
                      fig.height = 5.6, out.width = "100%",
                      fig.align = "center")
set.seed(1)
library(lagdynamics)
old_options <- options(digits = 3)
has_cograph <- requireNamespace("cograph", quietly = TRUE)
has_ggplot2 <- requireNamespace("ggplot2", quietly = TRUE)

## ----data---------------------------------------------------------------------
head(engagement)

## ----fit----------------------------------------------------------------------
fit <- lsa(engagement)
fit

## ----transitions--------------------------------------------------------------
transitions(fit)

## ----significant--------------------------------------------------------------
transitions(fit, significant = TRUE)

## ----companion-verbs----------------------------------------------------------
nodes(fit)
tests(fit)
initial(fit)
summary(fit)

## ----heatmap, eval = has_ggplot2----------------------------------------------
plot(fit)

## ----residual-network, eval = has_cograph-------------------------------------
plot(fit, type = "network")

## ----tna-network, eval = has_cograph------------------------------------------
plot(fit, type = "network", weights = "tna")

## ----certainty----------------------------------------------------------------
cert <- certainty_lsa(fit)
cert
transitions(cert) |> head(4)

## ----cleanup, include = FALSE-------------------------------------------------
options(old_options)

