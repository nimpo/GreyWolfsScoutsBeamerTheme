@default_files = ('main.tex');
$pdf_mode = 1;
$ENV{'TEXINPUTS'}='texmf//:' . $ENV{'TEXINPUTS'};
$ENV{'TFMFONTS'}='texmf/fonts/tfm//:' . $ENV{'TFMFONTS'};
$ENV{'TTFONTS'}='texmf/fonts/truetype//:' . $ENV{'TTFONTS'};
