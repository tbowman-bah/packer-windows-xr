#!/bin/bash

echo "Installing system dependencies with pacman"

pacman --noconfirm -S mingw-w64-{i686,x86_64}-fftw \
  mingw-w64-{i686,x86_64}-gdal \
  mingw-w64-{i686,x86_64}-geos \
  mingw-w64-{i686,x86_64}-libxml2 \
  mingw-w64-{i686,x86_64}-tools-git \
  mingw-w64-{i686,x86_64}-tools \
	msys/vim


echo "Installing R packages"

echo "dir.create(Sys.getenv('R_LIBS_USER'), recursive=TRUE); \
  .libPaths( c(Sys.getenv('R_LIBS_USER'), .libPaths()) ) ; \
  install.packages(c( \
  'deSolve', \
  'sp', \
  'rgeos', \
  'fields', \
  'MASS', \
  'Matrix', \
  'deldir', \
  'pracma', \
  'raster', \
  'fftwtools', \
  'mvtnorm', \
  'rgdal', \
  'sf', \
  'splancs', \
  'knitr', \
  'rmarkdown', \
  'testthat', \
  'Rcpp', \
  'RcppArmadillo', \
  'RcppEigen', \
  'fasterize', \
  'roxygen2', \
  'shiny', \
  'htmltools', \
  'shinydashboard', \
  'ggplot2', \
  'dplyr', \
  'dbplyr', \
  'DT', \
  'magrittr', \
  'devtools', \
  'shinyjs', \
  'stringi', \
  'stringr', \
  'jsonlite', \
  'data.table', \
  'htmlwidgets', \
  'RSQLite', \
  'BiocManager', \
  'foreach', \
  'doParallel', \
  'mvtnorm', \
  'mapdata', \
  'proj4', \
  'gstat', \
  'automap', \
  'RCALI', \
  'rgenoud', \
  'purrr' \
  ), \
  dependencies=TRUE, \
  repos='https://cran.biotools.fr')" > /c/Windows/Temp/install.R 
  
Rscript /c/Windows/Temp/install.R

Rscript -e "BiocManager::install(c('Biostrings', ask=FALSE))"
Rscript -e "update.packages(ask=FALSE, repos='https://cran.biotools.fr')"

