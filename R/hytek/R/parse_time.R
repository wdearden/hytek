#' Parse hytek time
#'
#' @importFrom readr parse_time
#' @importFrom stringr str_replace str_detect
#' @importFrom dplyr if_else
#' @param time a character vector containing the time scraped from Hy-Tek
#' @export
#' @examples 
#' parse_time_hytek(c("4:23.10#", "23.10"))
parse_time_hytek <- function(time) {
    # Remove record annotations
    time <- stringr::str_replace(time, '(!|#|@)$', '')
    
    # parse_time requires two digit minute
    time <- stringr::str_replace(time, '^([1-9]):', '0\\1:')
    
    suppressWarnings(dplyr::if_else(
        stringr::str_detect(time, '^[0-9]+:')
        , readr::parse_time(time, '%M:%OS')
        , readr::parse_time(time, '%OS')
    ))
}
