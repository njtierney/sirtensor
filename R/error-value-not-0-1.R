error_value_not_0_1 <- function(value){
  if (value > 1 | value < 0){
    msg <- cli::format_error(
      c(
        "Value must be between 0 and 1",
        "Value was: {.val {value}}"
      )
    )
    stop(
      msg,
      call. = FALSE
    )
  }
}
