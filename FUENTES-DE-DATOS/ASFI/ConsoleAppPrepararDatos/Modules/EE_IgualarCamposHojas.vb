Imports Microsoft.Office.Interop
Imports Microsoft.Office.Core
Module EE_IgualarCamposHojas
    Public Sub igualarCamposEstados(ExcelWkBook As Excel.Workbook, categoriaEstado As String)
        Dim categoriaEst As String = Replace(categoriaEstado, " ", "")

        If categoriaEst = "EstadosFinancieros" Then

            cargarCamposEstadosFinancieros(ExcelWkBook)

        ElseIf categoriaEst = "IndicadoresFinancieros" Then

            cargarCamposIndicadoresFinancieros(ExcelWkBook)
        Else
            registroEjecucion000_00("xxxxxxxxxxxxxxxxxxx")
        End If

    End Sub

    Public Sub cargarCamposEstadosFinancieros(ExcelWkBook As Excel.Workbook)
        Dim ExcelWkSheet As Excel.Worksheet
        Dim strEval As String
        Dim i3 As Integer
        Dim i, i2, n, nCol As Long

        registroEjecucion000_00("punto 1")

        ExcelWkSheet = hojaConCamposAgregados(ExcelWkBook)

        registroEjecucion000_00("punto 2")
        'AGREGAR CATEGORIAS A CUENTAS 
        'ACTIVO
        agregarCategoriaCtas(ExcelWkSheet, "DISPONIBILIDADES", "INVERSIONES_TEMPORARIAS", "ACTIVO", "PASIVO")
        agregarCategoriaCtas(ExcelWkSheet, "INVERSIONES_TEMPORARIAS", "CARTERA", "ACTIVO", "PASIVO")
        agregarCategoriaCtas(ExcelWkSheet, "CARTERA", "OTRAS_CUENTAS_POR_COBRAR", "ACTIVO", "PASIVO")
        agregarCategoriaCtas(ExcelWkSheet, "OTRAS_CUENTAS_POR_COBRAR", "BIENES_REALIZABLES", "ACTIVO", "PASIVO")
        agregarCategoriaCtas(ExcelWkSheet, "BIENES_REALIZABLES", "INVERSIONES_PERMANENTES", "ACTIVO", "PASIVO")
        agregarCategoriaCtas(ExcelWkSheet, "INVERSIONES_PERMANENTES", "BIENES_DE_USO", "ACTIVO", "PASIVO")
        agregarCategoriaCtas(ExcelWkSheet, "BIENES_DE_USO", "OTROS_ACTIVOS", "ACTIVO", "PASIVO")
        agregarCategoriaCtas(ExcelWkSheet, "OTROS_ACTIVOS", "FIDEICOMISOS_CONSTITUIDOS", "ACTIVO", "PASIVO")
        agregarCategoriaCtas(ExcelWkSheet, "FIDEICOMISOS_CONSTITUIDOS", "PASIVO", "ACTIVO", "PASIVO")
        'PASIVO
        agregarCategoriaCtas(ExcelWkSheet, "PASIVO", "PATRIMONIO", "PASIVO", "PATRIMONIO", False)
        'PATRIMONIO
        agregarCategoriaCtas(ExcelWkSheet, "PATRIMONIO", "CUENTAS_CONTINGENTES_DEUDORAS", "PATRIMONIO", "CUENTAS_CONTINGENTES_DEUDORAS", False)
        'CUENTAS_CONTINGENTES_DEUDORAS
        agregarCategoriaCtas(ExcelWkSheet, "CUENTAS_CONTINGENTES_DEUDORAS", "CUENTAS_CONTINGENTES_ACREEDORAS", "CUENTAS_CONTINGENTES_DEUDORAS", "INGRESOS_FINANCIEROS", False)
        agregarCategoriaCtas(ExcelWkSheet, "CUENTAS_CONTINGENTES_ACREEDORAS", "CUENTAS_ORDEN_DEUDORAS", "CUENTAS_CONTINGENTES_ACREEDORAS", "INGRESOS_FINANCIEROS", False)
        'CUENTAS DE ORDEN DEUDORAS
        agregarCategoriaCtas(ExcelWkSheet, "CUENTAS_ORDEN_DEUDORAS", "CUENTAS_ORDEN_ACREEDORAS", "CUENTAS_ORDEN_DEUDORAS", "INGRESOS_FINANCIEROS", False)
        agregarCategoriaCtas(ExcelWkSheet, "CUENTAS_ORDEN_ACREEDORAS", "INGRESOS_FINANCIEROS", "CUENTAS_ORDEN_ACREEDORAS", "INGRESOS_FINANCIEROS", False)

        'ESTADOS DE RESULTADOS
        agregarCategoriaCtas(ExcelWkSheet, "INGRESOS_FINANCIEROS", "GASTOS_FINANCIEROS", "INGRESOS_FINANCIEROS", "RESULTADO_FINANCIERO_BRUTO", False)
        agregarCategoriaCtas(ExcelWkSheet, "GASTOS_FINANCIEROS", "RESULTADO_FINANCIERO_BRUTO", "GASTOS_FINANCIEROS", "RESULTADO_FINANCIERO_BRUTO", False)
        agregarCategoriaCtas(ExcelWkSheet, "OTROS_INGRESOS_OPERATIVOS", "OTROS_GASTOS_OPERATIVOS", "OTROS_INGRESOS_OPERATIVOS", "RESULTADO_DE_OPERACION_BRUTO", False)
        agregarCategoriaCtas(ExcelWkSheet, "OTROS_GASTOS_OPERATIVOS", "RESULTADO_DE_OPERACION_BRUTO", "OTROS_GASTOS_OPERATIVOS", "RESULTADO_DE_OPERACION_BRUTO", False)
        agregarCategoriaCtas(ExcelWkSheet, "RESULTADO_DE_OPERACION_BRUTO", "RESULTADO_NETO_DE_LA_GESTION", "EERR_S2", "RESULTADO_NETO_DE_LA_GESTION", False, True)

        registroEjecucion000_00("punto 3")
        'AREGLAR NOMBRES DE CUENTAS
        cambiarNombreCtas(ExcelWkSheet, "EERR_S2_RESULTADO_DESPUES_DE_AJUSTE_POR_DIF_DE_CAMBIO_Y_MANTENIM_DE_VALOR",
                          "EERR_S2_RESULTADO_DESPUES_DE_AJUSTE_POR_DIFERENCIA_DE_CAMBIO_Y_MANTENIMIENTO_DE_VALOR")
        cambiarNombreCtas(ExcelWkSheet, "EERR_S2_RESULTADO_ANTES_DE_IMPTOS_Y_AJUSTE_CONTABLE_POR_EFECTO_DE_INFLACION",
                          "EERR_S2_RESULTADO_ANTES_DE_IMPUESTOS_Y_AJUSTE_CONTABLE_POR_EFECTO_DE_INFLACION")


        cambiarNombreCtas(ExcelWkSheet, "ACTIVO_FIDEICOMISOS_CONSTITUIDOS_FIDEICOMISOS_POR_SERVICIO_DE_PAGO",
                          "ACTIVO_FIDEICOMISOS_CONSTITUIDOS_FIDEICOMISOS_POR_SERVICIOS_DE_PAGO")

        cambiarNombreCtas(ExcelWkSheet, "CUENTAS_CONTINGENTES_DEUDORAS_ESTADO_DE_GANACIAS_Y_PERDIDAS",
                          "CUENTAS_CONTINGENTES_DEUDORAS_ESTADO_DE_GANANCIAS_Y_PERDIDAS")
        cambiarNombreCtas(ExcelWkSheet, "CUENTAS_CONTINGENTES_DEUDORAS_ESTADO_DE_GANANCIAS_Y_PERIDIDAS",
                          "CUENTAS_CONTINGENTES_DEUDORAS_ESTADO_DE_GANANCIAS_Y_PERDIDAS")

        registroEjecucion000_00("punto 4")
        'ELIMINAR FILAS VACIAS
        eliminarFilasVac(ExcelWkSheet, 2)

        registroEjecucion000_00("punto 5")
        'TRASLADARA LA CUENTAS QUE SE CONTEMPLARON QUE SON 372
        nCol = ExcelWkSheet.Cells(1, 1).End(Excel.XlDirection.xlToRight).Column
        ExcelWkSheet.Activate()
        ExcelWkSheet.Range("A1").CurrentRegion.Cut()
        ExcelWkSheet.Range("A500").Select()
        ExcelWkSheet.Paste()


        For i2 = 1 To UBound(EF_EF)

            n = ExcelWkSheet.Cells(ExcelWkSheet.Rows.Count, 1).End(Excel.XlDirection.xlUp).Row + 2
            n = If(n < 500, 502, n)

            For i = 500 To n
                strEval = If(CStr(ExcelWkSheet.Cells(i, 1).Value) <> "",
                          QuitarEspAcen(CStr(ExcelWkSheet.Cells(i, 1).Value)),
                          "")
                If strEval = EF_EF(i2) Then
                    ExcelWkSheet.Range(ExcelWkSheet.Cells(i, 1), ExcelWkSheet.Cells(i, nCol)).Cut()
                    ExcelWkSheet.Range($"A{i2}").Select()
                    ExcelWkSheet.Paste()
                    ExcelWkSheet.Rows(i).Delete()
                    Exit For
                ElseIf i = n And strEval <> EF_EF(i2) Then
                    ExcelWkSheet.Cells(i2, 1).Value = EF_EF(i2)
                    For i3 = 2 To nCol
                        ExcelWkSheet.Cells(i2, i3).Value = "NA"
                    Next
                End If
            Next
        Next

        registroEjecucion000_00("punto 6")
        'ENUMERAR LAS CUENTAS QUE NO SE CONTEMPLARON
        For i = 500 To n
            strEval = If(CStr(ExcelWkSheet.Cells(i, 1).Value) <> "",
                          QuitarEspAcen(CStr(ExcelWkSheet.Cells(i, 1).Value)),
                          "")
            If strEval <> "" Then
                registroEjecucion000_00(strEval)

            End If
        Next

        registroEjecucion000_00("punto 7")
        'ELIMINAR LOS DATOS FALTANTES QUE NO SE AJUSTAN A LAS CUENTAS QUE CONTAMOS
        ExcelWkSheet.Range(ExcelWkSheet.Cells(500, 1), ExcelWkSheet.Cells(ExcelWkSheet.Rows.Count, nCol)).Clear()

        'VERFICAR DIMENSIONES
        n = ExcelWkSheet.Cells(ExcelWkSheet.Rows.Count, 1).End(Excel.XlDirection.xlUp).Row
        registroEjecucion000_00($"Ultima fila: {n}")
        registroEjecucion000_00("-------------------------------------------")

        'GUARDAR Y CERRAR
        ExcelWkBook.Save()
        ExcelWkBook.Close()


    End Sub


    Public Sub cargarCamposIndicadoresFinancieros(ExcelWkBook As Excel.Workbook)
        Dim ExcelWkSheet As Excel.Worksheet
        Dim strEval As String
        Dim i, n As Long


        ExcelWkSheet = hojaConCamposAgregados(ExcelWkBook)
        n = ExcelWkSheet.Cells(ExcelWkSheet.Rows.Count, 1).End(Excel.XlDirection.xlUp).Row

        'AGREGAR CATEGORIAS A CUENTAS 

        While n > 9

            For i = 9 To n
                strEval = If(CStr(ExcelWkSheet.Cells(i, 1).Value) <> "",
                              QuitarEspAcen(CStr(ExcelWkSheet.Cells(i, 1).Value)),
                              "")
                If strEval <> "COEFICIENTE_DE_ADECUACION_PATRIMONIAL" Then
                    'registroEjecucion000_00(strEval)
                    ExcelWkSheet.Rows($"{CStr(i)}:{CStr(i)}").Delete()
                    Exit For
                ElseIf strEval = "COEFICIENTE_DE_ADECUACION_PATRIMONIAL" Then
                    ExcelWkSheet.Rows($"10:{CStr(n)}").Delete()
                End If
            Next

            n = ExcelWkSheet.Cells(ExcelWkSheet.Rows.Count, 1).End(Excel.XlDirection.xlUp).Row
        End While

        'VERFICAR DIMENSIONES
        n = ExcelWkSheet.Cells(ExcelWkSheet.Rows.Count, 1).End(Excel.XlDirection.xlUp).Row
        registroEjecucion000_00($"Ultima fila: {n}")
        registroEjecucion000_00("-------------------------------------------")

        'GUARDAR Y CERRAR
        ExcelWkBook.Save()
        ExcelWkBook.Close()


    End Sub
End Module
