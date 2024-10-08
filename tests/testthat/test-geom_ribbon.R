
# generate test data for testing
locations <- data.frame(
  long = c(-74, 139, 37, 151),
  lat = c(40, 35, 55, -33)
)

dates <- seq(as.Date("2024-01-01"), by = "day", length.out = 365)
data <- expand.grid(date = dates, long = locations$long, lat = locations$lat)
data$min <- rnorm(nrow(data), mean = 10, sd = 5)
data$max <- data$min + runif(nrow(data), min = 0, max = 10)


test_that("Plot returns ggplot object" ,{
  p <- data |>
    ggplot2::ggplot(
      ggplot2::aes(x_major = long, y_major = lat,
                   x_minor = date, ymin_minor = min, ymax_minor = max)) +
    geom_glyph_ribbon()
  expect_s3_class(p, "ggplot")
})

test_that("geom_ribbon() checks the aesthetics", {

  # omit ymax_minor
  p <- ggplot2::ggplot(data,
              ggplot2::aes(x_major = long, y_major = lat,
                          x_minor = date, ymin_minor = min)) +
    geom_glyph_ribbon()
  expect_error(ggplot2::ggplotGrob(p))

  p <- ggplot2::ggplot(data,
                       ggplot2::aes(x_major = long, ymax_minor = max,
                                    x_minor = date, ymin_minor = min)) +
    geom_glyph_ribbon()
  expect_error(ggplot2::ggplotGrob(p))


  p <- ggplot2::ggplot(data,
                       ggplot2::aes(x_major = long, y_major = lat, ymax_minor = max,
                                    x_minor = as.character(date), ymin_minor = min)) +
    geom_glyph_ribbon(width = "a")
  expect_error(ggplot2::ggplotGrob(p))

  p <- ggplot2::ggplot(data,
                       ggplot2::aes(x_major = long, y_major = lat, ymax_minor = max,
                                    x_minor = as.character(date), ymin_minor = min)) +
    geom_glyph_ribbon(height = "b")
  expect_error(ggplot2::ggplotGrob(p))

})


test_that("geom_ribbon interacts correctly with other geoms", {
  df <- data.frame(long = 1,
                   lat = 10,
                   date = seq(as.Date('2020-01-01'), by = "1 day", length.out = 5),
                   min = runif(5),
                   max = runif(5, 1, 2))
  p <- df |>
    ggplot2::ggplot(
      ggplot2::aes(x_major = long, y_major = lat,
                   x_minor = date, ymin_minor = min, ymax_minor = max)) +
    geom_glyph_ribbon() +
    ggplot2::geom_point()
  expect_s3_class(p, "ggplot")
})

test_that("geom_glyph_ribbon() works", {
  skip_if_not_installed("vdiffr")

  p <- ggplot2::ggplot(data = aus_temp) +
    ggplot2::geom_sf(data = ozmaps::abs_ste, color = "white")

  P1 <- p + geom_glyph_ribbon(
    width = 0.4,
    height = 0.1,
    ggplot2::aes(
      x_major = long,
      y_major = lat,
      x_minor = month,
      ymin_minor = tmin,
      ymax_minor = tmax)
  ) +
    ggthemes::theme_map()


  P2 <- p + geom_glyph_ribbon(
    global_rescale = FALSE,
    ggplot2::aes(
      x_major = long,
      y_major = lat,
      x_minor = month,
      ymin_minor = tmin,
      ymax_minor = tmax)
  ) +
    ggthemes::theme_map()


  P3 <- p + geom_glyph_ribbon(
    global_rescale = TRUE,
    ggplot2::aes(
      x_major = long,
      y_major = lat,
      x_minor = month,
      ymin_minor = tmin,
      ymax_minor = tmax)
  )  +
    ggthemes::theme_map()


  P4 <- aus_temp |> ggplot2::ggplot(
    ggplot2::aes(x_major = long,
                 y_major = lat,
                 x_minor = month,
                 ymin_minor = tmin,
                 ymax_minor = tmax)) +
    ggplot2::geom_sf(data = ozmaps::abs_ste, color = "white", inherit.aes = FALSE) +
    add_glyph_boxes() +
    add_ref_lines() +
    geom_glyph_ribbon() +
    ggthemes::theme_map()

  vdiffr::expect_doppelganger("geom_glyph_ribbon_identity", P1)
  vdiffr::expect_doppelganger("geom_glyph_ribbon_local_rescale", P2)
  vdiffr::expect_doppelganger("geom_glyph_ribbon_global_rescale", P3)
  vdiffr::expect_doppelganger("geom_glyph_ribbon_all", P4)

})



