install.packages("tictoc","microbenchmark","lobstr")

### Tictoc example

library(tictoc)

iterations <- 10000

# inefficient: kopieert de lijst in elke iteratie
tic()
a <- list()
for (i in 1:iterations){
  a <- c(a, 2*i)
  print(lobstr::obj_addr(a))
}
toc()

# beter: maak de lijst eerst op de juiste lengte en pas alleen de elementen aan
tic()
b <- vector("list", iterations)
for (i in 1:iterations){
  b[[i]] <- 2*i
  print(lobstr::obj_addr(b))
}
toc()

# makkelijker (niet altijd sneller!): gebruik een map() functie wanneer je elk element in een lijst wilt aanpassen
tic()
c <- purrr::map(1:iterations, function(x){2*x})
toc()

# snelst: gebruik een vectorized functie als die bestaat voor wat je wilt doen
tic()
d <- as.list(2*1:iterations)
toc()

### Microbenchmark example

library(microbenchmark)

search_words <- sample(stringr::words, 100)
collection_words <- sample(stringr::words, 500)

microbenchmark::microbenchmark(
  {
    result <- vector("logical", length(search_words))
    for (i in 1:length(search_words)){
      result[[i]] <- search_words[[i]] %in% collection_words
    }
  },
  {
    purrr::map_lgl(search_words, function(w){w %in% collection_words})
  },
  {
    search_words %in% collection_words
  })
