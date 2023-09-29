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

# make an empty data.table
dt_Vhot <- data.table::data.table(
  x        = numeric(),
  month    = integer(),
  dwelling = character(),
  Vhot     = numeric()
)

str(dt_Vhot)

# read the csv file data into one data.table
csv_fn <- l_csv[1] # for trying out commands in for loop
for(csv_fn in l_csv) {
  # read a csv file
  dt_csv <- data.table::as.data.table(readr::read_csv(csv_fn)) 
  
  # integer months
  dt_csv[, month:=round(x)] 
  
  # melt from wide to long
  dt_csv <-
    data.table::melt(dt_csv, id=c("x","month"),
                     variable.name   = "dwelling",
                     variable.factor = FALSE,
                     value.name      = "Vhot")
  
  # add to dt_Vhot
  dt_Vhot <- data.table::rbindlist(list(dt_Vhot,dt_csv))
  
}

# now read high-density-houses.csv for more data
dt_csv <- data.table::as.data.table(readr::read_csv("./high-density-houses.csv")) 

# integer months
dt_csv[, month:=round(x)] 

# set dwelling
dt_csv[, dwelling := "high-density-houses"]

# set dwelling name
data.table::setnames(dt_csv,
                     old = c("high-density-houses"),
                     new = c("Vhot"))


# add to dt_Vhot
dt_Vhot <- data.table::rbindlist(list(dt_Vhot,dt_csv), use.names=TRUE )

# set key
# sort by x, the unrounded decimal month from digitzing
data.table::setkey(dt_Vhot, x)

str(dt_Vhot)

# save data.table to .Rdata file
save(dt_Vhot, file = paste0(data_path, "dt_Vhot.Rdata" ))
