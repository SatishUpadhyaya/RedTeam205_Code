The Backend Code for the Bike Buddy App.

To Run Locally:
1. `cd Backend`
2. `source env/bin/activate`
3. `cd API`
4. `pip install -r requirements.txt`
5. `python manage.py runserver`


List of all endpoints and associated JSON structures:
superuser login:
username: jptboy
password: khanal2845
Login:
    - Create account: 
        - REQUEST TYPE: POST
        - url: /api/createacc
        - Headers: None
        - Body: {"username":"username","password":"password","email":"foo@gmail.com"}
                - example format above
        - Response Format: N/A, just look at status codes/ source code
    - Login:
        - REQUEST TYPE: POST
        - This will return an authorization token for future api calls
        - url: /api/login
        - Headers: None
        - Body: {"username":"username","password":"password"}
                - example format above
        - Response Format: {
                      "token": "8bf76be3ec2c04fc197b937de0d72d2cb7037b54"
                    }
Bike CRUD:
    - Get Bikes:
        - Request Type: GET
        - URL: /bikes/
        - Headers: 
                Key: Authorization
                Value: Token 8bf76be3ec2c04fc197b937de0d72d2cb7037b54
        - Body: None
        - Response Format: Try it out
    - Add Bike
        - Request Type: POST
        - URL: /bikes/addBike
        - Headers: 
                Key: Authorization
                Value: Token 8bf76be3ec2c04fc197b937de0d72d2cb7037b54
        - Body:
                {"Name" : "coooolBike"}
        - Response Format: Try it out
    - Change Bike Info
        - Request Type: PUT
        - URL: /bikes/changeBike
        - Headers: 
                Key: Authorization
                Value: Token 8bf76be3ec2c04fc197b937de0d72d2cb7037b54
        - Body:
                {"Name":"cooolBike","lat":1.0,"lng":1.1,"state":"testing"}
                - NOTE: lat and lng values have to be floating points
        - Response Format: Try it out
    - Delete Bike:
        - Request Type: DELETE
        - URL: /bikes/deleteBike
        - Headers: 
                Key: Authorization
                Value: Token 8bf76be3ec2c04fc197b937de0d72d2cb7037b54
        - Body: None
        - Response Format: Try it out