import requests;
import os;
import argparse;

def owner_set(email, password):
    return {
        "email": email,
        "firstName":"Process",
        "lastName":"SuperAdmin",
        "password": password
    }


owner_result = requests.post("http://workflow.localhost/rest/owner", json=owner_set("some@exaim.com", "some"));
