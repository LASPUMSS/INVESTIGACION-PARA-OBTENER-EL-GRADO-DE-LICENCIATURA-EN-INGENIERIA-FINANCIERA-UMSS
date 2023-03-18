Imports Microsoft.Office.Interop
Module BB_ProcedimientosEdicionHojas

#Region "CATEGORIA - ESTADOS FINANCIEROS"

    Public nTotalFilas As Long = 0


    ''' <summary>
    ''' <para>Procedimiento que edita los estados financieros.</para>
    ''' <para>1°: Se encontrar la hoja con EEFF y se realizara una copia, donde se trabajara lo demas.</para>
    ''' <para>2°: Se copiaran y volver a pegar las filas donde pueden haber formulas, para mantener los resultados solo como datos.</para>
    ''' <para>3°: Se enconrar en que unidad esta expresado el EEFF.</para>
    ''' <para>4°: Eliminar las filas que no son necesarias, que estan por ensima y por debajo de los datos.</para>
    ''' <para>5°: Agregar campos o filas necesaria para identificar el EEFF.</para>
    ''' <para>6°: Verificar cuantas filas contiene el EEFF despues de ser editado.</para>
    ''' <para>7°: Guardar y cerrar el libro excel.</para>
    ''' </summary>
    ''' <param name="ExcelWkBook">Lirbo a trabajar.</param>
    ''' <param name="gestion"> Gestion del EEFF.</param>
    ''' <param name="mes">Mes del EEFF.</param>
    ''' <param name="tipoEndidadInd">Tipo de entidad a la qe corresponde el EEFFF.</param>
    Public Sub Editar_Estados_Financieros(ByVal ExcelWkBook As Excel.Workbook, ByVal gestion As Long, ByVal mes As Integer, ByVal tipoEndidadInd As Integer)
        Dim tipoEntidadStr(5) As String
        Dim ExcelWkSheet As Excel.Worksheet
        Dim CelTiBn As Excel.Range
        Dim CelExpresado As Excel.Range
        Dim expresado As String
        Dim n As Long
        Dim nCol As Long

        tipoEntidadStr(0) = "BANCOS_MULTIPLES"
        tipoEntidadStr(1) = "BANCOS_PYME"
        tipoEntidadStr(2) = "BANCOS_DE_DESARROLLO_PRODUCTIVO"
        tipoEntidadStr(3) = "INSTITUCIONES_FINANCIERAS_DE_DESARROLLO"
        tipoEntidadStr(4) = "COPERATIVAS_DE_AHORRO_Y_CREDITO"
        tipoEntidadStr(5) = "ENTIDADES_FINANCIERAS_DE_VIVIENDA"

        'HOJA DE DATOS BBDD
        ExcelWkSheet = hojaDeDatos(ExcelWkBook, "ACTIVO")

        'COPIAR Y PEGAR FORMULAS DE SUMAS
        CelTiBn = celdaTiBn(ExcelWkSheet, "ACTIVO")

        nCol = CelTiBn.End(Excel.XlDirection.xlToRight).Column
        Dim ctaCpPg() As String = {"ACTIVO",
                                    "PASIVO",
                                    "PATRIMONIO",
                                    "CUENTAS_CONTINGENTES_DEUDORAS",
                                    "CUENTAS_DE_ORDEN_DEUDORAS",
                                    "INGRESOS_FINANCIEROS",
                                    "RESULTADO_NETO_DE_LA_GESTION"}

        For Each cta As String In ctaCpPg
            copiarPegarFila(ExcelWkSheet, nCol, cta)
        Next

        'ENCONTRAR LA CELDAD EXPRESADO
        CelExpresado = encontrarCeldaExpresado(ExcelWkSheet)
        expresado = QuitarEspAcen(CStr(CelExpresado.Value))
        registroEjecucion000_00($"EEFF expresado: {expresado}")

        'ELIMINAR FILA NO NECESARIAS DEL INICIO Y FINAL DE LA HOJA
        eliminarFilasInFn_TP1(ExcelWkSheet, "ACTIVO", "RESULTADO_NETO_DE_LA_GESTION")

        'ELIMINAR FILAS VARCIAS 
        eliminarFilasVac(ExcelWkSheet)

        'MODIFICAR FORMATO DE TITULOS
        modificarTitulosAntesTransponer(ExcelWkSheet)

        'ELIMANAR COLUMNAS NO NECESARIAS
        Dim clmNoNec() As String = {"TOTAL_SISTEMA", "TOTAL",
                                    "%", "PORCENTAJE", "PORCIENTO",
                                    "||", "|"}
        For Each clm As String In clmNoNec
            eliminarColmnasNoNec(ExcelWkSheet, clm)
        Next

        'AGREGAR CAMPOS NECESARIOS
        agregarCamposNecesarios(ExcelWkSheet, gestion, mes, tipoEntidadStr(tipoEndidadInd), expresado)

        'VERIFICAR DIMENSIONES
        n = ExcelWkSheet.Cells(ExcelWkSheet.Rows.Count, 1).End(Excel.XlDirection.xlUp).Row
        registroEjecucion000_00($"Total Filas: {n}")

        If n > nTotalFilas Then
            nTotalFilas = n
            registroEjecucion000_00($"Este el mayor hasta el momento.")
        End If

        'GUARDAR Y CERRAR
        ExcelWkBook.Save()
        ExcelWkBook.Close()

        registroEjecucion000_00("-------------------------------------------")

    End Sub

    Public Sub Editar_Estados_Financieros_Moneda(ByVal ExcelWkBook As Excel.Workbook, ByVal gestion As Long, ByVal mes As Integer, ByVal tipoEndidadInd As Integer)
        Dim tipoEntidadStr(5) As String
        Dim ExcelWkSheet As Excel.Worksheet
        Dim CelTiBn As Excel.Range

        tipoEntidadStr(0) = "BANCOS_MULTIPLES"
        tipoEntidadStr(1) = "BANCOS_PYME"
        tipoEntidadStr(2) = "BANCOS_DE_DESARROLLO_PRODUCTIVO"
        tipoEntidadStr(3) = "INSTITUCIONES_FINANCIERAS_DE_DESARROLLO"
        tipoEntidadStr(4) = "COPERATIVAS_DE_AHORRO_Y_CREDITO"
        tipoEntidadStr(5) = "ENTIDADES_FINANCIERAS_DE_VIVIENDA"

        'HOJA DE DATOS BBDD
        ExcelWkSheet = hojaDeDatos(ExcelWkBook, "ACTIVO")

        'COPIAR Y PEGAR FORMULAS DE SUMAS
        CelTiBn = celdaTiBn(ExcelWkSheet, "ACTIVO")
        Dim ctaCpPg() As String = {"ACTIVO",
                                    "RESULTADO_NETO_DE_LA_GESTION"}

        'For Each cta As String In ctaCpPg
        '    copiarPegarFila(ExcelWkSheet, CelTiBn, cta)
        'Next

        'ELIMINAR FILA NO NECESARIAS DEL INICIO Y FINAL DE LA HOJA
        eliminarFilasInFn_TP1(ExcelWkSheet, "ACTIVO", "RESULTADO_NETO_DE_LA_GESTION")

        'ELIMINAR FILAS VARCIAS 
        eliminarFilasVac(ExcelWkSheet)

        'MODIFICAR FORMATO DE TITULOS
        modificarTitulosAntesTransponer(ExcelWkSheet)

        'ELIMANAR COLUMNAS NO NECESARIAS
        Dim clmNoNec() As String = {"TOTAL_SISTEMA", "TOTAL",
                                    "%", "PORCENTAJE", "PORCIENTO",
                                    "||", "|"}
        For Each clm As String In clmNoNec
            eliminarColmnasNoNec(ExcelWkSheet, clm)
        Next

        'AGREGAR CAMPOS NECESARIOS
        agregarCamposNecesarios(ExcelWkSheet, gestion, mes, tipoEntidadStr(tipoEndidadInd), "EXPRESADO_EN_MILES_DE_BOLIVIANOS")

        'GUARDAR Y CERRAR
        ExcelWkBook.Save()
        ExcelWkBook.Close()




    End Sub

