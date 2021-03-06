\name{plot_n2n}
\alias{plot_n2n}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
plot distribution of niche and neutral coexistence patterns and generate pdf graphics
}
\description{
make barplots to compare the model outcomes under niche and nearly-neutrality parameter settings
}
\usage{
plot_n2n(resultlist, island, pagesetup = c(1, 1), path = NULL)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{resultlist}{
output from batch.n2n() function
}
  \item{island}{
number of patches in the model
}
  \item{pagesetup}{
how many figures will be generated in one page
}
  \item{path}{
local disk filename for saving the pdf graphics; if path==NULL, a random filename will be generated under "c://outcome" folder
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
\code{\link{batch.n2n}}, 
\code{\link{batch.coexistence}},
\code{\link{batch.mcoexistence}}
}

\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function (resultlist, island = island, pagesetup = c(1, 1), path = NULL) 
{
    prop <- list()
    length(prop) <- length(resultlist)
    scenarionum <- length(resultlist)
    temp <- matrix(0, ncol = 2, nrow = island - 1)
    for (i in 1:scenarionum) {
        temp[, 1] = rev(resultlist[[i]][1:9, 1]/resultlist[[i]][island, 
            1])
        temp[, 2] = rev(resultlist[[i]][1:9, 2]/resultlist[[i]][island, 
            2])
        prop[[i]] <- temp
    }
    if (length(path) != 0) {
        randnum <- runif(1)
        pos <- unlist(gregexpr("/", path))
        folder <- substr(path, 1, pos[length(pos)] - 1)
        dir.create(folder, showWarnings = F)
        filename = paste(path, "00yh", randnum, ".dat", sep = "")
    }
    else {
        randnum <- runif(1)
        dir.create(folder, showWarnings = F)
        filename = paste(folder, "n2nbarplot", randnum, ".dat", 
            sep = "")
    }
    pdf(filename)
    par(mfrow = pagesetup)
    for (i in 1:scenarionum) {
        nnplot <- barplot(prop[[i]], beside = T, axisnames = F, 
            col = 1)
        y <- max(prop[[i]])
        text(nnplot[5, 1], y - 0.05, "Neutrality", font = 2, 
            cex = 2)
        text(nnplot[5, 2], y - 0.05, "Niche", font = 2, cex = 2)
        axis(1, at = nnplot[, 1], labels = c(1, 2, 3, 4, 5, 6, 
            7, 8, 9))
        axis(1, at = nnplot[, 2], labels = c(1, 2, 3, 4, 5, 6, 
            7, 8, 9))
        mtext(paste("Model", i, sep = "-"))
    }
    dev.off()
  }
}

