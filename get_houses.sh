#! /usr/bin/bash
# script to extract fig 1 from
# Meyer, J. P., and M. Tshimankinda. “Domestic Hot Water Consumption in South African Houses for Developed and Developing Communities.” International Journal of Energy Research 21, no. 7 (June 10, 1997): 667–73. https://doi.org/10.1002/(SICI)1099-114X(19970610)21:7<667::AID-ER286>3.0.CO;2-2.

# see what's there.
# identify '/home/jiml/library/to read/Meyer_Domestic Hot Water Consumption in South African Houses for Developed and Developing Communities_1997.pdf[2]'
# /home/jiml/library/to read/Meyer_Domestic Hot Water Consumption in South African Houses for Developed and Developing Communities_1997.pdf[2] PDF 576x756 576x756+0+0 16-bit sRGB 2797B 0.000u 0:00.000

# look at the other copy
# identify '/home/jiml/library/to read/Meyer_Domestic.Hot.Water.Consumption.in.South.African.Houses.for.Developed.and.Developing.Communities.pdf[2]'
# /home/jiml/library/to read/Meyer_Domestic.Hot.Water.Consumption.in.South.African.Houses.for.Developed.and.Developing.Communities.pdf[2] PDF 576x756 576x756+0+0 16-bit sRGB 2797B 0.000u 0:00.000

# use convert to extract and save to tiff at high resolution 
convert -verbose -density 800 \
 '/home/jiml/library/to read/Meyer_Domestic Hot Water Consumption in South African Houses for Developed and Developing Communities_1997.pdf[2]'  \
 test.tiff

# see what's there.
identify test.tiff
# test.tiff[2] TIFF 6478x8400 6478x8400+0+0 16-bit Grayscale Gray 207.582MiB 0.000u 0:00.000

# use gimp to locate points measure distances

# now crop it 
convert -verbose test.tiff -crop 4424x2000+1406+5357  Meyer_houses_fig1.tiff