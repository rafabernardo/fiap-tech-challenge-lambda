import json
import re

import requests


def validate_cpf(cpf):
    return bool(re.match(r"^\d{11}$", cpf))


def call_mock_endpoint(cpf):
    url = "https://jsonplaceholder.typicode.com/posts"  # Mock endpoint
    payload = {"cpf": cpf}
    headers = {"Content-Type": "application/json"}

    response = requests.post(url, data=json.dumps(payload), headers=headers)
    return response


def lambda_handler(event):
    try:
        body = json.loads(event.get("body", "{}"))
        cpf = body.get("cpf", "")

        if not validate_cpf(cpf):
            return {
                "statusCode": 400,
                "body": json.dumps(
                    {"error": "CPF inválido. Deve conter 11 dígitos numéricos."}
                ),
            }

        response = call_mock_endpoint(cpf)

        if response.status_code == 201:
            return {
                "statusCode": 200,
                "body": json.dumps(
                    {
                        "message": "Mock endpoint chamado com sucesso.",
                        "data": response.json(),
                    }
                ),
            }
        else:
            return {
                "statusCode": 500,
                "body": json.dumps({"error": "Falha ao chamar o mock endpoint."}),
            }
    except Exception as e:
        return {
            "statusCode": 500,
            "body": json.dumps(
                {"error": "Erro interno no servidor.", "details": str(e)}
            ),
        }
