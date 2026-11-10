from domain.service.game_service_interface import GameServiceInterface
from domain.model.board import Board
from domain.model.game import Game, GameStatus
import uuid

class GameServiceImpl(GameServiceInterface):
    def __init__(self, game_repository):
        self.game_repository = game_repository

    def check_game_over(self, board: Board) -> str:
        # Этот внутренний метод возвращает чистый исход матча
        matrix = board.get_matrix()
        lines = []
        lines.extend(matrix)
        lines.extend([[matrix[r][c] for r in range(3)] for c in range(3)])
        lines.append([matrix[0][0], matrix[1][1], matrix[2][2]])
        lines.append([matrix[0][2], matrix[1][1], matrix[2][0]])
        
        for line in lines:
            if line == [1, 1, 1]: return "X_WIN"
            if line == [2, 2, 2]: return "O_WIN"
                
        if not any(0 in row for row in matrix): return "DRAW"
        return "PLAYING"

    def update_game_status_after_move(self, game: Game):
        # Метод улучшает логику окончания игры с использованием состояний 
        res = self.check_game_over(game.board)
        if res == "X_WIN":
            game.status = GameStatus.victory(game.player_x_id)
            game.current_turn_id = None
        elif res == "O_WIN":
            game.status = GameStatus.victory(game.player_o_id)
            game.current_turn_id = None
        elif res == "DRAW":
            game.status = GameStatus.DRAW
            game.current_turn_id = None
        else:
            # Смена хода 
            if game.current_turn_id == game.player_x_id:
                game.current_turn_id = game.player_o_id
                game.status = GameStatus.turn(game.player_o_id) if game.player_o_id else "Ход компьютера"
            else:
                game.current_turn_id = game.player_x_id
                game.status = GameStatus.turn(game.player_x_id)

    def validate_move(self, old_board: Board, new_board: Board) -> bool:
        # Метод-заглушка из интерфейса проекта 03, базовую валидацию на подмену клеток сделаем прямо в роуте
        return True

    def validate_player_move(self, old_board: Board, new_board: Board, expected_symbol: int) -> bool:
        # Проверяем честность хода: старые клетки не затерты, изменен ровно один нужный значок 
        old_m = old_board.get_matrix()
        new_m = new_board.get_matrix()
        changes = 0
        
        for r in range(3):
            for c in range(3):
                if old_m[r][c] != 0 and old_m[r][c] != new_m[r][c]:
                    return False  # Попытка изменить старый ход
                if old_m[r][c] == 0 and new_m[r][c] != 0:
                    if new_m[r][c] != expected_symbol:
                        return False  # Поставил чужой значок
                    changes += 1
        return changes == 1

    def get_next_move(self, board: Board) -> Board:
        # Логика бота (Минимакс) за знак O (2)
        matrix = board.get_matrix()
        best_score = -float('inf')
        best_move = None
        
        for r in range(3):
            for c in range(3):
                if matrix[r][c] == 0:
                    matrix[r][c] = 2
                    score = self._minimax(matrix, 0, False)
                    matrix[r][c] = 0
                    if score > best_score:
                        best_score = score
                        best_move = (r, c)
        if best_move:
            r, c = best_move
            new_matrix = [row[:] for row in matrix]
            new_matrix[r][c] = 2
            return Board(new_matrix)
        return board

    def _minimax(self, matrix, depth, is_maximizing):
        temp_board = Board(matrix)
        status = self.check_game_over(temp_board)
        if status == "O_WIN": return 10 - depth
        if status == "X_WIN": return depth - 10
        if status == "DRAW": return 0
        
        if is_maximizing:
            best_score = -float('inf')
            for r in range(3):
                for c in range(3):
                    if matrix[r][c] == 0:
                        matrix[r][c] = 2
                        score = self._minimax(matrix, depth + 1, False)
                        matrix[r][c] = 0
                        best_score = max(score, best_score)
            return best_score
        else:
            best_score = float('inf')
            for r in range(3):
                for c in range(3):
                    if matrix[r][c] == 0:
                        matrix[r][c] = 1
                        score = self._minimax(matrix, depth + 1, True)
                        matrix[r][c] = 0
                        best_score = min(score, best_score)
            return best_score