from fileinput import filename
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.support.select import Select
from selenium.common import exceptions
import unittest
import time
import glob
import os

mesesGestion = ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"]
urlEntidades = ["https://www.asfi.gob.bo/index.php/bancos-multiples-boletines.html", "https://www.asfi.gob.bo/index.php/bancos-pyme-boletines.html", "https://www.asfi.gob.bo/index.php/entidades-financieras-de-vivienda.html", "https://www.asfi.gob.bo/index.php/cooperativas-de-ahorro-y-credito-abiertas.html", "https://www.asfi.gob.bo/index.php/instituciones-financieras-de-desarrollo.html", "https://www.asfi.gob.bo/index.php/banco-de-desarrollo-productivo.html"]
nomEntidades = ["BancosMultiples","BancosPyme","EntidadesFinancierasVivienda","CooperativasDeAhorroAbiertas","InstitucionesFininacierasDesarrollo","BancosDesarrolloProductivo"]
seccionesDesc = ["EstadosFinancieros","IndicadoresFinancieros","Captaciones","Colocaciones","OperacionesInterbancarias","EstadosFinancierosEvolutivos","IndicadoresEvolutivos","EstadosFinancerosDesagregados","AgenciasSucursalesNumEmpleados"]
SEPARADOR = "#################################################################################"
directorio = os.getcwd()
print(SEPARADOR)
print("REGISTRO DE EJECUCION")
print(SEPARADOR)
ubDrive = f"{directorio}\chromedriver.exe"
ubDatos = f"{directorio}\DATOS"
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

	def verificarArchvioExiste(self, idxEnt, idxSecDesc, numArchivo, gestion, mes, name):

		if (int(mesesGestion.index(mes))+1)<10:
			mesAux = f"0{int(mesesGestion.index(mes))+1}"
		else:
			mesAux = f"{int(mesesGestion.index(mes))+1}"

		if int(numArchivo)<10:
			numArchivoAux = f"0{numArchivo}"
		else:
			numArchivoAux = numArchivo

		file_name = f"{ubDatos}\{str(gestion)}_{mesAux}_{nomEntidades[idxEnt]}_Seccion_{seccionesDesc[idxSecDesc]}_{numArchivoAux}_{name}"	
		
		return os.path.exists(file_name)

	def renombrarArchivo(self, idxEnt, idxSecDesc, numArchivo, gestion, mes, name):
		seRenombro = False
		while not seRenombro:
			try:
				list_of_files = glob.glob(rutaDatos)
				file_oldname = max(list_of_files, key=os.path.getctime)

				if (int(mesesGestion.index(mes))+1)<10:
					mesAux = f"0{int(mesesGestion.index(mes))+1}"
				else:
					mesAux = f"{int(mesesGestion.index(mes))+1}"

				if int(numArchivo)<10:
					numArchivoAux = f"0{numArchivo}"
				else:
					numArchivoAux = numArchivo

				file_newname_newfile = f"{ubDatos}\{str(gestion)}_{mesAux}_{nomEntidades[idxEnt]}_Seccion_{seccionesDesc[idxSecDesc]}_{numArchivoAux}_{name}"	
				os.rename(file_oldname, file_newname_newfile)

				latest_file = file_newname_newfile
				latest_file = latest_file.replace(f"{ubDatos}\\","")
				print(latest_file)
				seRenombro = True
				
			except IOError:
				time.sleep(5)

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

			print(str(Gestion))
			print(Mes)

			mes = driver.find_element_by_name("Mes")
			dropdown02 = Select(mes)
			dropdown02.select_by_visible_text(Mes)
			time.sleep(2)

			btnAceptar = driver.find_element_by_xpath("/html/body/form/p/table/tbody/tr/td[5]/input")
			btnAceptar.click()
			time.sleep(3)

			if (int(mesesGestion.index(Mes))+1)<10:
				mesAux = f"0{int(mesesGestion.index(Mes))+1}"
			else:
				mesAux = f"{int(mesesGestion.index(Mes))+1}"

			for Seccion in range(1,Secciones,1):

				for a in range(In,Fn,Stp):
					try:
						xpahtDesc = "/html/body/table/tbody/tr/td/table/tbody/tr[1]/td/table[" + str(Seccion) + "]/tbody/tr/td[2]/table/tbody/tr/td[2]/a[" + str(a) + "]"
						estFin = driver.find_element_by_xpath(xpahtDesc)
						nombreArchivo = str(estFin.get_attribute("href")).replace("https://appweb.asfi.gob.bo/boletines_if","")
						nombreArchivo = nombreArchivo.replace(f"/{Gestion}/{mesAux}/","")

						verificarArch = self.verificarArchvioExiste(idxEnt=urlEntidades.index(urlEnt), idxSecDesc=Seccion-1, numArchivo= a, gestion=Gestion, mes=Mes, name=nombreArchivo)
						if not verificarArch:
							estFin.click()
							time.sleep(5)
							self.renombrarArchivo(idxEnt=urlEntidades.index(urlEnt), idxSecDesc=Seccion-1, numArchivo= a, gestion=Gestion, mes=Mes, name=nombreArchivo)
							print(xpahtDesc)

					except exceptions.NoSuchElementException:
						pass

	def test_usando_toggle(self):
		gestionInc = 2014
		gestionFn = 2020 + 1

		for urlEnt in urlEntidades:
			print(SEPARADOR)
			print(urlEnt)
			print(SEPARADOR)
			
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
							
	def tearDown(self):
		self.driver.close()

if __name__ == '__main__':
	unittest.main()