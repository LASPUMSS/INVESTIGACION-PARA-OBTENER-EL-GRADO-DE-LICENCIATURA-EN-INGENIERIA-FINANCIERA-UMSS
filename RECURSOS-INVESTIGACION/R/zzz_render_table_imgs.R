library(gridExtra)
df <- datIdsNamesCamelInds
png("test.png", height = 25*nrow(df), width = 200*ncol(df))
grid.table(df)
dev.off()