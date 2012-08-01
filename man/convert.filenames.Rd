\name{convert.filenames}
\alias{convert.filenames}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
convert saved data sets' names in to a vector based on the order of numbers, which will be called by batch.read() function
}
\description{
convert saved data sets' names in to a vector based on the order of numbers, which will be called by batch.read() function
}
\usage{
convert.filenames(folder)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{folder}{
the folder that stored all the model outputs, not a detailed filename
}
}

\value{
return a vector for each member is a path pointed to a filename (a model output), which can be called by batch.read() function
}
\references{
Chen YH (2012) coexist: an R package for performing species coexistence modeling and analysis under asymmetric dispersal and fluctuating source-sink dynamics.
http://code.google.com/p/coexist.
}
\author{
Youhua Chen <yhchen@zoology.ubc.ca>
}

\seealso{
\code{\link{read.data}}, 
\code{\link{batch.read}},
\code{\link{read.patchdata}}
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function (folder) 
{
    files <- list.files(path = folder, full.names = TRUE)
    newf <- vector()
    fnum <- length(files)
    length(newf) <- fnum
    dataorder <- rep(0, 1, fnum)
    for (i in 1:fnum) {
        pos.end <- unlist(gregexpr("00yh", files[i]))[1] - 1
        pos.start <- unlist(gregexpr(paste(folder, "/out", sep = ""), 
            files[i]))[1] + 15
        dataorder[i] <- as.numeric(substr(files[i], pos.start, 
            pos.end))
    }
    for (i in 1:fnum) {
        newf[dataorder[i]] <- files[i]
    }
    newf <- newf[!is.na(newf)]
    return(newf)
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
