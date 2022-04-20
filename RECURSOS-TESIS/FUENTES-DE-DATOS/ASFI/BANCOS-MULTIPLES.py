import unittest
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.support.select import Select
import time

mesesGestion = ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"]

class usando_unittest(unittest.TestCase):

	def setUp(self):
		
		chromeOptions=Options() 
		chromeOptions.add_experimental_option("prefs", {
   	    "download.default_directory" : "F:\\PRUEBAS_DESCARGAS",
        })
		self.driver = webdriver.Chrome(executable_path=r"C:\dchrome\chromedriver.exe",chrome_options=chromeOptions)

	def test_usando_toggle(self):
		driver = self.driver
		driver.get("https://www.asfi.gob.bo/index.php/bancos-multiples-boletines.html")
		time.sleep(3)
		driver.switch_to.frame(driver.find_element_by_xpath("/html/body/div/div/div[2]/main/div[2]/iframe"))
		time.sleep(3)
		
		for j in range(2020,2021,1):

			for i in mesesGestion:

				gestion = driver.find_element_by_name("Anio")
				dropdown01 = Select(gestion)
				dropdown01.select_by_visible_text(str(j))
				time.sleep(5)

				mes = driver.find_element_by_name("Mes")
				dropdown02 = Select(mes)
				dropdown02.select_by_visible_text(i)
				time.sleep(5)

				btnAceptar = driver.find_element_by_xpath("/html/body/form/p/table/tbody/tr/td[5]/input")
				btnAceptar.click()
				time.sleep(5)

				estFin = driver.find_element_by_xpath("/html/body/table/tbody/tr/td/table/tbody/tr[1]/td/table[1]/tbody/tr/td[2]/table/tbody/tr/td[2]/a[1]")
				estFin.click()
				time.sleep(5)

				estFinPorMon = driver.find_element_by_xpath("/html/body/table/tbody/tr/td/table/tbody/tr[1]/td/table[1]/tbody/tr/td[2]/table/tbody/tr/td[2]/a[2]")
				estFinPorMon.click()
				time.sleep(5)

		
	def tearDown(self):
		self.driver.close()

if __name__ == '__main__':
	unittest.main()