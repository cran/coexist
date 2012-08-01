\name{dispvar}
\alias{dispvar}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
dispersal parameters' matrix
}
\description{
dispersal parameters' matrix
}
\usage{
dispvar(island, rate = 0.5, scale = 2, type = "decrease")
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{island}{
patch number in the simulation
}
  \item{rate}{
basal dispersal rate across the patches
}
  \item{scale}{
controlling the parameter's low value=parameter original value/scale; while
parameter's high value=parameter original value*scale. 
}
  \item{type}{
a model configuration vector describing the spatial patterns of each of the parameters, for example, a vector like this,
c("decrease","decrease","decrease","increase","increase","increase","mosaiclow") can be used as the input.
There are 5 simple spatial types currently for the package:
"decrease",the parameter will have one-time decreasing transition from source patch to other sink patches in the middle of the patches
"increase",the parameter will have one-time increasing transition from source patch to other sink patches in the middle of the patches
"constant",the parameter will keep in a constant value across the patches during the simulation
"mosaiclow",the parameter will switch from a low value to a high value one-by-one from the source patch to sink patches, so source
patch the parameter for the species there will be assigned a low value
"mosaichigh",the parameter will switch from a high value to a low value one-by-one from the source patch to sink patches,so source patch
the parameter for the species there will be assigned a high value
}
}

\references{
Chen YH (2012) coexist: an R package for performing species coexistence modeling and analysis under asymmetric dispersal and fluctuating source-sink dynamics.
http://code.google.com/p/coexist.
}
\author{
Youhua Chen <yhchen@zoology.ubc.ca>
}


\seealso{
\code{\link{flex.dispersal}},
\code{\link{dispersal}}
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function (island, rate = 0.5, scale = 2, type = "decrease") 
{
    dismat <- matrix(0, ncol = island, nrow = island)
    if (type == "decrease") {
        for (i in 1:as.integer((island - 1)/2)) {
            dismat[i, i + 1] = rate
        }
        for (i in (as.integer((island - 1)/2) + 1):(island - 
            1)) {
            dismat[i, i + 1] = rate/scale
        }
        diag(dismat) <- 1 - rowSums(dismat)
    }
    if (type == "increase") {
        for (i in 1:as.integer((island - 1)/2)) {
            dismat[i, i + 1] = rate/scale
        }
        for (i in (as.integer((island - 1)/2) + 1):(island - 
            1)) {
            dismat[i, i + 1] = rate
        }
        diag(dismat) <- 1 - rowSums(dismat)
    }
    if (type == "constant") {
        for (i in 1:(island - 1)) {
            dismat[i, i + 1] = rate
        }
        diag(dismat) <- 1 - rowSums(dismat)
    }
    if (type == "mosaiclow") {
        for (i in 1:(island - 1)) {
            if (i\%\%2 == 0) {
                dismat[i, i + 1] = rate
            }
            else {
                dismat[i, i + 1] = rate/scale
            }
        }
        diag(dismat) <- 1 - rowSums(dismat)
    }
    if (type == "mosaichigh") {
        for (i in 1:(island - 1)) {
            if (i\%\%2 == 0) {
                dismat[i, i + 1] = rate/scale
            }
            else {
                dismat[i, i + 1] = rate
            }
        }
        diag(dismat) <- 1 - rowSums(dismat)
    }
    return(dismat)
  }
}