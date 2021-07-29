#' Generate some simulated values
#'
#' @param n population size to simulate
#' @param init_s size of initial population that is susceptible
#' @param init_i number infeceted
#' @param init_r initial R at time t
#' @param p_recover probability of recovering
#' @param p_transmit probability of transmission
#'
#' @return data frame with columns, S, I, R.
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

  # check S, I, R are integers
  vctrs::vec_assert(n, ptype = integer())
  vctrs::vec_assert(init_s, ptype = integer())
  vctrs::vec_assert(init_i, ptype = integer())
  vctrs::vec_assert(init_r, ptype = integer())

  # check other values are less than 1
  vctrs::vec_assert(p_recover, ptype = numeric())
  vctrs::vec_assert(p_transmit, ptype = numeric())

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

  df_sir <- tibble::tibble(
    S,
    I,
    R
  )

  return(
    df_sir
  )

}
