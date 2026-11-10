import uuid
from datasource.repository.game_repository_interface import GameRepositoryInterface
from datasource.database.memory_storage import MemoryStorage
from datasource.mapper.storage_mapper import StorageMapper
from domain.model.game import Game

class GameRepositoryImpl(GameRepositoryInterface):
    def __init__(self, storage: MemoryStorage):
        self.storage = storage

    def save_game(self, game: Game) -> None:
        storage_game = StorageMapper.to_storage(game)
        self.storage.save(storage_game)

    def get_game(self, game_id: uuid.UUID) -> Game | None:
        storage_game = self.storage.get(str(game_id))
        if storage_game is None:
            return None
        return StorageMapper.to_domain(storage_game)