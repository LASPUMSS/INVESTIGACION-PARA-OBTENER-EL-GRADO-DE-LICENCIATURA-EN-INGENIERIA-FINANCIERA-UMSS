from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.support.select import Select
from selenium.common import exceptions
import unittest
import time
import os

mesesGestion = ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"]

directorio = os.getcwd()
ubDrive = directorio + "\chromedriver.exe"
ubDatos = directorio + "\DATOS"
print(ubDrive)
time.sleep(10)

class usando_unittest(unittest.TestCase):

	def setUp(self):
		chromeOptions=Options() 
		chromeOptions.add_experimental_option("prefs", {
   	    "download.default_directory" : ubDatos,
        })
		self.driver = webdriver.Chrome(executable_path=r"%s" %ubDrive, chrome_options=chromeOptions)

	def	descagar(self, In, Fn, Stp, Seccion, Mes, Gestion):

		Fn = Fn + 1

		driver = self.driver
		driver.get("https://www.asfi.gob.bo/index.php/entidades-financieras-de-vivienda.html")
		time.sleep(10)
		driver.switch_to.frame(driver.find_element_by_xpath("/html/body/div/div/div[2]/main/div[2]/iframe"))
		time.sleep(3)

		gestion = driver.find_element_by_name("Anio")
		dropdown01 = Select(gestion)
		dropdown01.select_by_visible_text(str(Gestion))
		time.sleep(3)

		mes = driver.find_element_by_name("Mes")
		dropdown02 = Select(mes)
		dropdown02.select_by_visible_text(Mes)
		time.sleep(3)

		btnAceptar = driver.find_element_by_xpath("/html/body/form/p/table/tbody/tr/td[5]/input")
		btnAceptar.click()
		time.sleep(3)

		for a in range(In,Fn,Stp):
			try:
				estFin = driver.find_element_by_xpath("/html/body/table/tbody/tr/td/table/tbody/tr[1]/td/table[" + str(Seccion) + "]/tbody/tr/td[2]/table/tbody/tr/td[2]/a[" + str(a) + "]")
				estFin.click()
				time.sleep(5)
			except exceptions.NoSuchElementException:
				pass

	def test_usando_toggle(self):
		gestionInc = 2020
		gestionFn = 2021
		
		gestionFn = gestionFn + 1

		for j in range(gestionInc, gestionFn, 1):

			for i in mesesGestion:

				# DESCARGAR LOS ESTADOS FINANCIEROS POR BANCOS Y POR MONEDAS - SECCION 01
				self.descagar(In=1, Fn=2, Stp=1, Seccion=1, Mes=i, Gestion=j)
				# DESCARGAR LOS ESTADOS DE INDEICADORES FINANCIEROS - SECCION 02
				self.descagar(In=1, Fn=3, Stp=1, Seccion=2, Mes=i, Gestion=j)
				# DESCARGAR LOS ESTADOS DE CAPTACIONES - SECCION 03
				self.descagar(In=1, Fn=40, Stp=1, Seccion=3, Mes=i, Gestion=j)
				# DESCARGAR LOS ESTADOS DE COLOCACIONES - SECCION 04
				self.descagar(In=1, Fn=40, Stp=1, Seccion=4, Mes=i, Gestion=j)

				# DESCARGAR LOS ESTADOS DE OPERACIONES INTERBANCARIAS (SEMESTRAL) - SECCION 05
				self.descagar(In=1, Fn=1, Stp=1, Seccion=5, Mes=i, Gestion=j)
				# DESCARGAR LOS ESTADOS FINANCIEROS EVOLUTIVOS- SECCION 06
				self.descagar(In=1, Fn=5, Stp=1, Seccion=6, Mes=i, Gestion=j)
				# DESCARGAR LOS ESTADOS DE INDICADORES EVOLUTIVOS - SECCION 07
				self.descagar(In=1, Fn=5, Stp=1, Seccion=7, Mes=i, Gestion=j)
				# DESCARGAR LOS ESTADOS FINANCIEROS DESAGREGADOS - SECCION 08
				self.descagar(In=1, Fn=5, Stp=1, Seccion=8, Mes=i, Gestion=j)
				# DESCARGAR LOS ESTADOS DE AGENCIAS, SUCURSALES, NRO. EMPLEADOS - SECCION 09
				self.descagar(In=1, Fn=5, Stp=1, Seccion=9, Mes=i, Gestion=j)
							
	def tearDown(self):
		self.driver.close()

if __name__ == '__main__':
	unittest.main()