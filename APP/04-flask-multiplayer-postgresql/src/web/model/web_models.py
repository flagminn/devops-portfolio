class WebGame:
    def __init__(self, game_id: str, board: list[list[int]], status: str, player_x: str, player_o: str, current_turn: str):
        self.id = game_id
        self.board = board
        self.status = status
        self.player_x = player_x
        self.player_o = player_o
        self.current_turn = current_turn

    def to_dict(self) -> dict:
        return {
            "id": self.id,
            "board": self.board,
            "status": self.status,
            "player_x_id": self.player_x,
            "player_o_id": self.player_o,
            "current_turn_id": self.current_turn
        }