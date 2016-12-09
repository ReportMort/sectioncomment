# sectioncomment

Creates an 80 character width comment padded with hyphens, similar to how 
comments are recommended in Hadley's style guide (http://adv-r.had.co.nz/Style.html). 
"Use commented lines of - and = to break up your file into easily readable chunks."

```r
# Load data ---------------------------
# Plot data ---------------------------
```

## System Requirements

* Run RStudio v0.99.878 or later
  - <https://www.rstudio.com/products/rstudio/download/preview/>
* Run `rstudioapi` package v0.5 or later
  - `install.packages("rstudioapi", type = "source")`
* Populate your *Addins* dropdown menus with some examples
  - `devtools::install_github("rstudio/addinexamples", type = "source")`

## Installation

```r
devtools::install_github("ReportMort/sectioncomment")
```

## Usage 

```r

# write a comment, place your cursor on the line and go to Addins > Section Comment

# write multiple comments
# then select those lines and 
# they all will be converted after clicking Addins > Section Comment

# CRT+A and then run

# run on an empty line
