import requests
import json


def incorrectLoginTest(usrpswd):
	container = usrpswd.split(" ")
	URL = "https://bikebuddy.udana.systems/api/login"
	userName = container[0]
	password = container[1]
	PARAMS = {"username":userName, "password":password}
	response = requests.post(URL, json=PARAMS)

	#print(response.json())
	stringResponse = str(response.json())
	if(stringResponse == '{\'error\': \'Invalid Credentials\'}'):
		print("Passed the test case: incorrectLoginTest")
	else:
		print("Failed the test case: incorrectLoginTest")
		
		
def correctLoginTest(usrpswd):
	container = usrpswd.split(" ")
	URL = "https://bikebuddy.udana.systems/api/login"
	userName = container[0]
	password = container[1]
	PARAMS = {"username":userName, "password":password}
	response = requests.post(URL, json=PARAMS)

	#print(response.json())
	jsonResponse = response.json()
	stringResponse = str(response.json())
	gotToken = stringResponse.split(" ")[0]
	if(gotToken == '{\'token\':'):
		print("Passed the test case: correctLoginTest")
		getStatusTest(jsonResponse["token"])
		getLocationTest(jsonResponse["token"])
		return 1
	else:
		print("Failed the test case: correctLoginTest")
		return 0


def getStatusTest(token):
	URL = URL1 = "https://bikebuddy.udana.systems/bikes"
	header = {"Authorization": "Token " + token}

	response = requests.get(URL1, headers=header)

	responseJson = response.json()
	stateReturned = responseJson["Bikes"][0]["State"]
	if(stateReturned == "disarmed" or stateReturned == "armed" or stateReturned == "stolen" or stateReturned == "unknown"):
		print("Passed the test case: getDataTest")
	else:
		print("Failed the test case: getDataTest")
	
	
def getLocationTest(token):
	URL = URL1 = "https://bikebuddy.udana.systems/bikes"
	header = {"Authorization": "Token " + token}

	response = requests.get(URL1, headers=header)

	responseJson = response.json()
	latReturned = responseJson["Bikes"][0]['LatLng'][0]
	lonReturned = responseJson["Bikes"][0]['LatLng'][1]
	if(type(latReturned) == float and type(lonReturned) == float):
		print("Passed the test case: getLocationTest")
	else:
		print("Failed the test case: getLocationTest")

		
def correctSignUpTest(creds):
	container = creds.split(" ")
	userName = container[0]
	password = container[1]
	email = container[2]
	URL = 'https://bikebuddy.udana.systems/api/createacc'
	bodyText = {"username":userName,"password":password,"email":email}

	res = str(requests.post(URL, json=bodyText))
	if(res == "<Response [200]>"):
		print("Passed the test case: correctSignUpTest")
	else:
		print("Failed the test case: correctSignUpTest")


def incorrectSignUpTest(creds):
	container = creds.split(" ")
	userName = container[0]
	password = container[1]
	email = container[2]
	URL = 'https://bikebuddy.udana.systems/api/createacc'
	bodyText = {"username":userName,"password":password,"email":email}

	res = str(requests.post(URL, json=bodyText))
	if(res == "<Response [400]>"):
		print("Passed the test case: incorrectSignUpTest")
	else:
		print("Failed the test case: incorrectSignUpTest")
		
		
def main():
	correctSignUpTest("newU1s11er1 newP1swd1 newUs1e11r@nu.com") #if the test passes, make sure to change it everytime: atleast username and email
	incorrectSignUpTest("satish khanal2845 satishrajupadhyaya@gmail.com")
	incorrectLoginTest("invalid invalid")
	if(correctLoginTest("satish khanal2845") == 0):
		print("Could not test getStatusTest and getLocationTest because correctLoginTest failed!")
	
	
if __name__ == "__main__":
	main()