#End Region

#Region "CATEGORIA - INDICADORES FINANCIEROS"
    Public Sub Editar_Calificacion_Cartera(ByVal ExcelWkBook As Excel.Workbook, ByVal gestion As Long, ByVal mes As Integer, ByVal tipoEndidadInd As Integer)

        Dim tipoEntidadStr(6) As String
        Dim CelTiBn As Excel.Range
        Dim ExcelWkSheet As Excel.Worksheet

        tipoEntidadStr(0) = "BANCOS_MULTIPLES"
        tipoEntidadStr(1) = "BANCOS_PYME"
        tipoEntidadStr(2) = "BANCOS_DE_DESARROLLO_PRODUCTIVO"
        tipoEntidadStr(3) = "INSTITUCIONES_FINANCIERAS_DE_DESARROLLO"
        tipoEntidadStr(4) = "COPERATIVAS_DE_AHORRO_Y_CREDITO"
        tipoEntidadStr(5) = "COPERATIVAS_DE_AHORRO_Y_CREDITO"
        tipoEntidadStr(6) = "ENTIDADES_FINANCIERAS_DE_VIVIENDA"

        'HOJA DE DATOS BBDD
        ExcelWkSheet = hojaDeDatos(ExcelWkBook, "CATEGORIA_A")

        'COPIAR Y PEGAR FORMULAS DE SUMAS
        CelTiBn = celdaTiBn(ExcelWkSheet, "CATEGORIA_A")
        Dim ctaCpPg() As String = {"TOTAL_CARTERA_Y_CONTINGENTE_4",
                                    "TOTAL_PREVISION_ESPECIFICA",
                                    "PORCENTAJE"}

        'For Each cta As String In ctaCpPg
        '    copiarPegarFila(ExcelWkSheet, CelTiBn, cta)
        'Next

        'ELIMINAR FILA NO NECESARIAS DEL INICIO Y FINAL DE LA HOJA
        eliminarFilasInFn_TP1(ExcelWkSheet, "CATEGORIA_A", "PORCENTAJE")

        'ELIMINAR FILAS VARCIAS
        eliminarFilasVac(ExcelWkSheet)

        'MODIFICAR FORMATO DE TITULOS
        modificarTitulosAntesTransponer(ExcelWkSheet)

        'ELIMANAR COLUMNAS NO NECESARIAS
        Dim clmNoNec() As String = {"TOTAL_SISTEMA", "TOTAL",
                                    "%", "PORCENTAJE", "PORCIENTO",
                                    "||", "|"}
        For Each clm As String In clmNoNec
            eliminarColmnasNoNec(ExcelWkSheet, clm)
        Next

        'AGREGAR CAMPOS NECESARIOS
        agregarCamposNecesarios(ExcelWkSheet, gestion, mes, tipoEntidadStr(tipoEndidadInd), "EXPRESADO_EN_MILES_DE_BOLIVIANOS")

        'GUARDAR Y CERRAR
        ExcelWkBook.Save()
        ExcelWkBook.Close()

        registroEjecucion000_00("-------------------------------------------")

    End Sub

    Public Sub Editar_Indicadores_Financieros(ByVal ExcelWkBook As Excel.Workbook, ByVal gestion As Long, ByVal mes As Integer, ByVal tipoEndidadInd As Integer)
        Dim tipoEntidadStr(5) As String
        Dim ExcelWkSheet As Excel.Worksheet
        Dim CelTiBn As Excel.Range

        tipoEntidadStr(0) = "BANCOS_MULTIPLES"
        tipoEntidadStr(1) = "BANCOS_PYME"
        tipoEntidadStr(2) = "BANCOS_DE_DESARROLLO_PRODUCTIVO"
        tipoEntidadStr(3) = "INSTITUCIONES_FINANCIERAS_DE_DESARROLLO"
        tipoEntidadStr(4) = "COPERATIVAS_DE_AHORRO_Y_CREDITO"
        tipoEntidadStr(5) = "ENTIDADES_FINANCIERAS_DE_VIVIENDA"

        'HOJA DE DATOS BBDD
        ExcelWkSheet = hojaDeDatos(ExcelWkBook, "ESTRUCTURA_DE_ACTIVOS")

        'COPIAR Y PEGAR FORMULAS DE SUMAS
        CelTiBn = celdaTiBn(ExcelWkSheet, "ESTRUCTURA_DE_ACTIVOS")
        Dim ctaCpPg() As String = {"UTILIDAD NETA"}
        'For Each cta As String In ctaCpPg
        '    copiarPegarFila(ExcelWkSheet, CelTiBn, cta)
        'Next

        'ELIMINAR FILA NO NECESARIAS DEL INICIO Y FINAL DE LA HOJA
        eliminarFilasInFn_TP1(ExcelWkSheet, "ESTRUCTURA_DE_ACTIVOS", "UTILIDAD_NETA")

        'ELIMINAR FILAS INTERMEDIAS NO NECESARIAS
        eliminarFilasInter_TP1(ExcelWkSheet, "ACTIVO_IMPRODUCTIVO_RESPECTO_PATRIMONIO", "RENTABILIDAD_1")

        'ELIMINAR FILAS VARCIAS 
        eliminarFilasVac(ExcelWkSheet)

        'MODIFICAR FORMATO DE TITULOS
        modificarTitulosAntesTransponer(ExcelWkSheet)

        'ELIMINAR FILAS POR NOMBRES
        Dim ctaElm() As String = {"ESTRUCTURA_DE_ACTIVOS",
                                  "ESTRUCTURA_DE_PASIVOS",
                                  "ESTRUCTURA_DE_OBLIGACIONES",
                                  "CALIDAD_DE_CARTERA_1",
                                  "LIQUIDEZ",
                                  "SOLVENCIA",
                                  "ESTRUCTURA_FINANCIERA",
                                  "RENTABILIDAD_1",
                                  "RESULTADOS_1",
                                  "INGRESOS_Y_GASTOS_FINANCIEROS_1",
                                  "EFICIENCIA_ADMINISTRATIVA",
                                   "RATIOS_DE_EFICIENCIA_1",
                                   "ESTRUCTURA_DE_GASTOS_DE_ADMINISTRACION",
                                   "CALCULO_SPREAD_EFECTIVO_1",
                                   "UTILIZACION_DEL_SPREAD_EFECTIVO_1"}
        registroEjecucion000_00("+")
        For Each cta As String In ctaElm
            eliminarFilaPorNombre(ExcelWkSheet, cta)
        Next
        registroEjecucion000_00("+")

        'AGREGAR CAMPOS NECESARIOS
        agregarCamposNecesarios(ExcelWkSheet, gestion, mes, tipoEntidadStr(tipoEndidadInd), "EXPRESADO_EN_MILES_DE_BOLIVIANOS")

        'GUARDAR Y CERRAR
        ExcelWkBook.Save()
        ExcelWkBook.Close()

        registroEjecucion000_00("-------------------------------------------")

    End Sub

    Public Sub Editar_Ponderacion_De_Activos_Y_CAP(ByVal ExcelWkBook As Excel.Workbook, ByVal gestion As Long, ByVal mes As Integer, ByVal tipoEndidadInd As Integer)
        Dim tipoEntidadStr(6) As String
        Dim ExcelWkSheet As Excel.Worksheet
        Dim CelTiBn As Excel.Range

        tipoEntidadStr(0) = "BANCOS_MULTIPLES"
        tipoEntidadStr(1) = "BANCOS_PYME"
        tipoEntidadStr(2) = "BANCOS_DE_DESARROLLO_PRODUCTIVO"
        tipoEntidadStr(3) = "INSTITUCIONES_FINANCIERAS_DE_DESARROLLO"
        tipoEntidadStr(4) = "COPERATIVAS_DE_AHORRO_Y_CREDITO"
        tipoEntidadStr(5) = "COPERATIVAS_DE_AHORRO_Y_CREDITO"
        tipoEntidadStr(6) = "ENTIDADES_FINANCIERAS_DE_VIVIENDA"

        'HOJA DE DATOS BBDD
        ExcelWkSheet = hojaDeDatos(ExcelWkBook, "COEFICIENTE_DE_ADECUACION_PATRIMONIAL")

        'COPIAR Y PEGAR FORMULAS DE SUMAS
        CelTiBn = celdaTiBn(ExcelWkSheet, "COEFICIENTE_DE_ADECUACION_PATRIMONIAL")
        Dim ctaCpPg() As String = {"TOTAL_CARTERA_Y_CONTINGENTE_4",
                                    "TOTAL_ACTIVO_Y_CONTINGENTE",
                                    "TOTAL_ACTIVO_COMPUTABLE",
                                    "COEFICIENTE_DE_PONDERACION_DEL_ACTIVO",
                                    "10_PORCIENTO_SOBRE_ACTIVO_COMPUTABLE",
                                    "CAPITAL_PRIMARIO_DESPUES_DE_AJUSTES",
                                    "CAPITAL_SECUNDARIO_DESPUES_DE_AJUSTES",
                                    "CAPITAL_REGULATORIO"}

        'For Each cta As String In ctaCpPg
        '    copiarPegarFila(ExcelWkSheet, CelTiBn, cta)
        'Next

        'ELIMINAR FILA NO NECESARIAS DEL INICIO Y FINAL DE LA HOJA
        eliminarFilasInFn_TP1(ExcelWkSheet,
                              "COEFICIENTE_DE_ADECUACION_PATRIMONIAL",
                              "COEFICIENTE_DE_INVERSION_EN_ACTIVOS_FIJOS_Y_OTRAS_SOCIEDADES_LIMITE_MAX_100_PORCIENTO")

        'ELIMINAR FILAS VARCIAS Y COLMUNA TOTAL SISTEMA , %, PORCIENTO
        eliminarFilasVac(ExcelWkSheet)

        'MODIFICAR FORMATO DE TITULOS
        modificarTitulosAntesTransponer(ExcelWkSheet)

        'AGREGAR CAMPOS NECESARIOS
        agregarCamposNecesarios(ExcelWkSheet, gestion, mes, tipoEntidadStr(tipoEndidadInd), "EXPRESADO_EN_MILES_DE_BOLIVIANOS")

        'GUARDAR Y CERRAR
        ExcelWkBook.Save()
        ExcelWkBook.Close()

        registroEjecucion000_00("-------------------------------------------")

    End Sub

