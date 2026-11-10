import uuid
from sqlalchemy.orm import Session
from datasource.repository.game_repository_interface import GameRepositoryInterface
from datasource.model.db_models import GameEntity
from datasource.mapper.storage_mapper import StorageMapper
from domain.model.game import Game, GameStatus

class GameRepositoryImpl(GameRepositoryInterface):
    def __init__(self, db_session: Session):
        self.db = db_session

    def save_game(self, game: Game) -> None:
        entity = StorageMapper.to_game_entity(game)
        existing = self.db.query(GameEntity).filter(GameEntity.id == entity.id).first()
        if existing:
            existing.board_str = entity.board_str
            existing.status = entity.status
            existing.player_x_id = entity.player_x_id
            existing.player_o_id = entity.player_o_id
            existing.current_turn_id = entity.current_turn_id
            existing.is_vs_bot = entity.is_vs_bot
        else:
            self.db.add(entity)
        self.db.commit()

    def get_game(self, game_id: uuid.UUID) -> Game | None:
        entity = self.db.query(GameEntity).filter(GameEntity.id == str(game_id)).first()
        return StorageMapper.to_game_domain(entity)

    def get_available_games(self) -> list[Game]:
        # Доступные игры — те, у которых статус WAITING_FOR_PLAYERS [cite: 90, 97]
        entities = self.db.query(GameEntity).filter(GameEntity.status == GameStatus.WAITING).all()
        return [StorageMapper.to_game_domain(e) for e in entities]