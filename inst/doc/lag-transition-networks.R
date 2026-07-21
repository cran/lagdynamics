## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>", message = FALSE,
                      warning = FALSE, dpi = 150, fig.width = 7,
                      fig.height = 5.4, out.width = "100%",
                      fig.align = "center")
set.seed(2026)
library(lagdynamics)
old_options <- options(digits = 3)
has_cograph <- requireNamespace("cograph", quietly = TRUE)

## ----data---------------------------------------------------------------------
data(ai_long)
head(ai_long)

## ----fit----------------------------------------------------------------------
fit <- lsa(ai_long,
           session = "session_id",
           action  = "code",
           order   = "order_in_session")
fit

## ----initial------------------------------------------------------------------
initial(fit)

## ----nodes--------------------------------------------------------------------
nodes(fit)

## ----tests--------------------------------------------------------------------
tests(fit)

## ----over---------------------------------------------------------------------
transitions(fit, direction = "over", sort = "strength")

## ----under--------------------------------------------------------------------
transitions(fit, direction = "under", sort = "strength")

## ----net-residual-full, eval = has_cograph------------------------------------
plot_transitions(fit, weights = "residuals", decimals = 1)

## ----net-residual-full-skip, echo = FALSE, eval = !has_cograph----------------
# message("Install 'cograph' to draw the residual network.")

## ----net-residual-top, eval = has_cograph-------------------------------------
plot_transitions(fit, weights = "residuals", top = 12, decimals = 1)

## ----net-yulesq-full, eval = has_cograph--------------------------------------
plot_transitions(fit, weights = "yules_q", decimals = 2)

## ----net-yulesq-full-skip, echo = FALSE, eval = !has_cograph------------------
# message("Install 'cograph' to draw the Yule's Q network.")

## ----net-yulesq-top, eval = has_cograph---------------------------------------
plot_transitions(fit, weights = "yules_q", top = 12, decimals = 2)

## ----net-prob, eval = has_cograph---------------------------------------------
plot_transitions(fit, weights = "tna")

## ----net-prob-skip, echo = FALSE, eval = !has_cograph-------------------------
# message("Install 'cograph' to draw the probability network.")

## ----bootstrap----------------------------------------------------------------
boot <- bootstrap_lsa(fit, R = 1000)
boot

## ----certainty----------------------------------------------------------------
cert <- certainty_lsa(fit)
cert

## ----cleanup, include = FALSE-------------------------------------------------
options(old_options)

