#' Create a Glyph Segment plot using ggplot2
#'
#' This function enables the creation of segment glyphs by defining major
#' coordinates (longitude and latitude) and minor segment structures within
#' a grid cell. Each glyph's appearance can be customized by specifying its
#' height, width, and scaling, allowing for flexible data representation in a visual context.
#'
#' @inheritParams cubble::geom_glyph
#' @import ggplot2
#' @import From dplyr mutate
#'
#' @param x_major,x_minor,y_major,y_minor,yend_minor The name of the
#' variable (as a string) for the major and minor x and y axes. \code{x_major}
#' and \code{y_major} specify a longitude and latitude on a map while
#' \code{x_minor}, \code{y_minor}, and \code{yend_minor}
#' provide the structure for glyph.
#' @param width The width of each glyph. The `default` is set
#' to the smallest distance between two consecutive coordinates, converted from meters
#' to degrees of latitude using the Haversine method.
#' @param height The height of each glyph. The `default` is calculated using the ratio (1:1.618)
#' relative to the `width`, to maintain a consistent aspect ratio.
#' @param y_scale,x_scale The scaling function to be applied to each set of
#'  minor values within a grid cell. The default is \code{\link{identity}} which
#'  produces a result without scaling.
#' @param global_rescale Determines whether or not the rescaling is performed
#' globally or separately for each individual glyph.
#' @return a ggplot object
#'
#' @examples
#' library(ggplot2)
#'
#' # Basic glyph map with base map and custom theme
#' aus_temp |>
#'   ggplot(aes(x_major = long, y_major = lat,
#'          x_minor = month, y_minor = tmin, yend_minor = tmax)) +
#'   geom_sf(data = ozmaps::abs_ste, fill = "grey95",
#'           color = "white",inherit.aes = FALSE) +
#'   geom_glyph_segment() +
#'   ggthemes::theme_map()
#'
#'
#' # Adjust width and height of the glyph
#' aus_temp |>
#'   ggplot(aes(x_major = long, y_major = lat,
#'          x_minor = month, y_minor = tmin, yend_minor = tmax)) +
#'   geom_sf(data = ozmaps::abs_ste, fill = "grey95",
#'           color = "white",inherit.aes = FALSE) +
#'   geom_glyph_segment(width = rel(4.5), height = rel(3)) +
#'  ggthemes::theme_map()
#'
#' # Extend glyph map with reference box and line
#' aus_temp |>
#'  ggplot(aes(x_major = long, y_major = lat,
#'          x_minor = month, y_minor = tmin, yend_minor = tmax)) +
#'   geom_sf(data = ozmaps::abs_ste, fill = "grey95",
#'           color = "white",inherit.aes = FALSE) +
#'   add_glyph_boxes() +
#'   add_ref_lines() +
#'   geom_glyph_segment() +
#'   ggthemes::theme_map()
#'
#' @export
geom_glyph_segment <- function(mapping = NULL, data = NULL, stat = "identity",
                               position = "identity", ..., x_major = NULL,
                               x_minor = NULL, y_major = NULL, y_minor = NULL,
                               yend_minor = NULL, width = "default",
                               x_scale = identity, y_scale = identity,
                               height = "default", global_rescale = TRUE,
                               show.legend = NA, inherit.aes = TRUE) {
  ggplot2::layer(
    data = data,
    mapping = mapping,
    stat = stat,
    geom = GeomGlyphSegment,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      width = width,
      height = height,
      global_rescale = global_rescale,
      x_scale = list(x_scale),
      y_scale = list(y_scale),
      ...
    )
  )
}

#' GeomSegmentGlyph-
#' @format NULL
#' @usage NULL
#' @seealso \link[ggplot2]{GeomSegment} from the ggplot2 package.
#' @keywords internal
#' @import ggiraph
#' @export
GeomGlyphSegment <- ggplot2::ggproto(
  "GeomGlyphSegment",
  ggplot2::GeomSegment,

  setup_data = function(data, params) {
    params <- update_params(data, params)
    data <- glyph_setup_data(data, params, segment = TRUE)
  },

  draw_panel = function(data, panel_params, coord, ...) {
    ggplot2:::GeomSegment$draw_panel(data, panel_params, coord, ...)
    # For interactive element
    ggiraph::GeomInteractiveSegment$draw_panel(data, panel_params, coord, ...)
  },

  required_aes = c("x_major", "y_major", "x_minor", "y_minor", "yend_minor"),
  default_aes = ggplot2::aes(
    colour = "black",
    linewidth = 0.5,
    linetype = 1,
    width = "default",
    height = "default",
    alpha = 1,
    global_rescale = TRUE,
    x_scale = list(identity),
    y_scale = list(identity)
  )
)
