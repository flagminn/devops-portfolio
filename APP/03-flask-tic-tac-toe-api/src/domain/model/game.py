import uuid
from domain.model.board import Board

class Game:
    def __init__(self, game_id: uuid.UUID = None, board: Board = None):
        self.id = game_id if game_id is not None else uuid.uuid4()
        self.board = board if board is not None else Board()