\name{batch.pdf.onepar}
\alias{batch.pdf.onepar}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
batch mode to plot matrix heatmap graphics for different model scenarios but only working on the sampling points of one parameter (x-axis) and generate pdf graphics
}
\description{
batch mode to plot matrix heatmap graphics for different model scenarios but only working on the sampling points of one parameter (x-axis) and generate pdf graphics
}
\usage{
batch.pdf.onepar(parmatlist, pagesetup = c(2, 2), path = NULL)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{parmatlist}{
a list of data generated from batch.monepar() function
}
  \item{pagesetup}{
how many plots would print in a page of the pdf document, default is 2*2=4 plots
}
  \item{path}{
local disk path for saving the pdf graphics,
if given, the file name will be changed by adding a postfix as "00yh"+a rand uniform number+".pdf" to avoid re-write
another file with the same file name.
If not given, the file name would be saved to a default path "c://outcome/" with a postfix "singleparameter"+ a random number+".pdf" 
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
\code{\link{batch.pdf.pairpar}},
\code{\link{batch.monepar}}
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function (parmatlist, pagesetup = c(2, 2), path = NULL) 
{
    scenarionum <- length(parmatlist)
    parnum <- length(parmatlist[[1]])
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
        filename = paste(folder, "singleparameter", randnum, 
            ".pdf", sep = "")
    }
    pdf(filename)
    par(mfrow = pagesetup)
    for (each in 1:parnum) {
        for (i in 1:scenarionum) {
            xname = paste("Model", i, sep = "-")
            title = names(parmatlist[[i]])[each]
            t <- parmatlist[[i]][[each]]
            t <- t[order(t[, 1], decreasing = F), ]
            t <- t[-1, -1]
            make.heatmap(t, xname = xname, xlab = c(0.1, 0.25, 
                0.5, 0.75, 0.9), ylab = c(1:9), title = title)
        }
    }
    dev.off()
  }
}

