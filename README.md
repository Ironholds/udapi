## Urban Dictionary API client

__Author:__ Oliver Keyes<br/>
__License:__ [MIT](http://opensource.org/licenses/MIT)<br/>
__Status:__ Stable

[![Travis-CI Build Status](https://travis-ci.org/Ironholds/udapi.svg?branch=master)](https://travis-ci.org/Ironholds/udapi) ![downloads](http://cranlogs.r-pkg.org/badges/grand-total/udapi)

###Description

Exactly what it says on the tin, udapi provides a connector to the Urban Dictionary API. It allows you to:

1. Retrieve definitions associated with a term, using `get_term`;
2. Retrieve definitions associated with a *random* term, using `random_term`;
3. Retrieve metadata tags associated with a term, using `get_tags`.

It's a simple client because it's a simple API.

Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md).
By participating in this project you agree to abide by its terms.

###Installation

The CRAN version can be retrieved with:

    install.packages("udapi")
    
The latest version can be obtained via:

    devtools::install_github("ironholds/udapi")

###Dependencies
* R
* httr
