Imports Microsoft.Office.Interop
Imports System.IO

' EN ESTE MODULO SE GUARDAN LOS PROCEDIMIENTOS PRINCIPALES PARA: EDITAR, ENUMERAR, AGREGAR(NORMALIZAR) Y UNIR HOJAS.
Module AA_ProcedimientosPrincipales

    Public Sub procedimientosEdicion(ExcelApp As Excel.Application, gestionIncial As Long, gestionActual As Long)
        registroEjecucion000_00("------------------------------------------------------------------------------------")
        registroEjecucion000_00("------------------------------------------------------------------------------------")
        registroEjecucion000_00("¿DESEA EJECUTAR LA EDICION DE LAS HOJAS?")
        registroEjecucion000_00("------------------------------------------------------------------------------------")
        registroEjecucion000_00("------------------------------------------------------------------------------------")
        ejecSec = UCase(Console.ReadLine())

        If ejecSec = "SI" Then

            '####################################################################################
            '##############  SECCION: ESTADOS FINANCIEROS
            '####################################################################################
            registroEjecucion000_00("¿Deseas ejecutar la seccion de estados financieros?")
            ejecSec = UCase(Console.ReadLine())

            If ejecSec = "SI" Then

                registroEjecucion000_00("####################################################################################")
                registroEjecucion000_00("SE EJECUTARA LA SECCION: ESTADOS FINANCIEROS")
                registroEjecucion000_00("####################################################################################")

                '### ESTADOS FINANCIEROS
                registroEjecucion000_00("¿Deseas ejecutar la seccion de estados financieros - estados financieros?")
                ejecSec = UCase(Console.ReadLine())

                If ejecSec = "SI" Then
                    cargarPatronRutaArchivo(ExcelApp, gestionIncial, CLng(gestionActual), "Estados Financieros", "Patron1")
                End If

                '### ESTADOS FINANCIEROS POR MONEDAS
                registroEjecucion000_00("¿Deseas ejecutar la seccion de estados financieros - estados financieros por moneda?")
                ejecSec = UCase(Console.ReadLine())

                If ejecSec = "SI" Then
                    cargarPatronRutaArchivo(ExcelApp, gestionIncial, CLng(gestionActual), "Estados Financieros Moneda", "Patron1")
                End If

            End If

            '####################################################################################
            '##############  SECCION: INDICADORES FINANCIEROS
            '####################################################################################
            registroEjecucion000_00("¿Deseas ejecutar la seccion de indicadores financieros?")
            ejecSec = UCase(Console.ReadLine())

            If ejecSec = "SI" Then

                registroEjecucion000_00("####################################################################################")
                registroEjecucion000_00("SE EJECUTARA LA SECCION: INDICADORES FINANCIEROS")
                registroEjecucion000_00("####################################################################################")

                '### CALIFICACION DE CARTERA
                registroEjecucion000_00("¿Deseas ejecutar la seccion de indicadores financieros - Calificacion de cartera?")
                ejecSec = UCase(Console.ReadLine())
                If ejecSec = "SI" Then
                    cargarPatronRutaArchivo(ExcelApp, gestionIncial, CLng(gestionActual), "Calificacion Cartera", "Patron2")
                End If

                '### INDICADORES FINANCIEROS
                registroEjecucion000_00("¿Deseas ejecutar la seccion de indicadores financieros - indicadores financieros?")
                ejecSec = UCase(Console.ReadLine())
                If ejecSec = "SI" Then
                    cargarPatronRutaArchivo(ExcelApp, gestionIncial, CLng(gestionActual), "Indicadores Financieros", "Patron1")
                End If

                '### PONDERACION DE ACTIVOS
                registroEjecucion000_00("¿Deseas ejecutar la seccion de indicadores financieros - ponderacion de activos?")
                ejecSec = UCase(Console.ReadLine())
                If ejecSec = "SI" Then
                    cargarPatronRutaArchivo(ExcelApp, gestionIncial, CLng(gestionActual), "Ponderacion Activos", "Patron2")
                End If

            End If

            '####################################################################################
            '##############  SECCION: CAPATACIONES
            '####################################################################################
            registroEjecucion000_00("¿Deseas ejecutar la seccion de captaciones?")
            ejecSec = UCase(Console.ReadLine())

            If ejecSec = "SI" Then

                registroEjecucion000_00("####################################################################################")
                registroEjecucion000_00("SE EJECUTARA LA SECCION: CAPTACIONES")
                registroEjecucion000_00("####################################################################################")

                registroEjecucion000_00("¿Deseas ejecutar la seccion de captaciones - Ranking Depositos Publico?")
                ejecSec = UCase(Console.ReadLine())

                If ejecSec = "SI" Then
                    cargarPatronRutaArchivo(ExcelApp, gestionIncial, CLng(gestionActual), "Ranking Depositos Publico", "Patron5")
                End If

                registroEjecucion000_00("¿Deseas ejecutar la seccion de captaciones - Ranking Depositos?")
                ejecSec = UCase(Console.ReadLine())

                If ejecSec = "SI" Then
                    cargarPatronRutaArchivo(ExcelApp, gestionIncial, CLng(gestionActual), "RankingDepositos", "Patron5")
                End If

                registroEjecucion000_00("¿Deseas ejecutar la seccion de captaciones - encaje legal?")
                ejecSec = UCase(Console.ReadLine())

                If ejecSec = "SI" Then
                    cargarPatronRutaArchivo(ExcelApp, gestionIncial, CLng(gestionActual), "Encaje Legal", "Patron4")
                End If

                registroEjecucion000_00("¿Deseas ejecutar la seccion de captaciones - EstratificacionDepDptoTotal?")
                ejecSec = UCase(Console.ReadLine())

                If ejecSec = "SI" Then
                    cargarPatronRutaArchivo(ExcelApp, gestionIncial, CLng(gestionActual), "EstratificacionDepDptoTotal", "Patron1")
                End If

                registroEjecucion000_00("¿Deseas ejecutar la seccion de captaciones - EstratificacionDepEntidadTotal?")
                ejecSec = UCase(Console.ReadLine())

                If ejecSec = "SI" Then
                    cargarPatronRutaArchivo(ExcelApp, gestionIncial, CLng(gestionActual), "EstratificacionDepEntidadTotal", "Patron1")
                End If

                registroEjecucion000_00("¿Deseas ejecutar la seccion de captaciones - EstratificacionDepositos?")
                ejecSec = UCase(Console.ReadLine())

                If ejecSec = "SI" Then
                    cargarPatronRutaArchivo(ExcelApp, gestionIncial, CLng(gestionActual), "EstratificacionDepositos", "Patron1")
                End If


            End If

            '####################################################################################
            '##############  SECCION: COLOCACIONES
            '####################################################################################
            registroEjecucion000_00("¿Deseas ejecutar la seccion de colocaciones?")
            ejecSec = UCase(Console.ReadLine())

            If ejecSec = "SI" Then

                registroEjecucion000_00("####################################################################################")
                registroEjecucion000_00("SE EJECUTARA LA SECCION: COLOCACIONES")
                registroEjecucion000_00("####################################################################################")

                registroEjecucion000_00("¿Deseas ejecutar la seccion de captaciones - Financiamientos Externos?")
                ejecSec = UCase(Console.ReadLine())

                If ejecSec = "SI" Then
                    cargarPatronRutaArchivo(ExcelApp, gestionIncial, CLng(gestionActual), "Financiamientos Externos", "Patron1")
                End If

                registroEjecucion000_00("¿Deseas ejecutar la seccion de captaciones - Ranking Colocaciones?")
                ejecSec = UCase(Console.ReadLine())

                If ejecSec = "SI" Then
                    cargarPatronRutaArchivo(ExcelApp, gestionIncial, CLng(gestionActual), "Ranking Colocaciones", "Patron5")
                End If

                registroEjecucion000_00("¿Deseas ejecutar la seccion de captaciones - Ranking Contingente?")
                ejecSec = UCase(Console.ReadLine())

                If ejecSec = "SI" Then
                    cargarPatronRutaArchivo(ExcelApp, gestionIncial, CLng(gestionActual), "Ranking Contingente", "Patron5")
                End If

            End If

            '####################################################################################
            '##############  SECCION: OPERACIONES INTERBANCARIAS
            '####################################################################################
            registroEjecucion000_00("¿Deseas ejecutar la seccion de operaciones interbancarias?")
            ejecSec = UCase(Console.ReadLine())

            If ejecSec = "SI" Then

                '# ESTADOS FINANCIEROS DESAGREGADOS
                registroEjecucion000_00("####################################################################################")
                registroEjecucion000_00("SE EJECUTARA LA SECCION: OPERACIONES INTERBANCARIAS")
                registroEjecucion000_00("####################################################################################")

                cargarPatronRutaArchivo(ExcelApp, gestionIncial, CLng(gestionActual), "Operaciones Interbancarias", "Patron5")

            End If

            '####################################################################################
            '##############  SECCION: ESTADOS FINANANCIEROS EVOLUTIVOS
            '####################################################################################


            '####################################################################################
            '############## SECCION: INDICADORES EVOLUTIVOS
            '####################################################################################


            '####################################################################################
            '############## SECCION: ESTADOS FINANCIEROS DESAGREGADOS
            '####################################################################################
            registroEjecucion000_00("¿Deseas ejecutar la seccion de estados financieros desagregados?")
            ejecSec = UCase(Console.ReadLine())

            If ejecSec = "SI" Then

                '# ESTADOS FINANCIEROS DESAGREGADOS
                registroEjecucion000_00("####################################################################################")
                registroEjecucion000_00("SE EJECUTARA LA SECCION: ESTADOS FINANCIEROS DESAGREGADOS")
                registroEjecucion000_00("####################################################################################")

                cargarPatronRutaArchivo(ExcelApp, gestionIncial, CLng(gestionActual), "Estados Financieros Desagregados", "Patron3")

            End If

            '####################################################################################
            '##############  SECCION: AGENCIAS, SUCURSALES, NRO. EMPLEADOS
            '####################################################################################
            registroEjecucion000_00("¿Deseas ejecutar la seccion de agencias, sucursales y numero de empleados?")
            ejecSec = UCase(Console.ReadLine())

            If ejecSec = "SI" Then

                registroEjecucion000_00("####################################################################################")
                registroEjecucion000_00("SE EJECUTARA LA SECCION: AGENCIAS, SUCURSALES Y NUMERO DE EMPLEADOS")
                registroEjecucion000_00("####################################################################################")

                registroEjecucion000_00("¿Deseas ejecutar la seccion de agencia, sucursales y numero de empleados - puntos de Atención Financiera por departamento?")
                ejecSec = UCase(Console.ReadLine())

                If ejecSec = "SI" Then
                    cargarPatronRutaArchivo(ExcelApp, gestionIncial, CLng(gestionActual), "PAFs_x_Depto", "Patron1")
                End If


                registroEjecucion000_00("¿Deseas ejecutar la seccion de agencia, sucursales y numero de empleados - sucursales y numero de empleados?")
                ejecSec = UCase(Console.ReadLine())

                If ejecSec = "SI" Then
                    cargarPatronRutaArchivo(ExcelApp, gestionIncial, CLng(gestionActual), "Agencias", "Patron1")
                End If

            End If

        End If

    End Sub

    Public Sub procedimientosEnumeracion(ExcelApp As Excel.Application, gestionIncial As Long, gestionActual As Long)
        registroEjecucion000_00("------------------------------------------------------------------------------------")
        registroEjecucion000_00("------------------------------------------------------------------------------------")
        registroEjecucion000_00("¿ESTADOS DESEA EJECUTAR LA ENUMERACION DE LOS CAMPOS DE LOS ESTADOS?")
        registroEjecucion000_00("------------------------------------------------------------------------------------")
        registroEjecucion000_00("------------------------------------------------------------------------------------")
        ejecSec = UCase(Console.ReadLine())

        If ejecSec = "SI" Then

            '####################################################################################
            '##############  SECCION: ESTADOS FINANCIEROS
            '####################################################################################
            registroEjecucion000_00("¿Deseas ejecutar la seccion de estados financieros?")
            ejecSec = UCase(Console.ReadLine())

            If ejecSec = "SI" Then

                registroEjecucion000_00("####################################################################################")
                registroEjecucion000_00("SE EJECUTARA LA SECCION: ESTADOS FINANCIEROS")
                registroEjecucion000_00("####################################################################################")

                '### ESTADOS FINANCIEROS
                registroEjecucion000_00("¿Deseas ejecutar la seccion de estados financieros - estados financieros?")
                ejecSec = UCase(Console.ReadLine())

                If ejecSec = "SI" Then
                    cargarPatronRutaArchivo(ExcelApp, gestionIncial, CLng(gestionActual), "Estados Financieros", "Patron1", False, True)
                End If

                '### ESTADOS FINANCIEROS POR MONEDAS
                registroEjecucion000_00("¿Deseas ejecutar la seccion de estados financieros - estados financieros por moneda?")
                ejecSec = UCase(Console.ReadLine())

                If ejecSec = "SI" Then
                    cargarPatronRutaArchivo(ExcelApp, gestionIncial, CLng(gestionActual), "Estados Financieros Moneda", "Patron1", False, True)
                End If

            End If

            '####################################################################################
            '##############  SECCION: INDICADORES FINANCIEROS
            '####################################################################################
            registroEjecucion000_00("¿Deseas ejecutar la seccion de indicadores financieros?")
            ejecSec = UCase(Console.ReadLine())

            If ejecSec = "SI" Then

                registroEjecucion000_00("####################################################################################")
                registroEjecucion000_00("SE EJECUTARA LA SECCION: INDICADORES FINANCIEROS")
                registroEjecucion000_00("####################################################################################")

                '### CALIFICACION DE CARTERA
                registroEjecucion000_00("¿Deseas ejecutar la seccion de indicadores financieros - Calificacion de cartera?")
                ejecSec = UCase(Console.ReadLine())
                If ejecSec = "SI" Then
                    cargarPatronRutaArchivo(ExcelApp, gestionIncial, CLng(gestionActual), "Calificacion Cartera", "Patron2", False, True)
                End If

                '### INDICADORES FINANCIEROS
                registroEjecucion000_00("¿Deseas ejecutar la seccion de indicadores financieros - indicadores financieros?")
                ejecSec = UCase(Console.ReadLine())
                If ejecSec = "SI" Then
                    cargarPatronRutaArchivo(ExcelApp, gestionIncial, CLng(gestionActual), "Indicadores Financieros", "Patron1", False, True)
                End If

                '### PONDERACION DE ACTIVOS
                registroEjecucion000_00("¿Deseas ejecutar la seccion de indicadores financieros - ponderacion de activos?")
                ejecSec = UCase(Console.ReadLine())
                If ejecSec = "SI" Then
                    cargarPatronRutaArchivo(ExcelApp, gestionIncial, CLng(gestionActual), "Ponderacion Activos", "Patron2", False, True)
                End If

            End If

            '####################################################################################
            '##############  SECCION: CAPATACIONES
            '####################################################################################
            registroEjecucion000_00("¿Deseas ejecutar la seccion de captaciones?")
            ejecSec = UCase(Console.ReadLine())

            If ejecSec = "SI" Then

                registroEjecucion000_00("####################################################################################")
                registroEjecucion000_00("SE EJECUTARA LA SECCION: CAPTACIONES")
                registroEjecucion000_00("####################################################################################")

                registroEjecucion000_00("¿Deseas ejecutar la seccion de captaciones - Ranking Depositos Publico?")
                ejecSec = UCase(Console.ReadLine())

                If ejecSec = "SI" Then
                    cargarPatronRutaArchivo(ExcelApp, gestionIncial, CLng(gestionActual), "Ranking Depositos Publico", "Patron5", False, True)
                End If

                registroEjecucion000_00("¿Deseas ejecutar la seccion de captaciones - Ranking Depositos?")
                ejecSec = UCase(Console.ReadLine())

                If ejecSec = "SI" Then
                    cargarPatronRutaArchivo(ExcelApp, gestionIncial, CLng(gestionActual), "RankingDepositos", "Patron5", False, True)
                End If

                registroEjecucion000_00("¿Deseas ejecutar la seccion de captaciones - encaje legal?")
                ejecSec = UCase(Console.ReadLine())

                If ejecSec = "SI" Then
                    cargarPatronRutaArchivo(ExcelApp, gestionIncial, CLng(gestionActual), "Encaje Legal", "Patron4", False, True)
                End If

                registroEjecucion000_00("¿Deseas ejecutar la seccion de captaciones - EstratificacionDepDptoTotal?")
                ejecSec = UCase(Console.ReadLine())

                If ejecSec = "SI" Then
                    cargarPatronRutaArchivo(ExcelApp, gestionIncial, CLng(gestionActual), "EstratificacionDepDptoTotal", "Patron1", False, True)
                End If

                registroEjecucion000_00("¿Deseas ejecutar la seccion de captaciones - EstratificacionDepEntidadTotal?")
                ejecSec = UCase(Console.ReadLine())

                If ejecSec = "SI" Then
                    cargarPatronRutaArchivo(ExcelApp, gestionIncial, CLng(gestionActual), "EstratificacionDepEntidadTotal", "Patron1", False, True)
                End If

                registroEjecucion000_00("¿Deseas ejecutar la seccion de captaciones - EstratificacionDepositos?")
                ejecSec = UCase(Console.ReadLine())

                If ejecSec = "SI" Then
                    cargarPatronRutaArchivo(ExcelApp, gestionIncial, CLng(gestionActual), "EstratificacionDepositos", "Patron1", False, True)
                End If


            End If

            '####################################################################################
            '##############  SECCION: COLOCACIONES
            '####################################################################################
            registroEjecucion000_00("¿Deseas ejecutar la seccion de colocaciones?")
            ejecSec = UCase(Console.ReadLine())

            If ejecSec = "SI" Then

                registroEjecucion000_00("####################################################################################")
                registroEjecucion000_00("SE EJECUTARA LA SECCION: COLOCACIONES")
                registroEjecucion000_00("####################################################################################")

                registroEjecucion000_00("¿Deseas ejecutar la seccion de captaciones - Financiamientos Externos?")
                ejecSec = UCase(Console.ReadLine())

                If ejecSec = "SI" Then
                    cargarPatronRutaArchivo(ExcelApp, gestionIncial, CLng(gestionActual), "Financiamientos Externos", "Patron1", False, True)
                End If

                registroEjecucion000_00("¿Deseas ejecutar la seccion de captaciones - Ranking Colocaciones?")
                ejecSec = UCase(Console.ReadLine())

                If ejecSec = "SI" Then
                    cargarPatronRutaArchivo(ExcelApp, gestionIncial, CLng(gestionActual), "Ranking Colocaciones", "Patron5", False, True)
                End If

                registroEjecucion000_00("¿Deseas ejecutar la seccion de captaciones - Ranking Contingente?")
                ejecSec = UCase(Console.ReadLine())

                If ejecSec = "SI" Then
                    cargarPatronRutaArchivo(ExcelApp, gestionIncial, CLng(gestionActual), "Ranking Contingente", "Patron5", False, True)
                End If

            End If

            '####################################################################################
            '##############  SECCION: OPERACIONES INTERBANCARIAS
            '####################################################################################
            registroEjecucion000_00("¿Deseas ejecutar la seccion de operaciones interbancarias?")
            ejecSec = UCase(Console.ReadLine())

            If ejecSec = "SI" Then

                '# ESTADOS FINANCIEROS DESAGREGADOS
                registroEjecucion000_00("####################################################################################")
                registroEjecucion000_00("SE EJECUTARA LA SECCION: OPERACIONES INTERBANCARIAS")
                registroEjecucion000_00("####################################################################################")

                cargarPatronRutaArchivo(ExcelApp, gestionIncial, CLng(gestionActual), "Operaciones Interbancarias", "Patron5", False, True)

            End If

            '####################################################################################
            '##############  SECCION: ESTADOS FINANANCIEROS EVOLUTIVOS
            '####################################################################################


            '####################################################################################
            '############## SECCION: INDICADORES EVOLUTIVOS
            '####################################################################################


            '####################################################################################
            '############## SECCION: ESTADOS FINANCIEROS DESAGREGADOS
            '####################################################################################
            registroEjecucion000_00("¿Deseas ejecutar la seccion de estados financieros desagregados?")
            ejecSec = UCase(Console.ReadLine())

            If ejecSec = "SI" Then

                '# ESTADOS FINANCIEROS DESAGREGADOS
                registroEjecucion000_00("####################################################################################")
                registroEjecucion000_00("SE EJECUTARA LA SECCION: ESTADOS FINANCIEROS DESAGREGADOS")
                registroEjecucion000_00("####################################################################################")

                cargarPatronRutaArchivo(ExcelApp, gestionIncial, CLng(gestionActual), "Estados Financieros Desagregados", "Patron3", False, True)

            End If

            '####################################################################################
            '##############  SECCION: AGENCIAS, SUCURSALES, NRO. EMPLEADOS
            '####################################################################################
            registroEjecucion000_00("¿Deseas ejecutar la seccion de agencias, sucursales y numero de empleados?")
            ejecSec = UCase(Console.ReadLine())

            If ejecSec = "SI" Then

                registroEjecucion000_00("####################################################################################")
                registroEjecucion000_00("SE EJECUTARA LA SECCION: AGENCIAS, SUCURSALES Y NUMERO DE EMPLEADOS")
                registroEjecucion000_00("####################################################################################")

                registroEjecucion000_00("¿Deseas ejecutar la seccion de agencia, sucursales y numero de empleados - puntos de Atención Financiera por departamento?")
                ejecSec = UCase(Console.ReadLine())

                If ejecSec = "SI" Then
                    cargarPatronRutaArchivo(ExcelApp, gestionIncial, CLng(gestionActual), "PAFs_x_Depto", "Patron1", False, True)
                End If


                registroEjecucion000_00("¿Deseas ejecutar la seccion de agencia, sucursales y numero de empleados - sucursales y numero de empleados?")
                ejecSec = UCase(Console.ReadLine())

                If ejecSec = "SI" Then
                    cargarPatronRutaArchivo(ExcelApp, gestionIncial, CLng(gestionActual), "Agencias", "Patron1", False, True)
                End If

            End If

        End If

    End Sub

    Public Sub procedimientosAgregarCamposHojas(ExcelApp As Excel.Application, gestionIncial As Long, gestionActual As Long)
        constantesEstados()
        registroEjecucion000_00("------------------------------------------------------------------------------------")
        registroEjecucion000_00("------------------------------------------------------------------------------------")
        registroEjecucion000_00("¿DESEA EJECUTAR AGREGAR CAMPOS?")
        registroEjecucion000_00("------------------------------------------------------------------------------------")
        registroEjecucion000_00("------------------------------------------------------------------------------------")
        ejecSec = UCase(Console.ReadLine())

        If ejecSec = "SI" Then

            '####################################################################################
            '##############  SECCION: ESTADOS FINANCIEROS
            '####################################################################################
            registroEjecucion000_00("¿Deseas ejecutar la seccion de estados financieros?")
            ejecSec = UCase(Console.ReadLine())

            If ejecSec = "SI" Then

                registroEjecucion000_00("####################################################################################")
                registroEjecucion000_00("SE EJECUTARA LA SECCION: ESTADOS FINANCIEROS")
                registroEjecucion000_00("####################################################################################")

                '### ESTADOS FINANCIEROS
                registroEjecucion000_00("¿Deseas ejecutar la seccion de estados financieros - estados financieros?")
                ejecSec = UCase(Console.ReadLine())

                If ejecSec = "SI" Then
                    cargarPatronRutaArchivo(ExcelApp, gestionIncial, CLng(gestionActual), "Estados Financieros", "Patron1", False, False, True)
                End If

                '### ESTADOS FINANCIEROS POR MONEDAS
                registroEjecucion000_00("¿Deseas ejecutar la seccion de estados financieros - estados financieros por moneda?")
                ejecSec = UCase(Console.ReadLine())

                If ejecSec = "SI" Then
                    cargarPatronRutaArchivo(ExcelApp, gestionIncial, CLng(gestionActual), "Estados Financieros Moneda", "Patron1", False, False, True)
                End If

            End If

            '####################################################################################
            '##############  SECCION: INDICADORES FINANCIEROS
            '####################################################################################
            registroEjecucion000_00("¿Deseas ejecutar la seccion de indicadores financieros?")
            ejecSec = UCase(Console.ReadLine())

            If ejecSec = "SI" Then

                registroEjecucion000_00("####################################################################################")
                registroEjecucion000_00("SE EJECUTARA LA SECCION: INDICADORES FINANCIEROS")
                registroEjecucion000_00("####################################################################################")

                '### CALIFICACION DE CARTERA
                registroEjecucion000_00("¿Deseas ejecutar la seccion de indicadores financieros - Calificacion de cartera?")
                ejecSec = UCase(Console.ReadLine())
                If ejecSec = "SI" Then
                    cargarPatronRutaArchivo(ExcelApp, gestionIncial, CLng(gestionActual), "Calificacion Cartera", "Patron2", False, False, True)
                End If

                '### INDICADORES FINANCIEROS
                registroEjecucion000_00("¿Deseas ejecutar la seccion de indicadores financieros - indicadores financieros?")
                ejecSec = UCase(Console.ReadLine())
                If ejecSec = "SI" Then
                    cargarPatronRutaArchivo(ExcelApp, gestionIncial, CLng(gestionActual), "Indicadores Financieros", "Patron1", False, False, True)
                End If

                '### PONDERACION DE ACTIVOS
                registroEjecucion000_00("¿Deseas ejecutar la seccion de indicadores financieros - ponderacion de activos?")
                ejecSec = UCase(Console.ReadLine())
                If ejecSec = "SI" Then
                    cargarPatronRutaArchivo(ExcelApp, gestionIncial, CLng(gestionActual), "Ponderacion Activos", "Patron2", False, False, True)
                End If

            End If

            '####################################################################################
            '##############  SECCION: CAPATACIONES
            '####################################################################################
            registroEjecucion000_00("¿Deseas ejecutar la seccion de captaciones?")
            ejecSec = UCase(Console.ReadLine())

            If ejecSec = "SI" Then

                registroEjecucion000_00("####################################################################################")
                registroEjecucion000_00("SE EJECUTARA LA SECCION: CAPTACIONES")
                registroEjecucion000_00("####################################################################################")

                registroEjecucion000_00("¿Deseas ejecutar la seccion de captaciones - Ranking Depositos Publico?")
                ejecSec = UCase(Console.ReadLine())

                If ejecSec = "SI" Then
                    cargarPatronRutaArchivo(ExcelApp, gestionIncial, CLng(gestionActual), "Ranking Depositos Publico", "Patron5", False, False, True)
                End If

                registroEjecucion000_00("¿Deseas ejecutar la seccion de captaciones - Ranking Depositos?")
                ejecSec = UCase(Console.ReadLine())

                If ejecSec = "SI" Then
                    cargarPatronRutaArchivo(ExcelApp, gestionIncial, CLng(gestionActual), "RankingDepositos", "Patron5", False, False, True)
                End If

                registroEjecucion000_00("¿Deseas ejecutar la seccion de captaciones - encaje legal?")
                ejecSec = UCase(Console.ReadLine())

                If ejecSec = "SI" Then
                    cargarPatronRutaArchivo(ExcelApp, gestionIncial, CLng(gestionActual), "Encaje Legal", "Patron4", False, False, True)
                End If

                registroEjecucion000_00("¿Deseas ejecutar la seccion de captaciones - EstratificacionDepDptoTotal?")
                ejecSec = UCase(Console.ReadLine())

                If ejecSec = "SI" Then
                    cargarPatronRutaArchivo(ExcelApp, gestionIncial, CLng(gestionActual), "EstratificacionDepDptoTotal", "Patron1", False, False, True)
                End If

                registroEjecucion000_00("¿Deseas ejecutar la seccion de captaciones - EstratificacionDepEntidadTotal?")
                ejecSec = UCase(Console.ReadLine())

                If ejecSec = "SI" Then
                    cargarPatronRutaArchivo(ExcelApp, gestionIncial, CLng(gestionActual), "EstratificacionDepEntidadTotal", "Patron1", False, False, True)
                End If

                registroEjecucion000_00("¿Deseas ejecutar la seccion de captaciones - EstratificacionDepositos?")
                ejecSec = UCase(Console.ReadLine())

                If ejecSec = "SI" Then
                    cargarPatronRutaArchivo(ExcelApp, gestionIncial, CLng(gestionActual), "EstratificacionDepositos", "Patron1", False, False, True)
                End If


            End If

            '####################################################################################
            '##############  SECCION: COLOCACIONES
            '####################################################################################
            registroEjecucion000_00("¿Deseas ejecutar la seccion de colocaciones?")
            ejecSec = UCase(Console.ReadLine())

            If ejecSec = "SI" Then

                registroEjecucion000_00("####################################################################################")
                registroEjecucion000_00("SE EJECUTARA LA SECCION: COLOCACIONES")
                registroEjecucion000_00("####################################################################################")

                registroEjecucion000_00("¿Deseas ejecutar la seccion de captaciones - Financiamientos Externos?")
                ejecSec = UCase(Console.ReadLine())

                If ejecSec = "SI" Then
                    cargarPatronRutaArchivo(ExcelApp, gestionIncial, CLng(gestionActual), "Financiamientos Externos", "Patron1", False, False, True)
                End If

                registroEjecucion000_00("¿Deseas ejecutar la seccion de captaciones - Ranking Colocaciones?")
                ejecSec = UCase(Console.ReadLine())

                If ejecSec = "SI" Then
                    cargarPatronRutaArchivo(ExcelApp, gestionIncial, CLng(gestionActual), "Ranking Colocaciones", "Patron5", False, False, True)
                End If

                registroEjecucion000_00("¿Deseas ejecutar la seccion de captaciones - Ranking Contingente?")
                ejecSec = UCase(Console.ReadLine())

                If ejecSec = "SI" Then
                    cargarPatronRutaArchivo(ExcelApp, gestionIncial, CLng(gestionActual), "Ranking Contingente", "Patron5", False, False, True)
                End If

            End If

            '####################################################################################
            '##############  SECCION: OPERACIONES INTERBANCARIAS
            '####################################################################################
            registroEjecucion000_00("¿Deseas ejecutar la seccion de operaciones interbancarias?")
            ejecSec = UCase(Console.ReadLine())

            If ejecSec = "SI" Then

                '# ESTADOS FINANCIEROS DESAGREGADOS
                registroEjecucion000_00("####################################################################################")
                registroEjecucion000_00("SE EJECUTARA LA SECCION: OPERACIONES INTERBANCARIAS")
                registroEjecucion000_00("####################################################################################")

                cargarPatronRutaArchivo(ExcelApp, gestionIncial, CLng(gestionActual), "Operaciones Interbancarias", "Patron5", False, False, True)

            End If

            '####################################################################################
            '##############  SECCION: ESTADOS FINANANCIEROS EVOLUTIVOS
            '####################################################################################


            '####################################################################################
            '############## SECCION: INDICADORES EVOLUTIVOS
            '####################################################################################


            '####################################################################################
            '############## SECCION: ESTADOS FINANCIEROS DESAGREGADOS
            '####################################################################################
            registroEjecucion000_00("¿Deseas ejecutar la seccion de estados financieros desagregados?")
            ejecSec = UCase(Console.ReadLine())

            If ejecSec = "SI" Then

                '# ESTADOS FINANCIEROS DESAGREGADOS
                registroEjecucion000_00("####################################################################################")
                registroEjecucion000_00("SE EJECUTARA LA SECCION: ESTADOS FINANCIEROS DESAGREGADOS")
                registroEjecucion000_00("####################################################################################")

                cargarPatronRutaArchivo(ExcelApp, gestionIncial, CLng(gestionActual), "Estados Financieros Desagregados", "Patron3", False, False, True)

            End If

            '####################################################################################
            '##############  SECCION: AGENCIAS, SUCURSALES, NRO. EMPLEADOS
            '####################################################################################
            registroEjecucion000_00("¿Deseas ejecutar la seccion de agencias, sucursales y numero de empleados?")
            ejecSec = UCase(Console.ReadLine())

            If ejecSec = "SI" Then

                registroEjecucion000_00("####################################################################################")
                registroEjecucion000_00("SE EJECUTARA LA SECCION: AGENCIAS, SUCURSALES Y NUMERO DE EMPLEADOS")
                registroEjecucion000_00("####################################################################################")

                registroEjecucion000_00("¿Deseas ejecutar la seccion de agencia, sucursales y numero de empleados - puntos de Atención Financiera por departamento?")
                ejecSec = UCase(Console.ReadLine())

                If ejecSec = "SI" Then
                    cargarPatronRutaArchivo(ExcelApp, gestionIncial, CLng(gestionActual), "PAFs_x_Depto", "Patron1", False, False, True)
                End If


                registroEjecucion000_00("¿Deseas ejecutar la seccion de agencia, sucursales y numero de empleados - sucursales y numero de empleados?")
                ejecSec = UCase(Console.ReadLine())

                If ejecSec = "SI" Then
                    cargarPatronRutaArchivo(ExcelApp, gestionIncial, CLng(gestionActual), "Agencias", "Patron1", False, False, True)
                End If

            End If

        End If

    End Sub

    Public Sub procedimientosUnirHojas(ExcelApp As Excel.Application, gestionIncial As Long, gestionActual As Long)
        registroEjecucion000_00("------------------------------------------------------------------------------------")
        registroEjecucion000_00("------------------------------------------------------------------------------------")
        registroEjecucion000_00("¿DESEA EJECUTAR LA UNION DE LAS HOJAS?")
        registroEjecucion000_00("------------------------------------------------------------------------------------")
        registroEjecucion000_00("------------------------------------------------------------------------------------")
        ejecSec = UCase(Console.ReadLine())

        If ejecSec = "SI" Then

            '####################################################################################
            '##############  SECCION: ESTADOS FINANCIEROS
            '####################################################################################
            registroEjecucion000_00("¿Deseas ejecutar la seccion de estados financieros?")
            ejecSec = UCase(Console.ReadLine())

            If ejecSec = "SI" Then

                registroEjecucion000_00("####################################################################################")
                registroEjecucion000_00("SE EJECUTARA LA SECCION: ESTADOS FINANCIEROS")
                registroEjecucion000_00("####################################################################################")

                '### ESTADOS FINANCIEROS
                registroEjecucion000_00("¿Deseas ejecutar la seccion de estados financieros - estados financieros?")
                ejecSec = UCase(Console.ReadLine())

                If ejecSec = "SI" Then
                    cargarPatronRutaArchivo(ExcelApp, gestionIncial, CLng(gestionActual), "Estados Financieros", "Patron1", True, False)
                End If

                '### ESTADOS FINANCIEROS POR MONEDAS
                registroEjecucion000_00("¿Deseas ejecutar la seccion de estados financieros - estados financieros por moneda?")
                ejecSec = UCase(Console.ReadLine())

                If ejecSec = "SI" Then
                    cargarPatronRutaArchivo(ExcelApp, gestionIncial, CLng(gestionActual), "Estados Financieros Moneda", "Patron1", True, False)
                End If

            End If

            '####################################################################################
            '##############  SECCION: INDICADORES FINANCIEROS
            '####################################################################################
            registroEjecucion000_00("¿Deseas ejecutar la seccion de indicadores financieros?")
            ejecSec = UCase(Console.ReadLine())

            If ejecSec = "SI" Then

                registroEjecucion000_00("####################################################################################")
                registroEjecucion000_00("SE EJECUTARA LA SECCION: INDICADORES FINANCIEROS")
                registroEjecucion000_00("####################################################################################")

                '### CALIFICACION DE CARTERA
                registroEjecucion000_00("¿Deseas ejecutar la seccion de indicadores financieros - Calificacion de cartera?")
                ejecSec = UCase(Console.ReadLine())
                If ejecSec = "SI" Then
                    cargarPatronRutaArchivo(ExcelApp, gestionIncial, CLng(gestionActual), "Calificacion Cartera", "Patron2", True, False)
                End If

                '### INDICADORES FINANCIEROS
                registroEjecucion000_00("¿Deseas ejecutar la seccion de indicadores financieros - indicadores financieros?")
                ejecSec = UCase(Console.ReadLine())
                If ejecSec = "SI" Then
                    cargarPatronRutaArchivo(ExcelApp, gestionIncial, CLng(gestionActual), "Indicadores Financieros", "Patron1", True, False)
                End If

                '### PONDERACION DE ACTIVOS
                registroEjecucion000_00("¿Deseas ejecutar la seccion de indicadores financieros - ponderacion de activos?")
                ejecSec = UCase(Console.ReadLine())
                If ejecSec = "SI" Then
                    cargarPatronRutaArchivo(ExcelApp, gestionIncial, CLng(gestionActual), "Ponderacion Activos", "Patron2", True, False)
                End If

            End If

            '####################################################################################
            '##############  SECCION: CAPATACIONES
            '####################################################################################
            registroEjecucion000_00("¿Deseas ejecutar la seccion de captaciones?")
            ejecSec = UCase(Console.ReadLine())

            If ejecSec = "SI" Then

                registroEjecucion000_00("####################################################################################")
                registroEjecucion000_00("SE EJECUTARA LA SECCION: CAPTACIONES")
                registroEjecucion000_00("####################################################################################")

                registroEjecucion000_00("¿Deseas ejecutar la seccion de captaciones - Ranking Depositos Publico?")
                ejecSec = UCase(Console.ReadLine())

                If ejecSec = "SI" Then
                    cargarPatronRutaArchivo(ExcelApp, gestionIncial, CLng(gestionActual), "Ranking Depositos Publico", "Patron5", True, False)
                End If

                registroEjecucion000_00("¿Deseas ejecutar la seccion de captaciones - Ranking Depositos?")
                ejecSec = UCase(Console.ReadLine())

                If ejecSec = "SI" Then
                    cargarPatronRutaArchivo(ExcelApp, gestionIncial, CLng(gestionActual), "RankingDepositos", "Patron5", True, False)
                End If

                registroEjecucion000_00("¿Deseas ejecutar la seccion de captaciones - encaje legal?")
                ejecSec = UCase(Console.ReadLine())

                If ejecSec = "SI" Then
                    cargarPatronRutaArchivo(ExcelApp, gestionIncial, CLng(gestionActual), "Encaje Legal", "Patron4", True, False)
                End If

                registroEjecucion000_00("¿Deseas ejecutar la seccion de captaciones - EstratificacionDepDptoTotal?")
                ejecSec = UCase(Console.ReadLine())

                If ejecSec = "SI" Then
                    cargarPatronRutaArchivo(ExcelApp, gestionIncial, CLng(gestionActual), "EstratificacionDepDptoTotal", "Patron1", True, False)
                End If

                registroEjecucion000_00("¿Deseas ejecutar la seccion de captaciones - EstratificacionDepEntidadTotal?")
                ejecSec = UCase(Console.ReadLine())

                If ejecSec = "SI" Then
                    cargarPatronRutaArchivo(ExcelApp, gestionIncial, CLng(gestionActual), "EstratificacionDepEntidadTotal", "Patron1", True, False)
                End If

                registroEjecucion000_00("¿Deseas ejecutar la seccion de captaciones - EstratificacionDepositos?")
                ejecSec = UCase(Console.ReadLine())

                If ejecSec = "SI" Then
                    cargarPatronRutaArchivo(ExcelApp, gestionIncial, CLng(gestionActual), "EstratificacionDepositos", "Patron1", True, False)
                End If


            End If

            '####################################################################################
            '##############  SECCION: COLOCACIONES
            '####################################################################################
            registroEjecucion000_00("¿Deseas ejecutar la seccion de colocaciones?")
            ejecSec = UCase(Console.ReadLine())

            If ejecSec = "SI" Then

                registroEjecucion000_00("####################################################################################")
                registroEjecucion000_00("SE EJECUTARA LA SECCION: COLOCACIONES")
                registroEjecucion000_00("####################################################################################")

                registroEjecucion000_00("¿Deseas ejecutar la seccion de captaciones - Financiamientos Externos?")
                ejecSec = UCase(Console.ReadLine())

                If ejecSec = "SI" Then
                    cargarPatronRutaArchivo(ExcelApp, gestionIncial, CLng(gestionActual), "Financiamientos Externos", "Patron1", True, False)
                End If

                registroEjecucion000_00("¿Deseas ejecutar la seccion de captaciones - Ranking Colocaciones?")
                ejecSec = UCase(Console.ReadLine())

                If ejecSec = "SI" Then
                    cargarPatronRutaArchivo(ExcelApp, gestionIncial, CLng(gestionActual), "Ranking Colocaciones", "Patron5", True, False)
                End If

                registroEjecucion000_00("¿Deseas ejecutar la seccion de captaciones - Ranking Contingente?")
                ejecSec = UCase(Console.ReadLine())

                If ejecSec = "SI" Then
                    cargarPatronRutaArchivo(ExcelApp, gestionIncial, CLng(gestionActual), "Ranking Contingente", "Patron5", True, False)
                End If

            End If

            '####################################################################################
            '##############  SECCION: OPERACIONES INTERBANCARIAS
            '####################################################################################
            registroEjecucion000_00("¿Deseas ejecutar la seccion de operaciones interbancarias?")
            ejecSec = UCase(Console.ReadLine())

            If ejecSec = "SI" Then

                '# ESTADOS FINANCIEROS DESAGREGADOS
                registroEjecucion000_00("####################################################################################")
                registroEjecucion000_00("SE EJECUTARA LA SECCION: OPERACIONES INTERBANCARIAS")
                registroEjecucion000_00("####################################################################################")

                cargarPatronRutaArchivo(ExcelApp, gestionIncial, CLng(gestionActual), "Operaciones Interbancarias", "Patron5", True, False)

            End If

            '####################################################################################
            '##############  SECCION: ESTADOS FINANANCIEROS EVOLUTIVOS
            '####################################################################################


            '####################################################################################
            '############## SECCION: INDICADORES EVOLUTIVOS
            '####################################################################################


            '####################################################################################
            '############## SECCION: ESTADOS FINANCIEROS DESAGREGADOS
            '####################################################################################
            registroEjecucion000_00("¿Deseas ejecutar la seccion de estados financieros desagregados?")
            ejecSec = UCase(Console.ReadLine())

            If ejecSec = "SI" Then

                '# ESTADOS FINANCIEROS DESAGREGADOS
                registroEjecucion000_00("####################################################################################")
                registroEjecucion000_00("SE EJECUTARA LA SECCION: ESTADOS FINANCIEROS DESAGREGADOS")
                registroEjecucion000_00("####################################################################################")

                cargarPatronRutaArchivo(ExcelApp, gestionIncial, CLng(gestionActual), "Estados Financieros Desagregados", "Patron3", True, False)

            End If

            '####################################################################################
            '##############  SECCION: AGENCIAS, SUCURSALES, NRO. EMPLEADOS
            '####################################################################################
            registroEjecucion000_00("¿Deseas ejecutar la seccion de agencias, sucursales y numero de empleados?")
            ejecSec = UCase(Console.ReadLine())

            If ejecSec = "SI" Then

                registroEjecucion000_00("####################################################################################")
                registroEjecucion000_00("SE EJECUTARA LA SECCION: AGENCIAS, SUCURSALES Y NUMERO DE EMPLEADOS")
                registroEjecucion000_00("####################################################################################")

                registroEjecucion000_00("¿Deseas ejecutar la seccion de agencia, sucursales y numero de empleados - puntos de Atención Financiera por departamento?")
                ejecSec = UCase(Console.ReadLine())

                If ejecSec = "SI" Then
                    cargarPatronRutaArchivo(ExcelApp, gestionIncial, CLng(gestionActual), "PAFs_x_Depto", "Patron1", True, False)
                End If


                registroEjecucion000_00("¿Deseas ejecutar la seccion de agencia, sucursales y numero de empleados - sucursales y numero de empleados?")
                ejecSec = UCase(Console.ReadLine())

                If ejecSec = "SI" Then
                    cargarPatronRutaArchivo(ExcelApp, gestionIncial, CLng(gestionActual), "Agencias", "Patron1", True, False)
                End If

            End If

        End If

    End Sub

End Module
