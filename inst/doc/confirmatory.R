## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>", message = FALSE,
                      warning = FALSE, dpi = 150, fig.width = 7,
                      fig.height = 5.6, out.width = "100%",
                      fig.align = "center")
set.seed(2026)
library(lagdynamics)
old_options <- options(digits = 3)
has_ggplot2 <- requireNamespace("ggplot2", quietly = TRUE)

## ----fit----------------------------------------------------------------------
fit <- lsa(engagement)
transitions(fit, significant = TRUE)

## ----edge---------------------------------------------------------------------
transitions(bootstrap_lsa(fit, R = 200)) |> head(4)   # resampling CIs
transitions(certainty_lsa(fit)) |> head(4)            # analytic CIs

## ----forest, eval = has_ggplot2, fig.height = 6.5-----------------------------
plot(bootstrap_lsa(fit, R = 200))

## ----stability----------------------------------------------------------------
transitions(stability_lsa(fit, R = 200)) |> head(4)

## ----reliability--------------------------------------------------------------
reliability_lsa(fit, R = 50)

## ----permute------------------------------------------------------------------
transitions(permute_lsa(fit, R = 200)) |> head(4)

## ----group--------------------------------------------------------------------
gfit <- lsa(group_regulation_long, actor = "Actor", action = "Action",
            time = "Time", group = "Achiever")

## ----compare------------------------------------------------------------------
cmp <- compare_lsa(gfit, R = 500, adjust = "BH")
cmp
transitions(cmp, significant = TRUE) |> head(4)

## ----barrel, eval = has_ggplot2, fig.height = 6.5-----------------------------
plot(cmp)

## ----bayes--------------------------------------------------------------------
bayes_compare_lsa(gfit, seed = 1)

## ----cleanup, include = FALSE-------------------------------------------------
options(old_options)

