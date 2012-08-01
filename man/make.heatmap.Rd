\name{make.heatmap}
\alias{make.heatmap}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
make a heatmap based on matrix values
}
\description{
make a heatmap based on matrix values
}
\usage{
make.heatmap(mat, type = "gray", xname = "x", yname = "y", xlab = NULL, ylab = NULL, title = NULL)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{mat}{
the coexistence density matrix under the two parameter value combination (x and y)
}
  \item{type}{
currently only support the "gray" density heatmap
}
  \item{xname}{
name for parameter x at the horizontal axis
}
  \item{yname}{
name for parameter y at the vertical axis
}
  \item{xlab}{
parameter x's sampling point vector, for example, c(.1,.3,.6,.9), something like that..
}
  \item{ylab}{
parameter y's sampling point vector, for example, c(.1,.3,.6,.9), something like that..
}
  \item{title}{
main text for the figure
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
\code{\link{batch.pdf.onepar}}
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function (mat, type = "gray", xname = "x", yname = "y", xlab = NULL, 
    ylab = NULL, title = NULL) 
{
    xrange <- dim(mat)[2] + 1
    yrange <- dim(mat)[1] + 1
    if (xrange >= yrange) {
        maxrange <- xrange
        xscale = 1
        yscale <- yrange/xrange
    }
    if (yrange > xrange) {
        maxrange <- yrange
        xscale <- xrange/yrange
        yscale = 1
    }
    maxnum = ceiling(max(as.vector(mat)))
    tmat <- t(mat)
    plot((1:maxrange) * xscale, (1:maxrange) * yscale, type = "n", 
        xlab = xname, ylab = yname, axes = F)
    if (length(xlab) != 0) {
        axis(1, at = c(1:(xrange - 1)) + 0.5, labels = xlab)
    }
    else {
        axis(1, at = c(1:(xrange - 1)) + 0.5, labels = c(1:(xrange - 
            1)))
    }
    if (length(ylab) != 0) {
        axis(2, at = c(1:(yrange - 1)) + 0.5, labels = ylab)
    }
    else {
        axis(2, at = c(1:(yrange - 1)) + 0.5, labels = c(1:(yrange - 
            1)))
    }
    if (length(title) != 0) {
        mtext(title)
    }
    for (i in 1:(xrange - 1)) {
        for (j in 1:(yrange - 1)) {
            value = tmat[i, j]
            x1 = i
            x2 = i + 1
            y1 = j
            y2 = j + 1
            if (type == "gray") {
                rect(x1, y1, x2, y2, col = gray((maxnum - value)/maxnum), 
                  border = gray((maxnum - value)/maxnum))
            }
        }
    }
  }
}