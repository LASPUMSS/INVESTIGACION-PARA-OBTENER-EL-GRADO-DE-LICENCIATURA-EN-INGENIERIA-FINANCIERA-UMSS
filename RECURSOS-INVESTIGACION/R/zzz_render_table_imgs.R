library(gridExtra)
df <- renderTableBasic2(resultadosARIMA,captionTable = 'Regresores y medias moviles del modeo ARIMA') %>% 
    footnote(general = 'NaN indica que uno de los series de tiempo es 0 en todos sus elementos, donde el R2 devuelve una indeterminación.',
             general_title = 'NOTA: ' )
df %>% 
    kable_styling(font_size = 50) %>% 
    save_kable(file = "table_2.png", zoom = 3)

