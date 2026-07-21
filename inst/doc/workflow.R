## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>", message = FALSE,
                      warning = FALSE, dpi = 150, fig.width = 7,
                      fig.height = 5.6, out.width = "100%",
                      fig.align = "center")
set.seed(2026)
library(lagdynamics)
old_options <- options(digits = 3)
has_cograph <- requireNamespace("cograph", quietly = TRUE)
has_ggplot2 <- requireNamespace("ggplot2", quietly = TRUE)

## ----data---------------------------------------------------------------------
head(engagement)

## ----fit----------------------------------------------------------------------
fit <- lsa(engagement)
fit

## ----read---------------------------------------------------------------------
transitions(fit)

## ----read-significant---------------------------------------------------------
transitions(fit, significant = TRUE)

## ----read-context-------------------------------------------------------------
nodes(fit)
tests(fit)
initial(fit)

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

## ----bootstrap----------------------------------------------------------------
boot <- bootstrap_lsa(fit, R = 100)
boot
transitions(boot) |> head(4)

## ----reliability--------------------------------------------------------------
reliability_lsa(fit, R = 30)

## ----log----------------------------------------------------------------------
head(group_regulation_long)

## ----log-fit------------------------------------------------------------------
fit_log <- lsa(group_regulation_long, actor = "Actor",
               action = "Action", time = "Time")
fit_log

## ----interop------------------------------------------------------------------
transition_probabilities(fit_log)
initial(fit_log)

## ----group--------------------------------------------------------------------
gfit <- lsa(group_regulation_long, actor = "Actor", action = "Action",
            time = "Time", group = "Achiever")
gfit

## ----group-read---------------------------------------------------------------
transitions(gfit, significant = TRUE) |> head(6)
nodes(gfit) |> head(6)

## ----compare------------------------------------------------------------------
cmp <- compare_lsa(gfit, R = 100, adjust = "BH")
cmp
transitions(cmp) |> head(6)

## ----barrel, eval = has_ggplot2-----------------------------------------------
plot(cmp)

## ----cleanup, include = FALSE-------------------------------------------------
options(old_options)

