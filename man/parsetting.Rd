\name{parsetting}
\alias{parsetting}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
rate vector for each species at each island, called widely by other functions
}
\description{
set up rate matrix of species-patches for the simulation
}
\usage{
parsetting(island, rate = 1, scale = 2, type = "decrease")
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{island}{
number of patches
}
  \item{rate}{
basal rate for setting up the matrix
}
  \item{scale}{
controlling the parameter's low value=parameter original value/scale; while
parameter's high value=parameter original value*scale. Specifically used in 
the spatial types.
}
  \item{type}{
a model configuration vector describing the spatial patterns of each of the paramters (default is "decrease"), for example, a vector like this,
c("decrease","decrease","decrease","increase","increase","increase","mosaiclow") can be used as the input.
There are 5 simple spatial types currently for the package:
"decrease",the parameter will have one-time decreasing transition from source patch to other sink patches in the middle of the patches
"increase",the parameter will have one-time increasing transition from source patch to other sink patches in the middle of the patches
"constant",the parameter will keep in a constant value across the patches during the simulation
"mosaiclow",the parameter will switch from a low value to a high value one-by-one from the source patch to sink patches, so source
patch the paramter for the species there will be assigned a low value
"mosaichigh",the parameter will switch from a high value to a low value one-by-one from the source patch to sink patches,so source patch
the paramter for the species there will be assigned a high value
}
}
\details{
will return a vector for recording species parameter value at each patch
}

\references{
Chen YH (2012) coexist: an R package for performing species coexistence modeling and analysis under asymmetric dispersal and fluctuating source-sink dynamics.
http://code.google.com/p/coexist.
}
\author{
Youhua Chen <yhchen@zoology.ubc.ca>
}



\seealso{
\code{\link{sim.coarse}}, 
\code{\link{flexsim}}
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function (island, rate = 1, scale = 2, type = "decrease") 
{
    parset <- vector()
    length(parset) <- island
    if (type == "decrease") {
        parset[1:as.integer(island/2)] = rate
        parset[(as.integer(island/2) + 1):island] = rate/scale
    }
    if (type == "increase") {
        parset[1:as.integer(island/2)] = rate/scale
        parset[(as.integer(island/2) + 1):island] = rate
    }
    if (type == "constant") {
        parset[1:island] = rate
    }
    if (type == "mosaiclow") {
        for (i in 1:island) {
            if (i\%\%2 == 0) {
                parset[i] = rate
            }
            else {
                parset[i] = rate/scale
            }
        }
    }
    if (type == "mosaichigh") {
        for (i in 1:island) {
            if (i\%\%2 == 0) {
                parset[i] = rate/scale
            }
            else {
                parset[i] = rate
            }
        }
    }
    return(parset)
  }
}