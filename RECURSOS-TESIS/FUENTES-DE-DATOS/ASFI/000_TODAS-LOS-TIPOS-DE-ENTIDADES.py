from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.support.select import Select
from selenium.common import exceptions
import unittest
import time
import glob
import os

mesesGestion = ["Enero"]
urlEntidades = ["https://www.asfi.gob.bo/index.php/bancos-multiples-boletines.html"]
nomEntidades = ["BancosMultiples","BancosPyme","EntidadesFinancierasVivienda","CooperativasDeAhorroAbiertas","InstitucionesFininacierasDesarrollo","BancosDesarrolloProductivo"]
seccionesDesc = ["EstadosFinancieros","IndicadoresFinancieros","Captaciones","Colocaciones","OperacionesInterbancarias","EstadosFinancierosEvolutivos","IndicadoresEvolutivos","EstadosFinancerosDesagregados","AgenciasSucursalesNumEmpleados"]
nombresAnt = []
nombresNew = []
SEPARADOR = "#################################################################################"
print("¿Que gestion vamos a descargar?")
gestionDescargar = input()
directorio = os.getcwd()
registroEjec = open(f"{directorio}/DATOS/registroEjecucion{gestionDescargar}.txt", "w")
registroEjec.write("REGISTRO DE EJECUCION")
print("REGISTRO DE EJECUCION")
ubDrive = f"{directorio}\chromedriver.exe"
ubDatos = f"{directorio}\DATOS\DATOS_ENTIDADES_ASFI_{gestionDescargar}"
rutaDatos = f"{ubDatos}\*.zip"
print(ubDrive)
time.sleep(10)

class usando_unittest(unittest.TestCase):

	def setUp(self):
		chromeOptions=Options() 
		chromeOptions.add_experimental_option("prefs", {
   		"download.default_directory" : ubDatos,
		})
		self.driver = webdriver.Chrome(executable_path=r"%s" %ubDrive, chrome_options=chromeOptions)

	def recolectaNombres(self, idxEnt, idxSecDesc, numArchivo, gestion, mes):
		list_of_files = glob.glob(rutaDatos)
		file_oldname = max(list_of_files, key=os.path.getctime)
		file_oldnameAux = file_oldname.replace(f"{ubDatos}\\","")

		if int(mesesGestion.index(mes)+1)<10:
			mesAux = f"0{mesesGestion.index(mes)+1}"
		else:
			mesAux = f"{mesesGestion.index(mes)+1}"
		if int(numArchivo)<10:
			numArchivoAux = f"0{numArchivo}"
		else:
			numArchivoAux = f"{numArchivo}"
		
		file_newname_newfile = f"{ubDatos}\{gestion}_{str(mesAux)}_{nomEntidades[idxEnt]}_Seccion_{seccionesDesc[idxSecDesc]}_{str(numArchivoAux)}_{file_oldnameAux}"
		nombresAnt.append(file_oldname)
		nombresNew.append(file_newname_newfile)

	def renombrarArchivos(self):
		time.sleep(30)
		for ind, nombreNuevo in enumerate(nombresNew):
			os.rename(nombresAnt[int(ind)], nombreNuevo)
			registroEjec.write("\n" + nombreNuevo)
			print(nombreNuevo)
		nombresAnt.clear()
		nombresNew.clear()

	def	descagar(self, In, Fn, Stp, Secciones, Gestion, urlEnt):
		Fn = Fn + 1
		Secciones = Secciones+1

		driver = self.driver
		driver.get(urlEnt)
		time.sleep(10)
		driver.switch_to.frame(driver.find_element_by_xpath("/html/body/div/div/div[2]/main/div[2]/iframe"))
		time.sleep(3)

		for Mes in mesesGestion:

			gestion = driver.find_element_by_name("Anio")
			dropdown01 = Select(gestion)
			dropdown01.select_by_visible_text(str(Gestion))
			time.sleep(2)

			mes = driver.find_element_by_name("Mes")
			dropdown02 = Select(mes)
			dropdown02.select_by_visible_text(Mes)
			time.sleep(2)

			btnAceptar = driver.find_element_by_xpath("/html/body/form/p/table/tbody/tr/td[5]/input")
			btnAceptar.click()
			time.sleep(3)

			for Seccion in range(1,Secciones,1):

				for a in range(In,Fn,Stp):
					try:
						xpahtDesc = "/html/body/table/tbody/tr/td/table/tbody/tr[1]/td/table[" + str(Seccion) + "]/tbody/tr/td[2]/table/tbody/tr/td[2]/a[" + str(a) + "]"
						estFin = driver.find_element_by_xpath(xpahtDesc)
						estFin.click()
						time.sleep(3)
						idEntidad = int(urlEntidades.index(urlEnt))
						self.recolectaNombres(idxEnt=idEntidad, idxSecDesc=Seccion-1, numArchivo=str(a), gestion=str(Gestion), mes=str(Mes))
					
					except exceptions.NoSuchElementException:
						pass

	def test_usando_toggle(self):
		gestionInc = int(gestionDescargar)
		gestionFn = gestionInc
		gestionFn = gestionFn + 1

		for urlEnt in urlEntidades:
			
			print(SEPARADOR)
			print(urlEnt)
			print(SEPARADOR)
			registroEjec.write("\n" + SEPARADOR)
			registroEjec.write("\n" + urlEnt)
			registroEjec.write("\n" + SEPARADOR)

			for j in range(gestionInc, gestionFn, 1):

				# DESCARGAR LOS ESTADOS FINANCIEROS POR BANCOS Y POR MONEDAS - SECCION 01
				# DESCARGAR LOS ESTADOS DE INDEICADORES FINANCIEROS - SECCION 02
				# DESCARGAR LOS ESTADOS DE CAPTACIONES - SECCION 03
				# DESCARGAR LOS ESTADOS DE COLOCACIONES - SECCION 04
				# DESCARGAR LOS ESTADOS DE OPERACIONES INTERBANCARIAS (SEMESTRAL) - SECCION 05
				# DESCARGAR LOS ESTADOS FINANCIEROS EVOLUTIVOS- SECCION 06
				# DESCARGAR LOS ESTADOS DE INDICADORES EVOLUTIVOS - SECCION 07
				# DESCARGAR LOS ESTADOS FINANCIEROS DESAGREGADOS - SECCION 08
				# DESCARGAR LOS ESTADOS DE AGENCIAS, SUCURSALES, NRO. EMPLEADOS - SECCION 09
				self.descagar(In=1, Fn=40, Stp=1, Secciones=9, Gestion=j, urlEnt=urlEnt)
		self.renombrarArchivos()
							
	def tearDown(self):
		self.driver.close()
		registroEjec.close()

if __name__ == '__main__':
	unittest.main()