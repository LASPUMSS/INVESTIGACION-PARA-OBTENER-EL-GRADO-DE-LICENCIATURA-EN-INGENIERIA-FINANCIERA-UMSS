Imports System.Text.RegularExpressions
Imports Microsoft.Office.Interop
Module ZZ_FuncionesExtras
    ''' <summary>
    ''' Descripcion
    ''' </summary>
    ''' <param name="ExcelWkBook"> Libro excel</param>
    ''' <returns></returns>
    Public Function hojaConCamposAgregados(ExcelWkBook As Excel.Workbook) As Excel.Worksheet
        Dim strEval As String
        Dim nombreHojaDatos As String
        Dim ExcelWkSheet As Excel.Worksheet

        'VERIFICAR SI LA BBDD EXISTE Y CREAR OTRA NUEVA
        Try
            ExcelWkBook.Sheets("BBDD_MOD").Delete()
            registroEjecucion000_00("Se elimino la hoja BBDD_MOD para crear una nueva...")
        Catch ex As Exception
            registroEjecucion000_00("El libro BBDD_MOD no existe, asi que se creara uno...")
        End Try

        'ENCONTRAR Y COPIAR LA HOJA DE DATOS

        ExcelWkSheet = ExcelWkBook.Sheets("BBDD")
        nombreHojaDatos = ExcelWkSheet.Name
        ExcelWkSheet.Select()
        ExcelWkSheet.Copy(Before:=ExcelWkBook.Sheets(1))


        'ENCONTRAR LA COPIA DE LA HOJA DE DATOS
        For i = 1 To ExcelWkBook.Sheets.Count
            If TypeName(ExcelWkBook.Sheets(i)) = "Worksheet" And ExcelWkBook.Sheets(i).Name <> nombreHojaDatos Then
                strEval = If(CStr(ExcelWkBook.Sheets(i).Cells(1, 1).Value) <> "",
                            QuitarEspAcen(CStr(ExcelWkBook.Sheets(i).Cells(1, 1).Value)),
                            "")
                If strEval = "ID" Then
                    registroEjecucion000_00($"La hoja con los datos es: {ExcelWkBook.Sheets(i).Name}")
                    ExcelWkSheet = ExcelWkBook.Sheets(i)
                    ExcelWkSheet.Name = "BBDD_MOD"
                    Exit For
                End If
            End If
        Next

        Return ExcelWkSheet

    End Function

    ''' <summary>
    ''' <para>Esta función devuelve la hoja donde se encuentra la copia EEFF.</para>
    ''' <para>Primero elimina las hojas BBDD y BBDD_MOD si existen.</para>
    ''' <para>Segundo busca la hoja que conitne los EEFF, usando como patron la celda el valor de activo.</para>
    ''' <para>Tercero copia y devuelve dicha hoja con los EEFF's copiados.</para>
    ''' </summary>
    ''' <param name="ExcelWkBook">Libro de excel donde se encuentra los EEFF.</param>
    ''' <param name="txt">El texto que se utilizara como patron para encontrar la hoja con los EEFF.</param>
    Public Function hojaDeDatos(ExcelWkBook As Excel.Workbook, txt As String) As Excel.Worksheet
        Dim strEval As String
        Dim nombreHojaDatos As String = "xxxxxxxxxxxxxxx"
        Dim done As Boolean
        Dim ExcelWkSheet As Excel.Worksheet = Nothing

        Dim rowIn As Integer = 1
        Dim rowFn As Long = 5000
        Dim colIn As Integer = 1
        Dim colFn As Long = 50

        'VERIFICAR SI LA BBDD EXISTE Y CREAR OTRA NUEVA
        Try
            ExcelWkBook.Sheets("BBDD").Delete()
            registroEjecucion000_00("Se elimino la hoja BBDD para crear una nueva...")
        Catch ex As Exception
            registroEjecucion000_00("El libro BBDD no existe, asi que se creara uno...")
        End Try

        'VERIFICAR SI LA BBDD_MOD EXISTE Y CREAR OTRA NUEVA
        Try
            ExcelWkBook.Sheets("BBDD_MOD").Delete()
            registroEjecucion000_00("Se elimino la hoja BBDD_MOD para crear una nueva...")
        Catch ex As Exception
            registroEjecucion000_00("El libro BBDD_MOD no existe, pero en esta seccion no implica un problema")
        End Try

        'ENCONTRAR Y COPIAR LA HOJA DE DATOS
        For i = 1 To ExcelWkBook.Sheets.Count
            If TypeName(ExcelWkBook.Sheets(i)) = "Worksheet" Then
                ExcelWkSheet = ExcelWkBook.Sheets(i)

                For Each celda As Excel.Range In ExcelWkBook.Sheets(i).Range(ExcelWkSheet.Cells(rowIn, colIn),
                                                                             ExcelWkSheet.Cells(rowFn, colFn))

                    strEval = If(CStr(celda.Value) <> "", QuitarEspAcen(CStr(celda.Value)), "")
                    If strEval = txt Then
                        nombreHojaDatos = ExcelWkSheet.Name
                        ExcelWkSheet.Select()
                        ExcelWkSheet.Copy(Before:=ExcelWkBook.Sheets(1))
                        done = True
                        Exit For
                    End If
                Next
                If done Then Exit For
            End If
        Next

        'ENCONTRAR LA COPIA DE LA HOJA DE DATOS
        For i = 1 To ExcelWkBook.Sheets.Count
            If TypeName(ExcelWkBook.Sheets(i)) = "Worksheet" And ExcelWkBook.Sheets(i).Name <> nombreHojaDatos Then

                ExcelWkSheet = ExcelWkBook.Sheets(i)

                For Each celda As Excel.Range In ExcelWkBook.Sheets(i).Range(ExcelWkSheet.Cells(rowIn, colIn),
                                                                             ExcelWkSheet.Cells(rowFn, colFn))

                    strEval = If(CStr(celda.Value) <> "", QuitarEspAcen(CStr(celda.Value)), "")
                    If strEval = txt Then
                        registroEjecucion000_00($"La hoja con los datos es: {ExcelWkBook.Sheets(i).Name}")
                        ExcelWkSheet.Name = "BBDD"
                        done = True
                        Exit For
                    End If
                Next
                If done Then
                    registroEjecucion000_00("se encontro la hoja")
                    Exit For
                End If
            End If
        Next

        Return ExcelWkSheet

    End Function

    ''' <summary>
    ''' <para>Esta función devuelve la hoja donde se encuentra la copia EEFF.</para>
    ''' <para>Primero elimina las hojas BBDD y BBDD_MOD si existen.</para>
    ''' <para>Segundo busca la hoja que conitne los EEFF, usando como patron la celda el valor de activo.</para>
    ''' <para>Tercero copia y devuelve dicha hoja con los EEFF's copiados.</para>
    ''' </summary>
    ''' <param name="ExcelWkBook">Libro de excel donde se encuentra los EEFF.</param>
    ''' <param name="txt">El texto que se utilizara como patron para encontrar la hoja con los EEFF.</param>
    Public Function hojaDeDatosV2(ExcelWkBook As Excel.Workbook, txt As String, txtNamesSheet As Object) As Excel.Worksheet
        Dim strEval As String
        Dim nombreHojaDatos As String = "xxxxxxxxxxxxxxx"
        Dim done As Boolean
        Dim ExcelWkSheet As Excel.Worksheet = Nothing

        Dim rowIn As Integer = 1
        Dim rowFn As Long = 5000
        Dim colIn As Integer = 1
        Dim colFn As Long = 50

        Dim verfEncotrarHojaPorNombre As Boolean = False

        'VERIFICAR SI LA BBDD EXISTE Y CREAR OTRA NUEVA
        Try
            ExcelWkBook.Sheets("BBDD").Delete()
            registroEjecucion000_00("Se elimino la hoja BBDD para crear una nueva...")
        Catch ex As Exception
            registroEjecucion000_00("El libro BBDD no existe, asi que se creara uno...")
        End Try

        'VERIFICAR SI LA BBDD_MOD EXISTE Y CREAR OTRA NUEVA
        Try
            ExcelWkBook.Sheets("BBDD_MOD").Delete()
            registroEjecucion000_00("Se elimino la hoja BBDD_MOD para crear una nueva...")
        Catch ex As Exception
            registroEjecucion000_00("El libro BBDD_MOD no existe, pero en esta seccion no implica un problema")
        End Try

        'ENCONTRAR Y COPIAR LA HOJA DE DATOS
        For Each item In txtNamesSheet

            Try
                ExcelWkSheet = ExcelWkBook.Sheets(item)

                nombreHojaDatos = ExcelWkSheet.Name
                ExcelWkSheet.Select()
                ExcelWkSheet.Copy(After:=ExcelWkBook.Sheets(ExcelWkBook.Sheets.Count))

                verfEncotrarHojaPorNombre = True
                registroEjecucion000_00($"Se encontro hoja datos por {nombreHojaDatos}")
                Try
                    ExcelWkBook.Sheets(ExcelWkBook.Sheets.Count).Name = "BBDD"
                Catch ex As Exception
                    registroEjecucion000_00("No se encontro la copia")
                End Try

                If verfEncotrarHojaPorNombre Then Exit For

            Catch ex As Exception
                registroEjecucion000_00($"No se encontro por {item}")
            End Try


        Next item


        If verfEncotrarHojaPorNombre = False Then

            registroEjecucion000_00("Se realiza la busqueda exhaustiva.....")

            For i = 1 To ExcelWkBook.Sheets.Count
                If TypeName(ExcelWkBook.Sheets(i)) = "Worksheet" Then
                    ExcelWkSheet = ExcelWkBook.Sheets(i)

                    For Each celda As Excel.Range In ExcelWkBook.Sheets(i).Range(ExcelWkSheet.Cells(rowIn, colIn),
                                                                                 ExcelWkSheet.Cells(rowFn, colFn))

                        strEval = If(CStr(celda.Value) <> "", QuitarEspAcen(CStr(celda.Value)), "")
                        If strEval = txt Then
                            nombreHojaDatos = ExcelWkSheet.Name
                            ExcelWkSheet.Select()
                            ExcelWkSheet.Copy(After:=ExcelWkBook.Sheets(ExcelWkBook.Sheets.Count))
                            done = True
                            registroEjecucion000_00($"Se encontro hoja datos por exhaustivo {nombreHojaDatos}")
                            Exit For
                        End If
                    Next
                    If done Then Exit For
                End If
            Next

            'ENCONTRAR LA COPIA DE LA HOJA DE DATOS
            Try
                ExcelWkBook.Sheets(ExcelWkBook.Sheets.Count).Name = "BBDD"
                registroEjecucion000_00("Se encontro la copia de hoja datos BBDD")
            Catch ex As Exception
                registroEjecucion000_00("No se encontro la copia")
            End Try

        End If

        'COPIA DE LA HOJA DE DATOS
        ExcelWkSheet = ExcelWkBook.Sheets(ExcelWkBook.Sheets.Count)

        Return ExcelWkSheet

    End Function


    ''' <summary>
    ''' <para>Esta función devuelve un celda donde se encuentra el titulo del primer entidad financiera.</para>
    ''' </summary>
    ''' <param name="ExcelWkSheet"> Hoja excel "BBDD" que contiene el EEFF</param>
    ''' <param name="txt">El texto que se utilizara para encontrar la celda de referencia.</param>
    ''' <param name="nCol">La columna en donde se encontrar el texto de celda de referencia.</param>
    ''' <returns>Una celda tipo "Excel.Range".</returns>
    Public Function celdaTiBn(ExcelWkSheet As Excel.Worksheet, txt As String, Optional ByVal nCol As Long = 1) As Excel.Range
        Dim strEval As String
        Dim celReferencia As Excel.Range = ExcelWkSheet.Cells(ExcelWkSheet.Rows.Count, 1)
        Dim CelResultado As Excel.Range = ExcelWkSheet.Cells(ExcelWkSheet.Rows.Count, 1)

        Dim rowIn As Integer = 1
        Dim rowFn As Long = 5000
        Dim colIn As Integer = 1
        Dim colFn As Long = 50


        'ENCONTRAR CELDA DE REFERENCIA
        For Each celda As Excel.Range In ExcelWkSheet.Range(ExcelWkSheet.Cells(rowIn, colIn),
                                                            ExcelWkSheet.Cells(rowFn, colFn))
            strEval = If(CStr(celda.Value) <> "", QuitarEspAcen(CStr(celda.Value)), "")
            If strEval = txt Then
                celReferencia = celda
                Exit For
            End If
        Next

        'ENCONTRAR LA CELDA DE TITULOS
        For i = celReferencia.Row - 1 To 1 Step -1
            strEval = If(CStr(ExcelWkSheet.Cells(i, nCol).Offset(0, 1).Value) <> "",
                        QuitarEspAcen(CStr(ExcelWkSheet.Cells(i, 1).Offset(0, nCol).Value)),
                        "")

            If strEval <> "" Then
                CelResultado = ExcelWkSheet.Cells(i, nCol).Offset(0, 1)
                Exit For
            End If

        Next

        Return CelResultado

    End Function

    ''' <summary>
    ''' <para>Esta función devuelve un celda donde se encuentra la unidad en la que esta expresada el EEFF.</para>
    ''' </summary>
    ''' <param name="ExcelWkSheet">Hoja excel "BBDD" que contiene el EEFF</param>
    ''' <param name="txt">El texto que se utilizara para encontrar la celda de referencia, por defecto es "ACTIVO".</param>
    ''' <param name="nCol">La columna en donde se encontrar el texto de celda de referencia.</param>
    ''' <returns>Una celda tipo "Excel.Range".</returns>
    Public Function encontrarCeldaExpresado(ExcelWkSheet As Excel.Worksheet, Optional ByVal txt As String = "ACTIVO", Optional ByVal nCol As Long = 1) As Excel.Range
        Dim strEval As String
        Dim celReferencia As Excel.Range = ExcelWkSheet.Cells(ExcelWkSheet.Rows.Count, 1)
        Dim CelTitulos As Excel.Range = ExcelWkSheet.Cells(ExcelWkSheet.Rows.Count, 1)
        Dim CelResultado As Excel.Range = ExcelWkSheet.Cells(ExcelWkSheet.Rows.Count, 1)

        Dim rowIn As Integer = 1
        Dim rowFn As Long = 5000
        Dim colIn As Integer = 1
        Dim colFn As Long = 50

        'ENCONTRAR CELDA DE REFERENCIA
        For Each celda As Excel.Range In ExcelWkSheet.Range(ExcelWkSheet.Cells(rowIn, colIn),
                                                            ExcelWkSheet.Cells(rowFn, colFn))
            strEval = If(CStr(celda.Value) <> "", QuitarEspAcen(CStr(celda.Value)), "")
            If strEval = txt Then
                celReferencia = celda
                Exit For
            End If
        Next

        'ENCONTRAR LA CELDA DE TITULOS
        For i = celReferencia.Row - 1 To 1 Step -1
            strEval = If(CStr(ExcelWkSheet.Cells(i, nCol).Offset(0, 1).Value) <> "",
                        QuitarEspAcen(CStr(ExcelWkSheet.Cells(i, 1).Offset(0, nCol).Value)),
                        "")

            If strEval <> "" Then
                CelTitulos = ExcelWkSheet.Cells(i, nCol).Offset(0, 1)
                Exit For
            End If

        Next

        'ENCONTRAR EXPRESADO
        For i = CelTitulos.Row - 1 To 1 Step -1
            strEval = If(CStr(ExcelWkSheet.Cells(i, nCol).Value) <> "",
                        QuitarEspAcen(CStr(ExcelWkSheet.Cells(i, nCol).Value)),
                        "")

            If strEval <> "" Then
                CelResultado = ExcelWkSheet.Cells(i, nCol)
                Exit For
            End If

        Next

        Return CelResultado

    End Function

    ''' <summary>
    ''' <para>Devuelve el ultimo dia del mes en función del si es bisiesto o no.</para>
    ''' </summary>
    ''' <param name="gestion">Gestion</param>
    ''' <param name="mes">Mes del cual se quire saber el ultimo dia del mes.</param>
    ''' <returns>El ultimo dia del mes, tipo de datos "Integer".</returns>
    Public Function NumeroDiasMes(ByVal gestion As Long, ByVal mes As Integer) As Integer
        Dim diasMes As Integer
        Dim i2 As Integer

        Dim diasMesGestionNor(11) As Integer
        Dim diasMesGestionBi(11) As Integer

        diasMesGestionNor(0) = 31
        diasMesGestionNor(1) = 28
        diasMesGestionNor(2) = 31
        diasMesGestionNor(3) = 30
        diasMesGestionNor(4) = 31
        diasMesGestionNor(5) = 30
        diasMesGestionNor(6) = 31
        diasMesGestionNor(7) = 31
        diasMesGestionNor(8) = 30
        diasMesGestionNor(9) = 31
        diasMesGestionNor(10) = 30
        diasMesGestionNor(11) = 31

        diasMesGestionBi(0) = 31
        diasMesGestionBi(1) = 29
        diasMesGestionBi(2) = 31
        diasMesGestionBi(3) = 30
        diasMesGestionBi(4) = 31
        diasMesGestionBi(5) = 30
        diasMesGestionBi(6) = 31
        diasMesGestionBi(7) = 31
        diasMesGestionBi(8) = 30
        diasMesGestionBi(9) = 31
        diasMesGestionBi(10) = 30
        diasMesGestionBi(11) = 31


        If (gestion Mod 4) = 0 Then
            'AÑO BICIESTO
            For i2 = 1 To 12
                If mes = i2 Then

                    diasMes = diasMesGestionBi(mes - 1)

                End If

            Next

        Else
            'AÑO NO BICIESTO
            For i2 = 1 To 12
                If mes = i2 Then

                    diasMes = diasMesGestionNor(mes - 1)

                End If

            Next


        End If

        Return diasMes

    End Function

    Public Function QuitarEspAcen(ByVal textoEntrada As String) As String
        Dim vocales(4) As String
        Dim vocales2(4) As String
        Dim vocalesRpt(4) As String
        Dim vocales2Rpt(4) As String
        Dim resultado As String
        Dim i As Integer

        resultado = textoEntrada

        vocales(0) = "á"
        vocales(1) = "é"
        vocales(2) = "í"
        vocales(3) = "ó"
        vocales(4) = "ú"

        vocalesRpt(0) = "a"
        vocalesRpt(1) = "e"
        vocalesRpt(2) = "i"
        vocalesRpt(3) = "o"
        vocalesRpt(4) = "u"

        vocales2(0) = "Á"
        vocales2(1) = "É"
        vocales2(2) = "Í"
        vocales2(3) = "Ó"
        vocales2(4) = "Ú"

        vocales2Rpt(0) = "A"
        vocales2Rpt(1) = "E"
        vocales2Rpt(2) = "I"
        vocales2Rpt(3) = "O"
        vocales2Rpt(4) = "U"

        For i = 0 To 4
            resultado = Replace(resultado, vocales(i), vocalesRpt(i))
            resultado = Replace(resultado, vocales2(i), vocales2Rpt(i))
        Next

        resultado = UCase(resultado)
        resultado = Replace(resultado, "+", "  ")
        resultado = Replace(resultado, "-", "  ")
        resultado = Replace(resultado, ".", "  ")
        resultado = Replace(resultado, ",", "  ")
        resultado = Replace(resultado, "_", "  ")
        resultado = Replace(resultado, "/", " RESPECTO ")
        resultado = Replace(resultado, "%", " PORCIENTO ")
        resultado = Replace(resultado, "=", "  ")
        resultado = Replace(resultado, ")", " ")
        resultado = Replace(resultado, "(", " ")
        resultado = Regex.Replace(resultado, "\s+", " ")
        resultado = Trim(resultado)
        resultado = Replace(resultado, " ", "_")


        Return resultado

    End Function

    Public Function QuitarEspAcen2(ByVal textoEntrada As String) As String
        Dim vocales(4) As String
        Dim vocales2(4) As String
        Dim vocalesRpt(4) As String
        Dim vocales2Rpt(4) As String
        Dim resultado As String
        Dim i As Integer

        resultado = textoEntrada

        vocales(0) = "á"
        vocales(1) = "é"
        vocales(2) = "í"
        vocales(3) = "ó"
        vocales(4) = "ú"

        vocalesRpt(0) = "a"
        vocalesRpt(1) = "e"
        vocalesRpt(2) = "i"
        vocalesRpt(3) = "o"
        vocalesRpt(4) = "u"

        vocales2(0) = "Á"
        vocales2(1) = "É"
        vocales2(2) = "Í"
        vocales2(3) = "Ó"
        vocales2(4) = "Ú"

        vocales2Rpt(0) = "A"
        vocales2Rpt(1) = "E"
        vocales2Rpt(2) = "I"
        vocales2Rpt(3) = "O"
        vocales2Rpt(4) = "U"

        For i = 0 To 4
            resultado = Replace(resultado, vocales(i), vocalesRpt(i))
            resultado = Replace(resultado, vocales2(i), vocales2Rpt(i))
        Next

        resultado = UCase(resultado)
        resultado = Replace(resultado, "+", "  ")
        resultado = Replace(resultado, "-", "  ")
        resultado = Replace(resultado, ".", "  ")
        resultado = Replace(resultado, ",", "  ")
        resultado = Replace(resultado, "_", "  ")
        resultado = Replace(resultado, "/", " RESPECTO ")
        resultado = Replace(resultado, "%", " PORCIENTO ")
        resultado = Replace(resultado, "=", "  ")
        resultado = Replace(resultado, ")", " ")
        resultado = Replace(resultado, "(", " ")
        resultado = Regex.Replace(resultado, "\d", "  ")
        resultado = Regex.Replace(resultado, "\s+", " ")
        resultado = Trim(resultado)
        resultado = Replace(resultado, " ", "_")


        Return resultado

    End Function

End Module
