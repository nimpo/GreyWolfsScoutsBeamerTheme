# Grey Wolf's Scouts Beamer Theme.
By Mike Jones, <dr.mike.jones@gmail.com>  
AKA Grey Wolf <mike.jones@mansouthscouts.org>  
[23rd Manchester (Birch with Fallowfield)][23MCR]  
[23MCR]: https://mansouthscouts.org.uk/our-groups/23rdManchester

## Overview

The purpose of this theme is to facilitate the making of Scout
presentations using free and open source software, in this case LaTeX.
It follows, as closely as I was reasonably able to, the Scout Association's
PowerPoint template. Users of this template/beamer theme *should* be able
to produce PDF documents, by default in widescreen format (16x9) with the font,
colours and layout matching those in the guidelines published by the Scout
Brand Centre.

How did this theme come about? Well if you really want to know, I have
written [some slides](./motivation.tex) about writing
[some slides](./Motivation/SignQuiz/include.tex)
for a 23rd Manchester all-section online group meeting we had over Summer 2020.
You should find a [PDF](./main.pdf) file along with this distribution.

The [PDF](./main.pdf) is compiled from the file [main.tex](./main.tex)
and also contains instructions on how to use this theme as well as a number
of other examples.

I have taken the liberty to apply some corrections to the Office 365
rendering of the POT file before transcribing it into this LaTeX theme.
In some places O365 appears to make poor font substitutions and font weight
selection which didn't appear to render correctly *my* browser or export
correctly to PDF. Where this has happened I have referred to the Scouts
brand for guidance.

Oh, and please remember that LaTeX and Beamer are not tools to replicate
Microsoft, they are a whole different kettle of fish. While it is
possible to replicate using LaTeX and Beamer any static slide deck created
with such tooling, it might take hours, days, months to get it pixel perfect.
There will therefore be differences between slide decks generated with
this theme and those generated using the Scout Brand Centre's PowerPoint
template. Heck different versions of PowerPoint render slides differently.
They do this in what I like to call a WYSINWYG environment.

## Package Contents

### In the top level directory

./main.tex
:  This is the primary file which can be compiled using the command: `latexmk`.
   It contains the directives to load this "scouts" Beamer theme and other
   basic headers in what LaTeX calls the *preamble*. Then it has the content
   based instructions between the `\begin{document}` and `\end{document}`
   labels. Those describe what and how to draw the slides (frames) and
   also, as in this case, potentially link to other files with other content
   to include.

./latexmkrc
:  This is a configuration file containing instructions on how to compile the LaTeX
   code relating to this theme. All the necessary additional fonts
   logos and code for this theme are contained within a copy of the Tex
   Directory Structure (TDS) packaged up with this bundle. In this latexmkrc
   file the latexmk executable reads the location where everything required
   has been stashed. latexmk is the automation tool that handles the building
   of the document.

:  The online cloud based LaTeX editing and rendering site overleaf.com
   uses this method to compile LaTeX documents. This template has been
   tested on Grey Wolk's Ubuntu 18 laptop and in Overleaf's environment.

