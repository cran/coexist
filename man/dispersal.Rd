\name{dispersal}
\alias{dispersal}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
perform dispersal analysis for each simulation time step for 2-species modeling
}
\description{
this function is used to characterize species' dispersal across the patches for each time step
}
\usage{
dispersal(spvector, initp,dismat, allee = 1)
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
a dispersal matrix, or connectivity matrix among the patches (i.e., matrix is the same for all species). Different from flex.dispersal() function, which is a list of matrices,
and allowed different species will have different dispersal rates across patches
}
  \item{allee}{
allee effect for the species, the minimum viable population in a local patch, default=1, indicating that if the population
size in a patch for a species is less than 1, then the species will be removed from that patch
}
}
\details{
return an updated species-patch abundance matrix at next time step
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
\code{\link{competition}}
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function (spvector, initp, dismat, allee = 1) 
{
    spvector <- spvector \%*\% dismat
    spvector[1, 1] = initp
    spvector[2, 1] = initp
    spvector[which(spvector < allee)] = 0
    return(spvector)
  }
}