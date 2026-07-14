
# Illustrations generated with ChatGPT

hexSticker::sticker(
  #package name
  package="grstat",
  p_size=25,
  p_x=1, p_y=0.55,
  p_color="#00aba4",
  #hexagon
  h_fill = "#F2F2F2",
  h_color = "#00aba4",
  h_size = 1.3,
  #subplot
  subplot= "inst/figures/no_crab.png",
  s_x=1, s_y=1.2,
  s_width=0.5,
  #output
  filename="man/figures/logo.png",
  dpi = 300
)

library(qrcode)
code <- qr_code("https://oncostat.github.io/grstat", ecl = "M")
generate_svg(code, filename = "man/figures/grstat_qr.svg")
