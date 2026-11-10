from flask import Blueprint, request, jsonify
import uuid
from web.mapper.web_mapper import WebMapper
from domain.model.board import Board


game_blueprint = Blueprint('game', __name__)


_game_service = None

def init_routes(game_service):
    global _game_service
    _game_service = game_service
    return game_blueprint

@game_blueprint.route('/game/<string:game_id_str>', methods=['POST'])
def play_turn(game_id_str):
    try:
        game_uuid = uuid.UUID(game_id_str)
    except ValueError:
        return jsonify({"error": "Некорректный формат UUID игры"}), 400

    
    data = request.get_json()
    if not data or 'board' not in data:
        return jsonify({"error": "Отсутствуют данные игрового поля"}), 400

    
    old_game = _game_service.game_repository.get_game(game_uuid)
    
    
    if old_game is None:
        return jsonify({"error": f"Игра с ID {game_id_str} не найдена на сервере"}), 404

    
    user_board = Board(data['board'])

    
    if not _game_service.validate_move(old_game.board, user_board):
        return jsonify({"error": "Некорректный ход! Предыдущие ходы изменены или нарушены правила."}), 400

    
    old_game.board = user_board

    
    status = _game_service.check_game_over(old_game.board)
    
    
    if status == "PLAYING":
        ai_board = _game_service.get_next_move(old_game.board)
        old_game.board = ai_board
        
        status = _game_service.check_game_over(old_game.board)

    
    _game_service.game_repository.save_game(old_game)

    
    web_response = WebMapper.to_web(old_game, status)
    return jsonify(web_response.to_dict()), 200