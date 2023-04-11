library(openxlsx)

dat <- read.xlsx(file.choose())

unique(dat$CAMPOS)

sort(unique(dat$CAMPOS))

table(dat$CAMPOS)
