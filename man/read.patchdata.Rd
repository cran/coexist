\name{read.patchdata}
\alias{read.patchdata}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
read species abundance data from the patches, an internal function
}
\description{
read species abundance data from the patches, an internal function used by other functions
}
\usage{
read.patchdata(path = NULL, spnum = 2, islandnum = 10)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{path}{
local filename for the model output
}
  \item{spnum}{
species number in the model, default is 2
}
  \item{islandnum}{
patch number in the model,default is 10
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
\code{\link{batch.read}},
\code{\link{read.data}},
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function (path = NULL, spnum = 2, islandnum = island) 
{
    if (length(path) != 0) {
        raw <- scan(path, what = character(), sep = "\t")
        fileline <- length(count.fields(path))
        outlist <- list()
        length(outlist) <- fileline/(spnum + 1)
        sp <- matrix(0, nrow = spnum, ncol = islandnum)
        count = 0
        for (i in 1:length(raw)) {
            if (raw[i] == "V1") {
                count = count + 1
                for (j in 1:spnum) {
                  sp[j, ] = as.numeric(raw[(i + 10 + j + (j - 
                    1) * islandnum):(i + 10 + j - 1 + j * islandnum)])
                }
                outlist[[count]] <- list(abund = sp)
            }
        }
    }
    return(outlist)
  }
}
