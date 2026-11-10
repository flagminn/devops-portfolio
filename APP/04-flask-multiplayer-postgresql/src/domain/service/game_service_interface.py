from abc import ABC, abstractmethod
from domain.model.board import Board

class GameServiceInterface(ABC):
    @abstractmethod
    def get_next_move(self, board: Board) -> Board:
        """Расчет хода компьютера алгоритмом Минимакс"""
        pass

    @abstractmethod
    def validate_move(self, old_board: Board, new_board: Board) -> bool:
        """Проверка честности хода игрока"""
        pass

    @abstractmethod
    def check_game_over(self, board: Board) -> str:
        """Проверка, закончилась ли игра ('X_WIN', 'O_WIN', 'DRAW', 'PLAYING')"""
        pass