#End Region

#Region "CATEGORIA - CAPTACIONES"

    Public Sub Editar_Encaje_Legal(ByVal ExcelWkBook As Excel.Workbook, ByVal gestion As Long, ByVal mes As Integer, ByVal tipoEndidadInd As Integer)

        Dim ExcelWkSheet As Excel.Worksheet

        'HOJA DE DATOS BBDD
        ExcelWkSheet = hojaDeDatos(ExcelWkBook, "OBLIGACIONES")

        'COPIAR Y PEGAR FORMULAS DE SUMAS


        'ELIMINAR FILA NO NECESARIAS DEL INICIO Y FINAL DE LA HOJA


        'ELIMINAR FILAS VARCIAS Y COLMUNA TOTAL SISTEMA , %, PORCIENTO


        'MODIFICAR FORMATO DE TITULOS


        'VERIFICAR DIMENSIONES


        'RECOGER CAMPOS PARA EVALUAR LOS CAMPOS POSIBLES

        'TRANSPONER

        'GUARDAR Y CERRAR
        ExcelWkBook.Save()
        ExcelWkBook.Close()

        registroEjecucion000_00("-------------------------------------------")

    End Sub

#End Region

#Region "CATEGORIA - COLOCAICONES"

#End Region

#Region "CATEGORIA - OPERACIONES INTERBANCARIAS"

