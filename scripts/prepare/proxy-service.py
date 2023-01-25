import requests;
import os;
import argparse;


def create_domain_request(domain, service_dns, service_port):
  return {
    "domain_names": [
        domain,
        f"{service_dns}.internal.docker"
    ],
    "forward_scheme": "http",
    "forward_host": service_dns,
    "forward_port": service_port,
    "caching_enabled": "true",
    "block_exploits": "true",
    "allow_websocket_upgrade": "true",
    "access_list_id": "0",
    "certificate_id": 0,
    "meta": {
        "letsencrypt_agree": "false",
        "dns_challenge": "false"
    },
    "advanced_config": "",
    "locations": [],
    "http2_support": "false",
    "hsts_enabled": "false",
    "hsts_subdomains": "false",
    "ssl_forced": "false"
  }

def auth_head(token):
  return {
    'Authorization': 'Bearer ' + token
  }

def get_identity_object(user_email, password):
  return {
    "identity": user_email,
    "scope": "user",
    "secret": password
  }

def change_default_identity(user_email, password, token):
  auth_headers = auth_head(token)
  changeIdentity = {
      "email": user_email,
      "name": "Super Admin",
      "nickname": "superadmin",
  }
  admin_change_email = requests.put("http://localhost:81/api/users/1", headers=auth_headers, data=changeIdentity)
  print(f"{admin_change_email.status_code} - default email changed")

  changePass = {
      "type": "password",
      "current": "changeme",
      "secret": password
    }

  admin_change_secret = requests.put("http://localhost:81/api/users/1/auth", headers=auth_headers, data=changePass)
  print(f"{admin_change_secret.status_code} - default secret changed")


def get_user_token(identity):
  tokens = requests.post('http://localhost:81/api/tokens', data=identity)
  return tokens

def create_service_domain(dns_name, internal_addr, internal_port, token, current_domains_dist):
  if dns_name in current_domains_dist:
    print(f"{dns_name} is exist - skiped")
  else:
    
    request_domain = create_domain_request(dns_name, internal_addr, internal_port)
    status = requests.post("http://localhost:81/api/nginx/proxy-hosts", json=request_domain, headers=auth_head(token))
    print(f"Create {dns_name} - status {status.status_code}")

    

parser = argparse.ArgumentParser(description='Create service discovery for empty deploy.')
parser.add_argument("-d", "--domain", required=True)
parser.add_argument("-u", "--user", required=True)
parser.add_argument("-s", "--secret",required=True)

#print(f"Starting {domain_prefix}")
args = parser.parse_args()
print(f"create service discovery and user {args.user} with wildcard *.{args.domain}")

default_token = get_identity_object("admin@example.com", "changeme")
print("check if default auth exist")
auth_token = get_user_token(default_token)

if auth_token.status_code == 200 :
  ## we does not change user
  print("first start - change default identity")
  token = auth_token.json().get('token')
  change_default_identity(args.user, args.secret, token)

auth_token = get_user_token(
    get_identity_object(
      args.user, args.secret
    )
)

#check settings
legal_token = auth_token.json().get('token')
settings = requests.get('http://localhost:81/api/settings',  headers=auth_head(legal_token))

# get current domains
current_proxy = requests.get("http://localhost:81/api/nginx/proxy-hosts", headers=auth_head(legal_token))

already_created_domain = dict()

for host in current_proxy.json():
  for domain in host.get('domain_names'):
    already_created_domain[domain] = host.get('forward_host')

create_service_domain(f"proxy.{args.domain}", "proxy", 81, legal_token, already_created_domain)
create_service_domain(f"dba.{args.domain}", "dba-admin", 80, legal_token, already_created_domain)
create_service_domain(f"api.{args.domain}", "graphql-mesh", 8080, legal_token, already_created_domain)
create_service_domain(f"tables.{args.domain}", "nocodedb", 8080, legal_token, already_created_domain)
create_service_domain(f"workflow.{args.domain}", "workflow", 5678, legal_token, already_created_domain)
create_service_domain(f"apps.{args.domain}", "appslowcode", 80, legal_token, already_created_domain)
create_service_domain(f"bi.{args.domain}", "biservice", 3000, legal_token, already_created_domain)
create_service_domain(f"mails.{args.domain}", "smtpserver", 8025, legal_token, already_created_domain)
