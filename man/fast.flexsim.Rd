\name{fast.flexsim}
\alias{fast.flexsim}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
faster multiple species simulation, but just a bit, not fast actually
}
\description{
similar to flexsim() function
}
\usage{
fast.flexsim(scale = 2, island,dispersalscale = 51, allee = 1, T = 1000, initp,parcombination, spnum = 2, sourcetype = "constant", type, path = NULL)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{scale}{
controlling the parameter's low value=parameter original value/scale; while
parameter's high value=parameter original value*scale. Specifically used in 
the spatial types.
}
  \item{island}{
number of patches in the simulation
}
  \item{dispersalscale}{
the scale value for reducing the dispersal rates between the neighbouring patches, allowing the simulation
slow down or speed up.
}
  \item{allee}{
allee effect for the species, the minimum viable population in a local patch, default=1, indicating that if the population
size in a patch for a species is less than 1, then the species was removed from that patch
}
  \item{T}{
simulation time/steps
}
  \item{parcombination}{
the matrix listing out all combinations of parameter setting
}
  \item{initp}{
initial population size for a species that will be released at the source patch at each time step
}
  \item{spnum}{
species number in the model
}
  \item{sourcetype}{
model configuration for the source supply methods, currently there are three types of source species supplying modes:
"constant": constant population size of each species will be released at the source patch for each simulation step
"flexible": random population size of each species will be released (all species should typically be assigned different values) based on a normal distribution with mean=initp, Variance=initp/2, at the source patch for each simulation step
"cochange": random population size (but all species will be assigned a same value) at the source patch for each simulation step
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

\references{
Chen YH (2012) coexist: an R package for performing species coexistence modeling and analysis under asymmetric dispersal and fluctuating source-sink dynamics.
http://code.google.com/p/coexist.
}
\author{
Youhua Chen <yhchen@zoology.ubc.ca>
}



\seealso{
\code{\link{flexsim}},
\code{\link{sim.coarse}}
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function (scale = 2, island,dispersalscale = 51, allee = 1, T = 1000, 
    initp, parcombination, spnum = 2, sourcetype = "constant", 
    type, path = NULL) 
{
    parnum = spnum * 3
    parcomb <- parcombination
    outcome <- list()
    length(outcome) <- dim(parcomb)[1]
    resource <- matrix(0, ncol = island, nrow = spnum)
    grow <- resource
    comp <- resource
    spvector <- resource
    for (i in 1:spnum) {
        resource[i, ] <- parsetting(island, initp, scale, type[i])
    }
    outcomefile <- filename.check(path)
    comnum <- dim(parcomb)[1]
    colnames(parcomb) <- c(paste("r", c(1:spnum), sep = ""), 
        paste("dis", c(1:spnum), sep = ""), paste("com", c(1:spnum), 
            sep = ""))
    dismat <- list()
    length(dismat) <- spnum
    for (each in 1:comnum) {
        typenum <- spnum
        for (i in 1:spnum) {
            grow[i, ] <- parsetting(island, rate = parcomb[each, 
                i], scale, type[typenum + i])
        }
        typenum <- spnum + typenum
        for (i in 1:spnum) {
            dismat[[i]] <- dispvar(island, rate = parcomb[each, 
                i + spnum]/dispersalscale, scale, type[typenum + 
                i])
        }
        typenum <- spnum + typenum
        for (i in 1:spnum) {
            comp[i, ] <- parsetting(island, rate = parcomb[each, 
                i + spnum * 2], scale, type[typenum + i])
        }
        for (i in 1:spnum) {
            spvector[i, ] <- spabundance(island, 1000)
        }
        for (j in 1:T) {
            spvector <- flex.competition(spvector, resource, 
                grow, comp, allee)
            spvector <- flex.dispersal(spvector, dismat, allee, 
                type = sourcetype)
        }
        outcome[[each]] <- spvector
        write.table(outcome[[each]], file = outcomefile, sep = "\t", 
            append = TRUE)
        outcome[[each]] <- list(abund = outcome[[each]], pars = parcomb[each, 
            ])
    }
    return(outcome)
  }
}
