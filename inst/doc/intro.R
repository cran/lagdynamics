## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>", message = FALSE,
                      warning = FALSE, dpi = 130, fig.width = 6.8,
                      fig.height = 5.4, out.width = "100%",
                      fig.align = "center")
set.seed(2026)
library(lagdynamics)
old_options <- options(digits = 3)
has_cograph <- requireNamespace("cograph", quietly = TRUE)
has_ggplot2 <- requireNamespace("ggplot2", quietly = TRUE)

## ----fit----------------------------------------------------------------------
fit <- lsa(engagement)
fit

## ----read---------------------------------------------------------------------
transitions(fit)
transitions(fit, significant = TRUE)
nodes(fit)
tests(fit)
initial(fit)
summary(fit)

## ----lags---------------------------------------------------------------------
lag_profile(engagement, "Active", "Disengaged", lags = 1:3)
transitions(lsa_lags(engagement, lags = 1:2)) |> head(6)

## ----structural---------------------------------------------------------------
fz <- lsa(engagement, loops = FALSE)
transitions(fz) |> subset(from == to)

## ----engines------------------------------------------------------------------
list_lsa_engines()
lsa_two_cell(engagement)

## ----heatmap, eval = has_ggplot2----------------------------------------------
plot(fit)

## ----network, eval = has_cograph----------------------------------------------
plot(fit, type = "network")

## ----tna-network, eval = has_cograph------------------------------------------
plot(fit, type = "network", weights = "tna")

## ----chord, eval = has_cograph------------------------------------------------
plot(fit, type = "chord")

## ----sunburst, eval = has_ggplot2---------------------------------------------
plot(fit, type = "sunburst")

## ----groups-------------------------------------------------------------------
gfit <- lsa(group_regulation_long, actor = "Actor", action = "Action",
            time = "Time", group = "Achiever")
gfit
transitions(gfit, significant = TRUE) |> head(4)
summary(gfit)

## ----compare------------------------------------------------------------------
cmp <- compare_lsa(gfit, R = 100, adjust = "BH")
cmp
transitions(cmp) |> head(4)

bcmp <- bayes_compare_lsa(gfit, draws = 1000, adjust = "BH", seed = 1)
bcmp
transitions(bcmp) |> head(4)

## ----compare-plots, eval = has_ggplot2----------------------------------------
plot(cmp)
plot(cmp, style = "heatmap")

## ----battery------------------------------------------------------------------
cert <- certainty_lsa(fit)
transitions(cert) |> head(3)

boot <- bootstrap_lsa(fit, R = 50)
transitions(boot) |> head(3)

rel <- reliability_lsa(fit, R = 20)
rel

stab <- stability_lsa(fit, R = 30)
stab

pm <- permute_lsa(fit, R = 100)
pm

## ----forest, eval = has_ggplot2-----------------------------------------------
plot(boot)

## ----ingest-------------------------------------------------------------------
fit_log <- lsa(group_regulation_long, actor = "Actor",
               action = "Action", time = "Time")
fit_log

## ----output-interop-----------------------------------------------------------
transition_probabilities(fit)
initial(fit)

## ----cleanup, include = FALSE-------------------------------------------------
options(old_options)

