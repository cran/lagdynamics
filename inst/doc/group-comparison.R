## ----options, include = FALSE-----------------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>", fig.width = 6.5,
                      fig.height = 5, fig.align = "center", dpi = 72)
old_options <- options(digits = 3, width = 90)

## ----data-------------------------------------------------------------------------------
library(lagdynamics)
head(group_regulation_long)

## ----fit--------------------------------------------------------------------------------
gfit <- lsa(group_regulation_long, actor = "Actor", action = "Action",
            time = "Time", group = "Achiever")
gfit

## ----summary----------------------------------------------------------------------------
summary(gfit)

## ----group-transitions------------------------------------------------------------------
transitions(gfit, significant = TRUE, sort = "strength") |> head(8)

## ----compare----------------------------------------------------------------------------
set.seed(2026)
cmp <- compare_lsa(gfit, R = 500, adjust = "BH")
cmp

## ----global-----------------------------------------------------------------------------
as.data.frame(cmp, what = "global")

## ----compare-transitions----------------------------------------------------------------
transitions(cmp, significant = TRUE, sort = "strength") |> head(8)

## ----barrel, fig.height = 6-------------------------------------------------------------
plot(cmp)

## ----bayes------------------------------------------------------------------------------
bcmp <- bayes_compare_lsa(gfit, adjust = "BH", seed = 1)
bcmp
transitions(bcmp, significant = TRUE, sort = "strength") |> head(8)

## ----smallest-differences---------------------------------------------------------------
transitions(cmp, sort = "strength") |> tail(6)

## ----cleanup, include = FALSE-------------------------------------------------
options(old_options)

