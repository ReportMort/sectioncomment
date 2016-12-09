
#' Convert to Section Comment
#'
#' Creates an 80 character width comment padded with hyphens, similar to how 
#' comments are shown in Hadley's style guide (http://adv-r.had.co.nz/Style.html)
#'
#' @usage sectioncomment
#' @importFrom stringr str_split
#' @export
sectioncomment <- function() {
  
  context <- rstudioapi::getActiveDocumentContext()
  
  for (sel in context$selection) {
    
    cursor_ln <- context$selection[[1]]$range$start[["row"]]
    cursor_col <- context$selection[[1]]$range$start[["column"]]
    entire_doc <- FALSE

    if (cursor_ln == 1 & cursor_col == 1)
      entire_doc <- TRUE
      
    if (sel$text != '' | entire_doc){
      
      if(!entire_doc){
        ln_start <- context$selection[[1]]$range$start[["row"]]
        ln_end <- context$selection[[1]]$range$end[["row"]]  
      } else {
        ln_start <- 1
        ln_end <- length(context$contents)
      }
      
      potential_target_lines <- context$contents[ln_start:ln_end]
      
      # pre-screen the rows for comment-like lines 
      # so that we don't loop through all lines
      # and modifying ranges where it's not necessary
      # and doesn't do anything
      found_target_lines <- target_line_identifier(potential_target_lines, 
                                                   doc_mode=entire_doc)
      
      if(length(found_target_lines) > 0){
        
        target_lines <- seq.int(from=ln_start, to=ln_end)[found_target_lines]
        
        for (i in target_lines){
          
          value <- context$contents[i]
          
          rstudioapi::modifyRange(whole_line_range(i), 
                                  comment_styler(value,
                                                 doc_mode=entire_doc), 
                                  context$id)
        }
      }
      
      break
    } else {
      
      ln <- context$selection[[1]]$range$start[["row"]]
      value <- context$contents[ln]
      
      if (value == '') {
        value <- '# a section break comment'
      }
      
      rstudioapi::modifyRange(whole_line_range(ln), comment_styler(value), context$id)
    }
  }
}


#' Function to create the padded comment
#' 
#' This function is the logic that runs to reformat
#' the comment as a section break
#' 
#' @usage comment_styler(x, doc_mode=FALSE, l = 80)
#' @importFrom stringr str_pad
#' @param x a string to format
#' @param doc_mode a logical indicating only to convert 
#' lines starting with at least a double hash sign
#' @param l an integer indicating length to pad
#' @return a string that is formatted
comment_styler <- function(x, doc_mode=FALSE, l=80) {
  
  starter_regex <- '(\\s*#+\\s*)(.*)'
  
  if(doc_mode)
    starter_regex <- '(\\s*#{2,}\\s*)(.*)'
  
  if(grepl(starter_regex, x)){
    clean_x <- trimws(gsub('-*$', '', gsub('-+\\s+-+', '', trimws(x))))
    x <- str_pad(gsub(starter_regex, '# \\2 ', clean_x), width=l, side='right', pad='-')  
  }
  
  return(x)
}


target_line_identifier <- function(x, doc_mode=FALSE){
  
  starter_regex <- '(\\s*#+\\s*)(.*)'
  
  if(doc_mode)
    starter_regex <- '(\\s*#{2,}\\s*)(.*)'
  
  lines_matching <- which(grepl(starter_regex, x))
    
  return(lines_matching)
}


whole_line_range <- function(ln){
  
  range <- structure(list(start = structure(c(ln, 1), .Names = c("row", "column"), 
                                            class = "document_position"),
                          end = structure(c(ln, 99999), .Names = c("row", "column"), 
                                          class = "document_position")), 
                     .Names = c("start", "end"), class = "document_range")
  
  return(range)
}
