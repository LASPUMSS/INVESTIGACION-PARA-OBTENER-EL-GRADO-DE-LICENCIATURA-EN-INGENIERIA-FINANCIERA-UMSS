Imports System.IO
Imports Microsoft.Office.Interop
Module AA_PRINCIPAL
    Public currentDirectory As String = Directory.GetCurrentDirectory()
    Public historialEjecucion As StreamWriter
    Public hojaUnionDatos As Excel.Workbook
    Public ejecSec As String

    Sub Main()

        Dim ExcelApp As Excel.Application
        Dim gestionActual As String
        Dim gestionIncial As Long

        '####################################################################################
        '##############  PROCEDIMIENTOS PRELEMINARES
        '####################################################################################

        ExcelApp = New Excel.Application
        ExcelApp.DisplayAlerts = False

        cargarCarpetas()
        caragarRegistros(ExcelApp)

        gestionIncial = 2014
        gestionActual = Year(Now)

        '####################################################################################
        '##############  EDICION HOJAS
        '####################################################################################

        procedimientosEdicion(ExcelApp, gestionIncial, gestionActual)

        '####################################################################################
        '##############  ENUMERAR LOS POSIBLES CAMPOS DE LOS ESTADOS
        '####################################################################################

        procedimientosEnumeracion(ExcelApp, gestionIncial, gestionActual)

        '####################################################################################
        '##############  AGREGAR CAMPOS HOJAS
        '####################################################################################

        procedimientosAgregarCamposHojas(ExcelApp, gestionIncial, gestionActual)

        '####################################################################################
        '##############  UNION HOJAS 
        '####################################################################################

        procedimientosUnirHojas(ExcelApp, gestionIncial, gestionActual)

        '####################################################################################
        '##############  CERRAR SERVICIOS
        '####################################################################################
        historialEjecucion.Flush()
        historialEjecucion.Close()
        ExcelApp.Quit()


    End Sub

End Module
