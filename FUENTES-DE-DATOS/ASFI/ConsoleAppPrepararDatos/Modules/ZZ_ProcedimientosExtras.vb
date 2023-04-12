Imports System.IO
Imports System.Text.RegularExpressions
Imports Microsoft.Office.Interop
Imports Microsoft.Office.Core
Module ZZ_ProcedimientosExtras

#Region "PROCEDIMIENTOS COMPLEMENTARIOS"
    ''' <summary>
    ''' Permite escribir un mensaje en consola y el archivo historial. 
    ''' </summary>
    Public Sub registroEjecucion000_00(ByVal texto As String)
        ' Permite escribir en consola y el archivo historial.
        Console.WriteLine(texto)
        historialEjecucion.WriteLine(texto)

    End Sub

    ''' <summary>
    ''' Crea las carpetas necesarias para ejecutar el programa.
    ''' </summary>
    Public Sub cargarCarpetas()

        If Not Directory.Exists($"{Directory.GetCurrentDirectory()}\HISTORIAL EJECUCION") Then
            Directory.CreateDirectory($"{Directory.GetCurrentDirectory()}\HISTORIAL EJECUCION")
        End If
        If Not Directory.Exists($"{Directory.GetCurrentDirectory()}\ENUMERACIONES") Then
            Directory.CreateDirectory($"{Directory.GetCurrentDirectory()}\ENUMERACIONES")
        End If
        If Not Directory.Exists($"{Directory.GetCurrentDirectory()}\DATOS_ASFI") Then
            Directory.CreateDirectory($"{Directory.GetCurrentDirectory()}\DATOS_ASFI")
        End If
        If Not Directory.Exists($"{Directory.GetCurrentDirectory()}\DATOS\scbmModificado") Then
            Directory.CreateDirectory($"{Directory.GetCurrentDirectory()}\DATOS\scbmModificado")
        End If

    End Sub

    Public Sub caragarRegistros(ExcelApp As Excel.Application)

        '#############################################################################################
        '###############   REGISTROS
        '#############################################################################################
        Dim rutaHistorialEjecucion As String = $"{Directory.GetCurrentDirectory()}\HISTORIAL EJECUCION\S0_00_HISTORIAL_EJECUCION_PRINCIPAL.txt"
        Dim rutaCarpeta As String = $"{Directory.GetCurrentDirectory()}\HISTORIAL EJECUCION"
        Dim sFiles() As String
        Dim n As Long
        Dim nStr As String

        If File.Exists(rutaHistorialEjecucion) Then
            sFiles = Directory.GetFiles(rutaCarpeta, "*.txt")
            n = UBound(sFiles) + 1
            nStr = If(n < 10, $"000{CStr(n)}", If(n < 100, $"00{CStr(n)}", If(n < 1000, $"0{CStr(n)}", $"{n}")))
            rutaHistorialEjecucion = $"{Directory.GetCurrentDirectory()}\HISTORIAL EJECUCION\S0_00_HISTORIAL_EJECUCION_PRINCIPAL_{nStr}.txt"
        End If

        Dim fs As FileStream
        fs = File.Create(rutaHistorialEjecucion)
        fs.Close()

        historialEjecucion = File.AppendText(rutaHistorialEjecucion)

    End Sub

    Public Sub eliminarFilasVac(ByVal ExcelWkSheet As Excel.Worksheet, Optional ByVal nCol As Long = 1)
        Dim n1 As Long
        Dim strEval As String
        Dim celdaFinal As Excel.Range

        'ELIMINAR FILAS VACIAS
        n1 = ExcelWkSheet.Cells(ExcelWkSheet.Rows.Count, nCol).End(Excel.XlDirection.xlUp).Row
        celdaFinal = ExcelWkSheet.Cells(n1, nCol)

        For i = 2 To n1

            If i < celdaFinal.Row Then
                strEval = If(CStr(ExcelWkSheet.Cells(i, nCol).Value) <> "",
                            QuitarEspAcen(CStr(ExcelWkSheet.Cells(i, nCol).Value)),
                            "")

                If strEval = "" And ExcelWkSheet.Cells(i, nCol).Row <> 1 Then

                    ExcelWkSheet.Rows($"{CStr(i)}:{CStr(i)}").Delete(Shift:=Excel.XlDirection.xlUp)

                    strEval = If(CStr(ExcelWkSheet.Cells(i, nCol).Value) <> "",
                                QuitarEspAcen(CStr(ExcelWkSheet.Cells(i, nCol).Value)),
                                "")
                    'PARA CUANDO HAY FILA VACIAS REPETIDAS
                    While strEval = "" And ExcelWkSheet.Cells(i, nCol).Row < celdaFinal.Row

                        ExcelWkSheet.Rows($"{CStr(i)}:{CStr(i)}").Delete(Shift:=Excel.XlDirection.xlUp)
                        strEval = If(CStr(ExcelWkSheet.Cells(i, nCol).Value) <> "",
                                QuitarEspAcen(CStr(ExcelWkSheet.Cells(i, nCol).Value)),
                                "")

                    End While

                End If

            ElseIf i > celdaFinal.Row Then
                Exit For
            End If

        Next


    End Sub

    ''' <summary>
    ''' <para>Este procedimiento contiene todos los patrones y si se decea editar, igualar campos, unir, enumerar</para>
    ''' </summary>
    ''' <param name="ExcelApp"></param>
    ''' <param name="gestionIn"></param>
    ''' <param name="gestionFn"></param>
    ''' <param name="categoriaHojas"></param>
    ''' <param name="patron"></param>
    ''' <param name="unirHojas"></param>
    ''' <param name="enumerar"></param>
    ''' <param name="igualarCampos"></param>
    Public Sub cargarPatronDeEdicion(ByVal ExcelApp As Excel.Application, ByVal gestionIn As Long, ByVal gestionFn As Long, ByVal categoriaHojas As String, ByVal patron As String, Optional unirHojas As Boolean = False, Optional enumerar As Boolean = False, Optional igualarCampos As Boolean = False)
        Dim nCategoria As String = Replace(categoriaHojas, " ", "")
        Dim nPatron As String = Replace(patron, " ", "")

        '   SECCION: ESTADOS FINANCIEROS
        If nCategoria = "EstadosFinancieros" And nPatron = "Patron1" Then
            editarArchivosPorPatron01(ExcelApp, gestionIn, CLng(gestionFn), categoriaHojas, unirHojas, enumerar, igualarCampos)
        ElseIf nCategoria = "EstadosFinancierosMoneda" And nPatron = "Patron1" Then
            editarArchivosPorPatron01(ExcelApp, gestionIn, CLng(gestionFn), categoriaHojas, unirHojas, enumerar, igualarCampos)

            'SECCION: INDICADORES FINANCIEROS
        ElseIf nCategoria = "CalificacionCartera" And nPatron = "Patron2" Then
            editarArchivosPorPatron02(ExcelApp, gestionIn, CLng(gestionFn), categoriaHojas, unirHojas, enumerar)
        ElseIf nCategoria = "IndicadoresFinancieros" And nPatron = "Patron1" Then
            editarArchivosPorPatron01(ExcelApp, gestionIn, CLng(gestionFn), categoriaHojas, unirHojas, enumerar, igualarCampos)
        ElseIf nCategoria = "PonderacionActivos" And nPatron = "Patron2" Then
            editarArchivosPorPatron02(ExcelApp, gestionIn, CLng(gestionFn), categoriaHojas, unirHojas, enumerar)

            'SECCION: CAPTACIONES
        ElseIf nCategoria = "RankingDepositosPublico" And nPatron = "Patron5" Then
            editarArchivosPorPatron05(ExcelApp, gestionIn, CLng(gestionFn), categoriaHojas, unirHojas, enumerar)
        ElseIf nCategoria = "RankingDepositos" And nPatron = "Patron5" Then
            editarArchivosPorPatron05(ExcelApp, gestionIn, CLng(gestionFn), categoriaHojas, unirHojas, enumerar)
        ElseIf nCategoria = "EncajeLegal" And nPatron = "Patron4" Then
            editarArchivosPorPatron04(ExcelApp, gestionIn, CLng(gestionFn), categoriaHojas, unirHojas, enumerar)
        ElseIf nCategoria = "EstratificacionDepositos" And nPatron = "Patron1" Then
            editarArchivosPorPatron01(ExcelApp, gestionIn, CLng(gestionFn), categoriaHojas, unirHojas, enumerar, igualarCampos)
        ElseIf nCategoria = "EstratificacionDepEntidadTotal" And nPatron = "Patron1" Then
            editarArchivosPorPatron01(ExcelApp, gestionIn, CLng(gestionFn), categoriaHojas, unirHojas, enumerar, igualarCampos)
        ElseIf nCategoria = "EstratificacionDepositos" And nPatron = "Patron1" Then
            editarArchivosPorPatron01(ExcelApp, gestionIn, CLng(gestionFn), categoriaHojas, unirHojas, enumerar, igualarCampos)

            'SECCION: COLOCACIONES
        ElseIf nCategoria = "FinanciamientosExternos" And nPatron = "Patron1" Then
            editarArchivosPorPatron01(ExcelApp, gestionIn, CLng(gestionFn), categoriaHojas, unirHojas, enumerar, igualarCampos)
        ElseIf nCategoria = "RankingColocaciones" And nPatron = "Patron5" Then
            editarArchivosPorPatron05(ExcelApp, gestionIn, CLng(gestionFn), categoriaHojas, unirHojas, enumerar)
        ElseIf nCategoria = "RankingContingente" And nPatron = "Patron5" Then
            editarArchivosPorPatron05(ExcelApp, gestionIn, CLng(gestionFn), categoriaHojas, unirHojas, enumerar)

            'SECCION: OPERACIONES INTERBANCARIAS
        ElseIf nCategoria = "OperacionesInterbancarias" And nPatron = "Patron5" Then
            editarArchivosPorPatron05(ExcelApp, gestionIn, CLng(gestionFn), categoriaHojas, unirHojas, enumerar)

            'SECCION: ESTADOS FINANANCIEROS EVOLUTIVOS

            'SECCION: INDICADORES EVOLUTIVOS

            'SECCION: ESTADOS FINANCIEROS DESAGREGADOS
        ElseIf nCategoria = "EstadosFinancierosDesagregados" And nPatron = "Patron3" Then
            editarArchivosPorPatron03(ExcelApp, gestionIn, CLng(gestionFn), categoriaHojas, unirHojas, enumerar)

            'SECCION: AGENCIAS, SUCURSALES, NRO. EMPLEADOS
        ElseIf nCategoria = "PAFs_x_Depto" And nPatron = "Patron1" Then
            editarArchivosPorPatron01(ExcelApp, gestionIn, CLng(gestionFn), categoriaHojas, unirHojas, enumerar, igualarCampos)
        ElseIf nCategoria = "Agencias" And nPatron = "Patron1" Then
            editarArchivosPorPatron01(ExcelApp, gestionIn, CLng(gestionFn), categoriaHojas, unirHojas, enumerar, igualarCampos)

            'PARA SECCIONES QUE NO CORRESPONDE
        Else
            registroEjecucion000_00("El patron de edicion para editar este tipo de cateroria no existe...")
            registroEjecucion000_00("-------------------------------------------")
        End If
    End Sub

#End Region

#Region "PROCEDIMIENTOS PARA EDICION DE HOJAS"

    Public Sub modificarTitulosAntesTransponer(ByVal ExcelWkSheet As Excel.Worksheet, Optional ByVal nCol As Long = 1)
        Dim n2 As Long
        Dim strEval As String

        'MODIFICAR FORMATO DE TITULOS
        n2 = ExcelWkSheet.Cells(ExcelWkSheet.Rows.Count, nCol).End(Excel.XlDirection.xlUp).Row

        For i = 1 To n2
            strEval = If(CStr(ExcelWkSheet.Cells(i, nCol).Value) <> "",
                            QuitarEspAcen(CStr(ExcelWkSheet.Cells(i, nCol).Value)),
                            "")

            If strEval <> "" Then
                ExcelWkSheet.Cells(i, nCol).Value = strEval
            End If
        Next

        ExcelWkSheet.Cells(1, 1).Value = "ENTIDIDAD"

    End Sub

    Public Sub eliminarColmnasNoNec(ByVal ExcelWkSheet As Excel.Worksheet, ByVal txt As String)
        Dim n1 As Long
        Dim strEval As String
        Dim colElm As String

        n1 = ExcelWkSheet.Cells(1, 1).End(Excel.XlDirection.xlToRight).Column

        'ELIMINAR COLUMNAS NO NECESARIAS
        For i = 1 To n1

            strEval = If(CStr(ExcelWkSheet.Cells(1, i).Value) <> "",
                            QuitarEspAcen(CStr(ExcelWkSheet.Cells(1, i).Value)),
                            "")

            colElm = Replace(Regex.Replace(ExcelWkSheet.Cells(1, i).Address(), "\d", ""), "$", "")
            If strEval = txt Then
                ExcelWkSheet.Columns($"{colElm}:{colElm}").Delete()
                Exit For
            End If


        Next

    End Sub

    Public Sub eliminarFilaPorNombre(ByVal ExcelWkSheet As Excel.Worksheet, ByVal txt As String, Optional ByVal nCol As Long = 1)
        Dim c As Long
        Dim i As Long
        Dim n1 As Long
        Dim strEval As String
        Dim strEval2 As String
        Dim nElm As Long

        'ELIMINAR FILA POR NOMBRE
        n1 = ExcelWkSheet.Cells(ExcelWkSheet.Rows.Count, nCol).End(Excel.XlDirection.xlUp).Row

        For i = 1 To n1
            strEval = If(CStr(ExcelWkSheet.Cells(i, nCol).Value) <> "",
                            QuitarEspAcen(CStr(ExcelWkSheet.Cells(i, nCol).Value)),
                            "")
            strEval2 = If(CStr(ExcelWkSheet.Cells(i, nCol).Value) <> "",
                            QuitarEspAcen2(CStr(ExcelWkSheet.Cells(i, nCol).Value)),
                            "")
            c = i

            If strEval = txt Or strEval2 = txt Then
                registroEjecucion000_00($"Se elimino la fila {txt}: {strEval}")
                nElm = ExcelWkSheet.Cells(i, nCol).Row
                ExcelWkSheet.Rows($"{CStr(nElm)}:{CStr(nElm)}").Delete(Shift:=Excel.XlDirection.xlUp)
                Exit For
            End If
            'POR SI NO ENCUENTRA EL VALOR PARA ELIMINAR LA FILA
            If c = n1 And (strEval <> txt Or strEval2 <> txt) Then
                registroEjecucion000_00($"No se encontro {txt}: Para poder eliminar la fila.")
            End If

        Next


    End Sub

    Public Sub eliminarFilasInFn_TP1(ByVal ExcelWkSheet As Excel.Worksheet, ByVal txtIn As String, ByVal txtFn As String, Optional ByVal colBusq As Long = 1)
        Dim CelTiBn As Excel.Range
        Dim CelIn As Excel.Range
        Dim CelFn As Excel.Range
        Dim n1 As Long
        Dim strEval As String
        Dim strEval2 As String

        'ENCONTRAR CELAS QUE SE USARAN DE REFERENCIA
        CelIn = ExcelWkSheet.Cells(1, 1)
        CelTiBn = ExcelWkSheet.Cells(1, 1)
        CelFn = ExcelWkSheet.Cells(1, 1)
        colBusq = colBusq - 1

        n1 = ExcelWkSheet.Cells(ExcelWkSheet.Rows.Count, 1).Offset(0, colBusq).End(Excel.XlDirection.xlUp).Row
        For i = 1 To n1

            strEval = If(CStr(ExcelWkSheet.Cells(i, 1).Offset(0, colBusq).Value) <> "",
                        QuitarEspAcen(CStr(ExcelWkSheet.Cells(i, 1).Offset(0, colBusq).Value)),
                        "")
            strEval2 = If(CStr(ExcelWkSheet.Cells(i, 1).Offset(0, colBusq).Value) <> "",
                        QuitarEspAcen2(CStr(ExcelWkSheet.Cells(i, 1).Offset(0, colBusq).Value)),
                        "")
            If strEval = txtIn Or strEval2 = txtIn Then
                CelIn = ExcelWkSheet.Cells(i, 1).Offset(0, colBusq)
                registroEjecucion000_00($"Celda Inicial: {CelIn.Row}, Value: {CStr(CelIn.Value)}")
                Exit For
            Else
                Continue For
            End If

        Next
        For i = n1 To 1 Step -1

            strEval = If(CStr(ExcelWkSheet.Cells(i, 1).Offset(0, colBusq).Value) <> "",
                        QuitarEspAcen(CStr(ExcelWkSheet.Cells(i, 1).Offset(0, colBusq).Value)),
                        "")
            strEval2 = If(CStr(ExcelWkSheet.Cells(i, 1).Offset(0, colBusq).Value) <> "",
                        QuitarEspAcen(CStr(ExcelWkSheet.Cells(i, 1).Offset(0, colBusq).Value)),
                        "")
            If strEval = txtFn Or strEval2 = txtFn Then
                CelFn = ExcelWkSheet.Cells(i, 1).Offset(0, colBusq)
                registroEjecucion000_00($"Celda Final: {CelFn.Row}, Value: {CStr(CelFn.Value)}")
                Exit For
            Else
                Continue For
            End If

        Next

        For i = CelIn.Row - 1 To 1 Step -1
            strEval = If(CStr(ExcelWkSheet.Cells(i, colBusq + 1).Offset(0, 1).Value) <> "",
                        QuitarEspAcen(CStr(ExcelWkSheet.Cells(i, colBusq + 1).Offset(0, 1).Value)),
                        "")

            If strEval <> "" Then
                CelTiBn = ExcelWkSheet.Cells(i, colBusq + 1).Offset(0, 1)
                registroEjecucion000_00($"CelTiBn: {CelTiBn.Row}, Value: {CStr(CelTiBn.Value)}")
                Exit For
            End If
        Next

        'ELIMINAR FILAS NO NECESARIAS
        n1 = ExcelWkSheet.Cells(ExcelWkSheet.Rows.Count, 1).Offset(0, colBusq).End(Excel.XlDirection.xlUp).Row
        ExcelWkSheet.Rows($"1:{CStr(CelTiBn.Row - 1)}").Delete(Shift:=Excel.XlDirection.xlUp)
        ExcelWkSheet.Rows($"{CStr(CelFn.Row + 1)}:{CStr(n1 + 1)}").Delete(Shift:=Excel.XlDirection.xlUp)

    End Sub

    Public Sub eliminarFilasInter_TP1(ByVal ExcelWkSheet As Excel.Worksheet, ByVal txtIn As String, ByVal txtFn As String, Optional ByVal colBusq As Long = 1)
        Dim CelIn As Excel.Range
        Dim CelFn As Excel.Range
        Dim n1 As Long
        Dim i As Long
        Dim strEval As String
        Dim strEval2 As String

        'ENCONTRAR CELAS QUE SE USARAN DE REFERENCIA
        CelIn = ExcelWkSheet.Cells(1, 1)
        CelFn = ExcelWkSheet.Cells(1, 1)
        colBusq = colBusq - 1

        n1 = ExcelWkSheet.Cells(ExcelWkSheet.Rows.Count, 1).Offset(0, colBusq).End(Excel.XlDirection.xlUp).Row
        For i = 1 To n1

            strEval = If(CStr(ExcelWkSheet.Cells(i, 1).Offset(0, colBusq).Value) <> "",
                QuitarEspAcen(CStr(ExcelWkSheet.Cells(i, 1).Offset(0, colBusq).Value)),
                "")
            strEval2 = If(CStr(ExcelWkSheet.Cells(i, 1).Offset(0, colBusq).Value) <> "",
                QuitarEspAcen2(CStr(ExcelWkSheet.Cells(i, 1).Offset(0, colBusq).Value)),
                "")

            If strEval = txtIn Or strEval2 = txtIn Then
                CelIn = ExcelWkSheet.Cells(i, 1).Offset(0, colBusq)
                registroEjecucion000_00($"CelInicial: {CelIn.Row}, Value: {CStr(CelIn.Value)}")
                Exit For
            Else
                Continue For
            End If

        Next
        For i = n1 To 1 Step -1

            strEval = If(CStr(ExcelWkSheet.Cells(i, 1).Offset(0, colBusq).Value) <> "",
                QuitarEspAcen(CStr(ExcelWkSheet.Cells(i, 1).Offset(0, colBusq).Value)),
                "")
            strEval2 = If(CStr(ExcelWkSheet.Cells(i, 1).Offset(0, colBusq).Value) <> "",
                QuitarEspAcen(CStr(ExcelWkSheet.Cells(i, 1).Offset(0, colBusq).Value)),
                "")


            If strEval = txtFn Or strEval2 = txtFn Then
                CelFn = ExcelWkSheet.Cells(i, 1).Offset(0, colBusq)
                registroEjecucion000_00($"Celda Final: {CelFn.Row}, Value: {CStr(CelFn.Value)}")
                Exit For
            Else
                Continue For
            End If

        Next

        'ELIMINAR FILAS NO NECESARIAS
        ExcelWkSheet.Rows($"{CStr(CelIn.Row + 1)}:{CStr(CelFn.Row - 1)}").Delete(Shift:=Excel.XlDirection.xlUp)

    End Sub

    Public Sub copiarPegarFila(ByVal ExcelWkSheet As Excel.Worksheet, ByVal nCol As Long, ByVal txt As String, Optional ByVal colBusq As Long = 1)
        Dim i As Long
        Dim c As Long
        Dim n1 As Long
        Dim strEval As String = Nothing
        Dim strEval2 As String = Nothing
        Dim celReferencia As Excel.Range = Nothing


        n1 = ExcelWkSheet.Cells(ExcelWkSheet.Rows.Count, colBusq).End(Excel.XlDirection.xlUp).Row
        For i = 1 To n1

            strEval = If(CStr(ExcelWkSheet.Cells(i, colBusq).Value) <> "",
                              QuitarEspAcen(CStr(ExcelWkSheet.Cells(i, colBusq).Value)),
                              "")
            strEval2 = If(CStr(ExcelWkSheet.Cells(i, colBusq).Value) <> "",
                              QuitarEspAcen2(CStr(ExcelWkSheet.Cells(i, colBusq).Value)),
                              "")
            c = i

            If strEval = txt Or strEval2 = txt Then
                celReferencia = ExcelWkSheet.Cells(i, colBusq)
                Exit For
            End If

            'POR SI NO ENCUENTRA EL VALOR PARA ELIMINAR LA FILA
            If c = n1 And (strEval <> txt Or strEval2 <> txt) Then
                registroEjecucion000_00($"No se encontro {txt}: Para poder copiar la fila.")
            End If

        Next

        If strEval = txt Or strEval2 = txt Then
            'COPIAR Y PEGAR LOS VALORES DE LA FILA
            registroEjecucion000_00($"Fila a copiar: {celReferencia.Row}, Valor de referencia: {CStr(celReferencia.Value)}")
            For i = 1 To (nCol - 1)
                celReferencia.Offset(0, i).Copy()
                celReferencia.Offset(0, i).PasteSpecial(Paste:=Excel.XlPasteType.xlPasteValues,
                                             Operation:=XlConstants.xlNone,
                                             SkipBlanks:=False,
                                             Transpose:=False)
            Next
        End If


    End Sub

    Public Sub cargarProcedimientoEdcion(ByVal ExcelWkBook As Excel.Workbook, ByVal gestion As Long, ByVal mes As Integer, ByVal tipoEndidadInd As Integer, ByVal categoriaHojas As String)

        '   SECCION: ESTADOS FINANCIEROS

        If Replace(categoriaHojas, " ", "") = "EstadosFinancieros" Then
            Editar_Estados_Financieros(ExcelWkBook, gestion, mes, tipoEndidadInd)
        ElseIf Replace(categoriaHojas, " ", "") = "EstadosFinancierosMoneda" Then
            Editar_Estados_Financieros_Moneda(ExcelWkBook, gestion, mes, tipoEndidadInd)

            'SECCION: INDICADORES FINANCIEROS
        ElseIf Replace(categoriaHojas, " ", "") = "IndicadoresFinancieros" Then
            Editar_Indicadores_Financieros(ExcelWkBook, gestion, mes, tipoEndidadInd)
        ElseIf Replace(categoriaHojas, " ", "") = "CalificacionCartera" Then
            Editar_Calificacion_Cartera(ExcelWkBook, gestion, mes, tipoEndidadInd)
        ElseIf Replace(categoriaHojas, " ", "") = "PonderacionActivos" Then
            Editar_Ponderacion_De_Activos_Y_CAP(ExcelWkBook, gestion, mes, tipoEndidadInd)

            'SECCION: CAPTACIONES

            'SECCION: COLOCACIONES

            'SECCION: OPERACIONES INTERBANCARIAS

            'SECCION: ESTADOS FINANANCIEROS EVOLUTIVOS

            'SECCION: INDICADORES EVOLUTIVOS

            'SECCION: ESTADOS FINANCIEROS DESAGREGADOS
        ElseIf Replace(categoriaHojas, " ", "") = "EstadosFinancierosDesagregados" Then
            Editar_Estados_Financieros_Desagregados(ExcelWkBook, gestion, mes, tipoEndidadInd)

            'SECCION: AGENCIAS, SUCURSALES, NRO. EMPLEADOS

            'PARA SECCIONES QUE NO CORRESPONDE
        Else
            registroEjecucion000_00("El metodo para editar este tipo de cateroria no existe...")
            registroEjecucion000_00("-------------------------------------------")
        End If

    End Sub

    Public Sub agregarCamposNecesarios(ByVal ExcelWkSheet As Excel.Worksheet, ByVal gestion As Long, ByVal mes As Integer, ByVal tipoEntidadStr As String, ByVal expresado As String)
        Dim n1 As Long
        Dim i As Long

        n1 = ExcelWkSheet.Cells(1, 1).End(Excel.XlDirection.xlToRight).Column

        'AGREGAR FILAS
        For i = 1 To 7
            ExcelWkSheet.Select()
            ExcelWkSheet.Rows("1:1").Insert(Shift:=Excel.XlDirection.xlDown,
                                               CopyOrigin:=Excel.XlInsertFormatOrigin.xlFormatFromLeftOrAbove)
        Next

        'AGREGAR VALOR DE CAMPOS

        For i = 1 To n1

            If i = 1 Then

                'AGREGAR NOMBRE DE CAMPOS ADICIONALES
                ExcelWkSheet.Cells(1, i).Value = "ID"
                ExcelWkSheet.Cells(2, i).Value = "FECHA"
                ExcelWkSheet.Cells(3, i).Value = "GESTION"
                ExcelWkSheet.Cells(4, i).Value = "MES"
                ExcelWkSheet.Cells(5, i).Value = "DIA"
                ExcelWkSheet.Cells(6, i).Value = "TIPO_DE_ENTIDAD"
                ExcelWkSheet.Cells(7, i).Value = "EXPRESADO"


            Else

                ExcelWkSheet.Cells(3, i).Value = CStr(gestion)
                ExcelWkSheet.Cells(4, i).Value = CStr(mes)
                ExcelWkSheet.Cells(5, i).Value = CStr(NumeroDiasMes(gestion, mes))
                ExcelWkSheet.Cells(6, i).Value = tipoEntidadStr
                ExcelWkSheet.Cells(7, i).Value = expresado

                'FILA ID

                ExcelWkSheet.Cells(1, i).Value = ExcelWkSheet.Cells(3, i).Value &
                                                      ExcelWkSheet.Cells(4, i).Value &
                                                      ExcelWkSheet.Cells(5, i).Value &
                                                       QuitarEspAcen(CStr(ExcelWkSheet.Cells(6, i).Value)) &
                                                       QuitarEspAcen(CStr(ExcelWkSheet.Cells(8, i).Value))

                ExcelWkSheet.Cells(2, i).Value = ExcelWkSheet.Cells(3, i).Value & "/" &
                                                  ExcelWkSheet.Cells(4, i).Value & "/" &
                                                  ExcelWkSheet.Cells(5, i).Value


            End If

        Next


        'ARREGLAR FORMATOS
        n1 = ExcelWkSheet.Cells(ExcelWkSheet.Rows.Count, 1).End(Excel.XlDirection.xlUp).Row
        ExcelWkSheet.Rows("1:1").NumberFormat = "@"
        ExcelWkSheet.Rows("2:2").NumberFormat = "m/d/yyyy"
        ExcelWkSheet.Rows("3:5").NumberFormat = "0"
        ExcelWkSheet.Rows("6:8").NumberFormat = "@"
        ExcelWkSheet.Rows($"9:{CStr(n1)}").NumberFormat = "0.00000000"
        ExcelWkSheet.Cells.EntireColumn.AutoFit()


    End Sub
#End Region

#Region "PROCEDIMIENTOS PARA IGUALAR CAMPOS"

    Public Sub agregarCategoriaCtas(ExcelWkSheet As Excel.Worksheet, txtIn As String, txtFn As String, categoriaPrincipal As String, txtFnAux As String, Optional tituloIn As Boolean = True, Optional tituloFn As Boolean = False)
        Dim strEval As String
        Dim i, n, nIn, nFn As Long
        Dim nStrIn, nStrFn As Long

        n = ExcelWkSheet.Cells(ExcelWkSheet.Rows.Count, 1).End(Excel.XlDirection.xlUp).Row
        nStrFn = 0
        nStrIn = 0

        For i = 1 To n
            strEval = If(CStr(ExcelWkSheet.Cells(i, 1).Value) <> "",
                          QuitarEspAcen(CStr(ExcelWkSheet.Cells(i, 1).Value)),
                          "")
            If strEval = txtIn Then
                nStrIn = ExcelWkSheet.Cells(i, 1).Row
                'registroEjecucion000_00($"SE ENCONTRO {strEval} -> {nStrIn}")
                If tituloIn Then
                    ExcelWkSheet.Cells(i, 1).Value = $"{categoriaPrincipal}_{strEval}"
                End If
            ElseIf strEval = txtFn Then
                nStrFn = ExcelWkSheet.Cells(i, 1).Row
                'registroEjecucion000_00($"SE ENCONTRO {strEval} -> {nStrFn}")
                Exit For
            End If
        Next

        If nStrIn > 0 Then

            If (nStrIn + 1) < nStrFn Then
                nIn = nStrIn + 1
                If tituloFn Then
                    nFn = nStrFn
                Else
                    nFn = nStrFn - 1
                End If

                For i = nIn To nFn
                    strEval = If(CStr(ExcelWkSheet.Cells(i, 1).Value) <> "",
                                QuitarEspAcen(CStr(ExcelWkSheet.Cells(i, 1).Value)),
                                "")
                    If tituloIn Then
                        ExcelWkSheet.Cells(i, 1).Value = $"{categoriaPrincipal}_{txtIn}_{strEval}"
                    Else
                        ExcelWkSheet.Cells(i, 1).Value = $"{categoriaPrincipal}_{strEval}"
                    End If
                Next
            End If

            'CUANDO NO SE ENCUENTRA LA CUENTA FINAL
            If nStrFn = 0 Then
                For i = 1 To n
                    strEval = If(CStr(ExcelWkSheet.Cells(i, 1).Value) <> "",
                                  QuitarEspAcen(CStr(ExcelWkSheet.Cells(i, 1).Value)),
                                  "")
                    If strEval = txtFnAux Then
                        nStrFn = ExcelWkSheet.Cells(i, 1).Row
                        'registroEjecucion000_00($"SE ENCONTRO LA CUENTA ALTERNATIVA FINAL {strEval} -> {nStrFn}")
                    End If
                Next

                If (nStrIn + 1) < nStrFn Then
                    nIn = nStrIn + 1
                    If tituloFn Then
                        nFn = nStrFn
                    Else
                        nFn = nStrFn - 1
                    End If

                    For i = nIn To nFn
                        strEval = If(CStr(ExcelWkSheet.Cells(i, 1).Value) <> "",
                                        QuitarEspAcen(CStr(ExcelWkSheet.Cells(i, 1).Value)),
                                        "")
                        If tituloIn Then
                            ExcelWkSheet.Cells(i, 1).Value = $"{categoriaPrincipal}_{txtIn}_{strEval}"
                        Else
                            ExcelWkSheet.Cells(i, 1).Value = $"{categoriaPrincipal}_{strEval}"
                        End If
                    Next
                End If
            End If

        End If


    End Sub

    Public Sub cambiarNombreCtas(ExcelWkSheet As Excel.Worksheet, txtAnt As String, txtDesp As String)
        Dim n As Long
        Dim strEval, strEval2 As String

        n = ExcelWkSheet.Cells(ExcelWkSheet.Rows.Count, 1).End(Excel.XlDirection.xlUp).Row
        strEval = txtAnt
        For i = 1 To n
            strEval2 = If(CStr(ExcelWkSheet.Cells(i, 1).Value) <> "",
                           QuitarEspAcen(CStr(ExcelWkSheet.Cells(i, 1).Value)),
                           "")
            If strEval2 = strEval Then
                ExcelWkSheet.Cells(i, 1).Value = txtDesp
                Exit For
            End If
        Next
    End Sub

#End Region

#Region "PROCEDIMIENTOS PARA ENUMERACION HOJAS"

    Public Sub crearHojaParaEnum(ExcelApp As Excel.Application, nombreHoja As String)
        Dim rutaHoja As String
        Dim ExcelWkBook As Excel.Workbook
        Dim ExcelWkSheet As Excel.Worksheet

        rutaHoja = $"{Directory.GetCurrentDirectory()}\ENUMERACIONES\ENUM_{nombreHoja}.xlsx"

        If File.Exists(rutaHoja) Then
            File.Delete(rutaHoja)
        End If

        ExcelWkBook = ExcelApp.Workbooks.Add()
        ExcelWkSheet = ExcelWkBook.Sheets(1)
        ExcelWkSheet.Name = "BBDD"

        ExcelWkSheet.Cells(1, 1).Value = "CAMPOS"
        ExcelWkSheet.Cells(1, 2).Value = "TIPO_ESTADO"
        ExcelWkSheet.Cells(1, 3).Value = "TIPO_ENTIDAD"
        ExcelWkSheet.Cells(1, 4).Value = "GESTION"
        ExcelWkSheet.Cells(1, 5).Value = "MES"
        ExcelWkSheet.Cells(1, 6).Value = "NUMERO"

        ExcelWkBook.SaveAs(rutaHoja)
        ExcelWkBook.Close()

    End Sub

    Public Sub enumerarFilasDelEstado(ByVal ExcelWkBook As Excel.Workbook, ByVal ExcelWkSheetEnum As Excel.Worksheet, Gestion As Long, mes As Integer, categoriaHojas As String, tipoEntidad As String, Optional strEnm As String = "BBDD")
        Dim ExcelWkSheet As Excel.Worksheet
        Dim i As Long
        Dim n1 As Long
        Dim n2 As Long
        Dim n3 As Long
        Dim c As Long

        ExcelWkSheet = ExcelWkBook.Sheets(strEnm)
        registroEjecucion000_00($"{ExcelWkSheet.Name}")
        ExcelWkSheet.Activate()
        n1 = ExcelWkSheet.Cells(ExcelWkSheet.Rows.Count, 1).End(Excel.XlDirection.xlUp).Row
        ExcelWkSheet.Range(ExcelWkSheet.Cells(1, 1), ExcelWkSheet.Cells(n1, 1)).Copy()


        ExcelWkSheetEnum.Activate()
        n2 = ExcelWkSheetEnum.Cells(ExcelWkSheetEnum.Rows.Count, 1).End(Excel.XlDirection.xlUp).Row + 1
        ExcelWkSheetEnum.Range($"A{n2}").PasteSpecial(Paste:=Excel.XlPasteType.xlPasteValues,
                                                   Operation:=XlConstants.xlNone,
                                                   SkipBlanks:=False,
                                                   Transpose:=False)

        n3 = ExcelWkSheetEnum.Cells(ExcelWkSheetEnum.Rows.Count, 1).End(Excel.XlDirection.xlUp).Row
        c = 1
        For i = n2 To n3
            ExcelWkSheetEnum.Range($"B{i}").Value = categoriaHojas
            ExcelWkSheetEnum.Range($"C{i}").Value = tipoEntidad
            ExcelWkSheetEnum.Range($"D{i}").Value = CStr(Gestion)
            ExcelWkSheetEnum.Range($"E{i}").Value = CStr(mes)
            ExcelWkSheetEnum.Range($"F{i}").Value = c
            c = c + 1
        Next

        ExcelWkBook.Save()
        ExcelWkBook.Close()
        registroEjecucion000_00("-Enumeracion Realizada")
        registroEjecucion000_00("-------------------------------------------")

    End Sub

#End Region

#Region "PROCEDIMIENTOS PARA UNIR HOJAS"

    Public Sub crearHojaParaUnir(ExcelApp As Excel.Application, nombreHoja As String)
        Dim rutaHoja As String
        Dim ExcelWkBook As Excel.Workbook
        Dim ExcelWkSheet As Excel.Worksheet

        rutaHoja = $"{Directory.GetCurrentDirectory()}\DATOS_ASFI\BBDD_{nombreHoja}.xlsx"

        If File.Exists(rutaHoja) Then
            File.Delete(rutaHoja)
        End If

        ExcelWkBook = ExcelApp.Workbooks.Add()
        ExcelWkSheet = ExcelWkBook.Sheets(1)
        ExcelWkSheet.Name = "BBDD"

        ExcelWkBook.SaveAs(rutaHoja)
        ExcelWkBook.Close()

    End Sub

    Public Sub crearCSV(ByVal ExcelApp As Excel.Application, ExcelWkBookUnir As Excel.Workbook, rutaCSV As String)
        Dim ExcelWkBookCSV As Excel.Workbook
        Dim ExcelWkSheetCSV As Excel.Worksheet

        If File.Exists(rutaCSV) Then
            File.Delete(rutaCSV)
        End If

        ExcelWkBookCSV = ExcelApp.Workbooks.Add()
        ExcelWkSheetCSV = ExcelWkBookCSV.Sheets(1)
        ExcelWkSheetCSV.Name = "BBDD"

        ExcelWkBookUnir.Activate()
        ExcelWkBookUnir.Sheets("BBDD").Cells(1, 1).CurrentRegion.Copy

        ExcelWkBookCSV.Activate()
        ExcelWkSheetCSV.Range("A1").Select()
        ExcelWkSheetCSV.Paste()

        ExcelWkBookCSV.SaveAs(rutaCSV, FileFormat:=Excel.XlFileFormat.xlCSV, CreateBackup:=False)
        ExcelWkBookCSV.Close()

        registroEjecucion000_00("Se creo un archivo CSV de los datos...")
    End Sub

    Public Sub copiarDatosEntreHojas(ByVal ExcelWkBook As Excel.Workbook, ByVal ExcelWkSheetUnir As Excel.Worksheet)
        Dim ExcelWkSheet As Excel.Worksheet
        Dim n1 As Long
        ExcelWkBook.Activate()
        ExcelWkSheet = ExcelWkBook.Sheets("BBDD")
        ExcelWkSheet.Activate()
        ExcelWkSheet.Range("A1").CurrentRegion.Copy()

        ExcelWkSheetUnir.Activate()
        n1 = ExcelWkSheetUnir.Cells(ExcelWkSheetUnir.Rows.Count, 1).End(Excel.XlDirection.xlUp).Row + 1
        ExcelWkSheetUnir.Range($"A{n1}").PasteSpecial(Paste:=Excel.XlPasteType.xlPasteValues,
                                                   Operation:=XlConstants.xlNone,
                                                   SkipBlanks:=False,
                                                   Transpose:=True)

        ExcelWkBook.Save()
        ExcelWkBook.Close()
        registroEjecucion000_00("-Copia transpuesta realizada exitosamente....")
        registroEjecucion000_00("-------------------------------------------")

    End Sub

#End Region

End Module
