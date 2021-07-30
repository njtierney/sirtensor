#' Generate some simulated values
#'
#' @param n population size to simulate
#' @param init_s size of initial population that is susceptible
#' @param init_i number infeceted
#' @param init_r initial R at time t
#' @param p_recover probability of recovering
#' @param p_transmit probability of transmission
#'
#' @return data frame with columns: S, I, R, with `n` rows.
#' @export
#'
#' @examples
#'
#' new_sims <- pop_sim()
#'
#' plot(new_sims$S, type = "l", col = "blue", ylim = c(0, new_sims$S[1]))
#' lines(new_sims$I, col = "red")
#' lines(new_sims$R, col = "green")

pop_sim <- function(
  n = 20L,
  init_s = 100L,
  init_i = 2L,
  init_r = 0L,
  p_recover = 0.1,
  p_transmit = 0.4
){

  # check S, I, R, p_recover, p_transmit are appripriate inputs
  vctrs::vec_cast(n, integer(), x_arg = "n")
  vctrs::vec_cast(init_s, integer(), x_arg = "init_s")
  vctrs::vec_cast(init_i, integer(), x_arg = "init_i")
  vctrs::vec_cast(init_r, integer(), x_arg = "init_r")
  vctrs::vec_cast(p_recover, numeric(), x_arg = "p_recover")
  vctrs::vec_cast(p_transmit, numeric(), x_arg = "p_recover")

  # check other values are less than 1
  error_value_not_0_1(p_recover)
  error_value_not_0_1(p_transmit)

  S <- I <- R <- rep(NA, n)
  S[1] <- init_s
  I[1] <- init_i
  R[1] <- init_r

  for (i in 2:n) {

    new_infections <- rbinom(
      n = 1,
      size = S[i - 1],
      prob = p_transmit * I[i - 1]/ (I[i - 1] + S[i - 1])
    )
    new_recoveries <- rbinom(
      n = 1,
      size = I[i - 1],
      prob = p_recover
    )

    I[i] <- I[i - 1] + new_infections - new_recoveries
    S[i] <- S[i - 1] - new_infections
    R[i] <- R[i - 1] + new_recoveries

  }

  tibble::tibble(
    S,
    I,
    R
  )

}
