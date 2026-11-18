## ----options, include = FALSE-----------------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>", fig.width = 6.5,
                      fig.height = 5, fig.align = "center", dpi = 72)
old_options <- options(digits = 3, width = 90)

## ----data-------------------------------------------------------------------------------
library(lagdynamics)
head(ai_long)

## ----fit--------------------------------------------------------------------------------
fit <- lsa(ai_long,
           session = "session_id",
           action  = "code",
           order   = "order_in_session")
fit

## ----initial----------------------------------------------------------------------------
initial(fit)

## ----nodes------------------------------------------------------------------------------
nodes(fit)

## ----tests------------------------------------------------------------------------------
tests(fit)

## ----over-------------------------------------------------------------------------------
transitions(fit, direction = "over", sort = "strength")

## ----under------------------------------------------------------------------------------
transitions(fit, direction = "under", sort = "strength")

## ----net-residual-----------------------------------------------------------------------
plot_transitions(fit, weights = "residuals", top = 12, decimals = 1)

## ----net-yulesq-------------------------------------------------------------------------
plot_transitions(fit, weights = "yules_q", top = 12, decimals = 2)

## ----net-prob---------------------------------------------------------------------------
plot_transitions(fit, weights = "tna")

## ----bootstrap--------------------------------------------------------------------------
set.seed(2026)
boot <- bootstrap_lsa(fit, R = 500)
boot

## ----certainty--------------------------------------------------------------------------
cert <- certainty_lsa(fit)
cert

## ----cleanup, include = FALSE-------------------------------------------------
options(old_options)

