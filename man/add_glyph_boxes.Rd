% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/geom_glyph_ribbon.R
\name{add_glyph_boxes}
\alias{add_glyph_boxes}
\title{Add Glyph Boxes layer to glyph plot}
\usage{
add_glyph_boxes(
  mapping = NULL,
  data = NULL,
  stat = "identity",
  position = "identity",
  x_major = NULL,
  y_major = NULL,
  height = "default",
  width = "default",
  fill = "white",
  linewidth = 0.1,
  inherit.aes = TRUE,
  show.legend = NA,
  ...
)
}
\arguments{
\item{mapping}{Set of aesthetic mappings created by \code{\link[ggplot2:aes]{aes()}}. If specified and
\code{inherit.aes = TRUE} (the default), it is combined with the default mapping
at the top level of the plot. You must supply \code{mapping} if there is no plot
mapping.}

\item{data}{The data to be displayed in this layer. If \code{NULL}, the default, the data is
inherited from the plot data as specified in the call to \code{ggplot()}.}

\item{stat}{The statistical transformation to use on the data for this layer.
When using a \verb{geom_*()} function to construct a layer, the \code{stat}
argument can be used the override the default coupling between geoms and
stats. The \code{stat} argument accepts the following:
\itemize{
\item A \code{Stat} ggproto subclass, for example \code{StatCount}.
\item A string naming the stat. To give the stat as a string, strip the
function name of the \code{stat_} prefix. For example, to use \code{stat_count()},
give the stat as \code{"count"}.
\item For more information and other ways to specify the stat, see the
\link[ggplot2:layer_stats]{layer stat} documentation.
}}

\item{position}{A position adjustment to use on the data for this layer. This
can be used in various ways, including to prevent overplotting and
improving the display. The \code{position} argument accepts the following:
\itemize{
\item The result of calling a position function, such as \code{position_jitter()}.
This method allows for passing extra arguments to the position.
\item A string naming the position adjustment. To give the position as a
string, strip the function name of the \code{position_} prefix. For example,
to use \code{position_jitter()}, give the position as \code{"jitter"}.
\item For more information and other ways to specify the position, see the
\link[ggplot2:layer_positions]{layer position} documentation.
}}

\item{x_major, y_major}{Aesthetics to map plot coordinates
for major and minor glyph components.}

\item{height}{The height of each glyph. The `default` is calculated using the ratio (1:1.618)
relative to the `width`, to maintain a consistent aspect ratio.}

\item{width}{The width of each glyph. The `default` is set
to the smallest distance between two consecutive coordinates, converted from meters
to degrees of latitude using the Haversine method.}

\item{fill}{The color used to fill the glyph box.}

\item{linewidth}{The thickness of the glyph box.}

\item{inherit.aes}{If \code{FALSE}, overrides the default aesthetics,
rather than combining with them. This is most useful for helper functions
that define both data and aesthetics and shouldn't inherit behaviour from
the default plot specification, e.g. \code{\link[ggplot2:borders]{borders()}}.}

\item{show.legend}{logical. Should this layer be included in the legends?
\code{NA}, the default, includes if any aesthetics are mapped.
\code{FALSE} never includes, and \code{TRUE} always includes.
It can also be a named logical vector to finely select the aesthetics to
display.}

\item{...}{Additional arguments passed on to function.}
}
\value{
A layer object that can be added to a ggplot.
}
\description{
This function introduces a custom layer to a ggplot, employing 'glyph boxes'
to visually represent individual glyph. Users can specify various aesthetics
including alpha, height, width, color, line type, and fill to customize the appearance.
}
