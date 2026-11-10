from flask import Blueprint, request, jsonify, g
import uuid
from web.mapper.web_mapper import WebMapper
from domain.model.board import Board
from domain.model.game import Game, GameStatus
from functools import wraps

game_blueprint = Blueprint('game', __name__)

_game_service = None
_authenticator = None

def init_game_routes(game_service, authenticator):
    global _game_service, _authenticator
    _game_service = game_service
    _authenticator = authenticator
    return game_blueprint

def require_auth(f):
    @wraps(f)
    def decorated(*args, **kwargs):
        if _authenticator is None:
            return jsonify({"error": "Внутренняя ошибка сервера (Authenticator не инициализирован)"}), 500
        
        user_uuid = _authenticator.authenticate()
        if user_uuid is None:
            return jsonify({"error": "Unauthorized. Неверный логин или пароль или отсутствует заголовок Basic Auth."}), 401
        
        g.user_id = user_uuid
        return f(*args, **kwargs)
    return decorated

@game_blueprint.route('/game/new', methods=['POST'])
@require_auth
def create_game():
    data = request.get_json() or {}
    mode = data.get('mode', 'bot') # 'bot' или 'user'
    
    creator_id = g.user_id
    new_game = Game()
    new_game.player_x_id = creator_id
    
    if mode == 'bot':
        new_game.is_vs_bot = True
        new_game.player_o_id = None
        new_game.current_turn_id = creator_id
        new_game.status = GameStatus.turn(creator_id)
    else:
        new_game.is_vs_bot = False
        new_game.status = GameStatus.WAITING
        
    _game_service.game_repository.save_game(new_game)
    return jsonify(WebMapper.to_web(new_game).to_dict()), 201

@game_blueprint.route('/games/available', methods=['GET'])
@require_auth
def get_available_games():
    games = _game_service.game_repository.get_available_games()
    return jsonify([WebMapper.to_web(g).to_dict() for g in games]), 200

@game_blueprint.route('/game/<string:game_id_str>/join', methods=['POST'])
@require_auth
def join_game(game_id_str):
    try:
        g_uuid = uuid.UUID(game_id_str)
    except ValueError:
        return jsonify({"error": "Неверный UUID игры"}), 400

    game = _game_service.game_repository.get_game(g_uuid)
    if not game:
        return jsonify({"error": "Игра не найдена"}), 404

    if game.status != GameStatus.WAITING:
        return jsonify({"error": "К игре нельзя присоединиться, она уже заполнена или завершена"}), 400

    if game.player_x_id == g.user_id:
        return jsonify({"error": "Вы не можете присоединиться к собственной игре"}), 400

    game.player_o_id = g.user_id
    game.current_turn_id = game.player_x_id
    game.status = GameStatus.turn(game.player_x_id)
    
    _game_service.game_repository.save_game(game)
    return jsonify(WebMapper.to_web(game).to_dict()), 200

@game_blueprint.route('/game/<string:game_id_str>', methods=['GET'])
@require_auth
def get_game(game_id_str):
    try:
        g_uuid = uuid.UUID(game_id_str)
    except ValueError:
        return jsonify({"error": "Неверный UUID"}), 400

    game = _game_service.game_repository.get_game(g_uuid)
    if not game:
        return jsonify({"error": "Игра не найдена"}), 404

    return jsonify(WebMapper.to_web(game).to_dict()), 200

@game_blueprint.route('/game/<string:game_id_str>', methods=['POST'])
@require_auth
def play_turn(game_id_str):
    try:
        game_uuid = uuid.UUID(game_id_str)
    except ValueError:
        return jsonify({"error": "Некорректный формат UUID игры"}), 400

    data = request.get_json()
    if not data or 'board' not in data:
        return jsonify({"error": "Отсутствуют данные игрового поля"}), 400

    game = _game_service.game_repository.get_game(game_uuid)
    if game is None:
        return jsonify({"error": "Игра не найдена"}), 404

    if "Победа" in game.status or game.status == GameStatus.DRAW:
        return jsonify({"error": "Игра уже завершена!"}), 400

    if game.current_turn_id != g.user_id:
        return jsonify({"error": "Сейчас не ваш ход!"}), 400

    expected_symbol = 1 if g.user_id == game.player_x_id else 2
    user_board = Board(data['board'])

    if not _game_service.validate_player_move(game.board, user_board, expected_symbol):
        return jsonify({"error": "Некорректный ход! Нарушены правила крестиков-ноликов."}), 400

    game.board = user_board
    _game_service.update_game_status_after_move(game)

    if game.is_vs_bot and "Ход" in game.status:
        ai_board = _game_service.get_next_move(game.board)
        game.board = ai_board
        game.current_turn_id = None 
        _game_service.update_game_status_after_move(game)
        if "Ход" in game.status:
            game.current_turn_id = game.player_x_id
            game.status = GameStatus.turn(game.player_x_id)

    _game_service.game_repository.save_game(game)
    return jsonify(WebMapper.to_web(game).to_dict()), 200