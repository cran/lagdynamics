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
fit <- lsa(engagement)

## ----heatmap, eval = has_ggplot2----------------------------------------------
plot(fit)                       # adjusted residuals (default)
plot(fit, which = "prob")       # transition probabilities

## ----net-residual, eval = has_cograph-----------------------------------------
plot(fit, type = "network")

## ----net-transition, eval = has_cograph---------------------------------------
plot(fit, type = "network", weights = "tna")

## ----chord, eval = has_cograph------------------------------------------------
plot(fit, type = "chord")

## ----sunburst, eval = has_ggplot2---------------------------------------------
plot(fit, type = "sunburst")                 # rose (default)
plot(fit, type = "sunburst", style = "wedge")  # frequency wedges

## ----forest, eval = has_ggplot2, fig.height = 6.5-----------------------------
plot(bootstrap_lsa(fit, R = 200))            # resampling CIs
plot(certainty_lsa(fit))                     # analytic credible intervals

## ----gfit---------------------------------------------------------------------
gfit <- lsa(group_regulation_long, actor = "Actor",
            action = "Action", time = "Time", group = "Achiever")

## ----barrel, eval = has_ggplot2, fig.height = 7-------------------------------
cmp <- compare_lsa(gfit, R = 500)
plot(cmp)                                    # frequency-ranked rows
plot(cmp, rank = "effect")                   # surface avoided (red) edges
plot(cmp, style = "heatmap")                 # full-grid difference

## ----bayes-barrel, eval = has_ggplot2, fig.height = 7-------------------------
plot(bayes_compare_lsa(gfit, seed = 1))

## ----grouped, eval = has_ggplot2----------------------------------------------
plot(gfit)                                   # one heatmap per group

## ----workers, eval = FALSE----------------------------------------------------
# plot_transitions(fit, weights = "residuals", significant = TRUE)  # network
# plot_chords(fit, width = "prob")                                  # chord
# plot_polar(fit, style = "wedge")                                  # sunburst
# plot_forest(bootstrap_lsa(fit), n_top = 12)                       # forest

## ----cleanup, include = FALSE-------------------------------------------------
options(old_options)

