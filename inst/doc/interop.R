## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>", message = FALSE,
                      warning = FALSE, dpi = 150, fig.width = 7,
                      fig.height = 5.6, out.width = "100%",
                      fig.align = "center")
set.seed(2026)
library(lagdynamics)
old_options <- options(digits = 3)
has_tna <- requireNamespace("tna", quietly = TRUE)
has_Nestimate <- requireNamespace("Nestimate", quietly = TRUE)
has_cograph <- requireNamespace("cograph", quietly = TRUE)

## ----wide---------------------------------------------------------------------
head(engagement)

fit_wide <- lsa(engagement)
fit_wide

## ----wide-read----------------------------------------------------------------
transitions(fit_wide, significant = TRUE)
nodes(fit_wide)
initial(fit_wide)

## ----long-data----------------------------------------------------------------
head(group_regulation_long)

## ----long-fit-----------------------------------------------------------------
fit_long <- lsa(group_regulation_long, actor = "Actor",
                action = "Action", time = "Time")
fit_long

## ----long-session-------------------------------------------------------------
head(ai_long)

fit_session <- lsa(ai_long, actor = "project", session = "session_id",
                   action = "code", order = "order_in_session")
fit_session

## ----grouped-long-------------------------------------------------------------
gfit <- lsa(group_regulation_long, actor = "Actor", action = "Action",
            time = "Time", group = "Achiever")
gfit
transitions(gfit, significant = TRUE) |> head(6)

## ----tna-object, eval = has_tna-----------------------------------------------
tna_fit <- tna::tna(engagement)
tna_fit

fit_from_tna <- lsa(tna_fit)
fit_from_tna

## ----tna-equivalence, eval = has_tna------------------------------------------
isTRUE(all.equal(transitions(fit_from_tna), transitions(fit_wide),
                 check.attributes = FALSE))

## ----nestimate-object, eval = has_Nestimate-----------------------------------
nestimate_fit <- Nestimate::build_network(
  ai_long,
  method = "tna",
  actor = "project",
  session = "session_id",
  action = "code",
  order = "order_in_session"
)

nestimate_fit

fit_nestimate <- lsa(nestimate_fit)
fit_nestimate

## ----nestimate-equivalence, eval = has_Nestimate------------------------------
fit_ai_direct <- lsa(ai_long, actor = "project", session = "session_id",
                     action = "code", order = "order_in_session")

isTRUE(all.equal(transitions(fit_nestimate), transitions(fit_ai_direct),
                 check.attributes = FALSE))

## ----lsa-to-tna, eval = has_tna-----------------------------------------------
tn <- lsa_to_tna(fit_wide, weights = "prob")
tn

tna::centralities(tn)

## ----probabilities------------------------------------------------------------
transition_probabilities(fit_long)
initial(fit_long)

## ----tna-plot, eval = has_cograph---------------------------------------------
plot(fit_long, type = "network", weights = "tna")

## ----cleanup, include = FALSE-------------------------------------------------
options(old_options)

