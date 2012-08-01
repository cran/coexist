\name{flex.dispersal}
\alias{flex.dispersal}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
perform species-specific dispersal and fluctuating source analysis, for two or multiple species models, it's
an internal function
}
\description{
perform species-specific dispersal and fluctuating source analysis, for two or multiple species models, it's
an internal function
}
\usage{
flex.dispersal(spvector, initp,dismat, allee = 1,type = "constant")
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{spvector}{
species-patch abundance matrix prior to dispersal in this time step
}
  \item{initp}{
initial population size for a species that will be released at the source patch at each time step
}
  \item{dismat}{
a list of dispersal matrix for each of the species. The dispersal matrix for the species indicated its dispersal
ability and perference across the patches.
}
  \item{allee}{
allee effect for the species, the minimum viable population in a local patch, default=1, indicating that if the population
size in a patch for a species is less than 1, then the species will be removed from that patch

}

  \item{type}{
model configuration for the source supply methods, currently there are three types of source species supplying modes:
"constant": constant population size of each species will be released at the source patch for each simulation step
"flexible": random population size of each species will be released (all species should typically be assigned different values) based on a normal distribution with mean=initp, Variance=initp/2, at the source patch for each simulation step
"cochange": random population size (but all species will be assigned a same value) at the source patch for each simulation step
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
\code{\link{flex.competition}},
\code{\link{dispersal}}
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function (spvector, initp,dismat, allee = 1, type = "constant") 
{
    if (type == "constant") {
        spnum <- length(dismat)
        for (i in 1:spnum) {
            spvector[i, ] <- spvector[i, ] \%*\% dismat[[i]]
            spvector[i, 1] = initp
        }
    }
    if (type == "flexible") {
        spnum <- length(dismat)
        for (i in 1:spnum) {
            spvector[i, ] <- spvector[i, ] \%*\% dismat[[i]]
            spvector[i, 1] = rnorm(1, mean = initp, sd = initp/10)
        }
    }
    if (type == "cochange") {
        spnum <- length(dismat)
        newresource <- rnorm(1, mean = initp, sd = initp/10)
        for (i in 1:spnum) {
            spvector[i, ] <- spvector[i, ] \%*\% dismat[[i]]
            spvector[i, 1] = newresource
        }
    }
    spvector[which(spvector < allee)] = 0
    spvector[which(spvector < 0)] = 0
    return(spvector)
  }
}
