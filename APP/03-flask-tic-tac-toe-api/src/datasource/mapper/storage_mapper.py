import uuid
from domain.model.game import Game
from domain.model.board import Board
from datasource.model.storage_models import StorageGame

class StorageMapper:
    @staticmethod
    def to_domain(storage_game: StorageGame) -> Game:
        if storage_game is None:
            return None
        board = Board(storage_game.board_matrix)
        game_id = uuid.UUID(storage_game.id)
        return Game(game_id=game_id, board=board)

    @staticmethod
    def to_storage(domain_game: Game) -> StorageGame:
        game_id_str = str(domain_game.id)
        matrix_copy = [row[:] for row in domain_game.board.get_matrix()]
        return StorageGame(game_id=game_id_str, board_matrix=matrix_copy)