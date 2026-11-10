class WebGame:
    def __init__(self, game_id: str, board: list[list[int]], status: str = "PLAYING"):
        self.id = game_id
        self.board = board
        self.status = status

    def to_dict(self) -> dict:
        return {
            "id": self.id,
            "board": self.board,
            "status": self.status
        }