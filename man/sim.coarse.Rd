\name{sim.coarse}
\alias{sim.coarse}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
2-species coexistence modeling based on the matrix listing out all combinations of parameter setting
}
\description{
all combinations of parameter setting can be input as in the argument item "prange"
}
\usage{
sim.coarse(island=10,scale = 2, dispersalscale = 51, allee = 1, T = 1000, prange, type, initp, path = NULL)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{island}{
  number of patches
}
  \item{scale}{
controlling the parameter's low value=parameter original value/scale; while
parameter's high value=parameter original value*scale. Specifically used in 
the spatial types.
}
  \item{dispersalscale}{
the scale value for reducing the connectivity probability between the neighbouring patches, allowing the simulation
slow down or speed up.
}
  \item{allee}{
allee effect for the species, the minimum viable population in a local patch, default=1, indicating that if the population
size in a patch for a species is less than 1, then the species was removed from that patch
}
  \item{T}{
simulation time/steps
}
  \item{prange}{
the matrix listing out all combinations of parameter setting
}
  \item{initp}{
initial population size for a species that will be released at the source patch at each time step
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
  \item{path}{
local disk file name or folder to save the simulated outputs
}
}

\value{
a list of output, each list member has a parameter combination vector, a matrix of species-site abundance
}
\references{
Chen YH (2012) coexist: an R package for performing species coexistence modeling and analysis under asymmetric dispersal and fluctuating source-sink dynamics.
http://code.google.com/p/coexist.
}
\author{
Youhua Chen <yhchen@zoology.ubc.ca>
}


\seealso{
\code{\link{flexsim}}
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function (scale = 2, dispersalscale = 51, allee = 1, T = 1000, 
    prange = parspace, type = typevector, path = NULL) 
{
    parnum = 5
    parlen <- length(prange)
    outcome <- list()
    length(outcome) <- parlen^parnum
    outindex <- matrix(0, nrow = parlen^parnum, ncol = parnum)
    colnames(outindex) <- c("r1", "r2", "dis", "c11", "c22")
    habitat1 <- parsetting(island, good, scale, type[1])
    habitat2 <- parsetting(island, good, scale, type[2])
    resource <- rbind(habitat1, habitat2)
    count = 0
    outcomefile = filename.check(path)
    for (i1 in 1:parlen) {
        for (i2 in 1:parlen) {
            for (i3 in 1:parlen) {
                for (i4 in 1:parlen) {
                  for (i5 in 1:parlen) {
                    grow1 <- parsetting(island, rate = prange[i1], 
                      scale, type[3])
                    grow2 <- parsetting(island, rate = prange[i2], 
                      scale, type[4])
                    grow <- rbind(grow1, grow2)
                    dismat <- dispvar(island, rate = prange[i3]/dispersalscale, 
                      scale, type[5])
                    comp1 <- compvar(island, rate = prange[i4], 
                      scale, type[6])
                    comp2 <- compvar(island, rate = prange[i5], 
                      scale, type[7])
                    spvector <- rbind(spabundance(island, 1000), 
                      spabundance(island, 1000))
                    count = count + 1
                    outindex[count, ] <- c(prange[i1], prange[i2], 
                      prange[i3], prange[i4], prange[i5])
                    for (j in 1:T) {
                      spvector <- competition(spvector, resource, 
                        comp1, comp2, grow, allee)
                      spvector <- dispersal(spvector, dismat, 
                        allee)
                    }
                    outcome[[count]] <- spvector
                    write.table(outcome[[count]], file = outcomefile, 
                      sep = "\t", append = TRUE)
                    outcome[[count]] <- list(abund = outcome[[count]], 
                      pars = outindex[count, ])
                  }
                }
            }
        }
    }
    return(outcome)
  }
}
