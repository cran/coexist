\name{read.data}
\alias{read.data}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
read data with paramter combination index file
}
\description{
read the data from one model/scenario output
}
\usage{
read.data(path = NULL, index = NULL, spnum = 2, islandnum=10)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{path}{
local filename for the model output
}
  \item{index}{
local fielname/path for recording all the paramter combination 
}
  \item{spnum}{
species number in the model, default is 2
}
  \item{islandnum}{
patch number in the model,default is 10
}
}
\details{
return a list of data, for each list member there is a paramater combination item in a vector form and an abundance matrix of species-patches
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
\code{\link{read.patchdata}}
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function (path = NULL, index = NULL, spnum = 2, islandnum=10) 
{
    if (is.character(index)) {
        indmat <- read.table(index, header = T)
        index = indmat
    }
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
                par <- index[count, ]
                names(par) <- c(paste("r", 1:spnum, sep = ""), 
                  paste("dis", 1:spnum, sep = ""), paste("c", 
                    1:spnum, sep = ""))
                outlist[[count]] <- list(abund = sp, pars = par)
            }
        }
    }
    return(outlist)
  }
}