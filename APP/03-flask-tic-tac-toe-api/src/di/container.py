from datasource.database.memory_storage import MemoryStorage
from datasource.repository.game_repository_impl import GameRepositoryImpl
from domain.service.game_service_impl import GameServiceImpl

class Container:
    def __init__(self):
        
        self._storage = MemoryStorage()      
        self._game_repository = GameRepositoryImpl(self._storage)              
        self._game_service = GameServiceImpl(self._game_repository)

    @property
    def game_service(self):
        return self._game_service
        
    @property
    def game_repository(self):
        return self._game_repository