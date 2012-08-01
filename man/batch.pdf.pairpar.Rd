\name{batch.pdf.pairpar}
\alias{batch.pdf.pairpar}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
batch analysis to plot matrix heatmaps for pairwise parameter matrices for different scenarios and generate pdf graphics
}
\description{
batch analysis to plot matrix values for pairwise parameter matrix
}
\usage{
batch.pdf.pairpar(parmatlist, pagesetup = c(2, 2), path = NULL)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{parmatlist}{
a list of data generated from batch.mpaircomp() function
}
  \item{pagesetup}{
how many plots would print in a page of the pdf document, default is 2*2=4 plots
}
  \item{path}{
local disk path for saving the pdf graphics,
if given, the file name will be changed by adding a postfix as "00yh"+a rand uniform number+".pdf" to avoid re-write
another file with the same file name.
If not given, the file name would be saved to a default path "c://outcome/" with a postfix "pairwiseparameters"+ a random number+".pdf" 
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
\code{\link{batch.pdf.onepar}},
\code{\link{batch.monepar}},
\code{\link{batch.mpaircomp}}
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function (parmatlist, pagesetup = c(2, 2), path = NULL) 
{
    scenarionum <- length(parmatlist)
    parnum <- length(parmatlist[[1]][[1]])
    if (length(path) != 0) {
        randnum <- runif(1)
        pos <- unlist(gregexpr("/", path))
        folder <- substr(path, 1, pos[length(pos)] - 1)
        dir.create(folder, showWarnings = F)
        filename = paste(path, "00yh", randnum, ".pdf", sep = "")
    }
    else {
        randnum <- runif(1)
        dir.create(folder, showWarnings = F)
        filename = paste(folder, "pairwiseparameters", randnum, 
            ".pdf", sep = "")
    }
    pdf(filename)
    par(mfrow = pagesetup)
    for (each in 1:parnum) {
        for (i in 1:scenarionum) {
            xname = paste("Model", i, sep = "-")
            title = names(parmatlist[[i]][[1]])[each]
            t <- parmatlist[[i]][[1]][[each]]
            t <- t(t)
            make.heatmap(t, xname = xname, xlab = c(0.1, 0.25, 
                0.5, 0.75, 0.9), ylab = c(0.1, 0.25, 0.5, 0.75, 
                0.9), title = title)
        }
    }
    dev.off()
  }
}
