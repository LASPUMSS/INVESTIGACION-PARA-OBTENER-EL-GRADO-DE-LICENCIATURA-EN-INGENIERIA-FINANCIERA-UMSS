Imports System.Threading
Imports System.IO
Imports Microsoft.Office.Interop
Module DD_FuncionesDeUnirHojas

#Region "CATEGORIA - ESTADOS FINANCIEROS"

#End Region

#Region "CATEGORIA - INDICADORES FINANCIEROS"

    Public Sub Unir_Calificacion_Cartera_Principal(ByVal ExcelApp As Excel.Application, ByVal gestionIn As Long, ByVal gestionFn As Long)

        Dim currentDirectory As String = Directory.GetCurrentDirectory()
        Dim rutaCSV As String = currentDirectory & "\DATOS\scbmModificado\BBDD_Calificacion_De_Cartera.csv"
        Dim rutaPrincipal As String = currentDirectory & "\DATOS\scbmModificado\BBDD_Calificacion_De_Cartera.xlsx"
        Dim rutaDatos As String
        Dim i As Long
        Dim gestion As Long
        Dim mes As Integer
        Dim n As Long
        Dim ExcelWkBook As Excel.Workbook
        Dim ExcelWkSheet As Excel.Worksheet
        Dim ExcelWkBookDatos As Excel.Workbook
        Dim ExcelWkSheetDatos As Excel.Worksheet
        Dim ExcelWkBookCSV As Excel.Workbook
        Dim ExcelWkSheetCSV As Excel.Worksheet
        Dim tipoEntidad(6) As String
        Dim tipoEntidad2(6) As String

        tipoEntidad(0) = "BcosMultiples"
        tipoEntidad(1) = "BcosPYME"
        tipoEntidad(2) = "BDR"
        tipoEntidad(3) = "IFD"
        tipoEntidad(4) = "Nobancos"
        tipoEntidad(5) = "Nobancos"
        tipoEntidad(6) = "Nobancos"

        tipoEntidad2(0) = "_BMU_"
        tipoEntidad2(1) = "_BPY_"
        tipoEntidad2(2) = "_BDR_"
        tipoEntidad2(3) = "_IFD_"
        tipoEntidad2(4) = "_COO_"
        tipoEntidad2(5) = "_COO_"
        tipoEntidad2(6) = "_EFV_"

        '##################################################################################################
        '# SE CREARA O SE CONECTARA CON LA HOJA PARA ACOPLAR LOS REGISTROS DE LA CALIFICACION DE CARTERA
        '##################################################################################################

        If File.Exists(rutaPrincipal) Then
            ExcelWkBook = ExcelApp.Workbooks.Open(rutaPrincipal)
            ExcelWkSheet = ExcelWkBook.Sheets(1)
            registroEjecucion000_00("Se procedera a acoplar los registros al libro BBDD_Calificacion_De_Cartera.xlsx")

        Else
            ExcelWkBook = ExcelApp.Workbooks.Add()
            ExcelWkSheet = ExcelWkBook.Sheets(1)
            ExcelWkBook.Sheets(1).Name = "BBDD_Calificacion_De_Cartera"

            ExcelWkSheet.Cells(1, 1).Value = "ID"
            ExcelWkSheet.Cells(1, 2).Value = "FECHA"
            ExcelWkSheet.Cells(1, 3).Value = "GESTION"
            ExcelWkSheet.Cells(1, 4).Value = "MES"
            ExcelWkSheet.Cells(1, 5).Value = "DIA"
            ExcelWkSheet.Cells(1, 6).Value = "TIPO_DE_ENTIDAD"
            ExcelWkSheet.Cells(1, 7).Value = "EXPRESADO"
            ExcelWkSheet.Cells(1, 8).Value = "ENTIDAD"

            ExcelWkSheet.Cells(1, 9).Value = "CATEGORIA_A"
            ExcelWkSheet.Cells(1, 10).Value = "PREVISION_conforme_a_(2)"
            ExcelWkSheet.Cells(1, 11).Value = "CATEGORIA_B"
            ExcelWkSheet.Cells(1, 12).Value = "PREVISION_conforme_a_(3)"
            ExcelWkSheet.Cells(1, 13).Value = "CATEGORIA_C"
            ExcelWkSheet.Cells(1, 14).Value = "PREVISION_20%"
            ExcelWkSheet.Cells(1, 15).Value = "CATEGORIA_D"
            ExcelWkSheet.Cells(1, 16).Value = "PREVISION_50%"
            ExcelWkSheet.Cells(1, 17).Value = "CATEGORIA_E"
            ExcelWkSheet.Cells(1, 18).Value = "PREVISION_80%"
            ExcelWkSheet.Cells(1, 19).Value = "CATEGORIA_F"
            ExcelWkSheet.Cells(1, 20).Value = "PREVISION_100%"
            ExcelWkSheet.Cells(1, 21).Value = "TOTAL_CARTERA_Y_CONTINGENTE_(4)"
            ExcelWkSheet.Cells(1, 22).Value = "TOTAL_PREVISION_ESPECIFICA"
            ExcelWkSheet.Cells(1, 23).Value = "Porcentaje"
            ExcelWkSheet.Cells(1, 24).Value = "Aux"

            ExcelWkSheet.Cells(1, 8).Value = "ENTIDAD"

            ExcelWkBook.SaveAs(rutaPrincipal)
            ExcelWkBook.Close()

            registroEjecucion000_00("Se creo un archivo BBDD_Calificacion_De_Cartera.xlsx")
            Thread.Sleep(5000)

            ExcelWkBook = ExcelApp.Workbooks.Open(rutaPrincipal)
            ExcelWkSheet = ExcelWkBook.Sheets(1)

        End If

        '##################################################################################################
        '##############  RECOLECTAR LOS NOMBRES DE LAS DISTINTOS INSTITUCIONES FINANCIERAS
        '##################################################################################################

        For i = 0 To 6

            For gestion = gestionIn To gestionFn

                For mes = 1 To 12

                    Try
                        If mes > 9 Then

                            If i = 4 Then
                                rutaDatos = currentDirectory & "\DATOS\scbm\" & CStr(gestion) & "\" & CStr(mes) & "\" & tipoEntidad(i) & CStr(mes) & CStr(gestion - 2000) & "\" & CStr(gestion) & CStr(mes) & tipoEntidad2(i) & "CalificacionCarteraA.XLS"
                            ElseIf i = 5 Then
                                rutaDatos = currentDirectory & "\DATOS\scbm\" & CStr(gestion) & "\" & CStr(mes) & "\" & tipoEntidad(i) & CStr(mes) & CStr(gestion - 2000) & "\" & CStr(gestion) & CStr(mes) & tipoEntidad2(i) & "CalificacionCarteraB.XLS"
                            Else
                                rutaDatos = currentDirectory & "\DATOS\scbm\" & CStr(gestion) & "\" & CStr(mes) & "\" & tipoEntidad(i) & CStr(mes) & CStr(gestion - 2000) & "\" & CStr(gestion) & CStr(mes) & tipoEntidad2(i) & "CalificacionCartera.XLS"
                            End If

                            If File.Exists(rutaDatos) Then

                                registroEjecucion000_00(rutaDatos)
                                ExcelWkBookDatos = ExcelApp.Workbooks.Open(rutaDatos)
                                ExcelWkSheetDatos = ExcelWkBookDatos.Sheets(1)

                                ExcelWkSheetDatos.Cells(1, 1).CurrentRegion.Copy

                                ExcelWkBook.Activate()
                                ExcelWkSheet.Activate()
                                n = ExcelWkSheet.Cells(ExcelWkSheet.Rows.Count, 1).End(Microsoft.Office.Interop.Excel.XlDirection.xlUp).Row + 1

                                registroEjecucion000_00(CStr(n))

                                ExcelWkBook.Activate()
                                ExcelWkSheet.Activate()
                                ExcelWkSheet.Range("A" & CStr(n)).Select()
                                ExcelWkSheet.Paste()
                                ExcelWkBook.Save()

                                ExcelWkBookDatos.Save()
                                ExcelWkBookDatos.Close()

                            End If

                        Else

                            If i = 4 Then
                                rutaDatos = currentDirectory & "\DATOS\scbm\" & CStr(gestion) & "\0" & CStr(mes) & "\" & tipoEntidad(i) & "0" & CStr(mes) & CStr(gestion - 2000) & "\" & CStr(gestion) & "0" & CStr(mes) & tipoEntidad2(i) & "CalificacionCarteraA.XLS"
                            ElseIf i = 5 Then
                                rutaDatos = currentDirectory & "\DATOS\scbm\" & CStr(gestion) & "\0" & CStr(mes) & "\" & tipoEntidad(i) & "0" & CStr(mes) & CStr(gestion - 2000) & "\" & CStr(gestion) & "0" & CStr(mes) & tipoEntidad2(i) & "CalificacionCarteraB.XLS"
                            Else
                                rutaDatos = currentDirectory & "\DATOS\scbm\" & CStr(gestion) & "\0" & CStr(mes) & "\" & tipoEntidad(i) & "0" & CStr(mes) & CStr(gestion - 2000) & "\" & CStr(gestion) & "0" & CStr(mes) & tipoEntidad2(i) & "CalificacionCartera.XLS"
                            End If

                            If File.Exists(rutaDatos) Then

                                registroEjecucion000_00(rutaDatos)
                                ExcelWkBookDatos = ExcelApp.Workbooks.Open(rutaDatos)
                                ExcelWkSheetDatos = ExcelWkBookDatos.Sheets(1)

                                ExcelWkSheetDatos.Cells(1, 1).CurrentRegion.Copy

                                ExcelWkBook.Activate()
                                ExcelWkSheet.Activate()
                                n = ExcelWkSheet.Cells(ExcelWkSheet.Rows.Count, 1).End(Microsoft.Office.Interop.Excel.XlDirection.xlUp).Row + 1

                                registroEjecucion000_00(CStr(n))

                                ExcelWkBook.Activate()
                                ExcelWkSheet.Activate()
                                ExcelWkSheet.Range("A" & CStr(n)).Select()
                                ExcelWkSheet.Paste()
                                ExcelWkBook.Save()

                                ExcelWkBookDatos.Save()
                                ExcelWkBookDatos.Close()

                            End If

                        End If

                    Catch ex As Exception

                        registroEjecucion000_00("ERROR: " & ex.Message)
                        Continue For

                    End Try

                Next

            Next
        Next

        '##################################################################################################
        '#######  ELIMINAR REGISTROS REPETIDOS UTILIZANDO LA COLUMNA ID COMO CAMPO DE REFERENCIA
        '##################################################################################################

        n = ExcelWkSheet.Cells(ExcelWkSheet.Rows.Count, 1).End(Microsoft.Office.Interop.Excel.XlDirection.xlUp).Row

        For i = 2 To n
            ExcelWkSheet.Cells(i, 24).FormulaR1C1 = "=COUNTIF(R2C1:R" & n & "C1,R[0]C[-23])"
        Next

        registroEjecucion000_00("Se procedera a eliminar registros duplicados....")

        For i = n To 2 Step -1
            If CLng(ExcelWkSheet.Cells(i, 24).Value) > 1 Then
                ExcelWkSheet.Rows(CStr(i) & ":" & CStr(i)).Delete(Shift:=Microsoft.Office.Interop.Excel.XlDirection.xlUp)
            End If
        Next

        ExcelWkSheet.Columns("I:W").NumberFormat = "0.000000"
        ExcelWkSheet.Columns("C:E").NumberFormat = "0"
        ExcelWkSheet.Columns("X:X").NumberFormat = "0"
        ExcelWkSheet.Columns("F:H").NumberFormat = "@"
        ExcelWkSheet.Columns("A:A").NumberFormat = "@"
        ExcelWkSheet.Columns("B:B").NumberFormat = "m/d/yyyy"

        '##################################################################################################
        '#########################    CREAR UN ARCHIVO CSV DE LOS DATOS
        '##################################################################################################

        Try

            If File.Exists(rutaCSV) Then
                File.Delete(rutaCSV)
            End If
            ExcelWkBookCSV = ExcelApp.Workbooks.Add()
            ExcelWkSheetCSV = ExcelWkBookCSV.Sheets(1)

            ExcelWkBook.Activate()
            ExcelWkSheet.Cells(1, 1).CurrentRegion.Copy

            ExcelWkBookCSV.Activate()
            ExcelWkSheetCSV.Range("A1").Select()
            ExcelWkSheetCSV.Paste()

            ExcelWkSheetCSV.Columns("I:W").NumberFormat = "0.000000"
            ExcelWkSheetCSV.Columns("C:E").NumberFormat = "0"
            ExcelWkSheetCSV.Columns("X:X").NumberFormat = "0"
            ExcelWkSheetCSV.Columns("F:H").NumberFormat = "@"
            ExcelWkSheetCSV.Columns("A:A").NumberFormat = "@"
            ExcelWkSheetCSV.Columns("B:B").NumberFormat = "m/d/yyyy"

            ExcelWkBookCSV.SaveAs(rutaCSV, FileFormat:=Microsoft.Office.Interop.Excel.XlFileFormat.xlCSV, CreateBackup:=False)
            ExcelWkBookCSV.Close()

            registroEjecucion000_00("Se creo un archivo CSV de los datos...")

        Catch ex As Exception
            registroEjecucion000_00(ex.Message)
        End Try


        ExcelWkBook.Save()
        ExcelWkBook.Close()

        Thread.Sleep(5000)

    End Sub

    Public Sub Unir_Indicadores_Financieros_Principal(ByRef ExcelApp As Excel.Application, ByVal gestionIn As Long, ByVal gestionFn As Long)

        Dim currentDirectory As String = Directory.GetCurrentDirectory()
        Dim rutaCSV As String = currentDirectory & "\DATOS\scbmModificado\BBDD_Indicadores_Financieros.csv"
        Dim rutaPrincipal As String = currentDirectory & "\DATOS\scbmModificado\BBDD_Indicadores_Financieros.xlsx"
        Dim rutaDatos As String
        Dim i As Long
        Dim gestion As Long
        Dim mes As Integer
        Dim n As Long
        Dim ExcelWkBook As Excel.Workbook
        Dim ExcelWkSheet As Excel.Worksheet
        Dim ExcelWkBookDatos As Excel.Workbook
        Dim ExcelWkSheetDatos As Excel.Worksheet
        Dim ExcelWkBookCSV As Excel.Workbook
        Dim ExcelWkSheetCSV As Excel.Worksheet
        Dim tipoEntidad(5) As String
        Dim tipoEntidad2(5) As String

        tipoEntidad(0) = "BcosMultiples"
        tipoEntidad(1) = "BcosPYME"
        tipoEntidad(2) = "BDR"
        tipoEntidad(3) = "IFD"
        tipoEntidad(4) = "Nobancos"
        tipoEntidad(5) = "Nobancos"

        tipoEntidad2(0) = "_BMU_"
        tipoEntidad2(1) = "_BPY_"
        tipoEntidad2(2) = "_BDR_"
        tipoEntidad2(3) = "_IFD_"
        tipoEntidad2(4) = "_COO_"
        tipoEntidad2(5) = "_EFV_"

        '##################################################################################################
        '# SE CREARA O SE CONECTARA CON LA HOJA PARA ACOPLAR LOS REGISTROS DE LA CALIFICACION DE CARTERA
        '##################################################################################################

        If File.Exists(rutaPrincipal) Then
            ExcelWkBook = ExcelApp.Workbooks.Open(rutaPrincipal)
            ExcelWkSheet = ExcelWkBook.Sheets(1)
            registroEjecucion000_00("Se procedera a acoplar los registros al libro BBDD_Indicadores_Financieros.xlsx")

        Else
            ExcelWkBook = ExcelApp.Workbooks.Add()
            ExcelWkSheet = ExcelWkBook.Sheets(1)
            ExcelWkBook.Sheets(1).Name = "BBDD_Indicadores_Financieros"

            ExcelWkSheet.Cells(1, 1).Value = "ID"
            ExcelWkSheet.Cells(1, 2).Value = "FECHA"
            ExcelWkSheet.Cells(1, 3).Value = "GESTION"
            ExcelWkSheet.Cells(1, 4).Value = "MES"
            ExcelWkSheet.Cells(1, 5).Value = "DIA"
            ExcelWkSheet.Cells(1, 6).Value = "TIPO_DE_ENTIDAD"
            ExcelWkSheet.Cells(1, 7).Value = "EXPRESADO"
            ExcelWkSheet.Cells(1, 8).Value = "ENTIDAD"

            ExcelWkSheet.Cells(1, 9) = "ESTRUCTURA_DE_ACTIVOS__DISPONIBILIDADES/ACTIVOS"
            ExcelWkSheet.Cells(1, 10) = "ESTRUCTURA_DE_ACTIVOS__CARTERA_NETA/ACTIVO"
            ExcelWkSheet.Cells(1, 11) = "ESTRUCTURA_DE_PASIVOS__OBLIG.CON_EL_PUBLICO/PASIVO+PATRIMONIO"
            ExcelWkSheet.Cells(1, 12) = "ESTRUCTURA_DE_PASIVOS__OBLIG.CON_EL_PUBLICO_Y_CON_EMPRESAS_PUBLICAS/PASIVO+PATRIMONIO"
            ExcelWkSheet.Cells(1, 13) = "ESTRUCTURA_DE_PASIVOS__OBLIG.CON_BANCOS_Y_ENT._FIN./PASIVO+PATRIMONIO"
            ExcelWkSheet.Cells(1, 14) = "ESTRUCTURA_DE_PASIVOS__OBLIGACIONES_SUBORDINADAS/PASIVO+PATRIMONIO"
            ExcelWkSheet.Cells(1, 15) = "ESTRUCTURA_DE_OBLIGACIONES__OBLIG._PERS._JURIDICAS_E_INSTITUCIONALES_/TOTAL_OBLIG._PUBLICO"
            ExcelWkSheet.Cells(1, 16) = "ESTRUCTURA_DE_OBLIGACIONES__OBLIG._PERSONAS._NATURALES_/TOTAL_OBLIG._PUBLICO"
            ExcelWkSheet.Cells(1, 17) = "ESTRUCTURA_DE_OBLIGACIONES__DIAS_DE_PERMANENCIA_DE_LOS_DEPOSITOS_A_PLAZO_FIJO"
            ExcelWkSheet.Cells(1, 18) = "CALIDAD_DE_CARTERA_(1)__CARTERA_VIGENTE_TOTAL/CARTERA_(1)"
            ExcelWkSheet.Cells(1, 19) = "CALIDAD_DE_CARTERA_(1)__CARTERA_REPROGRAMADA_O_REESTRUCTURADA/_CARTERA_(1)"
            ExcelWkSheet.Cells(1, 20) = "CALIDAD_DE_CARTERA_(1)__CARTERA_VENCIDA_TOTAL+EJECUCION_TOTAL_/CARTERA_(1)"
            ExcelWkSheet.Cells(1, 21) = "CALIDAD_DE_CARTERA_(1)__CARTERA_REPROGRAMADA_O_REESTRUCTURADA_VIGENTE/_CARTERA_VIGENTE_TOTAL"
            ExcelWkSheet.Cells(1, 22) = "CALIDAD_DE_CARTERA_(1)__CARTERA_REPROG._O_REESTRUCT._VENCIDA_Y_EJEC./_CARTERA_REPROG._O_REESTRUCT._TOTAL"
            ExcelWkSheet.Cells(1, 23) = "CALIDAD_DE_CARTERA_(1)__PROD._FINANCIEROS_DEVENGADOS_POR_COBRAR_CARTERA/CARTERA_(1)"
            ExcelWkSheet.Cells(1, 24) = "CALIDAD_DE_CARTERA_(1)__PREV.CARTERA_INCOBRABLE/CARTERA_(1)"
            ExcelWkSheet.Cells(1, 25) = "CALIDAD_DE_CARTERA_(1)__A_CARTERA_CON_REQUERIMIENTO_DE_PREVISION_CONFORME_A_(2)"
            ExcelWkSheet.Cells(1, 26) = "CALIDAD_DE_CARTERA_(1)__B_CARTERA_CON_REQUERIMIENTO_DE_PREVISION_CONFORME_A_(3)"
            ExcelWkSheet.Cells(1, 27) = "CALIDAD_DE_CARTERA_(1)__C_CARTERA_CON_REQUERIMIENTO_DE_PREVISION_DEL_20%"
            ExcelWkSheet.Cells(1, 28) = "CALIDAD_DE_CARTERA_(1)__D_CARTERA_CON_REQUERIMIENTO_DE_PREVISION_DEL_50%"
            ExcelWkSheet.Cells(1, 29) = "CALIDAD_DE_CARTERA_(1)__E_CARTERA_CON_REQUERIMIENTO_DE_PREVISION_DEL_80%"
            ExcelWkSheet.Cells(1, 30) = "CALIDAD_DE_CARTERA_(1)__F_CARTERA_CON_REQUERIMIENTO_DE_PREVISION_DEL_100%"
            ExcelWkSheet.Cells(1, 31) = "LIQUIDEZ__DISPONIBILIDADES/OBLIG.A_CORTO_PLAZO_(4)"
            ExcelWkSheet.Cells(1, 32) = "LIQUIDEZ__DISPONIB.+INV.TEMP./OBLIG.A_CORTO_PLAZO"
            ExcelWkSheet.Cells(1, 33) = "LIQUIDEZ__DISPONIB.+INV.TEMP./PASIVO"
            ExcelWkSheet.Cells(1, 34) = "LIQUIDEZ__DISPONIBILIDADES+INV.TEMPORARIAS/ACTIVO"
            ExcelWkSheet.Cells(1, 35) = "LIQUIDEZ__ACTIVOS_LIQUIDOS/DEPOSITOS_CORTO_PLAZO_(5)"
            ExcelWkSheet.Cells(1, 36) = "SOLVENCIA__PATRIMONIO/ACTIVO"
            ExcelWkSheet.Cells(1, 37) = "SOLVENCIA__PATRIMONIO/ACTIVO+CONTINGTE."
            ExcelWkSheet.Cells(1, 38) = "SOLVENCIA__CARTERA_VENCIDA_TOTAL_+_EJECUCION_TOTAL/PATRIMONIO"
            ExcelWkSheet.Cells(1, 39) = "SOLVENCIA__CARTERA_VENCIDA_+_EJEC._REPROG._O_REESTRUCT./PATRIMONIO"
            ExcelWkSheet.Cells(1, 40) = "SOLVENCIA__CARTERA_VENCIDA_TOTAL_+_EJE.TOTAL_-_PREV/PATRIMONIO"
            ExcelWkSheet.Cells(1, 41) = "SOLVENCIA__COEFICIENTE_DE_ADECUACION_PATRIMONIAL"
            ExcelWkSheet.Cells(1, 42) = "ESTRUCTURA_FINANCIERA__ACTIVO_PRODUCTIVO/ACTIVO+CONTINGENTE"
            ExcelWkSheet.Cells(1, 43) = "ESTRUCTURA_FINANCIERA__PASIVO_CON_COSTO/PASIVO+CONTINGENTE"
            ExcelWkSheet.Cells(1, 44) = "ESTRUCTURA_FINANCIERA__ACTIVO_PRODUCTIVO-PASIVO_CON_COSTO/PASIVO_CON_COSTO"
            ExcelWkSheet.Cells(1, 45) = "ESTRUCTURA_FINANCIERA__ACTIVO_IMPRODUCTIVO/PATRIMONIO"
            ExcelWkSheet.Cells(1, 46) = "RENTABILIDAD_(1)__RESULTADO_FINANCIERO_BRUTO/(ACTIVO_+_CONTINGENTE)"
            ExcelWkSheet.Cells(1, 47) = "RENTABILIDAD_(1)__RESULT.DE_OPERACION_BRUTO/(ACTIVO+CONTINGENTE)"
            ExcelWkSheet.Cells(1, 48) = "RENTABILIDAD_(1)__RESULTADO_DE_OPERACION_DESPUES_DE_INCOBRABLES_/(ACTIVO_+_CONTINGENTE)"
            ExcelWkSheet.Cells(1, 49) = "RENTABILIDAD_(1)__RESULT._DE_OPERACION_NETO/(ACTIVO_+_CONTINGENTE)"
            ExcelWkSheet.Cells(1, 50) = "RENTABILIDAD_(1)__RESULT.DE_OPERACION_NETO_ANTES_DE_IMPUESTOS/(ACTIVO+CONTINGENTE)"
            ExcelWkSheet.Cells(1, 51) = "RENTABILIDAD_(1)__RESULT.NETO_DE_LA_GESTION/(ACTIVO+CONTINGENTE)_(ROA)"
            ExcelWkSheet.Cells(1, 52) = "RENTABILIDAD_(1)__RESULT.NETO_DE_LA_GESTION/PATRIMONIO_(ROE)"
            ExcelWkSheet.Cells(1, 53) = "RESULTADOS_(1)__INGRESOS_FINANCIEROS/ACTIVO+CONTINGENTE"
            ExcelWkSheet.Cells(1, 54) = "RESULTADOS_(1)__GASTOS_FINANCIEROS/ACTIVO+CONTINGENTE"
            ExcelWkSheet.Cells(1, 55) = "RESULTADOS_(1)__GASTOS_FINANCIEROS/PASIVOS_CON_COSTO_PROMEDIO"
            ExcelWkSheet.Cells(1, 56) = "RESULTADOS_(1)__AJUSTES_NETOS_POR_INFLACION_Y_POR_DIFERENCIAS_DE_CAMBIO/ACTIVO+CONTING.(2)"
            ExcelWkSheet.Cells(1, 57) = "RESULTADOS_(1)__CARGOS_POR_INCOB.NETOS_DE_RECUPER./ACTIVO+CONTING."
            ExcelWkSheet.Cells(1, 58) = "RESULTADOS_(1)__OTROS_INGRESOS_OPERATIVOS_NETOS/ACTIVO+CONTINGENTE."
            ExcelWkSheet.Cells(1, 59) = "RESULTADOS_(1)__GASTOS_DE_ADMINISTRACION/ACTIVO+CONTINGENTE."
            ExcelWkSheet.Cells(1, 60) = "RESULTADOS_(1)__ING.EXTRAORD.Y_DE_GEST.ANT.NETOS/ACTIVO+CONTING."
            ExcelWkSheet.Cells(1, 61) = "RESULTADOS_(1)__DEPREC.Y_DESVAL.BIENES_DE_USO/BIENES_DE_USO-TERRENOS."
            ExcelWkSheet.Cells(1, 62) = "INGRESOS_Y_GASTOS_FINANCIEROS_(1)__PRODUCTOS_POR_CARTERA_VIGENTE/CARTERA_VIGENTE."
            ExcelWkSheet.Cells(1, 63) = "INGRESOS_Y_GASTOS_FINANCIEROS_(1)__PRODUCTOS_POR_CARTERA_REPROG._Y_REESTRUCT._VIGENTE/_CARTERA_REPROG._Y_REESTRUCT._VIGENTE"
            ExcelWkSheet.Cells(1, 64) = "INGRESOS_Y_GASTOS_FINANCIEROS_(1)__PRODUCTOS_POR_CARTERAVENCIDA_Y_EN_EJECUCION/CARTERA_VENCIDA_Y_EN_EJECUCION"
            ExcelWkSheet.Cells(1, 65) = "INGRESOS_Y_GASTOS_FINANCIEROS_(1)__PRODUCTOS_POR_CARTERA_REPROG._Y_REESTRUCT._VENCIDA_Y_EN_EJEC._/CARTERA_REPROG._Y_REESTRUCT._VENCIDA_Y_EN_EJEC."
            ExcelWkSheet.Cells(1, 66) = "INGRESOS_Y_GASTOS_FINANCIEROS_(1)__INT._PENALES_CARTERA_VENCIDA_TOTAL/PRODUCTOS_CARTERA_VENCIDA_TOTAL"
            ExcelWkSheet.Cells(1, 67) = "INGRESOS_Y_GASTOS_FINANCIEROS_(1)__INT._PENALES_CARTERA_EN_EJECUCION_TOTAL/PRODUCTOS_CARTERA_EN_EJECUCION"
            ExcelWkSheet.Cells(1, 68) = "INGRESOS_Y_GASTOS_FINANCIEROS_(1)__INT._PENALES_CARTERA_VENCIDA_TOTAL_Y_EN_EJECUCION_TOTAL/PRODUCTOS_CARTERA_VENCIDA_TOTAL_Y_EN_EJECUCION_TOTAL"
            ExcelWkSheet.Cells(1, 69) = "INGRESOS_Y_GASTOS_FINANCIEROS_(1)__INT.OBLIG.PUB.A_LA_VISTA/OBLIG.PUB._A_LA_VISTA"
            ExcelWkSheet.Cells(1, 70) = "INGRESOS_Y_GASTOS_FINANCIEROS_(1)__INT.DEPTOS.CAJA_DE_AHORRO/OB.PUB.CTAS.AHORRO"
            ExcelWkSheet.Cells(1, 71) = "INGRESOS_Y_GASTOS_FINANCIEROS_(1)__INT.DEPOSITOS_PUB.A_PLAZO/DPTOS.PUB.A_PLAZO"
            ExcelWkSheet.Cells(1, 72) = "INGRESOS_Y_GASTOS_FINANCIEROS_(1)__INT.OBLIG.CON_EMP._PUBLICAS/OBLIG.C/EMP._PUBLICAS"
            ExcelWkSheet.Cells(1, 73) = "INGRESOS_Y_GASTOS_FINANCIEROS_(1)__CARGOS_POR_OBLIG.CON_EL_B.C.B./OBLIG.CON_EL_B.C.B."
            ExcelWkSheet.Cells(1, 74) = "EFICIENCIA_ADMINISTRATIVA_RATIOS_DE_EFICIENCIA_(1)__GASTOS_DE_ADMINISTRACION/(ACTIVO+CONTINGENTE)"
            ExcelWkSheet.Cells(1, 75) = "EFICIENCIA_ADMINISTRATIVA_RATIOS_DE_EFICIENCIA_(1)__GASTOS_DE_ADMINISTRACION/ACTIVO_PRODUCTIVO_PROMEDIO_NETO_DE_CONTINGENTE"
            ExcelWkSheet.Cells(1, 76) = "EFICIENCIA_ADMINISTRATIVA_RATIOS_DE_EFICIENCIA_(1)__GASTOS_DE_ADMINISTRACION/(CARTERA+CONTINGENTE)"
            ExcelWkSheet.Cells(1, 77) = "EFICIENCIA_ADMINISTRATIVA_RATIOS_DE_EFICIENCIA_(1)__GASTOS_DE_ADMINISTRACION/DEPOSITOS(3)"
            ExcelWkSheet.Cells(1, 78) = "EFICIENCIA_ADMINISTRATIVA_ESTRUCTURA_DE_GASTOS_DE_ADMINISTRACION__GASTOS_DE_PERSONAL/GASTOS_DE_ADMINISTRACION"
            ExcelWkSheet.Cells(1, 79) = "EFICIENCIA_ADMINISTRATIVA_ESTRUCTURA_DE_GASTOS_DE_ADMINISTRACION__DEPREC.Y_AMORTIZACIONES/GASTOS_DE_ADMINISTRACION"
            ExcelWkSheet.Cells(1, 80) = "EFICIENCIA_ADMINISTRATIVA_ESTRUCTURA_DE_GASTOS_DE_ADMINISTRACION__OTROS_GASTOS_ADMINISTRACION/GASTOS_DE_ADMINISTRACION"
            ExcelWkSheet.Cells(1, 81) = "EFICIENCIA_ADMINISTRATIVA_ESTRUCTURA_DE_GASTOS_DE_ADMINISTRACION__GASTOS_DE_ADMINISTRACION/TOTAL_EGRESOS(4)"
            ExcelWkSheet.Cells(1, 82) = "EFICIENCIA_ADMINISTRATIVA_CALCULO_SPREAD_EFECTIVO_(1)__SPREAD_EFECTIVO"
            ExcelWkSheet.Cells(1, 83) = "EFICIENCIA_ADMINISTRATIVA_CALCULO_SPREAD_EFECTIVO_(1)__MARGEN_FINANCIERO_(5)"
            ExcelWkSheet.Cells(1, 84) = "EFICIENCIA_ADMINISTRATIVA_CALCULO_SPREAD_EFECTIVO_(1)__MARGEN_FINANCIERO_EN_ACTIVOS_PRODUCTIVOSPROMEDIO_NETO_DE_CONTINGENTE"
            ExcelWkSheet.Cells(1, 85) = "EFICIENCIA_ADMINISTRATIVA_CALCULO_SPREAD_EFECTIVO_(1)__INGRESO_FINANCIERO_PROMEDIO_EN_ACTIVOS_PRODUCTIVOS_NETO_DE_CONTINGENTE_(6)"
            ExcelWkSheet.Cells(1, 86) = "EFICIENCIA_ADMINISTRATIVA_CALCULO_SPREAD_EFECTIVO_(1)__COSTO_PROMEDIO_DE_FONDOS_(7)"
            ExcelWkSheet.Cells(1, 87) = "EFICIENCIA_ADMINISTRATIVA_CALCULO_SPREAD_EFECTIVO_(1)__IMPACTO_ACTIVOS_IMPRODUCTIVOS_PROMEDIO_NETO_DE_CONTINGENTE_(8)"
            ExcelWkSheet.Cells(1, 88) = "EFICIENCIA_ADMINISTRATIVA_CALCULO_SPREAD_EFECTIVO_(1)__MARGEN_OPERATIVO"
            ExcelWkSheet.Cells(1, 89) = "EFICIENCIA_ADMINISTRATIVA_UTILIZACION_DEL_SPREAD_EFECTIVO_(1)__SPREAD_EFECTIVO"
            ExcelWkSheet.Cells(1, 90) = "EFICIENCIA_ADMINISTRATIVA_UTILIZACION_DEL_SPREAD_EFECTIVO_(1)__INCOBRABILIDAD"
            ExcelWkSheet.Cells(1, 91) = "EFICIENCIA_ADMINISTRATIVA_UTILIZACION_DEL_SPREAD_EFECTIVO_(1)__GASTOS_ADMINISTRATIVOS"
            ExcelWkSheet.Cells(1, 92) = "EFICIENCIA_ADMINISTRATIVA_UTILIZACION_DEL_SPREAD_EFECTIVO_(1)__RESULTADOS_EXTRAORDINARIOS"
            ExcelWkSheet.Cells(1, 93) = "EFICIENCIA_ADMINISTRATIVA_UTILIZACION_DEL_SPREAD_EFECTIVO_(1)__RESULTADOS_GESTIONES_ANTERIORES"
            ExcelWkSheet.Cells(1, 94) = "EFICIENCIA_ADMINISTRATIVA_UTILIZACION_DEL_SPREAD_EFECTIVO_(1)__AJUSTES_NETOS_POR_INFLACION_Y_POR_DIFERENCIA_DE_CAMBIO"
            ExcelWkSheet.Cells(1, 95) = "UTILIDAD_NETA_PORCENTAJE"
            ExcelWkSheet.Cells(1, 96).Value = "Aux"

            ExcelWkBook.SaveAs(rutaPrincipal)
            ExcelWkBook.Close()

            registroEjecucion000_00("Se creo un archivo BBDD_Calificacion_De_Cartera.xlsx")
            Thread.Sleep(5000)

            ExcelWkBook = ExcelApp.Workbooks.Open(rutaPrincipal)
            ExcelWkSheet = ExcelWkBook.Sheets(1)

        End If

        '##################################################################################################
        '##############  RECOLECTAR LOS NOMBRES DE LAS DISTINTOS INSTITUCIONES FINANCIERAS
        '##################################################################################################

        For i = 0 To tipoEntidad2.Length - 1

            For gestion = gestionIn To gestionFn

                For mes = 1 To 12

                    Try
                        If mes > 9 Then

                            rutaDatos = currentDirectory & "\DATOS\scbm\" & CStr(gestion) & "\" & CStr(mes) & "\" & tipoEntidad(i) & CStr(mes) & CStr(gestion - 2000) & "\" & CStr(gestion) & CStr(mes) & tipoEntidad2(i) & "IndicadoresFinancieros.xls"

                            If File.Exists(rutaDatos) Then

                                registroEjecucion000_00(rutaDatos)
                                ExcelWkBookDatos = ExcelApp.Workbooks.Open(rutaDatos)
                                ExcelWkSheetDatos = ExcelWkBookDatos.Sheets(1)

                                ExcelWkBookDatos.Activate()
                                ExcelWkSheetDatos.Activate()
                                ExcelWkSheetDatos.Cells(1, 1).CurrentRegion.Copy

                                ExcelWkBook.Activate()
                                ExcelWkSheet.Activate()
                                n = ExcelWkSheet.Cells(ExcelWkSheet.Rows.Count, 1).End(Microsoft.Office.Interop.Excel.XlDirection.xlUp).Row + 1

                                registroEjecucion000_00($"A{CStr(n)}")

                                ExcelWkBook.Activate()
                                ExcelWkSheet.Activate()
                                ExcelWkSheet.Range($"A{CStr(n)}").Select()
                                ExcelWkSheet.Paste()
                                ExcelWkBook.Save()

                                ExcelWkBookDatos.Save()
                                ExcelWkBookDatos.Close()

                            End If

                        Else

                            rutaDatos = currentDirectory & "\DATOS\scbm\" & CStr(gestion) & "\0" & CStr(mes) & "\" & tipoEntidad(i) & "0" & CStr(mes) & CStr(gestion - 2000) & "\" & CStr(gestion) & "0" & CStr(mes) & tipoEntidad2(i) & "IndicadoresFinancieros.xls"

                            If File.Exists(rutaDatos) Then

                                registroEjecucion000_00(rutaDatos)
                                ExcelWkBookDatos = ExcelApp.Workbooks.Open(rutaDatos)
                                ExcelWkSheetDatos = ExcelWkBookDatos.Sheets(1)

                                ExcelWkBookDatos.Activate()
                                ExcelWkSheetDatos.Activate()
                                ExcelWkSheetDatos.Cells(1, 1).CurrentRegion.Copy

                                ExcelWkBook.Activate()
                                ExcelWkSheet.Activate()
                                n = ExcelWkSheet.Cells(ExcelWkSheet.Rows.Count, 1).End(Microsoft.Office.Interop.Excel.XlDirection.xlUp).Row + 1

                                registroEjecucion000_00($"A{CStr(n)}")

                                ExcelWkBook.Activate()
                                ExcelWkSheet.Activate()
                                ExcelWkSheet.Range($"A{CStr(n)}").Select()
                                ExcelWkSheet.Paste()
                                ExcelWkBook.Save()

                                ExcelWkBookDatos.Save()
                                ExcelWkBookDatos.Close()

                            End If

                        End If

                    Catch ex As Exception

                        registroEjecucion000_00($"ERROR: {ex.Message}")

                        Continue For

                    End Try

                Next

            Next
        Next

        '##################################################################################################
        '#######  ELIMINAR REGISTROS REPETIDOS UTILIZANDO LA COLUMNA ID COMO CAMPO DE REFERENCIA
        '##################################################################################################

        ExcelWkBook.Activate()

        n = ExcelWkSheet.Cells(ExcelWkSheet.Rows.Count, 1).End(Microsoft.Office.Interop.Excel.XlDirection.xlUp).Row

        For i = 2 To n
            ExcelWkSheet.Cells(i, 96).FormulaR1C1 = $"=COUNTIF(R2C1:R{n}C1,R[0]C[-95])"
        Next

        registroEjecucion000_00("Se procedera a eliminar registros duplicados....")

        For i = n To 2 Step -1
            If CLng(ExcelWkSheet.Cells(i, 96).Value) > 1 Then
                ExcelWkSheet.Rows(CStr(i) & ":" & CStr(i)).Delete(Shift:=Microsoft.Office.Interop.Excel.XlDirection.xlUp)
            End If
        Next

        ExcelWkSheet.Columns("A:A").NumberFormat = "@"
        ExcelWkSheet.Columns("B:B").NumberFormat = "m/d/yyyy"
        ExcelWkSheet.Columns("C:E").NumberFormat = "0"
        ExcelWkSheet.Columns("F:H").NumberFormat = "@"
        ExcelWkSheet.Columns("I:CQ").NumberFormat = "0.000000"
        ExcelWkSheet.Columns("CR:CR").NumberFormat = "0"

        '##################################################################################################
        '#########################    CREAR UN ARCHIVO CSV DE LOS DATOS
        '##################################################################################################

        Try

            If File.Exists(rutaCSV) Then
                File.Delete(rutaCSV)
            End If

            ExcelWkBookCSV = ExcelApp.Workbooks.Add()
            ExcelWkSheetCSV = ExcelWkBookCSV.Sheets(1)

            ExcelWkBook.Activate()
            ExcelWkSheet.Cells(1, 1).CurrentRegion.Copy

            ExcelWkBookCSV.Activate()
            ExcelWkSheetCSV.Range("A1").Select()
            ExcelWkSheetCSV.Paste()

            ExcelWkSheetCSV.Columns("A:A").NumberFormat = "@"
            ExcelWkSheetCSV.Columns("B:B").NumberFormat = "m/d/yyyy"
            ExcelWkSheetCSV.Columns("C:E").NumberFormat = "0"
            ExcelWkSheetCSV.Columns("F:H").NumberFormat = "@"
            ExcelWkSheetCSV.Columns("I:CQ").NumberFormat = "0.000000"
            ExcelWkSheetCSV.Columns("CR:CR").NumberFormat = "0"

            ExcelWkBookCSV.SaveAs(rutaCSV, FileFormat:=Microsoft.Office.Interop.Excel.XlFileFormat.xlCSV, CreateBackup:=False)
            ExcelWkBookCSV.Close()

            registroEjecucion000_00("Se creo un archivo CSV de los datos...")

        Catch ex As Exception

            registroEjecucion000_00(ex.Message)

        End Try

        ExcelWkBook.Save()
        ExcelWkBook.Close()

        Thread.Sleep(5000)

    End Sub

    Public Sub Unir_Ponderacion_De_Activos_Y_CAP_Principal(ByVal ExcelApp As Excel.Application, ByVal gestionIn As Long, ByVal gestionFn As Long)

        Dim currentDirectory As String = Directory.GetCurrentDirectory()
        Dim rutaCSV As String = currentDirectory & "\DATOS\scbmModificado\BBDD_Ponderacion_De_Activos.csv"
        Dim rutaPrincipal As String = currentDirectory & "\DATOS\scbmModificado\BBDD_Ponderacion_De_Activos.xlsx"
        Dim rutaDatos As String
        Dim i As Long
        Dim gestion As Long
        Dim mes As Integer
        Dim n As Long
        Dim ExcelWkBook As Excel.Workbook
        Dim ExcelWkSheet As Excel.Worksheet
        Dim ExcelWkBookDatos As Excel.Workbook
        Dim ExcelWkSheetDatos As Excel.Worksheet
        Dim ExcelWkBookCSV As Excel.Workbook
        Dim ExcelWkSheetCSV As Excel.Worksheet
        Dim tipoEntidad(6) As String
        Dim tipoEntidad2(6) As String

        tipoEntidad(0) = "BcosMultiples"
        tipoEntidad(1) = "BcosPYME"
        tipoEntidad(2) = "BDR"
        tipoEntidad(3) = "IFD"
        tipoEntidad(4) = "Nobancos"
        tipoEntidad(5) = "Nobancos"
        tipoEntidad(6) = "Nobancos"

        tipoEntidad2(0) = "_BMU_"
        tipoEntidad2(1) = "_BPY_"
        tipoEntidad2(2) = "_BDR_"
        tipoEntidad2(3) = "_IFD_"
        tipoEntidad2(4) = "_COO_"
        tipoEntidad2(5) = "_COO_"
        tipoEntidad2(6) = "_EFV_"

        '##################################################################################################
        '# SE CREARA O SE CONECTARA CON LA HOJA PARA ACOPLAR LOS REGISTROS DE LA CALIFICACION DE CARTERA
        '##################################################################################################

        If File.Exists(rutaPrincipal) Then
            ExcelWkBook = ExcelApp.Workbooks.Open(rutaPrincipal)
            ExcelWkSheet = ExcelWkBook.Sheets(1)
            registroEjecucion000_00("Se procedera a acoplar los registros al libro BBDD_Calificacion_De_Cartera.xlsx")

        Else
            ExcelWkBook = ExcelApp.Workbooks.Add()
            ExcelWkSheet = ExcelWkBook.Sheets(1)
            ExcelWkBook.Sheets(1).Name = "BBDD_Calificacion_De_Cartera"

            ExcelWkSheet.Cells(1, 1).Value = "ID"
            ExcelWkSheet.Cells(1, 2).Value = "FECHA"
            ExcelWkSheet.Cells(1, 3).Value = "GESTION"
            ExcelWkSheet.Cells(1, 4).Value = "MES"
            ExcelWkSheet.Cells(1, 5).Value = "DIA"
            ExcelWkSheet.Cells(1, 6).Value = "TIPO_DE_ENTIDAD"
            ExcelWkSheet.Cells(1, 7).Value = "EXPRESADO"
            ExcelWkSheet.Cells(1, 8).Value = "ENTIDAD"

            ExcelWkSheet.Cells(1, 9) = "COEFICIENTE_DE_ADECUACION_PATRIMONIAL"
            ExcelWkSheet.Cells(1, 10) = "CATEGORIA_I_ACTIVO_CON_CERO_RIESGO"
            ExcelWkSheet.Cells(1, 11) = "CATEGORIA_II_ACTIVO_CON_RIESGO_DE_10%"
            ExcelWkSheet.Cells(1, 12) = "CATEGORIA_III_ACTIVO_CON_RIESGO_DE_20%"
            ExcelWkSheet.Cells(1, 13) = "CATEGORIA_IV_ACTIVO_CON_RIESGO_DE_50%"
            ExcelWkSheet.Cells(1, 14) = "CATEGORIA_V_ACTIVO_CON_RIESGO_DE_75%"
            ExcelWkSheet.Cells(1, 15) = "CATEGORIA_VI_ACTIVO_CON_RIESGO_DE_100%"
            ExcelWkSheet.Cells(1, 16) = "TOTAL_ACTIVO_Y_CONTINGENTE"
            ExcelWkSheet.Cells(1, 17) = "TOTAL_ACTIVO_COMPUTABLE"
            ExcelWkSheet.Cells(1, 18) = "COEFICIENTE_DE_PONDERACION_DEL_ACTIVO"
            ExcelWkSheet.Cells(1, 19) = "10%_SOBRE_ACTIVO_COMPUTABLE"
            ExcelWkSheet.Cells(1, 20) = "CAPITAL_PRIMARIO_INICIAL"
            ExcelWkSheet.Cells(1, 21) = "Déficit_de_previsiones_de_activos"
            ExcelWkSheet.Cells(1, 22) = "Déficit_de_provisiones_de_pasivos"
            ExcelWkSheet.Cells(1, 23) = "Otros_Ajustes"
            ExcelWkSheet.Cells(1, 24) = "CAPITAL_PRIMARIO_DESPUES_DE_AJUSTES"
            ExcelWkSheet.Cells(1, 25) = "OBLIGACIONES_SUBORDINADAS_COMPUTABLES_(1)"
            ExcelWkSheet.Cells(1, 26) = "Obligaciones_subordinadas_con_el_Fondesif"
            ExcelWkSheet.Cells(1, 27) = "Obligaciones_subordinadas_Profop"
            ExcelWkSheet.Cells(1, 28) = "Otras_obligaciones_subordinadas"
            ExcelWkSheet.Cells(1, 29) = "PREVISIONES_GENERICAS_VOLUNTARIAS_PARA_PERDIDAS_FUTURAS"
            ExcelWkSheet.Cells(1, 30) = "Otros_ajustes"
            ExcelWkSheet.Cells(1, 31) = "CAPITAL_SECUNDARIO_DESPUES_DE_AJUSTES"
            ExcelWkSheet.Cells(1, 32) = "INVERSIONES_EN_SOCIEDADES_ANÓNIMAS_DE_SEGUROS"
            ExcelWkSheet.Cells(1, 33) = "INVERSIONES_EN_OTRAS_EMPRESAS_NO_CONSOLIDADAS"
            ExcelWkSheet.Cells(1, 34) = "CAPITAL_REGULATORIO"
            ExcelWkSheet.Cells(1, 35) = "EXCEDENTE_(DEFICIT)_PATRIMONIAL"
            ExcelWkSheet.Cells(1, 36).Value = "COEFICIENTE_DE_INVERSION_EN_ACTIVOS_FIJOS_Y_OTRAS_SOCIEDADES_(Limite_max._100%)"
            ExcelWkSheet.Cells(1, 37).Value = "Aux"


            ExcelWkBook.SaveAs(rutaPrincipal)
            ExcelWkBook.Close()

            registroEjecucion000_00("Se creo un archivo BBDD_Calificacion_De_Cartera.xlsx")
            Thread.Sleep(5000)

            ExcelWkBook = ExcelApp.Workbooks.Open(rutaPrincipal)
            ExcelWkSheet = ExcelWkBook.Sheets(1)

        End If

        '##################################################################################################
        '##############  RECOLECTAR LOS NOMBRES DE LAS DISTINTOS INSTITUCIONES FINANCIERAS
        '##################################################################################################

        For i = 0 To 6

            For gestion = gestionIn To gestionFn

                For mes = 1 To 12

                    Try
                        If mes > 9 Then

                            If i = 4 Then
                                rutaDatos = currentDirectory & "\DATOS\scbm\" & CStr(gestion) & "\" & CStr(mes) & "\" & tipoEntidad(i) & CStr(mes) & CStr(gestion - 2000) & "\" & CStr(gestion) & CStr(mes) & tipoEntidad2(i) & "PonderacionActivosA.XLS"
                            ElseIf i = 5 Then
                                rutaDatos = currentDirectory & "\DATOS\scbm\" & CStr(gestion) & "\" & CStr(mes) & "\" & tipoEntidad(i) & CStr(mes) & CStr(gestion - 2000) & "\" & CStr(gestion) & CStr(mes) & tipoEntidad2(i) & "PonderacionActivosB.XLS"
                            Else
                                rutaDatos = currentDirectory & "\DATOS\scbm\" & CStr(gestion) & "\" & CStr(mes) & "\" & tipoEntidad(i) & CStr(mes) & CStr(gestion - 2000) & "\" & CStr(gestion) & CStr(mes) & tipoEntidad2(i) & "PonderacionActivos.XLS"
                            End If

                            If File.Exists(rutaDatos) Then

                                registroEjecucion000_00(rutaDatos)
                                ExcelWkBookDatos = ExcelApp.Workbooks.Open(rutaDatos)
                                ExcelWkSheetDatos = ExcelWkBookDatos.Sheets(1)

                                ExcelWkSheetDatos.Cells(1, 1).CurrentRegion.Copy

                                ExcelWkBook.Activate()
                                ExcelWkSheet.Activate()
                                n = ExcelWkSheet.Cells(ExcelWkSheet.Rows.Count, 1).End(Microsoft.Office.Interop.Excel.XlDirection.xlUp).Row + 1

                                registroEjecucion000_00(CStr(n))

                                ExcelWkBook.Activate()
                                ExcelWkSheet.Activate()
                                ExcelWkSheet.Range("A" & CStr(n)).Select()
                                ExcelWkSheet.Paste()
                                ExcelWkBook.Save()

                                ExcelWkBookDatos.Save()
                                ExcelWkBookDatos.Close()

                            End If

                        Else

                            If i = 4 Then
                                rutaDatos = currentDirectory & "\DATOS\scbm\" & CStr(gestion) & "\0" & CStr(mes) & "\" & tipoEntidad(i) & "0" & CStr(mes) & CStr(gestion - 2000) & "\" & CStr(gestion) & "0" & CStr(mes) & tipoEntidad2(i) & "PonderacionActivosA.XLS"
                            ElseIf i = 5 Then
                                rutaDatos = currentDirectory & "\DATOS\scbm\" & CStr(gestion) & "\0" & CStr(mes) & "\" & tipoEntidad(i) & "0" & CStr(mes) & CStr(gestion - 2000) & "\" & CStr(gestion) & "0" & CStr(mes) & tipoEntidad2(i) & "PonderacionActivosB.XLS"
                            Else
                                rutaDatos = currentDirectory & "\DATOS\scbm\" & CStr(gestion) & "\0" & CStr(mes) & "\" & tipoEntidad(i) & "0" & CStr(mes) & CStr(gestion - 2000) & "\" & CStr(gestion) & "0" & CStr(mes) & tipoEntidad2(i) & "PonderacionActivos.XLS"
                            End If

                            If File.Exists(rutaDatos) Then

                                registroEjecucion000_00(rutaDatos)
                                ExcelWkBookDatos = ExcelApp.Workbooks.Open(rutaDatos)
                                ExcelWkSheetDatos = ExcelWkBookDatos.Sheets(1)

                                ExcelWkSheetDatos.Cells(1, 1).CurrentRegion.Copy

                                ExcelWkBook.Activate()
                                ExcelWkSheet.Activate()
                                n = ExcelWkSheet.Cells(ExcelWkSheet.Rows.Count, 1).End(Microsoft.Office.Interop.Excel.XlDirection.xlUp).Row + 1

                                registroEjecucion000_00(CStr(n))

                                ExcelWkBook.Activate()
                                ExcelWkSheet.Activate()
                                ExcelWkSheet.Range("A" & CStr(n)).Select()
                                ExcelWkSheet.Paste()
                                ExcelWkBook.Save()

                                ExcelWkBookDatos.Save()
                                ExcelWkBookDatos.Close()

                            End If

                        End If

                    Catch ex As Exception

                        registroEjecucion000_00("ERROR: " & ex.Message)
                        Continue For

                    End Try

                Next

            Next
        Next

        '##################################################################################################
        '#######  ELIMINAR REGISTROS REPETIDOS UTILIZANDO LA COLUMNA ID COMO CAMPO DE REFERENCIA
        '##################################################################################################

        n = ExcelWkSheet.Cells(ExcelWkSheet.Rows.Count, 1).End(Microsoft.Office.Interop.Excel.XlDirection.xlUp).Row

        For i = 2 To n
            ExcelWkSheet.Cells(i, 37).FormulaR1C1 = "=COUNTIF(R2C1:R" & n & "C1,R[0]C[-36])"
        Next

        registroEjecucion000_00("Se procedera a eliminar registros duplicados....")

        For i = n To 2 Step -1
            If CLng(ExcelWkSheet.Cells(i, 37).Value) > 1 Then
                ExcelWkSheet.Rows(CStr(i) & ":" & CStr(i)).Delete(Shift:=Microsoft.Office.Interop.Excel.XlDirection.xlUp)
            End If
        Next

        ExcelWkSheet.Columns("A:A").NumberFormat = "@"
        ExcelWkSheet.Columns("B:B").NumberFormat = "m/d/yyyy"
        ExcelWkSheet.Columns("C:E").NumberFormat = "0"
        ExcelWkSheet.Columns("F:H").NumberFormat = "@"
        ExcelWkSheet.Columns("I:AJ").NumberFormat = "0.000000"
        ExcelWkSheet.Columns("AK:AK").NumberFormat = "0"


        '##################################################################################################
        '#########################    CREAR UN ARCHIVO CSV DE LOS DATOS
        '##################################################################################################

        Try

            If File.Exists(rutaCSV) Then
                File.Delete(rutaCSV)
            End If
            ExcelWkBookCSV = ExcelApp.Workbooks.Add()
            ExcelWkSheetCSV = ExcelWkBookCSV.Sheets(1)

            ExcelWkBook.Activate()
            ExcelWkSheet.Cells(1, 1).CurrentRegion.Copy

            ExcelWkBookCSV.Activate()
            ExcelWkSheetCSV.Range("A1").Select()
            ExcelWkSheetCSV.Paste()

            ExcelWkSheet.Columns("A:A").NumberFormat = "@"
            ExcelWkSheet.Columns("B:B").NumberFormat = "m/d/yyyy"
            ExcelWkSheet.Columns("C:E").NumberFormat = "0"
            ExcelWkSheet.Columns("F:H").NumberFormat = "@"
            ExcelWkSheet.Columns("I:AJ").NumberFormat = "0.000000"
            ExcelWkSheet.Columns("AK:AK").NumberFormat = "0"

            ExcelWkBookCSV.SaveAs(rutaCSV, FileFormat:=Microsoft.Office.Interop.Excel.XlFileFormat.xlCSV, CreateBackup:=False)
            ExcelWkBookCSV.Close()

            registroEjecucion000_00("Se creo un archivo CSV de los datos...")

        Catch ex As Exception
            registroEjecucion000_00(ex.Message)
        End Try


        ExcelWkBook.Save()
        ExcelWkBook.Close()

        Thread.Sleep(5000)

    End Sub

#End Region

#Region "CATEGORIA - CAPTACIONES"

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

#End Region

#Region "CATEGORIA - AGENCIAS, SUCURSALES, NRO. EMPLEADOS"

#End Region

End Module
