from abc import ABC, abstractmethod
import uuid
from domain.model.game import Game

class GameRepositoryInterface(ABC):
    @abstractmethod
    def save_game(self, game: Game) -> None: pass

    @abstractmethod
    def get_game(self, game_id: uuid.UUID) -> Game | None: pass

    @abstractmethod
    def get_available_games(self) -> list[Game]: pass