./scouttemplate.tex
:  This file contains content and rendering instructions to reasonably
   recreate the [Scout Brand Centre's PowerPoint-template/POT][SBCPOT]  
   [SBCPOT]: https://scoutsbrand.org.uk/catalogue/item/scouts-powerpoint-template

./colours.tex
:  This file demonstrates base colours as defined in the theme. It is
   just a collection of simple content executed over a loop of changing
   colour themes. See the `\changecolours[]{}` macro for details about colour
   themes.

./euclid.tex
:  This file contains a walk-through of the Euclid example from
   [the Beamer documentation][Beamer]  
   [Beamer]: http://mirrors.ctan.org/macros/latex/contrib/beamer/doc/beameruserguide.pdf

./media/
:  The media directory contains the images extracted directly from the
   Scouts PowerPoint template (see above). Note that the Scout Branding
   Template uses a background image the size of the slide, whereas Grey Wolf's
   Scouts Beamer Theme includes the image but truncates it in the code allowing
   images to be placed with any appropriate colour theme choices. See the macro
   `\bgimage[]{}` for details.

./texmf/
:  The texmf directory is where all the theme files are placed as per
   the [Tex Directory Structure][TDS]  
   [TDS]: https://en.wikipedia.org/wiki/TeX_Directory_Structure "TDS on wikipedia"

./README.md
:  This file.

./LICENCE
:  A file describing the licence applied to all software in this package
   developed for Grey Wolf's Beamer Theme not already covered by its own
   licence statement.

./LICENSE
:  A symlink to LICENCE

./gpl-3.0.md
:  The GNU General Public License licence, version 3

### In the local Tex Directory Structure

./texmf/beamerthemescouts.sty
:  This `.sty` file sets up Grey Wolf's Scouts Beamer Theme. It loads the
   inner, outer, font and 'color' parts of the theme setup. These have been
   used somewhat haphazardly used and as such may not work in the usual
   separate way one expects. It could have been separated better, granted,
   however this theme is not designed to work as part of a multi-theme
   setup so this does not present an immediate problem. Additionally,
   this `.sty` file additionally loads a number of other beamerscouts `.sty`
   files which contain macros used by this theme.

./texmf/beamercolorthemescouts.sty
:  This `.sty` file  the colours used in Grey Wolf's Scouts Beamer
   Theme. These are the RGB hex encoded colours as defined in
   [Brand Guidelines May 2018][SBCGuide]

./texmf/beamerinnerthemescouts.sty
:  This is Grey Wolf's Scouts Beamer inner theme definition. It contains
   the configuration for the `\titlepage` macro. It attempts to place the
   following macros (if defined) on the Title Page when rendered:

1. \title: Attempts to place the title in a similar way to the
   *Do more. Share more. Be more.* in the PowerPoint template example.
2. \subtitle: If defined places the subtitle below the title.
3. \author and/or \institute are placed as per the PPT template.
4. Additionally a date (either `\today` or `\date`) is placed in the footer.
   Grey Wolf believes that a date should always be included in a presentation
   file for context.

./texmf/beamerouterthemescouts.sty
:  Here the logos for use in the head and footlines are defined,
   also the `frametitle` and `frametitle continuation` templates.
   The navigation symbols are deactivated here too. Grey Wolf prefers to use the
   PDF viewers tools. I dare say you can comment out the line:
:  `\defbeamertemplate*{navigation symbols}{scouts}{}`
:  if you wish

./texmf/beamerfontthemescouts.sty
:  While the font family is already set in the [setup file](./texmf/beamerthemescouts.sty)
   The font sizes need to be defined. This is done here using the
   `\pptratio` scaling factor defined in `./texmf/beamerthemescouts.sty`

./texmf/beamerscoutschangecolours.sty
:  Provides three macros:

*  `\changecolours[]{}`
*  `\headervisibility[]` and
*  `\togglecolours`

:  See the example `.tex` files for usage.

./texmf/beamerscoutslogo.sty
:  Provides the `\logoslide[]` macro. See the example .tex files for usage.

./texmf/beamerscoutsbgimage.sty
:  The `\bgimage[]{}` macro causes a background image to be shipped to
   the {current} or following frames.

./texmf/beamerscoutsitemseps.sty
:  The `\itemseps[]` macro allows the user to change the spacing in numbered/unnumbered lists:
   The `\itemise` and `\enumerate` environments.

./texmf/beamerscoutstwocolframe.sty
:  This macro created a convenient way to make slides with two columns
   similar to the slides in the Scout Brand Centre's examples. A more
   powerful tool might be LaTeX's `multicol` environment.

./texmf/fonts/truetype/NunitoSans/nunito-sans.zip
:  The [Nunito Sans TrueType font][NSTTF] distribution archive.  
   [NSTTF]: https://fonts.google.com/specimen/Nunito+Sans

./texmf/fonts/truetype/NunitoSans/OFL.txt
:  A local copy of [the Nunito Sans TrueType font licence][NSL]  
   [NSL]: https://fonts.google.com/specimen/Nunito+Sans#license

./texmf/fonts/truetype/NunitoSans/OS2v3/*
:  Modified versions of the Nunito Sans font. FontForge was used to downgrade
   the OS/2 Table to version 3.
   See the corresponding [README.md][OS2v3] file for details.
   Manifest: NunitoSansOS2v3-BlackItalic.ttf, NunitoSansOS2v3-Black.ttf,
   NunitoSansOS2v3-BoldItalic.ttf, NunitoSansOS2v3-Bold.ttf,
   NunitoSansOS2v3-ExtraBoldItalic.ttf, NunitoSansOS2v3-ExtraBold.ttf,
   NunitoSansOS2v3-ExtraLightItalic.ttf, NunitoSansOS2v3-ExtraLight.ttf,
   NunitoSansOS2v3-Italic.ttf, NunitoSansOS2v3-LightItalic.ttf,
   NunitoSansOS2v3-Light.ttf, NunitoSansOS2v3-Regular.ttf, 
   NunitoSansOS2v3-SemiBoldItalic.ttf, NunitoSansOS2v3-SemiBold.ttf
   [OS2v3]: ./texmf/fonts/truetype/NunitoSans/OS2v3/README.md

./fonts/tfm/NunitoSansOS2v3/*
:  Generated Tex Font Metric files.
   Manifest: nunbit8t.tfm, nunbn8t.tfm, nunebit8t.tfm, nunebn8t.tfm,
   nunelit8t.tfm, nuneln8t.tfm, nunlit8t.tfm, nunln8t.tfm, nunmit8t.tfm,
   nunmn8t.tfm, nunsbit8t.tfm, nunsbn8t.tfm, nunubit8t.tfm, nunubn8t.tfm

./texmf/tex/latex/psnfss/T1nun.fd
:  Font definition file for the use of the Nunito Sans OS2v3 TTF fonts listed
   above.

./texmf/tex/latex/psnfss/NunitoSansOS2v3.sty
:  Package to enable the loading of the Nunito Sans OS2v3 font family.

./texmf/tex/generic/images/Branding/Logos/RGB/*
:  The logos as obtained from the Scout Branding Centre
   https://scoutsbrand.org.uk/catalogue/category/digital/logos
   Due to there being some logos generated with borders and some without;
   some in CMYK and others in RGB, I have created RGB versions and stripped
   the borders for spacing consistency. NB there are strict branding
   rules on the spacing and use of scout logos please respect these.

:  Edit (2021-02-15) Since writing this README file the Scout Brand Centre
   has published some of the logos in a publicly accessible archive:
   <https://docs.scoutsbrand.org.uk/logos.zip> along with the general guidelines
   <https://docs.scoutsbrand.org.uk/guidelines.pdf>. This theme will, however,
   continue to use the derived RGB borderless logos for technical reasons. The
   publication of these logos is very welcome as it makes publishing this theme
   clearer.

## Installation
This package is designed to be installed in a standalone location or used
via a cloud service such as overleaf.com. While it *is* possible to install
the theme and its dependencies in the TDS, that was certainly not the intention.
To install issue the following command:

`git clone https://github.com/nimpo/GreyWolfsScoutsBeamerTheme.git`

To view the Git Repository online visit <https://github.com/nimpo/GreyWolfsScoutsBeamerTheme>.

## Package requirements and licence overview
The package contains, requires or has made use of other software. These
are discussed below.

0. LaTeX
1. Beamer
2. Fonts
3. Scouts Branding
4. Code produced for this project
5. Acknowledgements

### LaTeX
duh!   
I expect if you plan to use this theme you will already have an installation of LaTeX either locally or via a cloud service such as <https://overleaf.com/>.

### Beamer
Grey Wolf's Scout Beamer Theme is a third party Beamer theme. Beamer itself is part of the
standard LaTeX distribution available online here: <https://ctan.org/pkg/beamer>.
Beamer and it documentation is distributed under the following Licences:

* [Free Documentation License][FDL]
* [GNU General Public License, version 2 or newer][GPL2+]
* [The LATEX Project Public License 1.3c][LPPL13c]

[FDL]:     https://ctan.org/license/fdl
[GPL2+]:   https://ctan.org/license/gpl2+
[LPPL13c]: https://ctan.org/license/lppl1.3c

### Font
The fonts chosen and supplied for use in this project are those specified
by The Scout Association's branding guidelines: the Nunito Sans family
has been chosen because it can be used at no cost and suits the chosen
style.

It was necessary to create a modified version of the Nunito Sans TTF to
enable them to work with this software. This was a two step process:
1. Downgrade the OS/2 table
2. Convert to Adobe Type 1 postscript in order to create the TFM files
The Derived TTF files are used in the output PDF.

Nunito Sans was originally created by Vernon Adams and later extended by
Jacques Le Bailly. The T1 fonts for use with (PDF)LaTeX were converted to
Adobe Type 1 from TrueType format by Mike Jones using a mixture of tools
including but not limited to [FontForge][FF] and various tools from the
[FreeType 1][FT1] package.
[FF]: https://fontforge.org/
[FT1]: https://www.freetype.org/

Nunito Sans is distributed by Google as a TrueType Font and is freely
available under the terms of the SIL Open Font License licence
See: <https://fonts.google.com/specimen/Nunito+Sans#license> and
<https://scripts.sil.org/cms/scripts/page.php?site_id=nrsi&id=OFL>

### The Scout Association and its branding
The Scout Association rebranded in 2018. Here's a blog post about that:
<https://www.scouts.org.uk/news/2018/may/a-vibrant-new-brand-and-identity-for-the-scouts/>

You can read about the specifics of the new brand here (provided you have
access) in the [Brand Guidelines May 2018][SBCGuide]. (Edit 2021-02-15 [Publicly available version here][SBCGuide2].)
[SBCGuide]: https://scoutsbrand.org.uk/catalogue/category/digital/guidelines
[SBCGuide2]: https://docs.scoutsbrand.org.uk/guidelines.pdf

Use of the Scout Association logos and the various section logos and
Fleur-de-lis etc. is covered by the licensing rules in section 14 of
the POR, [Rule 147][POR147].
[POR147]: https://www.scouts.org.uk/por/14-other-matters/rule-147-protected-scout-logos-names-badges-and-awards/

### This project

When the `beamer` documentclass is used and this theme is selected the
default font will be switched to Nunito Sans, various macros will be
loaded and the default colour scheme, "ScoutPurple," will be selected.

All of this software not already covered by its own or derived licence
is released under the terms of the GNU GPL v3 License licence.

### Acknowledgements

(These people helped although they don't know it.)

Damir Rakityansky <radamir@technologist.com>
I leaned heavily on [these instructions][TTFT1] on how to convert TTF into T1.
This wasn't an easy process but I found that I kept returning to Damir's
notes and would not have managed to create the TTF fonts without them.
[TTFT1]: http://www.radamir.com/tex/ttf-tex.htm

Jerome Belleman <Jerome.Belleman@cern.ch> who provided the
[CERN Beamer template][CERN]. I started here as this was the kind of
theme that best lent itself to the kind of template as specified by
the Scout Brand Centre examples. In the end I rewrote the whole template
from scratch, but I learned much from Jerome's theme.
[CERN]: https://github.com/jeromebelleman/beamer-cern

And these were useful Stack Exchanges.

<https://tex.stackexchange.com/questions/204010/conditionally-print-subsection-in-beamer#483337>  
[Davy Gillebert](https://tex.stackexchange.com/users/185130/davy-gillebert)

<https://tex.stackexchange.com/questions/225736/latex-beamer-define-itemsep-globally#225737>  
[Gonzalo Medina](https://tex.stackexchange.com/users/3954/gonzalo-medina)

<https://tex.stackexchange.com/questions/192686/hyperref-warning-caused-by-beamer-appendix#192689>  
[Sam Carter](https://tex.stackexchange.com/users/36296/samcarter-is-at-topanswers-xyz)

<https://tex.stackexchange.com/questions/5285/tableofcontents-from-part-commands-in-beamer#5418>  
[Ulrich Schwarz](https://tex.stackexchange.com/users/1860/ulrich-schwarz)

<https://tex.stackexchange.com/questions/16866/how-can-i-use-footnotemark-with-a-ref-argument>  
["Mostly Harmless"](https://tex.stackexchange.com/users/4009/mostlyharmless)

<https://tex.stackexchange.com/questions/76273/multiple-pdfs-with-page-group-included-in-a-single-page-warning#78020>  
[Martin Schröder](https://tex.stackexchange.com/users/5763/martin-schr%c3%b6der)

<https://tex.stackexchange.com/questions/378307/advanced-string-highlighting-in-listings#378367>  
["SDF"](https://tex.stackexchange.com/users/106069/sdf)

<https://tex.stackexchange.com/questions/26828/first-line-number-in-lstinputlisting-environment#27240>  
["Werner"](https://tex.stackexchange.com/users/5764/werner)

<https://tex.stackexchange.com/questions/467672/problems-with-fragile-frames-in-beamer#467675>  
["TeXnician"](https://tex.stackexchange.com/users/124577/texnician)

<https://tex.stackexchange.com/questions/306396/paracol-how-to-reset-footnote-counter-every-page#306405>  
["Sr. Schnider"](https://tex.stackexchange.com/users/101831/sr-schneider)