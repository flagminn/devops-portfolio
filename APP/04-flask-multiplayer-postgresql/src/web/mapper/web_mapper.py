import uuid
from domain.model.game import Game
from web.model.web_models import WebGame

class WebMapper:
    @staticmethod
    def to_web(domain_game: Game) -> WebGame:
        return WebGame(
            game_id=str(domain_game.id),
            board=domain_game.board.get_matrix(),
            status=domain_game.status,
            player_x=str(domain_game.player_x_id) if domain_game.player_x_id else None,
            player_o=str(domain_game.player_o_id) if domain_game.player_o_id else None,
            current_turn=str(domain_game.current_turn_id) if domain_game.current_turn_id else None
        )