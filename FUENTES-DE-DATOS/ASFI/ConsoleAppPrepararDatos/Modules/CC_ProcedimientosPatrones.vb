Imports System.Threading
Imports System.IO
Imports Microsoft.Office.Interop
Module CC_ProcedimientosPatrones

#Region "PATRONES"

    'ESTE PATRON APLICA PARA:
    'Seccion Estados Financieros - Estados Financieros
    'Seccion Estados Financieros - Estados Financieros Moneda
    'Seccion Indicadores Finanacieros - Indicadores Financieros
    'Seccion Colocaciones - EstratificacionDepDptoTotal
    'Seccion Colocaciones - EstratificacionDepEntidadTotal
    'Seccion Colocaciones - EstratificacionDepositos
    'Seccion de agencia, sucursales y numero de empleados - puntos de Atención Financiera por departamento
    'Seccion de agencia, sucursales y numero de empleados - sucursales y numero de empleados
    Public Sub editarArchivosPorPatron01(ExcelApp As Excel.Application, gestionIn As Long, gestionFn As Long, categoriaHojas As String, unirHojas As Boolean, enumerar As Boolean, igualarCampos As Boolean)
        Dim mes As Integer
        Dim gestion As Long
        Dim ruta As String
        Dim i As Integer
        Dim tipoEntidad(5) As String
        Dim tipoEntidad2(5) As String
        Dim ExcelWkBook As Excel.Workbook = Nothing

        Dim rutaHojaEnum As String
        Dim strEnmVrf As String
        Dim strEnm As String = Nothing
        Dim ExcelWkBookEnum As Excel.Workbook = Nothing
        Dim ExcelWkSheetEnum As Excel.Worksheet = Nothing

        Dim ExcelWkBookUnir As Excel.Workbook = Nothing
        Dim ExcelWkSheetUnir As Excel.Worksheet = Nothing
        Dim rutaHojaUnir As String
        Dim rutaCSV As String = Nothing
        Dim nHoja As String

        If enumerar Then
            nHoja = QuitarEspAcen(categoriaHojas)
            crearHojaParaEnum(ExcelApp, nHoja)
            rutaHojaEnum = $"{Directory.GetCurrentDirectory()}\ENUMERACIONES\ENUM_{nHoja}.xlsx"
            ExcelWkBookEnum = ExcelApp.Workbooks.Open(rutaHojaEnum)
            ExcelWkSheetEnum = ExcelWkBookEnum.Sheets("BBDD")

            registroEjecucion000_00("¿Que categoria deseas enumerar")
            registroEjecucion000_00("1 - ENUMERAR BBDD_MOD")
            registroEjecucion000_00("2 - ENUMERAR BBDD")
            strEnmVrf = UCase(Console.ReadLine())
            If strEnmVrf = "1" Then
                strEnm = "BBDD_MOD"
            Else
                strEnm = "BBDD"
            End If
        End If

        If unirHojas Then
            nHoja = QuitarEspAcen(categoriaHojas)
            crearHojaParaUnir(ExcelApp, nHoja)
            rutaHojaUnir = $"{Directory.GetCurrentDirectory()}\DATOS_ASFI\BBDD_{nHoja}.xlsx"
            rutaCSV = $"{Directory.GetCurrentDirectory()}\DATOS_ASFI\BBDD_{nHoja}.csv"
            ExcelWkBookUnir = ExcelApp.Workbooks.Open(rutaHojaUnir)
            ExcelWkSheetUnir = ExcelWkBookUnir.Sheets("BBDD")
        End If

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

        registroEjecucion000_00("###############################################################################")
        registroEjecucion000_00($"Hola que tal, empecemos con las hojas de calculo de {currentDirectory}...")
        registroEjecucion000_00($"Directorio raiz: {currentDirectory}")
        registroEjecucion000_00("###############################################################################")

        Thread.Sleep(3000)

        For gestion = gestionIn To gestionFn

            If Not enumerar And Not unirHojas Then
                registroEjecucion000_00($"¿Deseas ejecutar la gestion {gestion} de {categoriaHojas}?")
                ejecSec = UCase(Console.ReadLine())
            Else
                ejecSec = "SI"
            End If

            If ejecSec = "SI" Then

                For mes = 1 To 12

                    For i = 0 To UBound(tipoEntidad)

                        Try
                            If mes > 9 Then

                                ruta = currentDirectory & "\DATOS\sNOcbm\" & CStr(gestion) & "\" & CStr(mes) & "\" & tipoEntidad(i) & CStr(mes) & CStr(gestion - 2000) & "\" & CStr(gestion) & CStr(mes) & tipoEntidad2(i) & Replace(categoriaHojas, " ", "") & ".xls"

                                If My.Computer.FileSystem.FileExists(ruta) Then

                                    If Not unirHojas And Not enumerar And Not igualarCampos Then

                                        registroEjecucion000_00($"El directorio a trabajar: {currentDirectory}")
                                        registroEjecucion000_00($"El directorio excel a trabajar: {ruta}")
                                        registroEjecucion000_00($"Fecha EEFF: {gestion} / {mes}")

                                        registroEjecucion000_00("LLEGO AQUI 1")
                                        ExcelWkBook = ExcelApp.Workbooks.Open(ruta)
                                        ExcelWkBook.Activate()
                                        ExcelApp.ActiveWorkbook.ChangeFileAccess(Microsoft.Office.Interop.Excel.XlFileAccess.xlReadWrite)

                                        registroEjecucion000_00("LLEGO AQUI 2")

                                        cargarProcedimientoEdcion(ExcelWkBook, gestion, mes, i, categoriaHojas)

                                    End If

                                    If unirHojas And Not enumerar And Not igualarCampos Then

                                        registroEjecucion000_00($"El directorio a trabajar: {currentDirectory}")
                                        registroEjecucion000_00($"El directorio excel a trabajar: {ruta}")
                                        registroEjecucion000_00($"Fecha EEFF: {gestion} / {mes}")
                                        copiarDatosEntreHojas(ExcelApp.Workbooks.Open(ruta), ExcelWkSheetUnir)

                                    End If

                                    If enumerar And Not unirHojas And Not igualarCampos Then

                                        registroEjecucion000_00($"El directorio a trabajar: {currentDirectory}")
                                        registroEjecucion000_00($"El directorio excel a trabajar: {ruta}")
                                        registroEjecucion000_00($"Fecha EEFF: {gestion} / {mes}")
                                        enumerarFilasDelEstado(ExcelApp.Workbooks.Open(ruta), ExcelWkSheetEnum, gestion, mes, categoriaHojas, tipoEntidad(i), strEnm)

                                    End If

                                    If igualarCampos And Not enumerar And Not unirHojas Then

                                        registroEjecucion000_00($"El directorio a trabajar: {currentDirectory}")
                                        registroEjecucion000_00($"El directorio excel a trabajar: {ruta}")
                                        registroEjecucion000_00($"Fecha EEFF: {gestion} / {mes}")
                                        igualarCamposEstados(ExcelApp.Workbooks.Open(ruta), categoriaHojas)

                                    End If

                                End If

                            Else


                                ruta = currentDirectory & "\DATOS\scbm\" & CStr(gestion) & "\0" & CStr(mes) & "\" & tipoEntidad(i) & "0" & CStr(mes) & CStr(gestion - 2000) & "\" & CStr(gestion) & "0" & CStr(mes) & tipoEntidad2(i) & Replace(categoriaHojas, " ", "") & ".xls"


                                If My.Computer.FileSystem.FileExists(ruta) Then

                                    If Not unirHojas And Not enumerar And Not igualarCampos Then
                                        registroEjecucion000_00($"El directorio a trabajar: {currentDirectory}")
                                        registroEjecucion000_00($"El directorio excel a trabajar: {ruta}")
                                        registroEjecucion000_00($"Fecha EEFF: {gestion} / {mes}")

                                        registroEjecucion000_00("LLEGO AQUI 1")
                                        ExcelWkBook = ExcelApp.Workbooks.Open(ruta)

                                        registroEjecucion000_00("LLEGO AQUI 2")

                                        cargarProcedimientoEdcion(ExcelWkBook, gestion, mes, i, categoriaHojas)

                                    End If

                                    If unirHojas And Not enumerar And Not igualarCampos Then

                                        registroEjecucion000_00($"El directorio a trabajar: {currentDirectory}")
                                        registroEjecucion000_00($"El directorio excel a trabajar: {ruta}")
                                        registroEjecucion000_00($"Fecha EEFF: {gestion} / {mes}")
                                        copiarDatosEntreHojas(ExcelApp.Workbooks.Open(ruta), ExcelWkSheetUnir)

                                    End If

                                    If enumerar And Not unirHojas And Not igualarCampos Then
                                        registroEjecucion000_00($"El directorio a trabajar: {currentDirectory}")
                                        registroEjecucion000_00($"El directorio excel a trabajar: {ruta}")
                                        registroEjecucion000_00($"Fecha EEFF: {gestion} / {mes}")
                                        enumerarFilasDelEstado(ExcelApp.Workbooks.Open(ruta), ExcelWkSheetEnum, gestion, mes, categoriaHojas, tipoEntidad(i), strEnm)
                                    End If

                                    If igualarCampos And Not enumerar And Not unirHojas Then
                                        registroEjecucion000_00($"El directorio a trabajar: {currentDirectory}")
                                        registroEjecucion000_00($"El directorio excel a trabajar: {ruta}")
                                        registroEjecucion000_00($"Fecha EEFF: {gestion} / {mes}")
                                        igualarCamposEstados(ExcelApp.Workbooks.Open(ruta), categoriaHojas)
                                    End If

                                End If

                            End If


                        Catch ex As Exception

                            'If (ex.GetType == "System.Runtime.InteropServices.COMException") Then

                            'End If
                            registroEjecucion000_00($"ERROR: {ex.GetType}")
                            registroEjecucion000_00($"DESCRIPCION: {ex.Message}")
                            registroEjecucion000_00($"INNER_EXCEPTION: {ex.InnerException}")
                            registroEjecucion000_00($"STACK_TRACE: {ex.StackTrace}")
                            registroEjecucion000_00($"HELP_LINK: {ex.HelpLink}")
                            historialEjecucion.Flush()
                            historialEjecucion.Close()
                            ExcelApp.Quit()
                            Stop

                            Continue For

                        End Try

                    Next

                Next

            Else
                Continue For
            End If

        Next

        If enumerar Then
            ExcelWkSheetEnum.Activate()
            ExcelWkSheetEnum.Cells.EntireColumn.AutoFit()
            ExcelWkBookEnum.Save()
            ExcelWkBookEnum.Close()
        End If

        If unirHojas Then
            crearCSV(ExcelApp, ExcelWkBookUnir, rutaCSV)
            ExcelWkBookUnir.Save()
            ExcelWkBookUnir.Close()
        End If

        Thread.Sleep(3000)
        registroEjecucion000_00("###############################################################################")
        registroEjecucion000_00($"Se acabo con los archivos de {categoriaHojas}")
        registroEjecucion000_00("###############################################################################")
        Thread.Sleep(3000)

    End Sub

    'ESTE PATRON APLICA PARA:
    'Seccion Indicadores Financieros - Calificacion de cartera
    'Seccion Indicadores Financieros - Ponderacion de activos
    Public Sub editarArchivosPorPatron02(ByVal ExcelApp As Excel.Application, ByVal gestionIn As Long, ByVal gestionFn As Long, ByVal categoriaHojas As String, unirHojas As Boolean, enumerar As Boolean)
        Dim mes As Integer
        Dim gestion As Long
        Dim ruta As String
        Dim i As Integer
        Dim tipoEntidad(6) As String
        Dim tipoEntidad2(6) As String

        Dim rutaHojaEnum As String
        Dim strEnmVrf As String
        Dim strEnm As String = Nothing
        Dim ExcelWkBookEnum As Excel.Workbook = Nothing
        Dim ExcelWkSheetEnum As Excel.Worksheet = Nothing

        Dim ExcelWkBookUnir As Excel.Workbook = Nothing
        Dim ExcelWkSheetUnir As Excel.Worksheet = Nothing
        Dim rutaHojaUnir As String
        Dim rutaCSV As String = Nothing
        Dim nHoja As String

        If enumerar Then
            nHoja = QuitarEspAcen(categoriaHojas)
            crearHojaParaEnum(ExcelApp, nHoja)
            rutaHojaEnum = $"{Directory.GetCurrentDirectory()}\ENUMERACIONES\ENUM_{nHoja}.xlsx"
            ExcelWkBookEnum = ExcelApp.Workbooks.Open(rutaHojaEnum)
            ExcelWkSheetEnum = ExcelWkBookEnum.Sheets("BBDD")

            registroEjecucion000_00("¿Que categoria deseas enumerar")
            registroEjecucion000_00("1 - ENUMERAR BBDD_MOD")
            registroEjecucion000_00("2 - ENUMERAR BBDD")
            strEnmVrf = UCase(Console.ReadLine())
            If strEnmVrf = "1" Then
                strEnm = "BBDD_MOD"
            Else
                strEnm = "BBDD"
            End If
        End If

        If unirHojas Then
            nHoja = QuitarEspAcen(categoriaHojas)
            crearHojaParaUnir(ExcelApp, nHoja)
            rutaHojaUnir = $"{Directory.GetCurrentDirectory()}\DATOS_ASFI\BBDD_{nHoja}.xlsx"
            rutaCSV = $"{Directory.GetCurrentDirectory()}\DATOS_ASFI\BBDD_{nHoja}.csv"
            ExcelWkBookUnir = ExcelApp.Workbooks.Open(rutaHojaUnir)
            ExcelWkSheetUnir = ExcelWkBookUnir.Sheets("BBDD")
        End If

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

        registroEjecucion000_00("###############################################################################")
        registroEjecucion000_00($"Hola que tal, empecemos con las hojas de {categoriaHojas}...")
        registroEjecucion000_00($"Directorio raiz: {currentDirectory}")
        registroEjecucion000_00("###############################################################################")
        Thread.Sleep(3000)

        For gestion = gestionIn To gestionFn

            If Not enumerar And Not unirHojas Then
                registroEjecucion000_00($"¿Deseas ejecutar la gestion {gestion} de {categoriaHojas}?")
                ejecSec = UCase(Console.ReadLine())
            Else
                ejecSec = "SI"
            End If

            If ejecSec = "SI" Then

                For mes = 1 To 12

                    For i = 0 To UBound(tipoEntidad)

                        Try

                            If mes > 9 Then

                                If i = 4 Then
                                    ruta = currentDirectory & "\DATOS\scbm\" & CStr(gestion) & "\" & CStr(mes) & "\" & tipoEntidad(i) & CStr(mes) & CStr(gestion - 2000) & "\" & CStr(gestion) & CStr(mes) & tipoEntidad2(i) & Replace(categoriaHojas, " ", "") & "A.XLS"
                                ElseIf i = 5 Then
                                    ruta = currentDirectory & "\DATOS\scbm\" & CStr(gestion) & "\" & CStr(mes) & "\" & tipoEntidad(i) & CStr(mes) & CStr(gestion - 2000) & "\" & CStr(gestion) & CStr(mes) & tipoEntidad2(i) & Replace(categoriaHojas, " ", "") & "B.XLS"
                                Else
                                    ruta = currentDirectory & "\DATOS\scbm\" & CStr(gestion) & "\" & CStr(mes) & "\" & tipoEntidad(i) & CStr(mes) & CStr(gestion - 2000) & "\" & CStr(gestion) & CStr(mes) & tipoEntidad2(i) & Replace(categoriaHojas, " ", "") & ".XLS"
                                End If

                                If My.Computer.FileSystem.FileExists(ruta) Then

                                    If Not unirHojas And Not enumerar Then
                                        registroEjecucion000_00($"El directorio a trabajar: {currentDirectory}")
                                        registroEjecucion000_00($"El directorio excel a trabajar: {ruta}")
                                        cargarProcedimientoEdcion(ExcelApp.Workbooks.Open(ruta), gestion, mes, i, categoriaHojas)

                                    End If

                                    If unirHojas And Not enumerar Then

                                        registroEjecucion000_00($"El directorio a trabajar: {currentDirectory}")
                                        registroEjecucion000_00($"El directorio excel a trabajar: {ruta}")
                                        copiarDatosEntreHojas(ExcelApp.Workbooks.Open(ruta), ExcelWkSheetUnir)

                                    End If

                                    If enumerar And Not unirHojas Then
                                        registroEjecucion000_00($"El directorio a trabajar: {currentDirectory}")
                                        registroEjecucion000_00($"El directorio excel a trabajar: {ruta}")
                                        enumerarFilasDelEstado(ExcelApp.Workbooks.Open(ruta), ExcelWkSheetEnum, gestion, mes, categoriaHojas, tipoEntidad(i))
                                    End If

                                End If

                            Else

                                If i = 4 Then
                                    ruta = currentDirectory & "\DATOS\scbm\" & CStr(gestion) & "\0" & CStr(mes) & "\" & tipoEntidad(i) & "0" & CStr(mes) & CStr(gestion - 2000) & "\" & CStr(gestion) & "0" & CStr(mes) & tipoEntidad2(i) & Replace(categoriaHojas, " ", "") & "A.XLS"
                                ElseIf i = 5 Then
                                    ruta = currentDirectory & "\DATOS\scbm\" & CStr(gestion) & "\0" & CStr(mes) & "\" & tipoEntidad(i) & "0" & CStr(mes) & CStr(gestion - 2000) & "\" & CStr(gestion) & "0" & CStr(mes) & tipoEntidad2(i) & Replace(categoriaHojas, " ", "") & "B.XLS"
                                Else
                                    ruta = currentDirectory & "\DATOS\scbm\" & CStr(gestion) & "\0" & CStr(mes) & "\" & tipoEntidad(i) & "0" & CStr(mes) & CStr(gestion - 2000) & "\" & CStr(gestion) & "0" & CStr(mes) & tipoEntidad2(i) & Replace(categoriaHojas, " ", "") & ".XLS"
                                End If

                                If My.Computer.FileSystem.FileExists(ruta) Then

                                    If Not unirHojas And Not enumerar Then
                                        registroEjecucion000_00($"El directorio a trabajar: {currentDirectory}")
                                        registroEjecucion000_00($"El directorio excel a trabajar: {ruta}")
                                        cargarProcedimientoEdcion(ExcelApp.Workbooks.Open(ruta), gestion, mes, i, categoriaHojas)

                                    End If

                                    If unirHojas And Not enumerar Then

                                        registroEjecucion000_00($"El directorio a trabajar: {currentDirectory}")
                                        registroEjecucion000_00($"El directorio excel a trabajar: {ruta}")
                                        copiarDatosEntreHojas(ExcelApp.Workbooks.Open(ruta), ExcelWkSheetUnir)

                                    End If

                                    If enumerar And Not unirHojas Then
                                        registroEjecucion000_00($"El directorio a trabajar: {currentDirectory}")
                                        registroEjecucion000_00($"El directorio excel a trabajar: {ruta}")
                                        enumerarFilasDelEstado(ExcelApp.Workbooks.Open(ruta), ExcelWkSheetEnum, gestion, mes, categoriaHojas, tipoEntidad(i))
                                    End If

                                End If

                            End If

                        Catch ex As Exception

                            registroEjecucion000_00("ERROR: " & ex.Message)
                            Continue For

                        End Try

                    Next

                Next

            End If
        Next

        If enumerar Then
            ExcelWkSheetEnum.Activate()
            ExcelWkSheetEnum.Cells.EntireColumn.AutoFit()
            ExcelWkBookEnum.Save()
            ExcelWkBookEnum.Close()
        End If

        If unirHojas Then
            crearCSV(ExcelApp, ExcelWkBookUnir, rutaCSV)
            ExcelWkBookUnir.Save()
            ExcelWkBookUnir.Close()
        End If

        Thread.Sleep(3000)
        registroEjecucion000_00("###############################################################################")
        registroEjecucion000_00($"Se acabo con los archivos de {categoriaHojas}")
        registroEjecucion000_00("###############################################################################")
        Thread.Sleep(3000)

    End Sub

    'ESTE PATRON APLICA PARA:
    'Seccion Estados Financieros Desagregados
    Public Sub editarArchivosPorPatron03(ByVal ExcelApp As Excel.Application, ByVal gestionIn As Long, ByVal gestionFn As Long, ByVal categoriaHojas As String, unirHojas As Boolean, enumerar As Boolean)
        Dim mes As Integer
        Dim gestion As Long
        Dim ruta As String
        Dim i As Integer
        Dim tipoEntidad2(5) As String

        Dim rutaHojaEnum As String
        Dim strEnmVrf As String
        Dim strEnm As String = Nothing
        Dim ExcelWkBookEnum As Excel.Workbook = Nothing
        Dim ExcelWkSheetEnum As Excel.Worksheet = Nothing

        Dim ExcelWkBookUnir As Excel.Workbook = Nothing
        Dim ExcelWkSheetUnir As Excel.Worksheet = Nothing
        Dim rutaHojaUnir As String
        Dim rutaCSV As String = Nothing
        Dim nHoja As String

        If enumerar Then
            nHoja = QuitarEspAcen(categoriaHojas)
            crearHojaParaEnum(ExcelApp, nHoja)
            rutaHojaEnum = $"{Directory.GetCurrentDirectory()}\ENUMERACIONES\ENUM_{nHoja}.xlsx"
            ExcelWkBookEnum = ExcelApp.Workbooks.Open(rutaHojaEnum)
            ExcelWkSheetEnum = ExcelWkBookEnum.Sheets("BBDD")

            registroEjecucion000_00("¿Que categoria deseas enumerar")
            registroEjecucion000_00("1 - ENUMERAR BBDD_MOD")
            registroEjecucion000_00("2 - ENUMERAR BBDD")
            strEnmVrf = UCase(Console.ReadLine())
            If strEnmVrf = "1" Then
                strEnm = "BBDD_MOD"
            Else
                strEnm = "BBDD"
            End If
        End If

        If unirHojas Then
            nHoja = QuitarEspAcen(categoriaHojas)
            crearHojaParaUnir(ExcelApp, nHoja)
            rutaHojaUnir = $"{Directory.GetCurrentDirectory()}\DATOS_ASFI\BBDD_{nHoja}.xlsx"
            rutaCSV = $"{Directory.GetCurrentDirectory()}\DATOS_ASFI\BBDD_{nHoja}.csv"
            ExcelWkBookUnir = ExcelApp.Workbooks.Open(rutaHojaUnir)
            ExcelWkSheetUnir = ExcelWkBookUnir.Sheets("BBDD")
        End If

        tipoEntidad2(0) = "_BMU_"
        tipoEntidad2(1) = "_BPY_"
        tipoEntidad2(2) = "_BDR_"
        tipoEntidad2(3) = "_IFD_"
        tipoEntidad2(4) = "_COO_"
        tipoEntidad2(5) = "_EFV_"

        registroEjecucion000_00("###############################################################################")
        registroEjecucion000_00($"Hola que tal, empecemos con las hojas de calculo de {currentDirectory}...")
        registroEjecucion000_00($"Directorio raiz: {currentDirectory}")
        registroEjecucion000_00("###############################################################################")

        Thread.Sleep(3000)

        For gestion = gestionIn To gestionFn

            If Not enumerar And Not unirHojas Then
                registroEjecucion000_00($"¿Deseas ejecutar la gestion {gestion} de {categoriaHojas}?")
                ejecSec = UCase(Console.ReadLine())
            Else
                ejecSec = "SI"
            End If

            If ejecSec = "SI" Then

                For mes = 1 To 12

                    For i = 0 To UBound(tipoEntidad2)

                        Try
                            If mes > 9 Then

                                ruta = currentDirectory & "\DATOS\scbm\" & CStr(gestion) & "\" & CStr(mes) & "\Desagregados" & CStr(mes) & CStr(gestion - 2000) & "\" & CStr(gestion) & CStr(mes) & tipoEntidad2(i) & Replace(categoriaHojas, " ", "") & ".xls"

                                If My.Computer.FileSystem.FileExists(ruta) Then


                                    If Not unirHojas And Not enumerar Then
                                        registroEjecucion000_00($"El directorio a trabajar: {currentDirectory}")
                                        registroEjecucion000_00($"El directorio excel a trabajar: {ruta}")
                                        cargarProcedimientoEdcion(ExcelApp.Workbooks.Open(ruta), gestion, mes, i, categoriaHojas)

                                    End If

                                    If unirHojas And Not enumerar Then

                                        registroEjecucion000_00($"El directorio a trabajar: {currentDirectory}")
                                        registroEjecucion000_00($"El directorio excel a trabajar: {ruta}")
                                        copiarDatosEntreHojas(ExcelApp.Workbooks.Open(ruta), ExcelWkSheetUnir)

                                    End If

                                    If enumerar And Not unirHojas Then
                                        registroEjecucion000_00($"El directorio a trabajar: {currentDirectory}")
                                        registroEjecucion000_00($"El directorio excel a trabajar: {ruta}")
                                        enumerarFilasDelEstado(ExcelApp.Workbooks.Open(ruta), ExcelWkSheetEnum, gestion, mes, categoriaHojas, tipoEntidad2(i))
                                    End If

                                End If

                            Else


                                ruta = currentDirectory & "\DATOS\scbm\" & CStr(gestion) & "\0" & CStr(mes) & "\Desagregados0" & CStr(mes) & CStr(gestion - 2000) & "\" & CStr(gestion) & "0" & CStr(mes) & tipoEntidad2(i) & Replace(categoriaHojas, " ", "") & ".xls"


                                If My.Computer.FileSystem.FileExists(ruta) Then


                                    If Not unirHojas And Not enumerar Then
                                        registroEjecucion000_00($"El directorio a trabajar: {currentDirectory}")
                                        registroEjecucion000_00($"El directorio excel a trabajar: {ruta}")
                                        cargarProcedimientoEdcion(ExcelApp.Workbooks.Open(ruta), gestion, mes, i, categoriaHojas)

                                    End If

                                    If unirHojas And Not enumerar Then

                                        registroEjecucion000_00($"El directorio a trabajar: {currentDirectory}")
                                        registroEjecucion000_00($"El directorio excel a trabajar: {ruta}")
                                        copiarDatosEntreHojas(ExcelApp.Workbooks.Open(ruta), ExcelWkSheetUnir)

                                    End If

                                    If enumerar And Not unirHojas Then
                                        registroEjecucion000_00($"El directorio a trabajar: {currentDirectory}")
                                        registroEjecucion000_00($"El directorio excel a trabajar: {ruta}")
                                        enumerarFilasDelEstado(ExcelApp.Workbooks.Open(ruta), ExcelWkSheetEnum, gestion, mes, categoriaHojas, tipoEntidad2(i))
                                    End If

                                End If

                            End If

                        Catch ex As Exception

                            registroEjecucion000_00($"ERROR: {ex.Message}")
                            Continue For

                        End Try

                    Next

                Next

            End If

        Next

        If enumerar Then
            ExcelWkSheetEnum.Activate()
            ExcelWkSheetEnum.Cells.EntireColumn.AutoFit()
            ExcelWkBookEnum.Save()
            ExcelWkBookEnum.Close()
        End If

        If unirHojas Then
            crearCSV(ExcelApp, ExcelWkBookUnir, rutaCSV)
            ExcelWkBookUnir.Save()
            ExcelWkBookUnir.Close()
        End If

        Thread.Sleep(3000)
        registroEjecucion000_00("###############################################################################")
        registroEjecucion000_00($"Se acabo con los archivos de {categoriaHojas}")
        registroEjecucion000_00("###############################################################################")
        Thread.Sleep(3000)

    End Sub

    'ESTE PATRON APLICA PARA:
    'Seccion Captaciones - Encaje Legal
    Public Sub editarArchivosPorPatron04(ByVal ExcelApp As Excel.Application, ByVal gestionIn As Long, ByVal gestionFn As Long, ByVal categoriaHojas As String, unirHojas As Boolean, enumerar As Boolean)
        Dim mes As Integer
        Dim gestion As Long
        Dim ruta As String
        Dim i As Integer
        Dim tipoEntidad(2) As String
        Dim tipoEntidad2(2) As String

        Dim rutaHojaEnum As String
        Dim strEnmVrf As String
        Dim strEnm As String = Nothing
        Dim ExcelWkBookEnum As Excel.Workbook = Nothing
        Dim ExcelWkSheetEnum As Excel.Worksheet = Nothing

        Dim ExcelWkBookUnir As Excel.Workbook = Nothing
        Dim ExcelWkSheetUnir As Excel.Worksheet = Nothing
        Dim rutaHojaUnir As String
        Dim rutaCSV As String = Nothing
        Dim nHoja As String

        If enumerar Then
            nHoja = QuitarEspAcen(categoriaHojas)
            crearHojaParaEnum(ExcelApp, nHoja)
            rutaHojaEnum = $"{Directory.GetCurrentDirectory()}\ENUMERACIONES\ENUM_{nHoja}.xlsx"
            ExcelWkBookEnum = ExcelApp.Workbooks.Open(rutaHojaEnum)
            ExcelWkSheetEnum = ExcelWkBookEnum.Sheets("BBDD")

            registroEjecucion000_00("¿Que categoria deseas enumerar")
            registroEjecucion000_00("1 - ENUMERAR BBDD_MOD")
            registroEjecucion000_00("2 - ENUMERAR BBDD")
            strEnmVrf = UCase(Console.ReadLine())
            If strEnmVrf = "1" Then
                strEnm = "BBDD_MOD"
            Else
                strEnm = "BBDD"
            End If
        End If

        If unirHojas Then
            nHoja = QuitarEspAcen(categoriaHojas)
            crearHojaParaUnir(ExcelApp, nHoja)
            rutaHojaUnir = $"{Directory.GetCurrentDirectory()}\DATOS_ASFI\BBDD_{nHoja}.xlsx"
            rutaCSV = $"{Directory.GetCurrentDirectory()}\DATOS_ASFI\BBDD_{nHoja}.csv"
            ExcelWkBookUnir = ExcelApp.Workbooks.Open(rutaHojaUnir)
            ExcelWkSheetUnir = ExcelWkBookUnir.Sheets("BBDD")
        End If

        tipoEntidad(0) = "BcosMultiples"
        tipoEntidad(1) = "BcosPYME"
        tipoEntidad(2) = "Nobancos"

        tipoEntidad2(0) = "_BMU_"
        tipoEntidad2(1) = "_BPY_"
        tipoEntidad2(2) = "_SNB_"

        registroEjecucion000_00("###############################################################################")
        registroEjecucion000_00($"Hola que tal, empecemos con las hojas de calculo de {currentDirectory}...")
        registroEjecucion000_00($"Directorio raiz: {currentDirectory}")
        registroEjecucion000_00("###############################################################################")

        Thread.Sleep(3000)

        For gestion = gestionIn To gestionFn

            If Not enumerar And Not unirHojas Then
                registroEjecucion000_00($"¿Deseas ejecutar la gestion {gestion} de {categoriaHojas}?")
                ejecSec = UCase(Console.ReadLine())
            Else
                ejecSec = "SI"
            End If

            If ejecSec = "SI" Then

                For mes = 1 To 12

                    For i = 0 To UBound(tipoEntidad)

                        Try
                            If mes > 9 Then

                                ruta = currentDirectory & "\DATOS\scbm\" & CStr(gestion) & "\" & CStr(mes) & "\" & tipoEntidad(i) & CStr(mes) & CStr(gestion - 2000) & "\" & CStr(gestion) & CStr(mes) & tipoEntidad2(i) & Replace(categoriaHojas, " ", "") & ".xls"

                                If My.Computer.FileSystem.FileExists(ruta) Then


                                    If Not unirHojas And Not enumerar Then
                                        registroEjecucion000_00($"El directorio a trabajar: {currentDirectory}")
                                        registroEjecucion000_00($"El directorio excel a trabajar: {ruta}")
                                        cargarProcedimientoEdcion(ExcelApp.Workbooks.Open(ruta), gestion, mes, i, categoriaHojas)

                                    End If

                                    If unirHojas And Not enumerar Then

                                        registroEjecucion000_00($"El directorio a trabajar: {currentDirectory}")
                                        registroEjecucion000_00($"El directorio excel a trabajar: {ruta}")
                                        copiarDatosEntreHojas(ExcelApp.Workbooks.Open(ruta), ExcelWkSheetUnir)

                                    End If

                                    If enumerar And Not unirHojas Then
                                        registroEjecucion000_00($"El directorio a trabajar: {currentDirectory}")
                                        registroEjecucion000_00($"El directorio excel a trabajar: {ruta}")
                                        enumerarFilasDelEstado(ExcelApp.Workbooks.Open(ruta), ExcelWkSheetEnum, gestion, mes, categoriaHojas, tipoEntidad(i))
                                    End If

                                End If

                            Else

                                ruta = currentDirectory & "\DATOS\scbm\" & CStr(gestion) & "\0" & CStr(mes) & "\" & tipoEntidad(i) & "0" & CStr(mes) & CStr(gestion - 2000) & "\" & CStr(gestion) & "0" & CStr(mes) & tipoEntidad2(i) & Replace(categoriaHojas, " ", "") & ".xls"

                                If My.Computer.FileSystem.FileExists(ruta) Then


                                    If Not unirHojas And Not enumerar Then
                                        registroEjecucion000_00($"El directorio a trabajar: {currentDirectory}")
                                        registroEjecucion000_00($"El directorio excel a trabajar: {ruta}")
                                        cargarProcedimientoEdcion(ExcelApp.Workbooks.Open(ruta), gestion, mes, i, categoriaHojas)

                                    End If

                                    If unirHojas And Not enumerar Then

                                        registroEjecucion000_00($"El directorio a trabajar: {currentDirectory}")
                                        registroEjecucion000_00($"El directorio excel a trabajar: {ruta}")
                                        copiarDatosEntreHojas(ExcelApp.Workbooks.Open(ruta), ExcelWkSheetUnir)

                                    End If

                                    If enumerar And Not unirHojas Then
                                        registroEjecucion000_00($"El directorio a trabajar: {currentDirectory}")
                                        registroEjecucion000_00($"El directorio excel a trabajar: {ruta}")
                                        enumerarFilasDelEstado(ExcelApp.Workbooks.Open(ruta), ExcelWkSheetEnum, gestion, mes, categoriaHojas, tipoEntidad(i))
                                    End If

                                End If

                            End If

                        Catch ex As Exception

                            registroEjecucion000_00($"ERROR: {ex.Message}")
                            Continue For

                        End Try

                    Next

                Next

            End If

        Next

        If enumerar Then
            ExcelWkSheetEnum.Activate()
            ExcelWkSheetEnum.Cells.EntireColumn.AutoFit()
            ExcelWkBookEnum.Save()
            ExcelWkBookEnum.Close()
        End If

        If unirHojas Then
            crearCSV(ExcelApp, ExcelWkBookUnir, rutaCSV)
            ExcelWkBookUnir.Save()
            ExcelWkBookUnir.Close()
        End If

        Thread.Sleep(3000)
        registroEjecucion000_00("###############################################################################")
        registroEjecucion000_00($"Se acabo con los archivos de {categoriaHojas}")
        registroEjecucion000_00("###############################################################################")
        Thread.Sleep(3000)

    End Sub

    'ESTE PATRON APLICA PARA:
    'Seccion Captaciones - Ranking Depositos Publico
    Public Sub editarArchivosPorPatron05(ByVal ExcelApp As Excel.Application, ByVal gestionIn As Long, ByVal gestionFn As Long, ByVal categoriaHojas As String, unirHojas As Boolean, enumerar As Boolean)
        Dim mes As Integer
        Dim gestion As Long
        Dim ruta As String
        Dim i As Integer
        Dim tipoEntidad(11) As String
        Dim tipoEntidad2(11) As String

        Dim rutaHojaEnum As String
        Dim strEnmVrf As String
        Dim strEnm As String = Nothing
        Dim ExcelWkBookEnum As Excel.Workbook = Nothing
        Dim ExcelWkSheetEnum As Excel.Worksheet = Nothing

        Dim ExcelWkBookUnir As Excel.Workbook = Nothing
        Dim ExcelWkSheetUnir As Excel.Worksheet = Nothing
        Dim rutaHojaUnir As String
        Dim rutaCSV As String = Nothing
        Dim nHoja As String

        If enumerar Then
            nHoja = QuitarEspAcen(categoriaHojas)
            crearHojaParaEnum(ExcelApp, nHoja)
            rutaHojaEnum = $"{Directory.GetCurrentDirectory()}\ENUMERACIONES\ENUM_{nHoja}.xlsx"
            ExcelWkBookEnum = ExcelApp.Workbooks.Open(rutaHojaEnum)
            ExcelWkSheetEnum = ExcelWkBookEnum.Sheets("BBDD")

            registroEjecucion000_00("¿Que categoria deseas enumerar")
            registroEjecucion000_00("1 - ENUMERAR BBDD_MOD")
            registroEjecucion000_00("2 - ENUMERAR BBDD")
            strEnmVrf = UCase(Console.ReadLine())
            If strEnmVrf = "1" Then
                strEnm = "BBDD_MOD"
            Else
                strEnm = "BBDD"
            End If
        End If

        If unirHojas Then
            nHoja = QuitarEspAcen(categoriaHojas)
            crearHojaParaUnir(ExcelApp, nHoja)
            rutaHojaUnir = $"{Directory.GetCurrentDirectory()}\DATOS_ASFI\BBDD_{nHoja}.xlsx"
            rutaCSV = $"{Directory.GetCurrentDirectory()}\DATOS_ASFI\BBDD_{nHoja}.csv"
            ExcelWkBookUnir = ExcelApp.Workbooks.Open(rutaHojaUnir)
            ExcelWkSheetUnir = ExcelWkBookUnir.Sheets("BBDD")
        End If

        tipoEntidad(0) = "BcosMultiples"
        tipoEntidad(1) = "BcosPYME"
        tipoEntidad(2) = "BDR"
        tipoEntidad(3) = "IFD"
        tipoEntidad(4) = "Nobancos"
        tipoEntidad(5) = "Nobancos"
        tipoEntidad(6) = "BcosMultiples"
        tipoEntidad(7) = "BcosPYME"
        tipoEntidad(8) = "BDR"
        tipoEntidad(9) = "IFD"
        tipoEntidad(10) = "Nobancos"
        tipoEntidad(11) = "Nobancos"

        tipoEntidad2(0) = "_BMU_"
        tipoEntidad2(1) = "_BPY_"
        tipoEntidad2(2) = "_BDR_"
        tipoEntidad2(3) = "_IFD_"
        tipoEntidad2(4) = "_COO_"
        tipoEntidad2(5) = "_EFV_"
        tipoEntidad2(6) = "_SIS2_"
        tipoEntidad2(7) = "_SIS2_"
        tipoEntidad2(8) = "_SIS2_"
        tipoEntidad2(9) = "_SIS2_"
        tipoEntidad2(10) = "_SIS2_"
        tipoEntidad2(11) = "_SIS2_"

        registroEjecucion000_00("###############################################################################")
        registroEjecucion000_00($"Hola que tal, empecemos con las hojas de calculo de {currentDirectory}...")
        registroEjecucion000_00($"Directorio raiz: {currentDirectory}")
        registroEjecucion000_00("###############################################################################")

        Thread.Sleep(3000)

        For gestion = gestionIn To gestionFn

            If Not enumerar And Not unirHojas Then
                registroEjecucion000_00($"¿Deseas ejecutar la gestion {gestion} de {categoriaHojas}?")
                ejecSec = UCase(Console.ReadLine())
            Else
                ejecSec = "SI"
            End If

            If ejecSec = "SI" Then

                For mes = 1 To 12

                    For i = 0 To UBound(tipoEntidad)

                        Try
                            If mes > 9 Then

                                ruta = currentDirectory & "\DATOS\scbm\" & CStr(gestion) & "\" & CStr(mes) & "\" & tipoEntidad(i) & CStr(mes) & CStr(gestion - 2000) & "\" & CStr(gestion) & CStr(mes) & tipoEntidad2(i) & Replace(categoriaHojas, " ", "") & ".xls"

                                If My.Computer.FileSystem.FileExists(ruta) Then

                                    If Not unirHojas And Not enumerar Then
                                        registroEjecucion000_00($"El directorio a trabajar: {currentDirectory}")
                                        registroEjecucion000_00($"El directorio excel a trabajar: {ruta}")
                                        cargarProcedimientoEdcion(ExcelApp.Workbooks.Open(ruta), gestion, mes, i, categoriaHojas)

                                    End If

                                    If unirHojas And Not enumerar Then

                                        registroEjecucion000_00($"El directorio a trabajar: {currentDirectory}")
                                        registroEjecucion000_00($"El directorio excel a trabajar: {ruta}")
                                        copiarDatosEntreHojas(ExcelApp.Workbooks.Open(ruta), ExcelWkSheetUnir)

                                    End If

                                    If enumerar And Not unirHojas Then
                                        registroEjecucion000_00($"El directorio a trabajar: {currentDirectory}")
                                        registroEjecucion000_00($"El directorio excel a trabajar: {ruta}")
                                        enumerarFilasDelEstado(ExcelApp.Workbooks.Open(ruta), ExcelWkSheetEnum, gestion, mes, categoriaHojas, tipoEntidad(i))
                                    End If

                                End If

                            Else

                                ruta = currentDirectory & "\DATOS\scbm\" & CStr(gestion) & "\0" & CStr(mes) & "\" & tipoEntidad(i) & "0" & CStr(mes) & CStr(gestion - 2000) & "\" & CStr(gestion) & "0" & CStr(mes) & tipoEntidad2(i) & Replace(categoriaHojas, " ", "") & ".xls"

                                If My.Computer.FileSystem.FileExists(ruta) Then


                                    If Not unirHojas And Not enumerar Then
                                        registroEjecucion000_00($"El directorio a trabajar: {currentDirectory}")
                                        registroEjecucion000_00($"El directorio excel a trabajar: {ruta}")
                                        cargarProcedimientoEdcion(ExcelApp.Workbooks.Open(ruta), gestion, mes, i, categoriaHojas)

                                    End If

                                    If unirHojas And Not enumerar Then

                                        registroEjecucion000_00($"El directorio a trabajar: {currentDirectory}")
                                        registroEjecucion000_00($"El directorio excel a trabajar: {ruta}")
                                        copiarDatosEntreHojas(ExcelApp.Workbooks.Open(ruta), ExcelWkSheetUnir)

                                    End If

                                    If enumerar And Not unirHojas Then
                                        registroEjecucion000_00($"El directorio a trabajar: {currentDirectory}")
                                        registroEjecucion000_00($"El directorio excel a trabajar: {ruta}")
                                        enumerarFilasDelEstado(ExcelApp.Workbooks.Open(ruta), ExcelWkSheetEnum, gestion, mes, categoriaHojas, tipoEntidad(i))
                                    End If

                                End If

                            End If

                        Catch ex As Exception

                            registroEjecucion000_00($"ERROR: {ex.Message}")
                            Continue For

                        End Try

                    Next

                Next

            End If

        Next

        If enumerar Then
            ExcelWkSheetEnum.Activate()
            ExcelWkSheetEnum.Cells.EntireColumn.AutoFit()
            ExcelWkBookEnum.Save()
            ExcelWkBookEnum.Close()
        End If

        If unirHojas Then
            crearCSV(ExcelApp, ExcelWkBookUnir, rutaCSV)
            ExcelWkBookUnir.Save()
            ExcelWkBookUnir.Close()
        End If

        Thread.Sleep(3000)
        registroEjecucion000_00("###############################################################################")
        registroEjecucion000_00($"Se acabo con los archivos de {categoriaHojas}")
        registroEjecucion000_00("###############################################################################")
        Thread.Sleep(3000)

    End Sub

#End Region

End Module
