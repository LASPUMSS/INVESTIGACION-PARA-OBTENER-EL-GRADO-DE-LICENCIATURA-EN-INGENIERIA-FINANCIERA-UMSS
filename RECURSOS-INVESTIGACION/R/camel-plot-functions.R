
plotIndCamel <- function(id, dat) {
    
    require(fpp2)
    
    dat$TIPO_DE_ENTIDAD <- gsub('_', ' ', dat$TIPO_DE_ENTIDAD)
    
    gestInc <- min(as.numeric(format(dat$FECHA, format='%Y')))
    gestFn <- max(as.numeric(format(dat$FECHA, format='%Y')))
    
    tsDat <- ts(matrix(0, nrow=(gestFn-gestInc+1)*12, ncol=length(unique(dat$TIPO_DE_ENTIDAD))), 
                start=gestInc, frequency=12)
    
    for (i in 1:length(unique(dat$TIPO_DE_ENTIDAD))) {
        
        tipoEnt <- as.character(unique(dat$TIPO_DE_ENTIDAD)[i])
        colnames(tsDat)[i] <- tipoEnt
        x <- dat[dat$TIPO_DE_ENTIDAD==tipoEnt,][order(dat[dat$TIPO_DE_ENTIDAD==tipoEnt,'FECHA']),id]
        x <- sapply(x, as.numeric)
        tsDat[,i] <- x
    }
    
    nameYlab <- gsub('indCap_', '',
                     gsub('indAct_', '',
                          gsub('indAdm_', '',
                               gsub('indBenf_', '',
                                    gsub('indLq_', '',id)))))
    nameYlab <- gsub('_',' ',nameYlab)
 
    p1 <- autoplot(tsDat, xlab = 'TIEMPO', ylab = nameYlab) + 
        theme(legend.position="bottom", legend.text=element_text(size=8)) + 
        guides(color=guide_legend(ncol=2, title="")) + 
        scale_x_continuous(breaks = gestInc:gestFn)
    
    return(p1)
}