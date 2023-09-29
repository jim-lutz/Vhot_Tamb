#! /usr/bin/bash
# script to extract fig 1 from
# Meyer, J.P, and M Tshimankinda. “Domestic Hot-Water Consumption in South African Apartments.” Energy 23, no. 1 (January 1998): 61–66. https://doi.org/10.1016/S0360-5442(97)00069-8.


# see what's there.
identify '/home/jiml/library/to read/Meyer_Domestic hot-water consumption in South African apartments_1998.pdf[2]'
# /home/jiml/library/to read/Meyer_Domestic hot-water consumption in South African apartments_1998.pdf[2] PDF 6011x8633 6011x8633+0+0 16-bit sRGB 824558B 0.000u 0:00.000


# use convert to extract and save to tiff at high resolution 
convert -verbose -density 800 \
 '/home/jiml/library/to read/Meyer_Domestic hot-water consumption in South African apartments_1998.pdf[2]'  \
 test.tiff

# see what's there.
identify test.tiff
# test.tiff[2] TIFF 6478x8400 6478x8400+0+0 16-bit Grayscale Gray 207.582MiB 0.000u 0:00.000

# use gimp to locate points measure distances

# now crop it 
convert -verbose test.tiff -crop 4300x2230+840+592  Meyer_apartments_fig1.tiff

# now just the graph for enguage to see if grid removal works.
convert -verbose test.tiff -crop 3700x1500+1350+592  Meyer_apartments_fig1.graph.tiff
# doesn't seem to