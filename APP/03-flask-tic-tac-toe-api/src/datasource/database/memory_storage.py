import threading
from datasource.model.storage_models import StorageGame

class MemoryStorage:
    def __init__(self):
        self._games = {}
        self._lock = threading.Lock()

    def save(self, game: StorageGame):
        with self._lock:
            self._games[game.id] = game

    def get(self, game_id: str) -> StorageGame | None:
        with self._lock:
            return self._games.get(game_id)