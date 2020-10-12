#!bin/bash

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
\begin{frame}{What is this sign...}
\vspace{1cm}
\begin{minipage}{0.4\textwidth}
        \vbox to \textheight{
            \centering
            \includegraphics[width=0.8\textwidth,height=0.5\textheight, keepaspectratio]{Signs/{@LBL@}.pdf}
            \vfill
        }
    \end{minipage}\hfill
    \begin{minipage}{0.6\textwidth}
        \vbox to \textheight{
            \begin{enumerate}[A]
                \item @1@
                \item @2@
                \item @3@
                \item @4@
            \end{enumerate}
            \vfill
        }
    \end{minipage}
\end{frame}
EOF

# Truncate and then create skeleton quiz file: include.tex
>include.tex
for sign in `echo "$SIGNS" | tr ' ' '\n' |sort -R`
do
  desc=`awk -F'\t' "/^$sign"'.eps\t/ {print $2}' traffic-signs-images-image-details-eps.tsv`
  randpos=$((1 + RANDOM % 4))
  sed -e 's/@LBL@/'"$sign/" -e 's/@'$randpos'@'"/$desc/" -e 's/@.@//' template.tmp >> include.tex
done

# Just for safety
mv main.tex main.tex.`date +%s`

# Write the main latex file
cat <<'EOF' > main.tex
\documentclass[aspectratio=169,utf8,t]{beamer}
\usetheme{scouts}
\institute{\href{https://mansouthscouts.org.uk/our-groups/23rdManchester}{23rd~Manchester}
\\\href{https://mansouthscouts.org.uk/our-groups/23rdManchester}{(Birch~with~Fallowfield)}}
\author{Grey Wolf}
\title{Do~more. Cycle~more. Be~more.}
\begin{document}
\logoslide[noheadlogo,type=stacked]
\frame[plain]{\titlepage}
\renewcommand*{\theenumii}{\Alph{enumii}}
\input{include.tex}
\section{Thankyou}
\frame{The images in this presentation are Crown Copyright and are licenced for use in this scout quiz context.}
\end{document}
EOF

# Compile and rename
latexmk

mv main.pdf HighwayCodeBikeQuiz.pdf
