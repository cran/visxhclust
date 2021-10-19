## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup, message=FALSE, warning=FALSE--------------------------------------
library(visxhclust)
library(dplyr)
library(ggplot2)

## ----first_step---------------------------------------------------------------
numeric_data <- iris %>% select(where(is.numeric))
annotation_data <- iris %>% select(where(is.factor))

## ----correlation--------------------------------------------------------------
correlation_heatmap(numeric_data)

## ----subset-------------------------------------------------------------------
subset_data <- numeric_data %>% select(Sepal.Length, Sepal.Width, Petal.Width)

## ----params-------------------------------------------------------------------
scaling <- TRUE
distance_method <- "euclidean"
linkage_method <- "ward.D2"
# this assumes that, in the app, we identified 3 as the optimal number of clusters
k <- 3 

## ----computation--------------------------------------------------------------
dmat <- compute_dmat(subset_data, distance_method, TRUE)
clusters <- compute_clusters(dmat, linkage_method)
cluster_labels <- cut_clusters(clusters, k)

## ----heatmap------------------------------------------------------------------
species_annotation <- create_annotations(iris, "Species")
cluster_heatmaps(scale(subset_data), 
                 clusters,
                 k,
                 cluster_colors,
                 annotation = species_annotation)

## ----boxplots-----------------------------------------------------------------
annotated_data <- annotate_clusters(subset_data, cluster_labels, TRUE)
cluster_boxplots(annotated_data)

