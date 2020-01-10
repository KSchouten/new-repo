# hoofd script
library(tictoc)
source("src/generics.R")
source("src/retrieve_raw_data.R")

some_generic_function(1:10)

tic()
get_some_data()
toc()
another_function()

lobstr


a <- list()
for (i in 1:10){
  a <- c(a, i)
  print(lobstr::obj_addr(a))
}

