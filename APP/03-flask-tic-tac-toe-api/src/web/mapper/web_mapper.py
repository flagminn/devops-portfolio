import uuid
from domain.model.game import Game
from domain.model.board import Board
from web.model.web_models import WebGame

class WebMapper:
    @staticmethod
    def to_domain(web_game: dict) -> Game:
        
        game_id = uuid.UUID(web_game["id"])
        board = Board(web_game["board"])
        return Game(game_id=game_id, board=board)

    @staticmethod
    def to_web(domain_game: Game, status: str) -> WebGame:
        return WebGame(
            game_id=str(domain_game.id),
            board=domain_game.board.get_matrix(),
            status=status
        )