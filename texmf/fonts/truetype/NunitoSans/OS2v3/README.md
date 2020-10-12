# Nunito Sans OS2v3 family
This is a version of the Nunito Sans font with its OS/2 table converted to version 3.

## Date
2020-07-25

## Author
Mike Jones, <dr.mike.jones@gmail.com>  
AKA Grey Wolf <mike.jones@mansouthscouts.org>  
[23rd Manchester (Birch with Fallowfield)][23MCR]
[23MCR]: https://mansouthscouts.org.uk/our-groups/23rdManchester

Nunito Sans was originally created by Vernon Adams and later extended by
Jacques Le Bailly. The T1 fonts for use with (PDF)LaTeX were converted to
Adobe Type 1 from TrueType format by Mike Jones using a mixture of tools
including but not limited to [FontForge][ff] and various tools from the
[FreeType 1][ft1] package.
[ff]: https://fontforge.org/
[ft1]: https://www.freetype.org/

## Overview
In this directory I have generated version of the Nunito Sans fonts in
TTF format but with the OS/2 Table version set to 3 not 4. This was necessary
as my version of (PDF)LaTeX and that of <overleaf.com> (at the time of
writing) did not now how to read version 4 of the OS/2 table.

While there are other LaTeX engines that can natively read TTF files
I wanted the fonts to work with my working environment. Unfortunately that
means shipping a new set of differently named[^1] TTF fonts with altered OS/2
tables.
[^1]: See SIL Open Font License licence section 3.

## How these were generated
These versions of the fonts were generated using `fontforge`
`FontForge 11:21 UTC 24-Sep-2017` on Ubuntu 18.04.
1. Each font was loaded.
2. The "Font Info" window was opened from the Element menu.
   * In the OS2 section: Misc the version was changed from version 4 to
     version 3
   * I checked but did not alter the "Weight, Width, Slope Only checkbox
     which was not checked. see e.g. <https://tex.stackexchange.com/a/428702>
   * On the metrics I unchecked "Really use Type metrics"
6. I clicked OK and then used File -> Generate, to create new OS/2 Table v3 fonts.
*  I did not attempt to fix any errors thrown in the process.

## Licence
This is a derivitave work under section 3 of the [SIL Open Font License licence](../OFL.txt).
This version of the font is therefore also released under the SIL Open
Font License licence in acordance with section 5 of the said licence.
