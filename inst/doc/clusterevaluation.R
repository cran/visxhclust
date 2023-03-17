## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup, message=FALSE, warning=FALSE--------------------------------------
library(visxhclust)
library(dplyr)

## ----prep---------------------------------------------------------------------
numeric_data <- iris %>% select(Sepal.Length, Sepal.Width, Petal.Width)
dmat <- compute_dmat(numeric_data, "euclidean", TRUE)
clusters <- compute_clusters(dmat, "complete")

## ----gapstat------------------------------------------------------------------
gap_results <- compute_gapstat(scale(numeric_data), clusters)
optimal_k <- cluster::maxSE(gap_results$gap, gap_results$SE.sim)
line_plot(gap_results, "k", "gap", xintercept = optimal_k)

## ----dunn---------------------------------------------------------------------
res <- compute_metric(dmat, clusters, "dunn")
optimal_k <- optimal_score(res$score)
line_plot(res, "k", "score", optimal_k)

