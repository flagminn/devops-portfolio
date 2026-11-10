import base64
from flask import request, jsonify, g
from functools import wraps

class UserAuthenticator:
    def __init__(self, auth_service):
        self.auth_service = auth_service

    def authenticate(self):
        """Возвращает UUID пользователя, если авторизация успешна, иначе None"""
        auth_header = request.headers.get('Authorization')
        if not auth_header or not auth_header.startswith('Basic '):
            return None

        try:
            encoded_credentials = auth_header.split(' ')[1]
            decoded_bytes = base64.b64decode(encoded_credentials)
            decoded_str = decoded_bytes.decode('utf-8')
            login, password = decoded_str.split(':', 1)
        except Exception:
            return None

        return self.auth_service.authenticate_user(login, password)