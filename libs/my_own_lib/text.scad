module create_letter(letter, z, size=5){
  linear_extrude(z)
    text(letter, size = size, valign = "center", halign = "center");
}
