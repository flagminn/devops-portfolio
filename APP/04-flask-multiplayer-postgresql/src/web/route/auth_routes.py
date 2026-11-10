from flask import Blueprint, request, jsonify
from web.mapper.web_mapper import WebMapper
import uuid

auth_blueprint = Blueprint('auth', __name__)

_auth_service = None
_user_repository = None

def init_auth_routes(auth_service, user_repository):
    global _auth_service, _user_repository
    _auth_service = auth_service
    _user_repository = user_repository
    return auth_blueprint

@auth_blueprint.route('/signup', methods=['POST'])
def signup():
    data = request.get_json()
    if not data or 'login' not in data or 'password' not in data:
        return jsonify({"error": "Передайте login и password"}), 400

    success = _auth_service.register_user(data['login'], data['password'])
    if not success:
        return jsonify({"error": "Пользователь с таким логином уже существует"}), 400

    return jsonify({"status": "Успешная регистрация"}), 201

@auth_blueprint.route('/login', methods=['POST'])
def login():
    auth_header = request.headers.get('Authorization')
    if not auth_header or not auth_header.startswith('Basic '):
        return jsonify({"error": "Требуется Basic Auth заголовок"}), 401

    import base64
    try:
        encoded = auth_header.split(' ')[1]
        decoded = base64.b64decode(encoded).decode('utf-8')
        login_val, pass_val = decoded.split(':', 1)
    except Exception:
        return jsonify({"error": "Ошибка декодирования заголовка"}), 400

    user_uuid = _auth_service.authenticate_user(login_val, pass_val)
    if user_uuid is None:
        return jsonify({"error": "Неверные учетные данные"}), 401

    return jsonify({"user_uuid": str(user_uuid)}), 200

@auth_blueprint.route('/user/<string:user_id_str>', methods=['GET'])
def get_user_info(user_id_str):
    try:
        u_uuid = uuid.UUID(user_id_str)
    except ValueError:
        return jsonify({"error": "Некорректный UUID"}), 400

    user = _user_repository.get_user(u_uuid)
    if not user:
        return jsonify({"error": "Пользователь не найден"}), 404

    return jsonify({
        "id": str(user.id),
        "login": user.login
    }), 200