import requests

class Users:
    
    def get_users_via_api(self):
        response = requests.get("https://jsonplaceholder.typicode.com/users", verify=False)
        if response.status_code == 200:
            return {user['id']: user for user in response.json()}
        else:
            response.raise_for_status()

    def get_users_as_dict(self):
        users_data_dict = self.get_users_via_api()
        formatted_users = {}
        for user_id, user_info in users_data_dict.items():
            formatted_users[user_id] = {
                "Name": user_info['name'],
                "Username": user_info['username'],
                "Email": user_info['email'],
                "Phone": user_info['phone'],
                "Website": user_info['website'],
                "Address": {
                    "Street": user_info['address']['street'],
                    "Suite": user_info['address']['suite'],
                    "City": user_info['address']['city'],
                    "Zipcode": user_info['address']['zipcode'],
                },
                "Company": user_info['company']['name']
            }
        return formatted_users
    
users = Users()

print(users.get_users_as_dict())