#End Region

#Region "CATEGORIA - ESTADOS FINANCIEROS EVOLUTIVOS"

#End Region

#Region "CATEGORIA - INDICADORES EVOLUTIVOS"

#End Region

#Region "CATEGORIA - ESTADOS FINANCIEROS DESAGREGADOS"

    Public Sub Editar_Estados_Financieros_Desagregados(ByVal ExcelWkBook As Excel.Workbook, ByVal gestion As Long, ByVal mes As Integer, ByVal tipoEndidadInd As Integer)
        Dim n1 As Long
        Dim tipoEntidadStr(5) As String
        Dim ExcelWkSheet As Excel.Worksheet
        Dim CelTiBn As Excel.Range


        tipoEntidadStr(0) = "BANCOS_MULTIPLES"
        tipoEntidadStr(1) = "BANCOS_PYME"
        tipoEntidadStr(2) = "BANCOS_DE_DESARROLLO_PRODUCTIVO"
        tipoEntidadStr(3) = "INSTITUCIONES_FINANCIERAS_DE_DESARROLLO"
        tipoEntidadStr(4) = "COPERATIVAS_DE_AHORRO_Y_CREDITO"
        tipoEntidadStr(5) = "ENTIDADES_FINANCIERAS_DE_VIVIENDA"

        'ENCONTRAR CELAS QUE SE USARAN DE REFERENCIA
        ExcelWkSheet = hojaDeDatos(ExcelWkBook, "ACTIVO")

        'COPIAR Y PEGAR FORMULAS DE SUMAS
        CelTiBn = celdaTiBn(ExcelWkSheet, "ACTIVO", 3)
        Dim ctaCpPg() As String = {"ACTIVO",
                                    "RESULTADO_NETO_DEL_EJERCICIO"}

        'For Each cta As String In ctaCpPg
        '    copiarPegarFila(ExcelWkSheet, CelTiBn, cta, 3)
        'Next

        'ELIMINAR FILAS VARCIAS Y COLMUNA TOTAL SISTEMA , %, PORCIENTO
        eliminarFilasVac(ExcelWkSheet, 3)

        'ELIMINAR FILA NO NECESARIAS DEL INICIO Y FINAL DE LA HOJA
        eliminarFilasInFn_TP1(ExcelWkSheet, "ACTIVO", "RESULTADO_NETO_DEL_EJERCICIO", 3)

        'MODIFICAR FORMATO DE TITULOS
        modificarTitulosAntesTransponer(ExcelWkSheet, 3)

        'VERIFICAR DIMENSIONES
        n1 = ExcelWkSheet.Cells(ExcelWkSheet.Rows.Count, 3).End(Excel.XlDirection.xlUp).Row
        registroEjecucion000_00($"Total Filas: {n1}")

        'ELIMINAR COLUMNAS


        'GUARDAR Y CERRAR
        ExcelWkBook.Save()
        ExcelWkBook.Close()

        registroEjecucion000_00("-------------------------------------------")

    End Sub

#End Region

#Region "CATEGORIA - AGENCIAS, SUCURSALES, NRO. EMPLEADOS"

#End Region

End Module
