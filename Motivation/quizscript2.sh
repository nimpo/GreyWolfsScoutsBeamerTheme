#!/bin/bash

git clone https://github.com/nimpo/GreyWolfsScoutsBeamerTheme SignQuiz
cd SignQuiz || exit

# The URL for the UK Government's traffic sign images webpage:
GOVURL='https://www.gov.uk/guidance/traffic-sign-images'

# Get Sign Descriptions form gov.uk
# Screen-scrape (yuk)
for url in `curl "$GOVURL" |tr '<' '\n' |grep 'href="[^"]*/traffic-signs-images-image-details.xls"' |sed -e 's,.*href="\([^"]*\)".*,\1,'`
do
  curl -O "$url"
done

# Convert to CSV
libreoffice --headless --convert-to csv traffic-signs-images-image-details.xls
sleep 1
while ! [ -e traffic-signs-images-image-details.csv ]
do
  sleep 1 
  echo "Still waiting for LibreOffice."
done 

# Extract eps filename and dump comments into TSV
csvtool -u TAB col 12,3 traffic-signs-images-image-details.csv > traffic-signs-images-image-details-eps.tsv

# Now get all the sign images from gov.uk 
mkdir -p SignsDL
for url in `curl "$GOVURL" |tr '<' '\n' |grep 'href="[^"]*-eps.zip"' |sed -e 's,.*href="\([^"]*\)".*,\1,'`
do
  curl -o tmp.zip "$url"
  unzip -n -j -d SignsDL tmp.zip
  rm tmp.zip
done

#Have a look at the signs manually and make a list of interesting ones  
SIGNS="2602.2 2603 2702 2928 4003.7 501 512 520 522 544 551.2 552 555 562 670V20 7001 770 810 827.2 833 834 950 951 953.1V 956 957 T201"

# Convert the signs we want into pdf (with an RGB colour profile) using inkscape
mkdir -p Signs
for sign in $SIGNS 
do
  #Convert from CMYK eps to sRGB pdf using inkscape
  if [ -e "SignsDL/$sign.eps" ] 
  then
    inkscape "SignsDL/$sign.eps" -A "Signs/$sign.pdf"
  fi
done

# Make Template
cat<<'EOF' > template.tmp
{
\bgimage[onlybodyheight,position=l,marginleft=1cm,marginright=2cm,fit=all,alwaysshow]{@LBL@}
\twocolframe[rightcol=7cm,leftcol=3cm,title={What is this sign...}]{}{
\large
  \begin{enumerate}[A]
    \item @1@
    \item @2@
    \item @3@
    \item @4@
  \end{enumerate}
  }
}
EOF

# NEW: Here's are some wrong answers I prepared earlier
cat <<EOF | base64 -d | gzip -cd > wronganswers.tsv
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
VlYOLzGfxt++Ev0D39nIZWEKAAA=
EOF

# NEW: And a script to merge them
csvtool -u TAB -t TAB join 1 2,3,4,5 traffic-signs-images-image-details-eps.tsv wronganswers.tsv | sed -e 's/\([[:space:]]\)[[:space:]]*/\1/g' > traffic-signs.tsv

# NEW: The following modified to take tweeked sign image files 2602.2-66, 2928all and 833-834
SIGNS="2602.2-66_ii 2603 2702 2928all 4003.7 501 512 520 522 544 551.2 552 555 562 670V20 7001 770 810 827.2 833-834 950 951 953.1V 956 957 T201"

# NEW: Loop over the new sign list and add in the wrong answers...
# Truncate and then create skeleton quiz file: include.tex
>include.tex
for sign in `echo "$SIGNS" | tr ' ' '\n' |sort -R`
do
  d1=`awk -F'\t' "/^$sign"'.eps\t/ {print $2}' traffic-signs.tsv|tr '\\\\' '#'`
  d2=`awk -F'\t' "/^$sign"'.eps\t/ {print $3}' traffic-signs.tsv|tr '\\\\' '#'`
  d3=`awk -F'\t' "/^$sign"'.eps\t/ {print $4}' traffic-signs.tsv|tr '\\\\' '#'`
  d4=`awk -F'\t' "/^$sign"'.eps\t/ {print $5}' traffic-signs.tsv|tr '\\\\' '#'`
#s/@LBL@/'"$sign/"
  echo sed -e "`echo 1 2 3 4 |tr ' ' '\n' | shuf |tr -d '\n' | sed -e 's|\(.\)\(.\)\(.\)\(.\)|s~@LBL@~'"$sign"'~; s~@\1@~'"$d1"'~; s~@\2@~'"$d2"'~; s~@\3@~'"$d3"'~; s~@\4@~'"$d4"'~|'`" template.tmp
  sed -e "`echo 1 2 3 4 |tr ' ' '\n' | shuf |tr -d '\n' | sed -e 's|\(.\)\(.\)\(.\)\(.\)|s~@LBL@~'"$sign"'~; s~@\1@~'"$d1"'~; s~@\2@~'"$d2"'~; s~@\3@~'"$d3"'~; s~@\4@~'"$d4"'~|'`" template.tmp | tr '#' '\\' >> include.tex
done

# Just for safety
mv main.tex main.tex.`date +%s`

# Write the main latex file
cat <<'EOF' > main.tex
\documentclass[aspectratio=169,utf8,t]{beamer}
\usetheme{scouts}
\usepackage{grffile}
\graphicspath{{Motivation/Signs/}{Motivation/Signs/extra/}{Signs/}} % Where are my signs
\institute{\href{https://mansouthscouts.org.uk/our-groups/23rdManchester}{23rd~Manchester}
\\\href{https://mansouthscouts.org.uk/our-groups/23rdManchester}{(Birch~with~Fallowfield)}}
\author{Grey Wolf}
\title{Do~more. Cycle~more. Be~more.}
\begin{document}
\logoslide[noheadlogo,type=stacked]
\frame[plain]{\titlepage}
\renewcommand*{\theenumii}{\Alph{enumii}}
\input{include.tex}
\section{That's All Folks!}
\frame{The images in this presentation are Crown Copyright and are licenced for use in this scout quiz context.}
\end{document}
EOF

# Compile and rename
latexmk

mv main.pdf HighwayCodeBikeQuiz.pdf
