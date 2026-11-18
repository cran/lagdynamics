## ----options, include = FALSE-----------------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>", fig.width = 6.5,
                      fig.height = 4.5, fig.align = "center", dpi = 72)
old_options <- options(digits = 3, width = 90)

## ----setup------------------------------------------------------------------------------
library(lagdynamics)
head(engagement)

## ----fit--------------------------------------------------------------------------------
fit <- lsa(engagement)
fit

## ----significant------------------------------------------------------------------------
transitions(fit, significant = TRUE, sort = "strength")

## ----over-------------------------------------------------------------------------------
transitions(fit, direction = "under", sort = "strength")

## ----tests------------------------------------------------------------------------------
tests(fit)

## ----nodes------------------------------------------------------------------------------
nodes(fit)
initial(fit)

## ----summary----------------------------------------------------------------------------
fit_summary <- summary(fit)
fit_summary
as.data.frame(fit_summary)
as.data.frame(fit_summary, what = "nodes")

## ----probabilities----------------------------------------------------------------------
transition_probabilities(fit)

## ----heatmap----------------------------------------------------------------------------
plot(fit)

## ----cleanup, include = FALSE-------------------------------------------------
options(old_options)

