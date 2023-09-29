# get_meter_data.R
# script to read and examine data digitized from Meyer curves

# startup consistently
source("startup.R")

# build list of csv file names
l_csv <- list.files(path = ".",
                   pattern="*.csv$",
                   full.names = TRUE)

# remove ./high-density-houses.csv
l_csv <- stringr::str_subset(l_csv, "-", negate = TRUE)

# read the csv file data into one data.table
for(csv_fn in l_csv) {
  cat(csv_fn) 
}


dt_Vhot <- data.table::rbindlist(lapply(l_csv, readr::read_csv)) 
                                        



str(dt_loadS)

# read Westridge data from csv file into data.table
dt_loadW <-
  data.table::setDT(
    readr::read_csv(
      file = paste0(data_path, "Westridge 2004 profile extract.txt")
    )
  )

str(dt_loadW)


# look at GroupID in dt_loadW
unique(dt_loadW$GroupID)
# [1] 1000024

# change GroupID to be 24 in dt_loadW
dt_loadW[GroupID==1000024, GroupID:=24]

# look at ProfileID in dt_loadW
dt_loadW[, list(
  n         = .N,
  days      = .N/(24*60/5) # 24 hours per day * 60 mins per hour / 5 mins per record
), by = ProfileID
  ][order(ProfileID)]
# got about a years worth of data from 63 houses

# reduce ProfileID in dt_loadW to 4 digit number
dt_loadW[GroupID==24, ProfileID:= ProfileID - 1000000]

# concatenate dt_loadS and dt_loadW into dt_load
dt_load <-
  data.table::rbindlist(list(dt_loadS,dt_loadW))

# see what it is
str(dt_loadW)
# Classes ‘data.table’ and 'data.frame':	5231828 obs. of  5 variables:
#   $ GroupID  : num  24 24 24 24 24 24 24 24 24 24 ...
# $ ProfileID: num  1714 1714 1714 1714 1714 ...
# $ Datefield: POSIXct, format: "2003-12-30 15:35:00" "2003-12-30 15:40:00" "2003-12-30 15:45:00" ...
# $ Unitsread: num  2.62 2.64 2.63 2.64 2.65 ...
# $ Valid    : chr  "Y" "Y" "Y" "Y" ...
# - attr(*, "spec")=
#   .. cols(
#     ..   GroupID = col_double(),
#     ..   ProfileID = col_double(),
#     ..   Datefield = col_datetime(format = ""),
#     ..   Unitsread = col_double(),
#     ..   Valid = col_character()
#     .. )
# - attr(*, "problems")=<externalptr>
#   - attr(*, ".internal.selfref")=<externalptr>
#   - attr(*, "index")= int(0)
# ..- attr(*, "__GroupID")= int(0)

# find out what timezone Datefield is in
dt_load[1:5]$Datefield
# [1] "2001-02-03 04:40:00 UTC" "2001-02-03 04:45:00 UTC" "2001-02-03 04:50:00 UTC"
# [4] "2001-02-03 04:54:59 UTC" "2001-02-03 04:59:59 UTC"

lubridate::tz(dt_load$Datefield)
# [1] "UTC"

# force time to "Africa/Johannesburg"
dt_load[,dttm:= lubridate::force_tz(Datefield, tzone="Africa/Johannesburg")]

lubridate::tz(dt_load[1:5]$dttm)
# [1] "Africa/Johannesburg"

# drop Datefield
dt_load[,Datefield:=NULL]

# add a VA field so can see if lines up with expected watts
dt_load[,VA:=Unitsread*230] # South Africa is 230V, 50Hz

# add SA_date as string
dt_load[ , SA_date := strftime(dttm, format = "%F", tz = "Africa/Johannesburg")]

# add month
dt_load[, month := lubridate::month(dttm, label = FALSE)]
# add day of month and day of week
dt_load[, mday := lubridate::mday(dttm)]
dt_load[, wday := lubridate::wday(dttm)]

str(dt_load)

# save data.table to .Rdata file
save(dt_load, file = paste0(data_path, "dt_load.Rdata" ))
