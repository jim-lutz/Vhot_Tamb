#! /usr/bin/bash
# script to extract fig 1 from
# Meyer, J.P., and M. Tshimankinda. “Domestic Hot Water Consumption in South African Townhouses.” Energy Conversion and Management 39, no. 7 (May 1998): 679–84. https://doi.org/10.1016/S0196-8904(97)00048-4.


# use convert to extract and save to tiff at high resolution 
convert -verbose -density 800 \
'/home/jiml/library/to read/Meyer_Domestic hot water consumption in south african townhouses_1998.pdf[2]'  \
test.tiff

# see what's there.
identify test.tiff
# test.tiff[2] PDF 6000x8644 6000x8644+0+0 16-bit Bilevel Gray 197.85MiB 0.810u 0:00.618

# use gimp to locate points measure distances

# now crop it 
convert -verbose test.tiff -crop 3700x1925+1034+520  Meyer_townhouses_fig1.tiff