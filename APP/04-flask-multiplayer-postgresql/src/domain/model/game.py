import uuid
from domain.model.board import Board

class GameStatus:
    WAITING = "WAITING_FOR_PLAYERS"
    DRAW = "DRAW"
    # Для динамических статусов возвращаем строку по шаблону из чек-листа
    @staticmethod
    def turn(user_uuid: uuid.UUID) -> str:
        return f"Ход игрока с {user_uuid}"
    
    @staticmethod
    def victory(user_uuid: uuid.UUID) -> str:
        return f"Победа игрока с {user_uuid}"

class Game:
    def __init__(
        self, 
        game_id: uuid.UUID = None, 
        board: Board = None, 
        status: str = GameStatus.WAITING,
        player_x_id: uuid.UUID = None,
        player_o_id: uuid.UUID = None,
        current_turn_id: uuid.UUID = None,
        is_vs_bot: bool = False
    ):
        self.id = game_id if game_id is not None else uuid.uuid4()
        self.board = board if board is not None else Board()
        self.status = status
        self.player_x_id = player_x_id      # Кто ходит Х 
        self.player_o_id = player_o_id      # Кто ходит О 
        self.current_turn_id = current_turn_id  # UUID игрока, чей сейчас ход 
        self.is_vs_bot = is_vs_bot          # Игра с компьютером или человеком