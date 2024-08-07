#' Apply a Custom Glyph Theme to ggplot2 Plots
#'
#' This function customizes the appearance of ggplot2 plots by applying a black-and-white theme with specified font settings for various plot components. It allows for easy customization of the font used throughout the plot while maintaining a clean and professional look.
#'
#' @param font A character string specifying the font family to use for the text elements in the plot. The default is "sans".
#'
#' @return A ggplot2 theme object that can be added to ggplot2 plot objects using the `+` operator.
#'
#' @examples
#' library(ggplot2)
#' # Basic usage with default font
#' p <- ggplot(mpg, aes(displ, hwy)) +
#'   geom_point() +
#'   theme_glyph()
#' print(p)
#'
#' # Usage with a custom font
#' p <- ggplot(mpg, aes(displ, hwy)) +
#'   geom_point() +
#'   theme_glyph(font = "serif")
#' print(p)
#'
#' @export

theme_glyph <- function(font = "sans") {

  theme_bw()  %+replace%
    theme(
      plot.title = element_text(
        hjust = 0, vjust = 2, size = 18,
        family = font, face = "bold"
      ),
      plot.subtitle = element_text(
        family = font, size = 14,
        hjust = 0, vjust = 1
      ),
      plot.caption = element_text(
        family = font, size = 10,
        hjust = 1, vjust = 1
      ),
      axis.title = element_text(
        family = font, size = 10
      ),
      axis.text = element_blank(),
      axis.text.x = element_blank(),
      axis.ticks = element_blank(),
      plot.background = element_blank(),
      panel.grid.minor = element_blank(),
      panel.grid.major = element_blank(),
      panel.background = element_rect(fill = "transparent",
                                      color = NA),
      panel.border = element_blank()
    )
}

utils::globalVariables(c(".data", "%+replace%", "theme_bw", "element_rect",
                         "theme", "element_text", "element_blank"))
