# startup.R
# install libraries for SA WH geyser standby loss project

# quit R
# quit(save = "no", runLast = FALSE)
# this quits RStudio as well


# use tidyverse
install.packages("tidyverse", dependencies = TRUE)

# see what packages are available
lapply(.libPaths(), list.files)

# data folder for this project
data_path = "./data/"

# graphs folder for this project
graph_path = "./graphics/"
