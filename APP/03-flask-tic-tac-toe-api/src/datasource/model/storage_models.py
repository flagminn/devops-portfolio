import uuid

class StorageGame:
    def __init__(self, game_id: str, board_matrix: list[list[int]]):
        self.id = game_id  
        self.board_matrix = board_matrix