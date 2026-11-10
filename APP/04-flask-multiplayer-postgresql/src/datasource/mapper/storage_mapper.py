import uuid
from domain.model.game import Game
from domain.model.board import Board
from domain.model.user import User
from datasource.model.db_models import GameEntity, UserEntity

class StorageMapper:
    @staticmethod
    def to_user_domain(entity: UserEntity) -> User:
        if entity is None: return None
        return User(user_id=uuid.UUID(entity.id), login=entity.login, password=entity.password)

    @staticmethod
    def to_user_entity(domain: User) -> UserEntity:
        return UserEntity(id=str(domain.id), login=domain.login, password=domain.password)

    @staticmethod
    def to_game_domain(entity: GameEntity) -> Game:
        if entity is None: return None
        
        # Конвертируем строку "0,1,2..." обратно в матрицу [[0,1,2]...]
        nums = [int(x) for x in entity.board_str.split(",")]
        matrix = [nums[0:3], nums[3:6], nums[6:9]]
        board = Board(matrix)
        
        return Game(
            game_id=uuid.UUID(entity.id),
            board=board,
            status=entity.status,
            player_x_id=uuid.UUID(entity.player_x_id) if entity.player_x_id else None,
            player_o_id=uuid.UUID(entity.player_o_id) if entity.player_o_id else None,
            current_turn_id=uuid.UUID(entity.current_turn_id) if entity.current_turn_id else None,
            is_vs_bot=entity.is_vs_bot
        )

    @staticmethod
    def to_game_entity(domain: Game) -> GameEntity:
        # Конвертируем матрицу [[0,0,0]...] в плоскую строку "0,0,0,0,0,0,0,0,0"
        flat_list = []
        for row in domain.board.get_matrix():
            flat_list.extend(row)
        board_str = ",".join(str(x) for x in flat_list)
        
        return GameEntity(
            id=str(domain.id),
            board_str=board_str,
            status=domain.status,
            player_x_id=str(domain.player_x_id) if domain.player_x_id else None,
            player_o_id=str(domain.player_o_id) if domain.player_o_id else None,
            current_turn_id=str(domain.current_turn_id) if domain.current_turn_id else None,
            is_vs_bot=domain.is_vs_bot
        )